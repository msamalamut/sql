/****** Object:  Function [dbo].[xMX20mtr]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[xMX20mtr](@dn datetime, @dk datetime, @prj varchar(32), @ka varchar(32))
RETURNS TABLE 
AS
RETURN 
(
--	select * from xMX20mtr('20180101','20180116','Полиэкс','6002E9F7475F4A52B8BD947149016F72') a
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
	, a.Название, a.Артикул, a.БЕИ, a.КодОКЕИ, a.Цена
--	, cast( Round((a.СтоимПрих)/(a.КолБЕИ),2) as money) as ЦенаУч
	, nullif(cast((a.ВходКолво)		as money),0)	as   ВходКолво, nullif(cast((a.ВходВесТнБрутто  )	as decimal(18,6)),0) as   ВходВесТнБрутто, nullif(cast((a.ВходСумма)	as money),0)	as   ВходСумма
	, nullif(cast((a.ПриходКолво)	as money),0)	as ПриходКолво, nullif(cast((a.ПриходВесТнБрутто)	as decimal(18,6)),0) as ПриходВесТнБрутто, nullif(cast((a.ПриходСумма)	as money),0)	as ПриходСумма
	, nullif(cast((a.РасходКолво)	as money),0)	as РасходКолво, nullif(cast((a.РасходВесТнБрутто)	as decimal(18,6)),0) as РасходВесТнБрутто, nullif(cast((a.РасходСумма)	as money),0)	as РасходСумма
	, nullif(cast((a.КонецКолво)	as money),0)	as  КонецКолво, nullif(cast((a.КонецВесТнБрутто )	as decimal(18,6)),0) as  КонецВесТнБрутто, nullif(cast((a.КонецСумма)	as money),0)	as  КонецСумма
	from (

		SELECT	t.rc
		, m.Название, n.Артикул, m.БЕИ, b.КодОКЕИ
		, m.КолБЕИ, m.Цена--, m.Цена*m.КолБЕИ СтоимПрих
		, t.kkVh ВходКолво	, t.kkVh/m.КолБЕИ*m.ВесКгБрутто/1000   ВходВесТнБрутто, t.kkVh*isnull(m.Цена,0)   ВходСумма
		, t.kkPr ПриходКолво, t.kkPr/m.КолБЕИ*m.ВесКгБрутто/1000 ПриходВесТнБрутто, t.kkPr*isnull(m.Цена,0) ПриходСумма
		, t.kkRh РасходКолво, t.kkRh/m.КолБЕИ*m.ВесКгБрутто/1000 РасходВесТнБрутто, t.kkRh*isnull(m.Цена,0) РасходСумма
		, t.kkKn КонецКолво , t.kkKn/m.КолБЕИ*m.ВесКгБрутто/1000  КонецВесТнБрутто, t.kkKn*isnull(m.Цена,0)  КонецСумма
		from				t
		inner join			хОбъекты			as m on t.mtr=m.SYS_ID
		left outer join		хНоменклатура		as n on m.Номенклатура=n.SYS_ID
		left outer join		ЕдиницыИзмерения	as b on	m.БЕИ=b.Название
		where		m.SYS_U is null
	) a

	WHERE  a.ВходКолво<>0 or a.ПриходКолво<>0 or a.РасходКолво<>0 or a.КонецКолво<>0
		
)