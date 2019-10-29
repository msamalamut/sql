/****** Object:  Function [dbo].[fn_SkladPrice]    Committed by VersionSQL https://www.versionsql.com ******/

-- =============================================
-- Author:		osmor
-- Create date: 23.10.2019
-- Description:	вщзвращает цену по складу Цена, Цена2 или цена3
-- поднимается вверх по дереву скадов пока не стретит 'Склад','Сектор','Место' с не пустой ценой
-- Если у верхнего цена пустая вернет 0
-- @SYS_ID_SKLAD - код склада
-- @NameFieldPrice - поле с ценой 
-- =============================================
CREATE FUNCTION [dbo].[fn_SkladPrice](@SYS_ID_SKLAD varchar(32), @NumPrice int ) 

RETURNS money
AS
BEGIN

	-- Declare the return variable here
	DECLARE @SkladPrice money
		, @ParentID varchar(32)
		, @type varchar(32)
		, @i int
		, @continue int

		
	set @i = 1
	set @continue = 1
	while @continue = 1 and @i < 10
	BEGIN
		if @NumPrice = 1
			SELECT @SkladPrice = [Цена] ,@ParentID = [Подчинен], @type = [Тип]  FROM [dbo].[хОбъекты]
			Where Sys_id = @SYS_ID_SKLAD;
		if @NumPrice = 2
			SELECT @SkladPrice = [Цена2] ,@ParentID = [Подчинен], @type = [Тип]  FROM [dbo].[хОбъекты]
			Where Sys_id = @SYS_ID_SKLAD;
		if @NumPrice = 3
		SELECT @SkladPrice = [Цена3] ,@ParentID = [Подчинен], @type = [Тип]  FROM [dbo].[хОбъекты]
			Where Sys_id = @SYS_ID_SKLAD;

			if @type in ('Склад','Сектор','Место') and isnull(@SkladPrice,0) <> 0  
				set @continue = 2
			else
				BEGIN
					if isnull(@ParentID,'') <> ''
						SET @SYS_ID_SKLAD  = @ParentID
					else
						set @continue = 2
						set @SkladPrice = 0
				END
			set @i = @i+1
	END
	-- Return the result of the function
	RETURN @SkladPrice

END