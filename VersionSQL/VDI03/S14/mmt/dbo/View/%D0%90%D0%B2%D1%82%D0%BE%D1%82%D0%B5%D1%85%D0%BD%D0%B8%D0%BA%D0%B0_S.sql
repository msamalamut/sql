/****** Object:  View [dbo].[Автотехника_S]    Committed by VersionSQL https://www.versionsql.com ******/



CREATE view [Автотехника_S]
--with schemabinding 
as
	SELECT Автотехника.SYS_ID, Автотехника.Код, Автотехника.Название
	, isnull(в.[Название],'') + isnull(', '+[ГосНомер],'') + isnull(', '+convert(varchar(4),[ГодВыпуска])+'г','') AS Название2
	, Автотехника.Вид  , в.Название AS ВидНазвание
--	, Автотехника.Класс, к.Название AS КлассНазвание
	, в.Параметр1 AS ШаблонОтчета, Автотехника.Топливо, Автотехника.Участок
	, Автотехника.SYS_U
	FROM Автотехника 
	LEFT OUTER JOIN Справочники в ON Автотехника.Вид = в.SYS_ID
--	LEFT OUTER JOIN Справочники к ON Автотехника.Класс = к.SYS_ID


