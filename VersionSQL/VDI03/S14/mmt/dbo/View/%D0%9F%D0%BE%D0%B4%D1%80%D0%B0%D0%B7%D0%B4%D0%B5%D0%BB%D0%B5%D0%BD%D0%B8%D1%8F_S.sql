/****** Object:  View [dbo].[Подразделения_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [Подразделения_S]
as
	SELECT Подразделения.SYS_ID
	, Подразделения.Название, Подразделения.Подчинен, Подразделения.Начальник, Подразделения.Емайл
	, Подразделения.SYS_U
	FROM Подразделения