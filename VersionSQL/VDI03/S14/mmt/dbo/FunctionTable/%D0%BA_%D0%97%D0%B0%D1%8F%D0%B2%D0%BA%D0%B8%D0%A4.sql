/****** Object:  Function [dbo].[к_ЗаявкиФ]    Committed by VersionSQL https://www.versionsql.com ******/

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION dbo.к_ЗаявкиФ

(	


)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
SELECT        к_Заявки.SYS_ID, к_Заявки.Номер, к_Заявки.Дата, к_Клиенты.Название AS Клиент, к_Заявки.ДоговорНомер, к_Заявки.ДоговорДата, 
                         к_Заявки.ДоговорСодержание, к_Заявки.Направление, к_Заявки.Состояние, к_Заявки.Номер + ' от:' + CONVERT(varchar(32), к_Заявки.Дата) 
                         + к_клиенты.Название AS Заявка
FROM            к_Заявки INNER JOIN
                         к_Клиенты ON к_Заявки.Заказчик = к_Клиенты.SYS_ID
WHERE        (к_Заявки.SYS_U IS NULL) AND (NOT (к_Заявки.Состояние LIKE '%отклонен%'))
)
