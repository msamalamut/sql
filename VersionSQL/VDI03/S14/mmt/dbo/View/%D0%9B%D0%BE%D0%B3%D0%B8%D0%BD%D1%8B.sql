/****** Object:  View [dbo].[Логины]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE VIEW [dbo].[Логины]
AS
	SELECT п.Пользователь, п.Пароль, п.SYS_ID, с.Название AS Сотрудник
	
	, у.Название Участок --/*isnull(у.Название,'--') + isnull('. '+д.Название,'. --') + isnull('. '+м.Название,'. --')*/ Описание
	, с.SYS_ID AS sys_sotr, с.Подразделение AS sys_otd, с.ID AS id_sotr
	
	FROM			Пользователи AS п 
	LEFT JOIN		Сотрудники		AS с ON п.Сотрудник		= с.SYS_ID
	LEFT JOIN		Должности		AS д ON с.Должность		= д.SYS_ID
	LEFT JOIN		Подразделения	AS м ON с.Подразделение = м.SYS_ID
	LEFT JOIN		Участки			AS у ON с.Участок = у.SYS_ID
	WHERE			п.SYS_U Is Null