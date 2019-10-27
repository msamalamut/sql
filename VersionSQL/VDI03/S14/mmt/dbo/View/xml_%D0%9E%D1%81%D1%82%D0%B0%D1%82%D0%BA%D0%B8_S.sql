/****** Object:  View [dbo].[xml_Остатки_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE VIEW dbo.xml_Остатки_S
AS
SELECT        '<Rests>' AS beginRests, 
                         '<warehouseRegion><Code>' + s.SYS_SKLAD + '</Code><name>' + СкладПолный + '</name><warehouse><Code>' + s.SYS_SKLAD + '</Code><name>' + СкладПОлный + '</name></warehouse></warehouseRegion>' AS warehouseRegion,
                          '<goods><Code>' + a.что + '</Code><name>' + m.Название + '</name>' AS good1, 
                         '<OUM><Code>' + CASE WHEN БЕИ = 'кг' THEN '64E87DFB25E84C8D8D961C728B02752D' WHEN БЕИ = 'компл' THEN '04930FC2C25C467FBE06A5D5BA0E359E' WHEN БЕИ = 'л' THEN '9E86F38CAFBC4652B2F83C1663C5538C'
                          WHEN БЕИ = 'м' THEN 'BD928D74B0DE4ECBBB57F23BCD44F014' WHEN БЕИ = 'м2' THEN 'FFDE699791F84799A50BC6596D2B3072' WHEN БЕИ = 'пар' THEN '4FD69A8EE7DC4B9E8C8877526E44F616' WHEN БЕИ = 'пог.м'
                          THEN '878F95068EE14B7487A6E612902F78D6' WHEN БЕИ = 'рул' THEN '749DEC5D978240309156600FB9FB9529' WHEN БЕИ = 'т' THEN '2087867C3511429FAD370C204934FCA1' WHEN БЕИ = 'упак' THEN 'C9FB8968557048ACA8D0B4A7E8C3C261'
                          WHEN БЕИ = 'шт' THEN '02960BC781344E738C312B0544D96FB7' END + '</Code><name>' + m.БЕИ + '</name><fullName>' + m.БЕИ + '</fullName></OUM>' AS OUM, 
                         '<fullName>' + m.название + '</fullName><isContainer>false</isContainer><isFuel>false</isFuel><shelfLifeDays></shelfLifeDays></goods>' AS goods2, '<receivingDate>' + CONVERT(varchar, m.ПартияДата, 104) 
                         + '</receivingDate>' AS receivingDate, '<MateriallyResponsiblePerson><fullName>NA</fullName><position><Code>1</Code><name>NA</name></position></MateriallyResponsiblePerson>' AS MateriallyResponsiblePerson, 
                         '<Qty>' + CAST(a.КолБеи AS varchar(10)) + '</Qty>' AS Qty, '<mass>' + ISNULL(CAST(a.ВесКгНетто AS varchar(10)), '') + '</mass>' AS mass, '<costWithoutVAT>' + CAST(a.Стоимость AS varchar(10)) 
                         + '</costWithoutVAT>' AS costWithoutVAT, '</Rests>' AS endRests
FROM            dbo.хОбъекты AS m INNER JOIN
                         dbo.хОстатки_S AS a ON a.Что = m.SYS_ID INNER JOIN
                         dbo.хСклады_S AS s ON a.Где = s.SYS_SKLAD LEFT OUTER JOIN
                         dbo.хНоменклатура AS n ON m.Номенклатура = n.SYS_ID LEFT OUTER JOIN
                         dbo.Контрагенты AS k ON m.Контрагент = k.SYS_ID
WHERE        (m.Проект = dbo.TV('Салман')) AND (s.SYS_FULL LIKE dbo.TV('') + '%') AND (s.ТипТоп = 'склад')
