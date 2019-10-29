/****** Object:  Function [dbo].[fn_VM]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_VM](@id varchar(32))
RETURNS TABLE 
AS
RETURN 
(
	SELECT
	  sum(s.Мест) Мест
	, cast(sum(cast(s.Количество/o.КолБЕИ*o.ВесКгНетто  as decimal(18,0))) as decimal(18,0)) ВесКгНетто
	, cast(sum(cast(s.Количество/o.КолБЕИ*o.ВесКгБрутто as decimal(18,0))) as decimal(18,0)) ВесКгБрутто
	, cast(sum(cast(s.Количество/o.КолБЕИ*o.ВесКгБрутто as decimal(18,0))/1000) as decimal(18,3)) ВесТн
	, count(*) rc

	, cast(sum(cast(o.ВесКгБрутто as decimal(18,0))/1000) as decimal(18,3)) ВесТнПриход

	FROM        хДвижениеСтроки AS s 
	inner join	хОбъекты AS o on o.SYS_ID=s.Что
	WHERE       s.Операция=@id and s.SYS_U is null and s.Количество<>0 and o.КолБЕИ<>0
)