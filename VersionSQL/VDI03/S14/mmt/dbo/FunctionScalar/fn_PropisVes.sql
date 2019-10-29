/****** Object:  Function [dbo].[fn_PropisVes]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE function [fn_PropisVes](@tn decimal(18,3))
returns varchar(255)
as
begin 
	return dbo.NumPhrase(floor(@tn),1 )+ ' тн '+cast(floor((@tn-floor(@tn))*1000) as varchar(10)) +' кг'
end