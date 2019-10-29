/****** Object:  View [dbo].[tmp_Движений]    Committed by VersionSQL https://www.versionsql.com ******/

create view tmp_Движений
as
	select			b.Что, Count(*) as rc
	from			хДвижение		as a 
	INNER JOIN		хДвижениеСтроки	as b on a.SYS_ID=b.Операция
	WHERE			a.SYS_U is null and b.SYS_U is null and b.Количество<>0
	GROUP BY		b.Что
