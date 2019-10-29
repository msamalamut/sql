/****** Object:  View [dbo].[Р_МХ3стр]    Committed by VersionSQL https://www.versionsql.com ******/

create view Р_МХ3стр
AS 

SELECT н.SYS_ID, а.oper, н.Номер, '' AS НаименованиеПоставщика, н.ЕИ, н.ЦенаБНДС, н.БалСчет, н.НомерПартии, а.Кол, а.Вес
, REPLACE(н.Номенклатура, '0000000000', '') AS Номенклатура
, CASE 
  WHEN Номер=-2 OR Номер =-3 OR Номер IS NULL AND (Номенклатура LIKE '%999999%' OR Номенклатура LIKE '%222222%') 
  THEN 'Грузоместо ЗАО "Полюс"(' + CONVERT(varchar(3000), НаименованиеПоставщика) + ')' 
  ELSE CONVERT(varchar(3000), НаименованиеПоставщика) 
  END AS Название
FROM be0.dbo.МТР_СОД AS а
INNER JOIN be0.dbo.мтр_Номенклатура AS н ON а.mtr = н.SYS_ID
WHERE (н.SYS_U IS NULL) AND (а.Кол <> 0) AND (н.Количество > 0)


