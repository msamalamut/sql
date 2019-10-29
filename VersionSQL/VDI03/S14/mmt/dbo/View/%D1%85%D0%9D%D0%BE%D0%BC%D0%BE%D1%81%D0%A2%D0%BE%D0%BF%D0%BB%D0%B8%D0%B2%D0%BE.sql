/****** Object:  View [dbo].[хНомосТопливо]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [хНомосТопливо]
as
--	select * from хНомосТопливо
	select Где, Что, sum(a.КоличествоКГ) КоличествоКГ
	from (
		select Куда Где, Что, КоличествоКГ from хтопливо where SYS_U is null and КоличествоКГ<>0
		union all
		select Откуда, Что, -КоличествоКГ  from хтопливо where SYS_U is null and КоличествоКГ<>0
	)	as a
	group by Где, Что
	--having sum(a.КоличествоКГ)<>0