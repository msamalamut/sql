/****** Object:  Function [dbo].[fn_сПлистыРазверткаДней]    Committed by VersionSQL https://www.versionsql.com ******/

-- =============================================
-- Author:		osmor
-- Create date: 10.10.2019
-- Description:	Возвращает таблицу из с_Плисты с отдельной строкой для каждого дня работы по двум сменам
--т.е.для каждой записи таблицы вернет как минимум 2 записи с разными сменами и + записи для каждого дня работы
-- без малой механизации Автотехника.Класс <> '6FEE008D73A04136AE2BBB4A67D84CBE'
-- и только путевые листы "на линии" ПЛВид = '4F7DBC9C29FA4E9B8FD8F60DE5A3E900' (
-- =============================================
CREATE FUNCTION [dbo].[fn_сПлистыРазверткаДней](
-- @dtFrom дата начала выборки
-- @dtTo дата окончания выборки
@dtFrom datetime,
@dtTo datetime
)

RETURNS 
@table_return TABLE (
Название varchar(150),
Участок varchar(150),
Смена varchar(20),
fld_numday int
)
AS
BEGIN
DECLARE @sys varchar(250)
DECLARE @ts varchar(150)
DECLARE @uch varchar(150)
DECLARE @smena_t int
DECLARE @smena_r int
DECLARE @dt_s datetime
DECLARE @dt_e datetime
DECLARE @numday int
DECLARE @smena_1 varchar(20) = '08:00-20:00'
DECLARE @smena_2 varchar(20) = '20:00-08:00'
DECLARE @smena_text varchar(20)

DECLARE cursor_pp CURSOR FOR

SELECT        sel.SYS_ID, texn.Название AS ТС, uch.Название AS Участок, pl.Смена, sel.смена_т, pl.Дата, pl.ДатаДо
FROM            dbo.Автотехника AS texn RIGHT OUTER JOIN
                         dbo.с_ПЛисты AS pl RIGHT OUTER JOIN
                             (SELECT        SYS_ID, Автотехника, участок, 1 AS смена_т
                               FROM            dbo.с_ПЛисты
                               WHERE        (ПЛВид = '4F7DBC9C29FA4E9B8FD8F60DE5A3E900') AND (дата >= @dtFrom) AND (дата <= @dtTo)
                               UNION
                               SELECT        SYS_ID, Автотехника, участок, 2 AS смена_т
                               FROM            dbo.с_ПЛисты AS с_ПЛисты_1
                               WHERE        (ПЛВид = '4F7DBC9C29FA4E9B8FD8F60DE5A3E900') AND (дата >= @dtFrom) AND (дата <= @dtTo)) AS sel LEFT OUTER JOIN
                         dbo.Участки AS uch ON sel.участок = uch.SYS_ID LEFT OUTER JOIN
                         dbo.У_УС AS y ON sel.Автотехника = y.SYS_ID ON pl.SYS_ID = sel.SYS_ID AND isnull(pl.Смена,1) = sel.смена_т ON texn.SYS_ID = y.Автотехника
						 WHERE        (texn.Класс <> '6FEE008D73A04136AE2BBB4A67D84CBE');
						 
OPEN cursor_pp


FETCH NEXT FROM cursor_pp INTO  @sys, @ts, @uch, @smena_r, @smena_t , @dt_s , @dt_e 

WHILE (@@FETCH_STATUS = 0) 
BEGIN
--INSERT INTO @table_return (fld_ts,fld_uch,Смена,fld_numday) VALUES (@ts, @uch, @smena_r, DATEPART(d, @dt_s))

	IF @smena_t = 1
		SET @smena_text = @smena_1 -- дневная смена
	ELSE
		SET @smena_text = @smena_2 -- Ночная смена

	if @dt_s is null
		INSERT INTO @table_return (Название,Участок,Смена,fld_numday) VALUES (@ts, @uch, @smena_text,0)
	else
	BEGIN
	IF (@dt_s = @dt_e) -- если дни совпадают, то один день
		BEGIN
			SET @numday = DATEPART(d, @dt_s)
			INSERT INTO @table_return (Название,Участок,Смена,fld_numday) VALUES (@ts, @uch, @smena_text, @numday)
		END
	ELSE
		BEGIN
			IF EOMONTH(@dt_s) < @dt_e -- если дата начала и окончания в разных месяцах делаем дату окончания последнюю дату месяца
				SET @dt_e = EOMONTH(@dt_s)
			while @dt_s <= @dt_e -- перебираем все даты
				BEGIN
					SET @numday = DATEPART(d, @dt_s)
					INSERT INTO @table_return (Название,Участок,Смена,fld_numday) VALUES (@ts, @uch, @smena_text, @numday)
					SET @dt_s =  dateadd(y,1, @dt_s)
				END
		END
 
   END

    FETCH NEXT FROM cursor_pp INTO  @sys, @ts, @uch, @smena_r, @smena_t , @dt_s , @dt_e  

END /*WHILE*/

CLOSE cursor_pp
DEALLOCATE cursor_pp


RETURN 
END