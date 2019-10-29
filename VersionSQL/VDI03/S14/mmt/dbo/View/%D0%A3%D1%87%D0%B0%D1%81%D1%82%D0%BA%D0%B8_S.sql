/****** Object:  View [dbo].[Участки_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [Участки_S]
as
	SELECT Участки.SYS_ID
	, Участки.Название
	, Участки.SYS_U, Участки.Состояние
	FROM Участки