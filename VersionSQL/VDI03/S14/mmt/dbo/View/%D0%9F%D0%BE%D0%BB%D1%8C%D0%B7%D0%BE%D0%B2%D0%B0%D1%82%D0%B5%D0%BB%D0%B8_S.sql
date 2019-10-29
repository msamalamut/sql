/****** Object:  View [dbo].[Пользователи_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view Пользователи_S
as
	SELECT Пользователи.SYS_ID
	, Пользователи.Пользователь
	, Пользователи.SYS_U
	FROM Пользователи