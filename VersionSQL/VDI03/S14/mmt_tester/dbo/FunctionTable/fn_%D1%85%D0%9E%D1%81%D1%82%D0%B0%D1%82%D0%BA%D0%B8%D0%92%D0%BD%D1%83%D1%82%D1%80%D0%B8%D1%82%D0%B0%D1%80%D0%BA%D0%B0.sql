/****** Object:  Function [dbo].[fn_хОстаткиВнутритарка]    Committed by VersionSQL https://www.versionsql.com ******/


CREATE FUNCTION [dbo].[fn_хОстаткиВнутритарка] (
	@project VARCHAR(32)
	,@DATA DATE
	)
RETURNS TABLE
AS
RETURN (
		-- остатки на дату по проекту
		SELECT g.Название ГдеТ
			,g.Тип ТипГ
			,h.Название ЧтоТ
			,h.Тип ТипЧ
			,CASE 
				WHEN h.КолБЕИ <> 0
					THEN isnull(h.ВесКгНетто * o.Количество / h.КолБЕИ, 0)
				END Нетто
			,CASE 
				WHEN h.КолБЕИ <> 0
					THEN isnull(h.ВесКгБрутто * o.Количество / h.КолБЕИ, 0)
				END Брутто
			,o.Количество
			--	, 'Остаток' Операция, null Дата, 'НАЧАЛО' Номер
			,g.SYS_ID Где
			,h.SYS_ID Что
		FROM (
			SELECT Где
				,Что
				,sum(Количество) AS Количество
			FROM (
				-- Весь приход
				SELECT b.Куда AS Где
					,b.Что
					,b.Количество
				FROM dbo.хДвижение AS a
				INNER JOIN dbo.хДвижениеСтроки AS b ON a.SYS_ID = b.Операция
				INNER JOIN dbo.хОбъекты AS ot ON b.Откуда = ot.SYS_ID
				WHERE (a.SYS_U IS NULL)
					AND (b.SYS_U IS NULL)
					AND (b.Количество <> 0)
					AND (a.Дата <= @DATA)
					AND (a.Проект = @project)
					AND (ot.Тип = 'Контрагент')
				
				UNION ALL
					
					-- Расход
					SELECT DISTINCT b.Откуда AS Где
					,b.Что
					,- b.Количество 
					
				FROM dbo.хДвижениеСтроки AS b
				INNER JOIN dbo.хДвижение AS a ON b.Операция = a.SYS_ID
				INNER JOIN dbo.хСклады_S AS s ON b.Куда = s.SYS_SKLAD
				WHERE (a.SYS_U IS NULL)
					AND (b.SYS_U IS NULL)
					AND (b.Количество <> 0)
					AND (a.Дата <= @DATA)
					AND (a.Проект = @project)
					AND (s.типТоп = 'Контрагент')
				) AS d
			GROUP BY Где
				,Что
			HAVING sum(Количество) <> 0
			) AS o
		INNER JOIN хОбъекты h ON h.SYS_ID = o.Что
		INNER JOIN хОбъекты g ON g.SYS_ID = o.Где
		)