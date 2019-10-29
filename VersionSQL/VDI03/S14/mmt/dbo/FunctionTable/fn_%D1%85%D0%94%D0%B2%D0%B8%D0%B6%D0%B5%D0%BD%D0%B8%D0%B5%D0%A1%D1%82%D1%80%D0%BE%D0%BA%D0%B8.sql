/****** Object:  Function [dbo].[fn_хДвижениеСтроки]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_хДвижениеСтроки] (@oper VARCHAR(255))
RETURNS TABLE
AS
RETURN (
		SELECT a.Операция, a.Что, a.SYS_ID SYS_IDS
		, CASE WHEN o.Тип = 'Товар' THEN a.Количество END Количество
--		, a.Количество
		, CASE WHEN o.Тип = 'Товар' THEN a.Количество END КолБЕИ
		, CASE WHEN o.Тип = 'Товар' THEN o.БЕИ END БЕИ
		, CAST(o.КолДЕИ * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) КолДЕИ
		, CAST(o.КолАЕИ * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) КолАЕИ
		--, CAST(o.ВесКгНетто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) ВесКгНетто
		--, CAST(o.ВесКгБрутто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) ВесКгБрутто
		--, CAST(o.ВесКгНетто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) / 1000 ВесТнНетто
		--, CAST(o.ВесКгБрутто * a.Количество / o.КолБЕИ AS DECIMAL(18, 3)) / 1000 ВесТнБрутто
		-- округ до кг, граммы не интересны и вредны
		, case when o.ВесКгНетто <>0 and o.КолБЕИ<>0 then CAST(o.ВесКгНетто  * a.Количество / o.КолБЕИ AS DECIMAL(18, 0)) end ВесКгНетто
		, case when o.ВесКгБрутто<>0 and o.КолБЕИ<>0 then CAST(o.ВесКгБрутто * a.Количество / o.КолБЕИ AS DECIMAL(18, 0)) end ВесКгБрутто
		, case when o.ВесКгНетто <>0 and o.КолБЕИ<>0 then CAST(o.ВесКгНетто  * a.Количество / o.КолБЕИ AS DECIMAL(18, 0)) / 1000 end ВесТнНетто
		, case when o.ВесКгБрутто<>0 and o.КолБЕИ<>0 then CAST(o.ВесКгБрутто * a.Количество / o.КолБЕИ AS DECIMAL(18, 0)) / 1000 end ВесТнБрутто

		, a.Мест

		, CAST(round(o.Стоимость * a.Количество / o.КолБЕИ,2) AS money) Стоимость
		, CAST(round(o.Сумма	 * a.Количество / o.КолБЕИ,2) AS money) Сумма
		, CAST(round(o.НДС		 * a.Количество / o.КолБЕИ,2) AS money) НДС
, cast(a.Количество * o.Цена as money) СтоимостьОпер
		, o.Цена, o.СтавкаНДС
--		, o.НДС, o.Стоимость, o.Сумма

		, o.Название, o.Маркировка
		, o.ЗаводскойНомер, o.Описание, o.Габариты, k.Название AS КонтрагенТ, o.ДЕИ, o.АЕИ, o.Упаковка
		, o.Счет1, o.Пломба, o.Код Материал, o.КолБЕИДок, o.ВесКгБруттоДок, o.МестДок, NULL Характеристики
		, isnull('Недостача ' + CAST(o.Недостача AS VARCHAR(20)) + o.БЕИ,'') + isnull(' Излишек ' + CAST(o.Излишек AS VARCHAR(20)) + o.БЕИ,'') AS НедостачаИзлишек
		, n.Артикул, n.Укрупненка, e.КодОКЕИ, o.ПартияНомер, o.Заявка, o.Прожект
		, a.Примечания ПримечанияСтроки, o.Тип стрТип
		, l.Название + ISNULL(' (' + l.Тип + ')', '') стрОткудаТ
		, r.Название + ISNULL(' (' + r.Тип + ')', '') стрКудаТ
		, a.ОтКуда стрОтКуда
		, a.Куда стрКуда

		FROM хДвижениеСтроки AS a
		INNER JOIN хОбъекты AS o ON a.Что = o.SYS_ID
		INNER JOIN хОбъекты AS l ON a.Откуда = l.SYS_ID
		INNER JOIN хОбъекты AS r ON a.Куда = r.SYS_ID
		LEFT OUTER JOIN хНоменклатура AS n ON o.Номенклатура = n.SYS_ID
		LEFT OUTER JOIN ЕдиницыИзмерения AS e ON o.БЕИ = e.Название
		LEFT OUTER JOIN Контрагенты AS k ON o.Контрагент = k.SYS_ID
		WHERE a.Операция = @oper AND a.SYS_U IS NULL AND a.Количество <> 0

)