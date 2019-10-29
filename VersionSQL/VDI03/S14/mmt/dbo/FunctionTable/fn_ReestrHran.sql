/****** Object:  Function [dbo].[fn_ReestrHran]    Committed by VersionSQL https://www.versionsql.com ******/

create FUNCTION [fn_ReestrHran](@project varchar(32), @dn datetime, @dk datetime)
RETURNS TABLE 
AS
RETURN 
(	-- select * from fn_ReestrHranNakop('Устькут','20180101','20180131') order by ПартияДата, ПартияНомер, код, npp

	with vd as (
		-- вес внутри груз и тара в рамках операции
		SELECT b.Операция, b.Куда, b.Что
		, case when h.КолБЕИ<>0 then cast(h.ВесКгНетто *b.Количество/h.КолБЕИ as decimal(18,0)) end Нетто
		, case when h.КолБЕИ<>0 then cast(h.ВесКгБрутто*b.Количество/h.КолБЕИ as decimal(18,0)) end Брутто
		FROM			хДвижение		AS a
		INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
		INNER JOIN		хОбъекты		AS h ON b.Что		= h.SYS_ID
		where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 and a.Проект=@project
		and h.КолБЕИ<>0
), bz as (
		-- все операции, кроме внутритарки и засовывания в тару-груз
		SELECT h.Код, h.SYS_ID
			, cast(ROW_NUMBER() over(partition by h.SYS_ID order by 
				 case a.тип when 'Приемка' then 1 when 'Перемещения' then 2 when 'Выдача' then 2 else 9 end , a.Дата
				,case a.тип when 'Приемка' then 1 when 'Перемещения' then 2 when 'Выдача' then 3 else 9 end 
			) as int) npp, b.Количество, h.БЕИ, b.мест		
		, cast( (isnull(h.ВесКгНетто *b.Количество/h.КолБЕИ,0) + isnull(g.Нетто ,0)) as decimal(18,0) ) Нетто
		, cast( (isnull(h.ВесКгБрутто*b.Количество/h.КолБЕИ,0) + isnull(g.Брутто,0)) as decimal(18,0) ) Брутто
		, a.Тип Операция, a.Дата, a.Номер, b.Откуда, o.Название ОткудаТ, b.Куда, k.Название КудаТ, h.Партия, h.ПартияНомер, h.ПартияДата, h.КолБЕИ
		, h.Название Тмц, h.Тип ТмцТип, k.Тип КудаТип, o.Тип ОткудаТип, a.ТСНомер Транспорт
		FROM			хДвижение		AS a
		INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
		INNER JOIN		хОбъекты		AS o ON b.Откуда	= o.SYS_ID
		INNER JOIN		хОбъекты		AS k ON b.куда		= k.SYS_ID
		INNER JOIN		хОбъекты		AS h ON b.Что		= h.SYS_ID
		left outer JOIN	(	select r.Операция, r.Куда, sum(r.Нетто ) Нетто, sum(r.Брутто) Брутто, count(*) rc
							from vd as r
							group by r.Операция, r.Куда
						)	as g on b.Операция=g.Операция and b.Что=g.Куда
		where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 and a.Проект=@project
		-- внутритарка
		and b.Откуда<>b.Куда
	union all
	--	текущие остатки на складе
		select		h.Код, h.SYS_ID, 999, o.Количество, h.БЕИ, case when h.КолБЕИ<>0 and h.мест<>0 then cast(ceiling(h.мест*o.Количество/h.КолБЕИ) as int) end
		, cast(h.ВесКгНетто *o.Количество/h.КолБЕИ as decimal(18,0)) Нетто
		, cast(h.ВесКгБрутто*o.Количество/h.КолБЕИ as decimal(18,0)) Брутто
		, 'Остаток', null --getdate()
		, 'В наличии', g.SYS_ID, g.Название , g.SYS_ID, g.Название, h.Партия, h.ПартияНомер, h.ПартияДата, h.КолБЕИ, h.Название, h.Тип, g.Тип, g.Тип, null
		from		хОстатки o
		inner join	хОбъекты h on o.Что=h.SYS_ID
		inner join	хОбъекты g on o.Где=g.SYS_ID
		where		o.Количество>0 and g.Тип in ('Склад','Сектор','Место')
		and h.Проект=@project
	)



		select ПартияНомер Партия, ОткудаТ Склад, УслХранения, Поклажедатель, Сегмент, ТС, Тмц
		, СДаты, ПоДату
		, datediff(d,СДаты,isnull(ПоДату,dateadd(d,1,@dk) ))+1  СрокПолный
		, datediff(d,case when СДаты>=@dn then СДаты else @dn end, case when ПоДату<=@dk then ПоДату else @dk end)+1 СрокХранения
		, Количество, БЕИ, Мест, Нетто, Брутто
		, Операция, Номер, Транспорт, КудаТ, npp, Записей, ТмцТип, КолБЕИ, Код mtr, ОткудаТип, кудаТип
		from (
			select a.ПартияДата, a.ПартияНомер, a.Тмц, a.ОткудаТ
			, a.Дата СДаты, min(b.Дата) ПоДату
			, a.Количество, a.БЕИ, a.мест, a.Нетто, a.Брутто

			, count(*) Записей
			, a.Код, a.npp, a.ТмцТип, a.КолБЕИ, a.Операция, a.Номер, a.КудаТ, a.КудаТип, a.ОткудаТип
			, k.Название Поклажедатель, x.Сегмент, x.ТСНомер ТС, x.УслХранения, a.Транспорт

			from				bz a
			inner join			bz b on a.SYS_ID=b.SYS_ID and a.Куда=b.Откуда and a.npp<b.npp
			left outer join		хДвижение x on a.Партия=x.SYS_ID
			left outer join		Контрагенты k on x.ОткудаКА=k.SYS_ID
			
			group by			a.Код, a.npp, a.Операция, a.Номер, a.ПартияНомер, a.ПартияДата, a.КолБЕИ, a.БЕИ
			, a.Тмц, a.ТмцТип, a.ОткудаТ, a.КудаТ, a.Количество, a.Дата, a.мест, a.Нетто, a.Брутто, a.КудаТип, a.ОткудаТип
			, k.Название, x.Сегмент, x.ТСНомер, x.УслХранения, a.Транспорт 
		) a
--	where (	(СДаты<=@dk and ПоДату between @dn and @dk) or  (ПоДату is null   and СДаты<=@dk) )
	where СДаты<=@dk and (ПоДату>=@dn or ПоДату is null)
	-- было в таре(ГМ) - это не хранение!
	and кудаТип not in ('Тара','Груз')
)