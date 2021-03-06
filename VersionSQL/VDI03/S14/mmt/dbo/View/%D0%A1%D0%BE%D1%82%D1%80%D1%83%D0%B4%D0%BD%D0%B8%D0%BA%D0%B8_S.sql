/****** Object:  View [dbo].[Сотрудники_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [Сотрудники_S]
as
	SELECT Сотрудники.SYS_ID
		, Сотрудники.Название
		, Сотрудники.Код1С ТабельныйНомер
		, Должности.Название AS Должность
		, Сотрудники.Подразделение
		, Подразделения.Название AS ПодразделениеНазвание
		, isnull([Сотрудники].[Фамилия],'') + ISNULL(' '+[Сотрудники].[Имя],'') + ISNULL(' '+[Сотрудники].[Отчество],'')  AS FIO
		, Участки.Название AS Участок
		, Сотрудники.Емайл
		, Сотрудники.SYS_U
		, Сотрудники.Состояние
		, isnull([Сотрудники].[Фамилия],'') + ISNULL(' '+[Сотрудники].[Имя],'') + ISNULL(' '+[Сотрудники].[Отчество],'')  + ISNULL(', '+Должности.Название,'') + ISNULL(', '+Участки.Название,'') AS FEODAL
		, isnull(Физлица.[ПаспортСерия]+' ','') + isnull('№ '+Физлица.[ПаспортНомер],'') AS Паспорт 
		, Участки.НазваниеПолное НазваниеПодрПолное, Физлица.ДеньРождения
	FROM		Сотрудники 
	LEFT OUTER JOIN Подразделения	ON Сотрудники.Подразделение = Подразделения.SYS_ID
	LEFT OUTER JOIN Должности		ON Сотрудники.Должность = Должности.SYS_ID
	LEFT OUTER JOIN Участки			ON Сотрудники.Участок = Участки.SYS_ID
	LEFT OUTER JOIN Физлица			ON Сотрудники.Физлицо = Физлица.SYS_ID