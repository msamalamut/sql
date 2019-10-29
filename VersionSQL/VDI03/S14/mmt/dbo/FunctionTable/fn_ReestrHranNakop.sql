/****** Object:  Function [dbo].[fn_ReestrHranNakop]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_ReestrHranNakop](@project varchar(32), @dn datetime, @dk datetime)
RETURNS TABLE 
AS
RETURN 
(	-- select * from fn_ReestrHranNakop('Устькут','20180101','20180131') order by ПартияДата, ПартияНомер, код, npp

	with bz as (
		-- все операции, кроме внутритарки и засовывания в тару-груз
		SELECT h.Код
			, cast(ROW_NUMBER() over(partition by h.SYS_ID order by 
				 case a.тип when 'Приемка' then 1 when 'Перемещения' then 2 when 'Выдача' then 2 else 9 end , a.Дата
				,case a.тип when 'Приемка' then 1 when 'Перемещения' then 2 when 'Выдача' then 3 else 9 end 
			) as int) npp, b.Количество, h.БЕИ, b.мест		
		, case when h.КолБЕИ<>0 then cast(h.ВесКгНетто *b.Количество/h.КолБЕИ as decimal(18,0)) end Нетто
		, case when h.КолБЕИ<>0 then cast(h.ВесКгБрутто*b.Количество/h.КолБЕИ as decimal(18,0)) end Брутто
		, a.Тип Операция, a.Дата, a.Номер, b.Откуда, o.Название ОткудаТ, b.Куда, k.Название КудаТ, h.Партия, h.ПартияНомер, h.ПартияДата, h.КолБЕИ
		, h.Название Тмц, h.Тип ТмцТип, h.Заявка ШифрТГ, k.Тип КудаТип, o.Тип ОткудаТип, a.ТСНомер Транспорт
		FROM			хДвижение		AS a
		INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
		INNER JOIN		хОбъекты		AS o ON b.Откуда	= o.SYS_ID
		INNER JOIN		хОбъекты		AS k ON b.куда		= k.SYS_ID
		INNER JOIN		хОбъекты		AS h ON b.Что		= h.SYS_ID
		where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 and a.Проект=@project
		-- внутритарка
		and b.Откуда<>b.Куда
	union all
	--	текущие остатки на складе
		select		h.Код, 999, o.Количество, h.БЕИ, case when h.КолБЕИ<>0 and h.мест<>0 then cast(ceiling(h.мест*o.Количество/h.КолБЕИ) as int) end
		, case when h.КолБЕИ<>0 then cast(h.ВесКгНетто *o.Количество/h.КолБЕИ as decimal(18,0)) end Нетто
		, case when h.КолБЕИ<>0 then cast(h.ВесКгБрутто*o.Количество/h.КолБЕИ as decimal(18,0)) end Брутто
		, 'Остаток', null --getdate()
		, 'В наличии', g.SYS_ID, g.Название , g.SYS_ID, g.Название, h.Партия, h.ПартияНомер, h.ПартияДата, h.КолБЕИ, h.Название, h.Тип, h.Заявка ШифрТГ, g.Тип, g.Тип, null
		from		хОстатки o
		inner join	хОбъекты h on o.Что=h.SYS_ID
		inner join	хОбъекты g on o.Где=g.SYS_ID
		where		o.Количество>0 and g.Тип in ('Склад','Сектор','Место')
		and h.Проект=@project
	)



		select ПартияНомер Партия, ОткудаТ Склад, УслХранения, Поклажедатель, Сегмент, ТС, Тмц
		, СДаты, ПоДату
		, datediff(d,СДаты,isnull(ПоДату,@dk))+1  СрокПолный
		, case when (case when СДаты2>=@dn then СДаты2 else @dn end) <= (case when ПоДату<=@dk then ПоДату else @dk end) then
			 datediff(d,case when СДаты2>=@dn then СДаты2 else @dn end, case when ПоДату<=@dk then ПоДату else @dk end)+1 end СрокХранЛьгот
		, datediff(d,case when СДаты >=@dn then СДаты  else @dn end, case when ПоДату<=@dk then ПоДату else @dk end)+1 СрокХранения
		, Количество, БЕИ, Мест, Нетто, Брутто
		, Операция, Номер, Транспорт, КудаТ, Цена, Прайс, npp, Записей, ТмцТип, ШифрТГ, КолБЕИ, Код mtr, ОткудаТип, кудаТип
		, ТСп, ТСМарка, ТСНомер, ТСД, ТСДНомер, ТСДДата
		from (
			select a.ПартияДата, a.ПартияНомер, a.Тмц, a.Откуда, a.ОткудаТ, max(b.Дата) СДаты, dateadd(d,30,max(b.Дата)) СДаты2, a.Дата ПоДату
			, a.Количество, a.БЕИ, a.мест, a.Нетто, a.Брутто
			, count(*) Записей
			, a.Код, a.npp, a.ТмцТип, a.ШифрТГ, a.КолБЕИ, a.Операция, a.Номер, a.КудаТ, a.КудаТип, a.ОткудаТип
			, k.Название Поклажедатель, x.Сегмент, x.ТСНомер ТС, x.УслХранения, a.Транспорт
			, x.ТС ТСп, x.ТСМарка, x.ТСНомер, x.ТСД, x.ТСДНомер, x.ТСДДата
			from				bz a
			inner join			bz b on a.Код=b.Код and a.ОтКуда=b.куда and a.npp>b.npp
			left outer join		хДвижение	x on a.Партия=x.SYS_ID
			left outer join		Контрагенты k on x.ОткудаКА=k.SYS_ID
			
			group by			a.Код, a.npp, a.Операция, a.Номер, a.ПартияНомер, a.ПартияДата, a.КолБЕИ, a.БЕИ
			, a.Тмц, a.ТмцТип, a.ШифрТГ, a.Откуда, a.ОткудаТ, a.КудаТ, a.Количество, a.Дата, a.мест, a.Нетто, a.Брутто, a.КудаТип, a.ОткудаТип
			, k.Название, x.Сегмент, x.ТСНомер, x.УслХранения, a.Транспорт 
			, x.ТС, x.ТСМарка, x.ТСНомер, x.ТСД, x.ТСДНомер, x.ТСДДата
		) a
	-- Мурманск, тарифы на складах
	left outer join (	select Артикул, Склад, Max(Прайс) Прайс 
						from хУслугиСпр 
						where SYS_U is null and Группа='Хранение' and Проект=@project
						group by Артикул, Склад
					)	t on a.ШифрТГ=t.Артикул and a.Откуда=t.Склад



	-- Устькут, тарифы на складах
	left outer join (	select SYS_ID, Цена
						from хОбъекты 
						where SYS_U is null and Тип in ('Склад','Сектор','Место') and Проект=@project
					)	U on a.Откуда=u.SYS_ID



--	where (	(СДаты<=@dk and ПоДату between @dn and @dk) or  (ПоДату is null   and СДаты<=@dk) )
	where СДаты<=@dk and (ПоДату>=@dn or ПоДату is null)
	-- было в таре(ГМ) - это не хранение!
	and ОткудаТип not in ('Тара','Груз')
)