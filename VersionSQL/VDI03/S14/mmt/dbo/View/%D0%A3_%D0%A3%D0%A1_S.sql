/****** Object:  View [dbo].[У_УС_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [У_УС_S]
as
	SELECT У_УС.SYS_ID
	, У_УС.Название
	, isnull([У_УС].[Тип],'') +' '+ isnull([Участки].[Название],'') +', '+ isnull([У_УС].[Название],'') AS Название2
	, У_УС.SYS_U
	, У_УС.Участок
	, Участки.Название			AS УчастокНазвание
	, Сотрудники.Название		AS СотрудникНазвание
	, Контрагенты.Название		AS КонтрагентНазвание
	, Контрагенты.ОфНазвание	AS КонтрагентОфНазвание
	, Контрагенты.ИНН, Контрагенты.КПП, Контрагенты.ОКПО, Контрагенты.ОГРЭН, Контрагенты.Код1С
	, Сотрудники.Код1С ТабельныйНомер
	, isnull([Сотрудники].[Фамилия],'') +' '+isnull([Сотрудники].[Имя],'') +' '+isnull([Сотрудники].[Отчество],'') AS FIO
	, У_УС.Тип
	, Контрагенты.ОфАдрес, Контрагенты.ОфТелефон, Контрагенты.ФактАдрес, Контрагенты.БанкРеквизиты
	, У_УС.Автотехника, Справочники.Название AS АвтотехникаВид, Автотехника.ГосНомер, Автотехника.Марка
	, Справочники.Параметр1 AS ШаблонОтчетаАвто
	, Автотехника.ID AS АвтотехникаID
	, У_УС.Состояние
	, Справочники.Параметр2 AS ШаблонОтчетаАвто2
	FROM			У_УС 
	LEFT OUTER JOIN Участки		ON У_УС.Участок = Участки.SYS_ID
	LEFT OUTER JOIN Сотрудники	ON У_УС.Сотрудник = Сотрудники.SYS_ID
	LEFT OUTER JOIN Контрагенты ON У_УС.Контрагент = Контрагенты.SYS_ID
	LEFT OUTER JOIN Автотехника ON У_УС.Автотехника = Автотехника.SYS_ID
	LEFT OUTER JOIN Справочники ON Автотехника.Вид = Справочники.SYS_ID