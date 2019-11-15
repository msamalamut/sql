/****** Object:  Function [dbo].[fn_хНомос]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_хНомос](@project varchar(32), @DATA date)
RETURNS TABLE 
AS
RETURN 
(	-- остатки на дату по проекту
	select g.Название ГдеТ, g.Тип ТипГ, h.Название ЧтоТ, h.Тип ТипЧ
	, case when h.КолБЕИ<>0 then isnull(h.ВесКгНетто *o.Количество/h.КолБЕИ,0) end Нетто
	, case when h.КолБЕИ<>0 then isnull(h.ВесКгБрутто*o.Количество/h.КолБЕИ,0) end Брутто
	, o.Количество
--	, 'Остаток' Операция, null Дата, 'НАЧАЛО' Номер
	, g.SYS_ID Где
	, h.SYS_ID Что

	FROM (

			select Где, Что, sum(Количество) as Количество 
			from 
					(	
						select			b.Куда   as Где, b.Что, b.Количество
						FROM			хДвижение		AS a
						INNER JOIN		хДвижениеСтроки AS b  on a.SYS_ID	= b.Операция
						WHERE			a.SYS_U iS null and b.SYS_U is null and b.Количество<>0 
									and a.Дата<=@DATA and a.Проект=@project
					UNION ALL 
						select			b.Откуда as Где, b.Что,-b.Количество
						FROM			хДвижение		AS a
						INNER JOIN		хДвижениеСтроки AS b  on a.SYS_ID	= b.Операция
						WHERE			a.SYS_U iS null and b.SYS_U is null and b.Количество<>0
									and a.Дата<=@DATA and a.Проект=@project
					) as d
			group by Где, Что
			having sum(Количество)<>0

	)  AS o 
	inner join хОбъекты h on h.SYS_ID=o.Что
	inner join хОбъекты g on g.SYS_ID=o.Где


)