/****** Object:  Function [dbo].[fn_ReestrHranNakopOLD]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[fn_ReestrHranNakopOLD](@project varchar(32), @dn datetime, @dk datetime, @LgotPeriod int)
RETURNS TABLE 
AS
RETURN 
(	
	with ba as (
		-- операции
		SELECT h.SYS_ID
		, case a.тип when 'Приемка' then 1 when 'Приход' then 1 when 'Перемещения' then 2 when  'Выдача' then 7 else 9 end as s
		, o.Тип ОткудаТип
		, cast(isnull(h.ВесКгНетто *b.Количество/h.КолБЕИ,0)+isnull(g.Нетто ,0) as decimal(18,0)) Нетто
		, cast(isnull(h.ВесКгБрутто*b.Количество/h.КолБЕИ,0)+isnull(g.Брутто,0) as decimal(18,0)) Брутто
		, b.Количество, b.Мест
		, a.Тип Операция, a.Дата, a.Номер, a.ТСНомер Транспорт
		, o.Название ОткудаТ, k.Название КудаТ, h.Название ЧтоТ, b.Откуда, b.Куда, b.Что
		FROM			хДвижение		AS a
		INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
		INNER JOIN		хОбъекты		AS o ON b.Откуда	= o.SYS_ID
		INNER JOIN		хОбъекты		AS k ON b.куда		= k.SYS_ID
		INNER JOIN		хОбъекты		AS h ON b.Что		= h.SYS_ID

		-- внутритарка - в грузоместе в операции
		left outer join (
				SELECT			b.Операция, b.Куда ЧТО,
								sum(isnull(h.ВесКгНетто,0) *b.Количество/h.КолБЕИ) Нетто,
								sum(isnull(h.ВесКгБрутто,0)*b.Количество/h.КолБЕИ) Брутто
				FROM			хДвижение		AS a
				INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
				INNER JOIN		хОбъекты		AS o ON b.Откуда	= o.SYS_ID		--	Kazak 21112018
				INNER JOIN		хОбъекты		AS k ON b.куда		= k.SYS_ID
				INNER JOIN		хОбъекты		AS h ON b.Что		= h.SYS_ID
				where			k.Тип = 'ГРУЗ'
							and h.Тип = 'Товар'
							and a.SYS_U is null and b.SYS_U is null and b.Количество<>0 and h.КолБЕИ<>0 
							and (h.ВесКгНетто<>0 or h.ВесКгБрутто<>0) and a.Проект=@project and a.Дата<=@dk --and b.Куда<>b.Откуда
				group by		b.Операция, b.Куда
		) G on b.Операция=g.Операция and b.Что=g.ЧТО

		where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 and h.КолБЕИ<>0 and a.Проект=@project --and a.Дата between @dn and @dk
	and a.Дата<=@dk
	and b.Куда<>b.Откуда
--	and not (a.тип='приемка' and k.Тип='груз')
--	and not (a.тип='выдача'  and o.Тип='груз')
--	and not (a.тип='выдача'  and o.Тип='тара')
	union all

	-- остатки на конец
	--/*
	select o.Что, 999 npp, o.ТипГ
	, cast(isnull(o.Нетто ,0)+isnull(v.Нетто ,0) as decimal(18,0)) Нетто
	, cast(isnull(o.Брутто,0)+isnull(v.Брутто,0) as decimal(18,0)) Брутто
	, o.Количество, case when h.КолБЕИ<>0 and h.мест<>0 then cast(ceiling(h.мест*o.Количество/h.КолБЕИ) as int) end мест
	, 'Остаток' Операция, null Дата, 'В наличии' Номер, null Транспорт
	, g.Название ОткудаТ, g.Название КудаТ, h.Название ЧтоТ, g.SYS_ID Откуда, g.SYS_ID Куда, h.SYS_ID Что
	from fn_хНомос(@project, @dk) o
	inner join хОбъекты h on o.Что=h.SYS_ID
	inner join хОбъекты g on o.Где=g.SYS_ID
	left outer join (
			select		Где, sum(Нетто) Нетто, sum(Брутто) Брутто
			from		fn_хНомос(@project, @dk)
			group by	Где
	) as v on o.Что=v.Где
	left outer join fn_хНомос(@project, @dk) o2 on o.Где = o2.Что and o2.Количество>0 --and o2.ТипЧ ='Груз'
	left outer join fn_хНомос(@project, @dk) o3 on o2.Где= o3.Что --and o3.ТипЧ  = 'Тара'
	where	o.ТипГ in ('Склад','Сектор','Место','Груз')  --,'Тара')
		and  (CASE 
			-- товар в грузоместе и грузоместо на складе
			WHEN (o2.типЧ = 'Груз') AND o2.ТипГ in ('Склад','Сектор','Место') THEN 9
			WHEN (o2.типЧ = 'Груз') AND o3.Где IS NULL THEN 1  -- внутритарка в грузоместе, груз в контейнере, контейнер не у нас (1) (9) - у нас
			WHEN (o.типг = 'Груз')  AND o2.Где IS NULL THEN 2  -- 
		ELSE 9 END = 9)

--*/

	--	-- остатки
/*
	select h.SYS_ID, 999 npp, g.Тип
	--	, h.ВесКгНетто *o.Количество/h.КолБЕИ Нетто, h.ВесКгБрутто*o.Количество/h.КолБЕИ Брутто
		, cast(isnull(h.ВесКгНетто *o.Количество/h.КолБЕИ,0)+isnull(v.Нетто ,0) as decimal(18,0)) Нетто
		, cast(isnull(h.ВесКгБрутто*o.Количество/h.КолБЕИ,0)+isnull(v.Брутто,0) as decimal(18,0)) Брутто
		, o.Количество, case when h.КолБЕИ<>0 and h.мест<>0 then cast(ceiling(h.мест*o.Количество/h.КолБЕИ) as int) end мест

		, 'Остаток' Операция, null Дата, 'В наличии' Номер, null Транспорт
		, g.Название ОткудаТ, g.Название КудаТ, h.Название ЧтоТ, g.SYS_ID Откуда, g.SYS_ID Куда, h.SYS_ID Что
		from		хОстатки o
		inner join	хОбъекты h on o.Что=h.SYS_ID
		inner join	хОбъекты g on o.Где=g.SYS_ID

	--	-- внутритарка - в грузоместе на остатках
		left outer join (
				SELECT		o.Где, sum(h.ВесКгНетто *o.Количество/h.КолБЕИ) Нетто, sum(h.ВесКгБрутто*o.Количество/h.КолБЕИ) Брутто
				from		хОстатки o
				inner join	хОбъекты h on o.Что=h.SYS_ID
				inner join	хОбъекты g on o.Где=g.SYS_ID
				where		g.Тип='ГРУЗ' and o.Количество<>0 and h.КолБЕИ<>0 and (h.ВесКгНетто<>0 or h.ВесКгБрутто<>0)
				group by	o.Где
		) v on o.Что=v.Где
		where		o.Количество>0 and h.Проект=@project 
			and g.Тип in ('склад','сектор','место')


*/

	union all



		-- выдача из ГМ
		SELECT o.SYS_ID, 5 s, o.Тип ОткудаТип
		, cast(sum(h.ВесКгНетто *b.Количество/h.КолБЕИ) as decimal(18,0)) Нетто
		, cast(sum(h.ВесКгБрутто*b.Количество/h.КолБЕИ) as decimal(18,0)) Брутто
		, null Количество,	Null мест
		, a.Тип Операция, a.Дата, a.Номер, a.ТСНомер Транспорт
		, o.Название ОткудаТ, k.Название КудаТ, o.Название ЧтоТ, b.Откуда, b.Куда, b.Откуда Что
		FROM			хДвижение		AS a
		INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
		INNER JOIN		хОбъекты		AS o ON b.Откуда	= o.SYS_ID
		INNER JOIN		хОбъекты		AS k ON b.куда		= k.SYS_ID
		INNER JOIN		хОбъекты		AS h ON b.Что		= h.SYS_ID
		where			o.Тип = 'ГРУЗ'
					and a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
					and h.КолБЕИ<>0 and (h.ВесКгНетто<>0 or h.ВесКгБрутто<>0) and a.Проект=@project 
					and b.Куда<>b.Откуда
					and a.Дата<=@dk
--					and o.Код=16671
		group by		o.SYS_ID, o.Тип, a.Тип, a.Дата, a.Номер, a.ТСНомер
		, o.Название, k.Название, o.Название, b.Откуда, b.Куда, b.Откуда


	), bx as (
			select ROW_NUMBER() over(partition by SYS_ID order by s, Дата, Операция) npp, *
			from ba
	), bj as (

	--	select * from bz where Код in (17472)--,17555,17959)

			-- выдача из грузоместа - переделка откуда, добавление к выборке. оригинал сам пропадет
			select a.npp, a.SYS_ID, 6 as s, b.ОткудаТип, a.Нетто, a.Брутто, a.Количество, a.Мест
			, a.Операция+' частичн' Операция, a.Дата, a.Номер, a.Транспорт
			, b.КудаТ ОткудаТ, a.КудаТ, a.ЧтоТ, b.Куда Откуда, a.Куда, a.Что
			from				bx a
			inner join			bx b on a.SYS_ID=b.SYS_ID and a.Откуда=b.Что and a.npp>b.npp
			where a.s=5 --a.Откуда=a.Что
		union all 
			-- полная выборка
			select * 
			from bx where s<>5
	), bz as (
			select ROW_NUMBER() over(partition by SYS_ID order by s, Дата, s) npp
			, SYS_ID, s, ОткудаТип, Нетто, Брутто, Количество, Мест
			, Операция, Дата, Номер, Транспорт
			, ОткудаТ, КудаТ, ЧтоТ, Откуда, Куда, Что

			from bj
	)

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
	select	m.ПартияНомер Партия, ОткудаТ Склад, p.УслХранения, k.Название Поклажедатель,
			p.Сегмент, p.ТСномер ТС, m.Название+isnull(' '+m.маркировка,'') Тмц
	, СДаты, ПоДату

	, datediff(d,СДаты,isnull(ПоДату,@dk))+1  СрокПолный

	, case when (case when dateadd(d,@LgotPeriod,m.ПартияДата)>=@dn then dateadd(d,@LgotPeriod,m.ПартияДата) else @dn end) <= (case when ПоДату<=@dk then ПоДату else @dk end) then
		 datediff(d,case when dateadd(d,@LgotPeriod,m.ПартияДата)>=@dn then dateadd(d,@LgotPeriod,m.ПартияДата) else @dn end, case when ПоДату<=@dk then ПоДату else @dk end)+1 end СрокХранЛьгот
	--, case when (case when СДаты2>=@dn then СДаты2 else @dn end) <= (case when ПоДату<=@dk then ПоДату else @dk end) then
	--	 datediff(d,case when СДаты2>=@dn then СДаты2 else @dn end, case when ПоДату<=@dk then ПоДату else @dk end)+1 end СрокХранЛьгот

	, datediff(d,case when СДаты >=@dn then СДаты  else @dn end, case when ПоДату<=@dk then ПоДату else @dk end)+1 СрокХранения
	, a.Количество, m.БЕИ, a.Мест
	/*
	, case when a.Мест is not null /*and m.Тип = 'Товар'*/ then a.Нетто end Нетто
	, case when a.Мест is not null /*and m.Тип = 'Товар'*/ then a.Брутто end Брутто
	*/
	/*osmor 07042020 что бы вес выводился для всего
	, case when a.Мест is not null and m.Тип = 'Груз' then Null else a.Нетто end Нетто
	, case when a.Мест is not null and m.Тип = 'Груз' then Null else a.Брутто end Брутто
	*/
	,a.Нетто Нетто
	,a.Брутто Брутто
	, a.Операция, a.Номер, a.Транспорт, u.Цена
	, a.npp, m.Код mtr
	, m.тип ТмцТип
	, m.Маркировка
	, dense_rank() over(partition by m.Партия order by m.Партия, m.Маркировка) CargoId
	, row_number() over(partition by m.Партия, m.Маркировка order by m.Партия, m.Маркировка, isnull(a.Мест, 0) desc) PlaceId
	from (
		select  a.Откуда, a.ОткудаТ, a.кудаТ, a.ОткудаТип
		, a.Нетто, a.Брутто, a.Количество, a.Мест
		, a.SYS_ID, a.npp, a.Операция, a.Номер, a.Транспорт
		, a.Дата ПоДату
		, max(b.Дата) СДаты--, dateadd(d,30,max(b.Дата)) СДаты2
		from				bz a
		inner join			bz b on a.SYS_ID=b.SYS_ID
						and a.Откуда = b.куда
						and a.npp > b.npp
		--				and a.Операция = 'Приемка'
		group by			a.Откуда, a.ОткудаТ, a.кудаТ, a.ОткудаТип
							, a.SYS_ID, a.Нетто, a.Брутто, a.Количество, a.Мест
							, a.npp, a.Операция, a.Номер, a.Транспорт
							, a.Дата
	) a	
	-- детализация
	inner join			хОбъекты	m on a.SYS_ID=m.SYS_ID
--	inner join			хДвижениеСтроки	a1 on a1.Код=m.Код
	inner join			хДвижение	p on p.SYS_ID=m.Партия
	left outer join		Контрагенты	k on p.ОткудаКА=k.SYS_ID


	-- Устькут, тарифы на складах
	left outer join (	select SYS_ID, Цена
						from хОбъекты 
						where SYS_U is null and Тип in ('Склад','Сектор','Место') and Проект=@project
					)	U on a.Откуда=u.SYS_ID




	where СДаты <= @dk
	and (ПоДату>=@dn or ПоДату is null)
	-- было в таре(ГМ) - это не хранение!

	--	and ОткудаТип not in ('Тара','Груз')
		and m.тип in ('Товар','Груз')
)