/****** Object:  View [dbo].[Роли_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [Роли_S]
as 
	SELECT Роли.SYS_ID
	, Роли.Роль
	, Роли.SYS_U
	FROM Роли