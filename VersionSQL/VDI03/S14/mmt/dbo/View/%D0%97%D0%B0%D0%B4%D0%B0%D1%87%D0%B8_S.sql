/****** Object:  View [dbo].[Задачи_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view Задачи_S
as
	SELECT Задачи.SYS_ID
	, isnull([Задачи].[Название],'') + isnull(' '+[Задачи].[Описание],'') + isnull(' '+convert(varchar(10),[Задачи].[Дата],104),'') + isnull(' '+[Сотрудники].[Название],'') + isnull(' '+[Сотрудники_1].[Название],'') AS Название2
	, Задачи.SYS_U
	FROM (Задачи 
	LEFT JOIN Сотрудники ON Задачи.Постановщик = Сотрудники.SYS_ID) 
	LEFT JOIN Сотрудники AS Сотрудники_1 ON Задачи.Исполнитель = Сотрудники_1.SYS_ID