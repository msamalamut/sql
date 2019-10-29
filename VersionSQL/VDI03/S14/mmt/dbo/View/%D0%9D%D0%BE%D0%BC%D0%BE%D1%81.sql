/****** Object:  View [dbo].[Номос]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [Номос]
as
SELECT У_УС.Тип AS ТипУС, У_УС.SYS_ID AS СКЛАД, У_УС.Участок, Номенклатура.СсылкаНомУ1 AS Головная
, isnull([Номенклатура].[СсылкаНомУ2],[Номенклатура].[SYS_ID]) AS Товар
, Документы.МТР AS МТР
, cast(isnull([Номенклатура].[ЕИКПересчет],1) as money) AS ЕИКПересчет
, Sum(Документы.Количество) AS Колво
, Sum(Документы.Стоимость) AS Стоим
, Count(*) as rc

FROM ((

SELECT а.Куда AS СКЛАД, б.МТР, б.Количество, б.Стоимость
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Закупки','Перемещения','Переброски')

UNION ALL

SELECT а.ОтКуда, б.МТР, -б.Количество, -б.Стоимость
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Перемещения','Списания','Реализация') 

UNION ALL

SELECT б.ОтКуда, б.МТР, -б.Количество, -б.Стоимость
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Переброски') 

UNION ALL


SELECT а.ОтКуда, б.МТР, б.Количество, б.Стоимость
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Маркировка')

UNION ALL

SELECT а.ОтКуда, а.МТР, -б.Количество, -б.Стоимость
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Маркировка')

UNION ALL

SELECT б.Куда, а.МТР, б.Количество, б.Стоимость
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Заправки444')

UNION ALL

SELECT а.ОтКуда, а.МТР, -б.Количество, -б.Стоимость
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Заправки')


)  AS Документы 
LEFT JOIN Номенклатура ON Документы.МТР = Номенклатура.SYS_ID) 
LEFT JOIN У_УС ON Документы.СКЛАД = У_УС.SYS_ID
GROUP BY У_УС.Тип, У_УС.SYS_ID, У_УС.Участок, Номенклатура.СсылкаНомУ1
, isnull([Номенклатура].[СсылкаНомУ2],[Номенклатура].[SYS_ID])
, Документы.МТР
, cast(isnull([Номенклатура].[ЕИКПересчет],1) as money)
HAVING (((Sum(Документы.Количество))<>0))