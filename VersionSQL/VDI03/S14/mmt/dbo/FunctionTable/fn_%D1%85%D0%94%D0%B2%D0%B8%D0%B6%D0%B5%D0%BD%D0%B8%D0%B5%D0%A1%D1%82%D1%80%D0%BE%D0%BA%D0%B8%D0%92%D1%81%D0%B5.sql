/****** Object:  Function [dbo].[fn_хДвижениеСтрокиВсе]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_хДвижениеСтрокиВсе] (@oper VARCHAR(255))
RETURNS TABLE
AS
RETURN (
--	select npp, стрТип, Название, Количество, Мест, cтрКуда, l1, l2 from fn_хДвижениеСтроки('DC2390B87D4743D5A619379D0D57A46A')
	SELECT CAST(ROW_NUMBER() OVER (ORDER BY l1, l2) AS INT) npp, *
	FROM (
		SELECT a.Операция, a.Что
		, a.Количество
		, a.Количество КолБЕИ
--		, CASE WHEN o.Тип = 'Груз' THEN NULL ELSE a.Количество END Количество
--		, CASE WHEN o.Тип = 'Груз' THEN NULL ELSE a.Количество END КолБЕИ
		, CAST(o.КолДЕИ * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) КолДЕИ
		, CAST(o.КолАЕИ * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) КолАЕИ
		, CAST(o.ВесКгНетто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) ВесКгНетто
		, CAST(o.ВесКгБрутто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) ВесКгБрутто
		, CAST(o.ВесКгНетто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) / 1000 ВесТнНетто
		, CAST(o.ВесКгБрутто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) / 1000 ВесТнБрутто
		, CAST(o.Мест * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) Мест
		, a.Количество * o.Цена СтоимостьОпер, o.Цена, o.СтавкаНДС, o.НДС, o.Стоимость, o.Сумма, o.Название, o.Маркировка
		, o.ЗаводскойНомер, o.Описание, o.Габариты, k.Название AS КонтрагенТ, o.БЕИ, o.ДЕИ, o.АЕИ, o.Упаковка
		, o.Счет1, o.Пломба, o.Код Материал, o.КолБЕИДок, o.ВесКгБруттоДок, o.МестДок, NULL Характеристики
		, 'Недостача ' + CAST(o.Недостача AS VARCHAR(20)) + o.БЕИ + ' Излишек ' + CAST(o.Излишек AS VARCHAR(20)) + o.БЕИ AS НедостачаИзлишек
		, n.Артикул, e.КодОКЕИ, o.ПартияНомер, o.Заявка, o.Прожект
		--	, a.Примечания стрПримечания
		, a.Примечания ПримечанияСтроки, o.Тип стрТип
		--	, l.Название + isnull(' ('+l.Тип+')','') cтрОткуда
		--	, r.Название + isnull(' ('+r.Тип+')','') cтрКуда
		, l.Название + ISNULL(' (' + l.Тип + ')', '') стрОткудаТ
		, r.Название + ISNULL(' (' + r.Тип + ')', '') стрКудаТ
		, a.ОтКуда стрОтКуда
		, a.Куда стрКуда
		, a.ID стрID
		, CASE WHEN r.Тип IN ('Груз', 'Тара') THEN r.Код ELSE o.Код END l1
		, CASE WHEN r.Тип IN ('Груз', 'Тара') THEN o.Код ELSE 0 END l2

		FROM хДвижениеСтроки AS a
		INNER JOIN хОбъекты AS o ON a.Что = o.SYS_ID
		INNER JOIN хОбъекты AS l ON a.Откуда = l.SYS_ID
		INNER JOIN хОбъекты AS r ON a.Куда = r.SYS_ID
		LEFT OUTER JOIN хНоменклатура AS n ON o.Номенклатура = n.SYS_ID
		LEFT OUTER JOIN ЕдиницыИзмерения AS e ON o.БЕИ = e.Название
		LEFT OUTER JOIN Контрагенты AS k ON o.Контрагент = k.SYS_ID
		WHERE a.Операция = @oper AND a.SYS_U IS NULL --AND a.Количество <> 0
	) a

)