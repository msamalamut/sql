/****** Object:  Function [dbo].[fn_BalanceOnDate]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[fn_BalanceOnDate](@project varchar(32), @DATA date)
RETURNS TABLE 
AS
RETURN 
(	-- остатки на товару на дату сумма прихода минус расход
select Что, где             
,      sum(balance) as balance
from ( SELECT vds.Что
, vds.Откуда где 
,             - vds.количество balance
FROM       dbo.хДвижение       AS vd 
INNER JOIN dbo.хДвижениеСтроки AS vds ON vd.SYS_ID = vds.Операция
INNER JOIN dbo.хОбъекты        AS vo  ON vds.Куда = vo.SYS_ID
WHERE (
	vd.Тип = 'Перемещения'
	OR vd.Тип = 'Выдача'
	)
	AND (
	vo.Тип IN (
	'Тара'
	,'Место'
	,'Контрагент'
	, 'Сектор'
	, 'Груз'
	)
	)
	AND (vd.Дата < @DATA )
	AND (vd.SYS_U IS NULL)
	AND (vds.SYS_U IS NULL)
	AND (vds.количество <> 0)
	AND (vds.Откуда <> vds.куда)
	and vd.Проект=@project

UNION ALL

SELECT vds.Что
, vds.Куда где
,            vds.количество  as balance
FROM       dbo.хДвижение       AS vd 
INNER JOIN dbo.хДвижениеСтроки AS vds ON vd.SYS_ID = vds.Операция
INNER JOIN dbo.хОбъекты        AS vo  ON vds.Куда = vo.SYS_ID

WHERE 
	(
	  (vd.Тип = 'Приемка' 	AND	vo.Тип <> 'Тара') 
	  or (vd.тип = 'Перемещения' and vo.тип IN ('Сектор','Груз'))
	 )
	AND (vd.Дата < @DATA)
	AND (vd.SYS_U IS NULL)
	AND (vds.SYS_U IS NULL)
	AND (vds.количество <> 0)
	AND (vds.Откуда <> vds.куда)
	and vd.Проект=@project)
as d
group by Что, где 
having sum(balance)>0

)