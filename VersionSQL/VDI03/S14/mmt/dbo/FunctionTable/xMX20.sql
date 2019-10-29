/****** Object:  Function [dbo].[xMX20]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[xMX20](@dn datetime, @dk datetime, @prj varchar(32), @ka varchar(32))
RETURNS TABLE 
AS
RETURN 
(

	with t as (
		select mtr, sum(kVH) kkVH, sum(kPr) kkPr, -sum(kRh) kkRh, sum(kKn) kkKn, count(*) rc
		from (
				--	вход Плюс
				SELECT			s.Что mtr, s.Количество kVH, 0 kPr, 0 kRh, s.Количество kKn
				FROM            хДвижение		as i
				INNER JOIN		хДвижениеСтроки	AS s ON i.SYS_ID	= s.Операция 
				WHERE			i.SYS_U IS NULL and s.SYS_U IS NULL and s.Количество<>0 and i.Дата<@dn  
							and i.Проект=@prj and i.Откуда=@ka
			union all

				--	вход минус
				SELECT			s.Что, -s.Количество, 0, 0, -s.Количество
				FROM            хДвижение		as i
				INNER JOIN		хДвижениеСтроки	AS s ON i.SYS_ID	= s.Операция 
				WHERE			i.SYS_U IS NULL and s.SYS_U IS NULL and s.Количество<>0 and i.Дата<@dn  
							and i.Проект=@prj and i.куда=@ka
			union all

				--	период Плюс
				SELECT			s.Что,  0, s.Количество, 0 kRh, s.Количество
				FROM            хДвижение		as i
				INNER JOIN		хДвижениеСтроки	AS s ON i.SYS_ID	= s.Операция 
				WHERE			i.SYS_U IS NULL and s.SYS_U IS NULL and s.Количество<>0 and i.Дата between @dn and @dk 
							and i.Проект=@prj and i.Откуда=@ka
			union all

				--	период минус
				SELECT			s.Что, 0, 0 , -s.Количество, -s.Количество
				FROM            хДвижение		as i 
				INNER JOIN		хДвижениеСтроки	AS s ON i.SYS_ID	= s.Операция 
				WHERE			i.SYS_U IS NULL and s.SYS_U IS NULL and s.Количество<>0 and i.Дата between @dn and @dk
							and i.Проект=@prj and i.куда=@ka
			)	as mt
		group by mtr
	)


	select Cast(ROW_NUMBER() OVER(ORDER BY a.Название, a.Артикул) as int) as npp
	, a.Название, a.Артикул, a.БЕИ, b.КодОКЕИ
	, cast(Round(sum(a.СтоимПрих)/sum(a.КолБЕИ),2) as money) as ЦенаУч
	, nullif(cast(sum(a.ВходКолво)		as money),0)	as ВходКолво	, nullif(cast(sum(a.ВходСумма)		as money),0)	as ВходСумма
	, nullif(cast(sum(a.ПриходКолво)	as money),0)	as ПриходКолво	, nullif(cast(sum(a.ПриходСумма)	as money),0)	as ПриходСумма
	, nullif(cast(sum(a.РасходКолво)	as money),0)	as РасходКолво	, nullif(cast(sum(a.РасходСумма)	as money),0)	as РасходСумма
	, nullif(cast(sum(a.КонецКолво)		as money),0)	as КонецКолво	, nullif(cast(sum(a.КонецСумма)		as money),0)	as КонецСумма
	, sum(a.rc) rc
	from (

		SELECT	t.rc
		, isnull(isnull(n.Название, m.Название),'----') Название, n.Артикул, m.БЕИ
		, m.КолБЕИ, m.Цена*m.КолБЕИ СтоимПрих
		, t.kkVh ВходКолво	, t.kkVh*isnull(m.Цена,0) ВходСумма
		, t.kkPr ПриходКолво, t.kkPr*isnull(m.Цена,0) ПриходСумма
		, t.kkRh РасходКолво, t.kkRh*isnull(m.Цена,0) РасходСумма
		, t.kkKn КонецКолво , t.kkKn*isnull(m.Цена,0) КонецСумма
		from				t
		inner join			хОбъекты		as m on t.mtr=m.SYS_ID
		left outer join		хНоменклатура	as n on m.Номенклатура=n.SYS_ID
		where		m.SYS_U is null
	) a
	left outer join		ЕдиницыИзмерения	as b on	a.БЕИ=b.Название

	group by  a.Название, a.Артикул, a.БЕИ, b.КодОКЕИ
	having sum(a.ВходКолво  )<>0 or sum(a.ВходСумма  )<>0
		or sum(a.ПриходКолво)<>0 or sum(a.ПриходСумма)<>0
		or sum(a.РасходКолво)<>0 or sum(a.РасходСумма)<>0
		or sum(a.КонецКолво )<>0 or sum(a.КонецСумма )<>0

)