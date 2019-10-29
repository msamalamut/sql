/****** Object:  Function [dbo].[fn_ReestrUslugiSvod_v4]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[fn_ReestrUslugiSvod_v4]
(@project varchar(32), @startdate datetime, @enddate datetime)
RETURNS TABLE 
AS
RETURN 
(
	select	cast(ROW_NUMBER() over(order by a.Услуга) as int) [№№] 
			, a.Услуга, a.Цена, a.Стоимость, a.НДС, a.Сумма, a.Операций
			, cast(cast(a.Сумма    as real)/cast(s.Сумма	as real) as real) ПроцСумма
			, cast(cast(a.Операций as real)/cast(s.Операций as real) as real) ПроцОпераций
			, a.Цена2, a.Стоимость2, a.Цена3, a.Стоимость3
	from (
		select	s.Название Услуга
				, b.Цена
				, sum(b.Стоимость) Стоимость
				, sum(b.НДС) НДС
				, sum(b.Сумма) Сумма
				, count(*) Операций

				, s.Цена2, sum(round(b.Количество*s.Цена2,2)) Стоимость2
				, s.Цена3, sum(round(b.Количество*s.Цена3,2)) Стоимость3

		from			хУслуги			as a
		inner join		хУслугиСтроки	as b on a.SYS_ID=b.Операция
		inner join		хУслугиСпр		as s on b.Услуга=s.SYS_ID
		where a.SYS_U is null  and b.SYS_U is null and a.Дата between @startdate and @enddate and a.Проект=@project
		group by s.Название, b.Цена
				, s.Цена2
				, s.Цена3
	) as a
	cross join (
		select sum(b.Сумма) Сумма, count(*) Операций
		from			хУслуги			as a
		inner join		хУслугиСтроки	as b on a.SYS_ID=b.Операция
		inner join		хУслугиСпр		as s on b.Услуга=s.SYS_ID
		where a.SYS_U is null  and b.SYS_U is null and a.Дата between @startdate and @enddate and a.Проект=@project
	) s
	/*
	----------------------------------------------------------------------------------------------------------------
	UNION ALL
	----------------------------------------------------------------------------------------------------------------
	select	cast(ROW_NUMBER() over(order by a.Услуга) as int) [№№] 
			, a.Услуга, a.Цена, a.Стоимость, a.НДС, a.Сумма, a.Операций
			, cast(cast(a.Сумма    as real)/cast(s.Сумма	as real) as real) ПроцСумма
			, cast(cast(a.Операций as real)/cast(s.Операций as real) as real) ПроцОпераций
			, a.Цена2, a.Стоимость2, a.Цена3, a.Стоимость3
	from (

			select  u.Название Услуга
					, d.Цена
					, sum(d.Стоимость) Стоимость
					, sum(d.НДС) НДС
					, sum(d.Сумма) Сумма
					, count(*) Операций
					, u.Цена2, sum(round(d.Количество * u.Цена2, 2)) Стоимость2
					, u.Цена3, sum(round(d.Количество * u.Цена3, 2)) Стоимость3
			from	хОбъекты o
					join хДвижениеСтроки b on o.SYS_ID = b.Откуда
					join хДвижение a on b.Операция = a.SYS_ID
					join хУслугиСтроки d on b.Привязка = d.SYS_ID
					join хУслугиСпр u on u.SYS_ID = d.Услуга
					join хУслуги e on e.SYS_ID = d.Операция
			where	o.Название like 'ОП крупногабарит%' or o.Название in('ХС', 'ОП', 'ХС легковес')
				and a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
				and a.Проект = @project
				and (a.Дата between @startdate and @enddate
				or	e.Дата between @startdate and @enddate)
			group by u.Название
					, d.Цена, u.Цена2, u.Цена3
		) a
	cross join
			(
			select sum(d.Сумма) Сумма, count(*) Операций
			from	хОбъекты o
					join хДвижениеСтроки b on o.SYS_ID = b.Откуда
					join хДвижение a on b.Операция = a.SYS_ID
					join хУслугиСтроки d on b.Привязка = d.SYS_ID
					join хУслугиСпр u on u.SYS_ID = d.Услуга
					join хУслуги e on e.SYS_ID = d.Операция
			where	o.Название like 'ОП крупногабарит%' or o.Название in('ХС', 'ОП', 'ХС легковес')
				and a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
				and a.Проект = @project
				and (a.Дата between @startdate and @enddate
				or	e.Дата between @startdate and @enddate)

		) s
*/
)