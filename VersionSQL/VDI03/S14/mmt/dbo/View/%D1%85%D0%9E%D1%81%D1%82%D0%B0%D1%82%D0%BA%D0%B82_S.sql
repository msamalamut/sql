/****** Object:  View [dbo].[хОстатки2_S]    Committed by VersionSQL https://www.versionsql.com ******/

create view хОстатки2_S 
as
--	select * from хОстатки2_S
	with aa as (
		select
		  b.что, b.Где, k.Название ГдеТ
		, b.ВесКгНетто, b.ВесКгБрутто, b.Количество, b.Мест, b.Стоимость, b.Сумма
		
		from			хОстатки_S	b
		inner join		хОбъекты	k on k.SYS_ID=b.Где
		inner join		хОбъекты	h on h.SYS_ID=b.Что
--		where			k.Тип='Тара' and k.Проект='Устькут'-- and b.Количество<>1
--		order by 8,7

	union all

		select
		  b.Что, t.Где, t.ГдеТ
		, b.ВесКгНетто, b.ВесКгБрутто, b.Количество, b.Мест, b.Стоимость, b.Сумма
--		, o.Название
		from			хОстатки_S		b
		inner join		хОбъекты		o on o.SYS_ID=b.Что
		inner join		aa				t on b.Где=t.Что
		where			b.Количество<>0
	
	)

--select * from aa

select  o.Где, o.ГдеТ
, Sum(o.Стоимость) Стоимость
, Sum(o.Сумма) Сумма
, cast(Sum(o.ВесКгНетто ) as decimal(18,3)) ВесКгНетто
, cast(Sum(o.ВесКгБрутто) as decimal(18,3)) ВесКгБрутто
, cast(Sum(CEILING(o.Мест)) as int) Мест
, count(*) Позиций 
from aa o 
group by  o.Где, o.ГдеТ