/****** Object:  View [dbo].[МТО_Движение]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view МТО_Движение
as
SELECT isnull([СсылкаНомУ2],[МТР]) AS Товар, с.*, Справочники.Название AS ЕдИзм
FROM ((

SELECT б.МТР, а.Откуда, а.Куда, а.SYS_ID, а.ID, б.Количество, б.Стоимость, а.Дата, а.Номер
, 'с_'+(case when а.Направление='Топливо' then 'Топливо' else 'Мто' end)+а.Тип as Таблица, а.Тип
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Закупки','Перемещения','Списания','Услуги')
UNION ALL


SELECT б.МТР, б.Откуда, а.Куда, а.SYS_ID, а.ID, б.Количество, б.Стоимость, а.Дата, а.Номер, 'с_МтоПереброски' as Таблица, а.Тип
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Переброски')
UNION ALL


SELECT а.МТР, а.Откуда, а.Куда, а.SYS_ID, а.ID, б.Количество, б.Стоимость, а.Дата, а.Номер, 'с_МтоМаркировка' as Таблица, а.Тип
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Маркировка')
UNION ALL

SELECT б.МТР, а.Куда, а.Откуда, а.SYS_ID, а.ID, б.Количество, б.Стоимость, а.Дата, а.Номер, 'с_МтоМаркировка' as Таблица, а.Тип
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Маркировка')
UNION ALL

SELECT а.МТР, а.Откуда, б.Куда, а.SYS_ID, а.ID, б.Количество, б.Стоимость, а.Дата, а.Номер, 'с_ТопливоЗаправки' as Таблица, а.Тип
FROM с_НДвижение AS а 
INNER JOIN с_НДвижениеСтроки AS б ON а.SYS_ID = б.Операция
WHERE а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 and а.Тип in ('Заправки')


)  AS с 
INNER JOIN Номенклатура ON с.МТР = Номенклатура.SYS_ID) 
LEFT JOIN Справочники ON Номенклатура.ЕдИзм = Справочники.SYS_ID