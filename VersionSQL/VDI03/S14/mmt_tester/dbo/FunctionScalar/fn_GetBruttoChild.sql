/****** Object:  Function [dbo].[fn_GetBruttoChild]    Committed by VersionSQL https://www.versionsql.com ******/

-- =============================================
-- Author:		osmor
-- Create date: 29.10.2019
-- Description:	Возвращает сумму веса Брутто Всех товаров у которых переданный SYS_ID является родителем
-- в указаннои движении
-- =============================================
CREATE FUNCTION fn_GetBruttoChild ( @sys_id_parent varchar(32), @sys_id_oper varchar(32) )
RETURNS decimal(18,3)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @SumNetto DECIMAL(18, 3)

	SELECT @SumNetto = SUM(o.ВесКгБрутто)
	FROM       dbo.хДвижениеСтроки AS ds
	INNER JOIN dbo.хОбъекты        AS o  ON ds.Что = o.SYS_ID
	WHERE (ds.Куда = @sys_id_parent) and ds.Операция = @sys_id_oper
	GROUP BY ds.Куда

	RETURN isnull(@SumNetto, 0)

END
