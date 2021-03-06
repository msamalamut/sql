/****** Object:  View [dbo].[Номенклатура1С_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [dbo].[Номенклатура1С_S]
as 
	SELECT Номенклатура1С.SYS_ID
	, isnull([Номенклатура1С].[Название],'') 
	+ ' (' +isnull('Код:'+CAST([Номенклатура1С].[Код] as varchar(10)),'') 
--	+ isnull(', '+[ТипНДС],', ТипНДС не указан') 
	+ isnull(', НДС '+cast(cast([СтавкаНДС] as real)*100 as varchar(20))+'%',', Без НДС') 
	+ isnull(', '+[Справочники].[Название],'') 
	+ isnull(', '+[Код1С],'')+')' AS Название2
	, Номенклатура1С.Код1С, Номенклатура1С.ЕдИзм, Номенклатура1С.Название
	, Номенклатура1С.SYS_U, Номенклатура1С.Состояние, Номенклатура1С.СтавкаНДС
	FROM Номенклатура1С 
	LEFT JOIN Справочники ON Номенклатура1С.ЕдИзм = Справочники.SYS_ID