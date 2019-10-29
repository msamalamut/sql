/****** Object:  Function [dbo].[fn_хРеестрУслугиУпаковка_R]    Committed by VersionSQL https://www.versionsql.com ******/

-- =============================================
-- Author:		<Kazak>
-- Create date: <20190131>
-- Description:	<Реестр услуг Упаковка>
-- =============================================
CREATE FUNCTION [dbo].[fn_хРеестрУслугиУпаковка_R]
(	
	@project nvarchar(255),
	@startdate datetime,
	@enddate datetime
)
RETURNS TABLE 
AS
RETURN 
(
	with usl as
(	-- Заявка 
	select	
		cast(ROW_NUMBER() over(order by p.Дата, p.Номер, a.Дата, a.Номер, b.Код) as int) npp
		, p.Дата [Дата Поручения], p.Номер [Номер Поручения], p.Тип [Тип Поручения]
		
		-- Поручение АМТП Строй
		, p.ПВДата [Дата ОЛДК], p.ПВНомер [Номер ОЛДК]

		-- Операция (приемка, перемещение (затарка), выдача)
		, d.Дата [Дата Операции], d.Номер [Номер Операции]
		, g.ОфНазвание as Грузовладелец, null as Проект
		
--		, d.Сегмент, case when d.Тип='приемка' then o.Название else k.Название end Поклажедатель
		-- список ТМЦ блять
		, cast(replace(replace(substring( (	
			select	m.Название + isnull(' ' + m.Маркировка,'')+', ' +cast(cast(b.Количество as real) as varchar(20)) + ' ' + m.БЕИ+'|||' as 'data()' 
			from	хДвижениеСтроки as b
					inner join	хОбъекты		as m on m.SYS_ID=b.Что
			where	b.SYS_U is null and b.Количество<>0 and b.Операция=d.SYS_ID
			order by m.ПартияНомер, m.Код, b.Код, m.Название
			for xml path('') 
			) ,1,8000),'||| ',char(13)+char(10)) ,'|||','') as varchar(8000))  as Наименование
		-- Счёт
		, a.Дата as ВфефСФ, a.НомерСФ
		-- Услуга
		, cast(s.Название + isnull(' ('+s.ЕИ+')','') as varchar(300)) Услуга
		, b.Груз, b.Мест
		
		, b.Тоннаж, s.ЕИ, b.Количество
		, b.Цена, b.Стоимость
		, round(b.Количество*b.Цена*1.2,2) Стоимость2
--		, s.Цена2, round(b.Количество*s.Цена2,2) Стоимость2
--		, s.Цена3, round(b.Количество*s.Цена3,2) Стоимость3
		, d.SYS_ID
	from			хУслуги			as a
	inner join		хУслугиСтроки	as b on a.SYS_ID=b.Операция
	inner join		хУслугиСпр		as s on b.Услуга=s.SYS_ID
	left outer join хПоручения		as p on b.Поручение=p.SYS_ID
	full outer join хДвижение		as d on b.Движение=d.SYS_ID
	
	left outer join Контрагенты		as o on d.ОткудаКА=o.SYS_ID
	left outer join Контрагенты		as k on d.кудаКА=k.SYS_ID
	left outer join Контрагенты		as g on p.Грузовладелец = g.SYS_ID

	where 
		(a.SYS_U is null and a.Дата between @startdate and @enddate and a.Проект = @project and b.SYS_U is null) 
	or	(d.SYS_U is null and d.Дата between @startdate and @enddate and d.Проект = @project and b.SYS_U is null)
	and d.Тип = @project and p.Тип = @project
)
, gab as
(	select	o.Прожект, --s.Операция, s.Что			
			o.ДлинаМ, o.ШиринаМ, o.ВысотаМ, o.ОбъемМ3, s.Операция
	from	хДвижениеСтроки s
			join хОбъекты o on s.Что = o.SYS_ID
	where	s.SYS_U is null and s.Количество <> 0 and o.Проект = @project

)

	select	distinct
			-- Заявка
			usl.npp, usl.[Дата Поручения], usl.[Номер Поручения], usl.[Тип Поручения],
			-- Поручение АМТП Строй
			usl.[Дата ОЛДК], usl.[Номер ОЛДК],
			-- Операция (приемка, перемещение (затарка), выдача)
			usl.[Дата Операции], usl.[Номер Операции], usl.Грузовладелец, gab.Прожект, usl.Наименование,
			-- Счёт
			usl.ВфефСФ, usl.НомерСФ,
			-- Услуга
			usl.Услуга, usl.Груз, usl.Мест, 
			gab.ДлинаМ, gab.ШиринаМ, gab.ВысотаМ, gab.ОбъемМ3, usl.Тоннаж,
			-- АМТП Строй
			usl.ЕИ, usl.Количество,
			usl.Цена, usl.Стоимость, usl.Стоимость2
--			usl.SYS_ID,
--			gab.Что
--			o.ДлинаМ, o.ШиринаМ, o.ВысотаМ, o.ОбъемМ3
	from	usl
			join gab on usl.SYS_ID = gab.Операция
--			join хОбъекты o on gab.Что = o.Подчинен


)
