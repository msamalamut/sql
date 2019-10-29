/****** Object:  Function [dbo].[Документы_Ф]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE Function dbo.Документы_Ф (

 @oper varchar(32)
 
 ) RETURNS TABLE 
AS
RETURN 
(



Select sys_id,ДокТип Документ,Файл, Размер From alls.dbo.Документы  where Sys_U  Is Null and Скан='+'   and Операция=@Oper )
 