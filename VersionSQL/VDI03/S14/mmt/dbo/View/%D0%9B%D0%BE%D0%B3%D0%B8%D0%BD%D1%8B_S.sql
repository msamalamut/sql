/****** Object:  View [dbo].[Логины_S]    Committed by VersionSQL https://www.versionsql.com ******/


CREATE VIEW [dbo].[Логины_S]
AS

	SELECT п.SYS_ID, п.Пользователь, п.Пароль, с.SYS_ID AS sys_sotr, с.Название AS Сотрудник, u.Название AS Участок, с.Подразделение AS sys_otd, с.ID AS id_sotr
	FROM			Пользователи AS п 

	INNER JOIN (
		SELECT DISTINCT Права.Пользователь 
		FROM Меню 
		INNER JOIN		Доступ ON Меню.Операция = Доступ.Операция
		INNER JOIN		Роли ON Доступ.Роль = Роли.SYS_ID
		INNER JOIN		Права ON Роли.SYS_ID = Права.Роль 
		WHERE			Меню.SYS_U IS NULL AND Доступ.SYS_U IS NULL AND Права.SYS_U IS NULL AND Роли.SYS_U IS NULL
		GROUP BY		Права.Пользователь
	)	AS о ON п.SYS_ID = о.Пользователь

	LEFT JOIN	(	SELECT * FROM Сотрудники WHERE SYS_U IS NULL)  AS с ON п.Сотрудник = с.SYS_ID
	LEFT JOIN		Участки AS u ON с.Участок = u.SYS_ID

	WHERE			п.SYS_U Is Null


