/****** Object:  View [dbo].[хНомос]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [хНомос]
as
--	select * from хНомос
	select Где, Что, sum(Количество) as Количество 
	from 
			(	
				select			b.Куда   as Где, b.Что, b.Количество
				FROM			хДвижение		AS a
				INNER JOIN		хДвижениеСтроки AS b  on a.SYS_ID	= b.Операция
				WHERE			a.SYS_U iS null and b.SYS_U is null and b.Количество<>0
			UNION ALL 
				select			b.Откуда as Где, b.Что,-b.Количество
				FROM			хДвижение		AS a
				INNER JOIN		хДвижениеСтроки AS b  on a.SYS_ID	= b.Операция
				WHERE			a.SYS_U iS null and b.SYS_U is null and b.Количество<>0
			) as d
	group by Где, Что