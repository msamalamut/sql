/****** Object:  View [dbo].[хСкладыАктив_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [хСкладыАктив_S]
as
--	select * from хСкладыАктив_S where Проект = 'Устькут' ORDER BY SortLevel, СКЛАДПОЛНЫЙ

	SELECT DISTINCT S.SYS_FULL, S.СКЛАДПОЛНЫЙ, S.ТипОбъекта, S.ТипТоп, s.Проект, s.SortLevel  
	FROM хСклады_S as s      
	inner JOIN хОстатки as o ON S.SYS_SKLAD = o.Где          
	WHERE S.ТипТоп='Склад' AND S.ТипОбъекта<>'Склад' AND o.Количество<>0         

	UNION   
	-- склады неудаленные
	SELECT  S.SYS_FULL, S.СКЛАДПОЛНЫЙ , S.ТипОбъекта, S.ТипТоп, s.Проект, s.SortLevel
	FROM хСклады_S as s       
	WHERE S.ТипОбъекта='Склад' and s.SYS_U is null