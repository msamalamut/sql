/****** Object:  Function [dbo].[fn_PlOneValue]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_PlOneValue](@auto varchar(32), @org varchar(32), @data datetime, @nk bit, @pole varchar(32))
RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @r money

	if @nk=0
		select top 1 @r=case @pole 
			when 'МТР_Начало'		then МТР_Начало 
			when 'МТР_Конец'		then МТР_Конец 
			when 'Спидометр_Начало'	then Спидометр_Начало 
			when 'Спидометр_Конец'	then Спидометр_Конец 
			when 'Моточасы_Начало'	then Моточасы_Начало 
			when 'Моточасы_Конец'	then Моточасы_Конец 
				 end
		from с_ПЛисты 
		where SYS_U is null and Состояние is not null and Автотехника=@auto and Организация=@org and Дата>=@data 
		order by Дата, Смена, Код

	else
		select top 1 @r=case @pole 
			when 'МТР_Начало'		then МТР_Начало 
			when 'МТР_Конец'		then МТР_Конец 
			when 'Спидометр_Начало' then Спидометр_Начало 
			when 'Спидометр_Конец'	then Спидометр_Конец 
			when 'Моточасы_Начало'	then Моточасы_Начало 
			when 'Моточасы_Конец'	then Моточасы_Конец 
			end
		from с_ПЛисты 
		where SYS_U is null and Состояние is not null and Автотехника=@auto and Организация=@org and Дата<=@data 
		order by Дата desc, Смена desc, Код desc

	RETURN @r

END