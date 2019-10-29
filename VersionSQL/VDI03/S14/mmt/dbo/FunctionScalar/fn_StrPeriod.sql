/****** Object:  Function [dbo].[fn_StrPeriod]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_StrPeriod](@dn datetime, @dk datetime)
RETURNS varchar(100)
AS
BEGIN
/*	
	print dbo.fn_StrPeriod('20170113',null)
	print dbo.fn_StrPeriod('20170213',null)
	print dbo.fn_StrPeriod('20170313',null)
	print dbo.fn_StrPeriod('20170413',null)
	print dbo.fn_StrPeriod('20170513',null)
	print dbo.fn_StrPeriod('20170613',null)
	print dbo.fn_StrPeriod('20170713',null)
	print dbo.fn_StrPeriod('20170813',null)
	print dbo.fn_StrPeriod('20180202','20180203')

	print convert(varchar(11),cast('20180203' as datetime),105) 
	print convert(varchar(11),cast('20180203' as datetime),106) 
	print convert(varchar(11),cast('20180203' as datetime),107) 
	print convert(varchar(11),cast('20180203' as datetime),108) 
	print convert(varchar(11),cast('20180203' as datetime),109) 
	print convert(varchar(11),cast('20180203' as datetime),110) 
	print convert(varchar(11),cast('20180203' as datetime),111) 
	print convert(varchar(11),cast('20180203' as datetime),112) 
	print substring(convert(varchar(11),cast('20180203' as datetime),113),3,11 )
	print convert(varchar(11),cast('20180203' as datetime),114) 
	print convert(varchar(11),cast('20180203' as datetime),115) 
*/
	DECLARE @ResultVar varchar(100)

	if @dn is null											set @ResultVar=null
	else if @dk is null  									set @ResultVar=convert(varchar(11),@dn,113)
	else if @dn=@dk											set @ResultVar=convert(varchar(11),@dn,113)
--	else if year(@dn)=year(@dk) and month(@dn)= month(@dk)	set @ResultVar=convert(varchar(2),day(@dn)) + '-' + convert(varchar(11),@dk,113)
	else if year(@dn)=year(@dk) and month(@dn)= month(@dk)	set @ResultVar=convert(varchar(2) ,@dn,113) + '-' + convert(varchar(11),@dk,113)
	else if year(@dn)=year(@dk) and month(@dn)<>month(@dk)	set @ResultVar=convert(varchar(6) ,@dn,113) + ' - ' + convert(varchar(11),@dk,113)
	else													set @ResultVar=convert(varchar(11),@dn,113) + 'г - ' + convert(varchar(11),@dk,113)


	set @ResultVar = replace(@ResultVar,'янв','января')
	set @ResultVar = replace(@ResultVar,'фев','февраля')
	set @ResultVar = replace(@ResultVar,'мар','марта')
	set @ResultVar = replace(@ResultVar,'апр','апреля')
	set @ResultVar = replace(@ResultVar,'май','мая')
	set @ResultVar = replace(@ResultVar,'июн','июня')
	set @ResultVar = replace(@ResultVar,'июл','июля')
	set @ResultVar = replace(@ResultVar,'авг','августа')
	set @ResultVar = replace(@ResultVar,'сен','сентября')
	set @ResultVar = replace(@ResultVar,'окт','октября')
	set @ResultVar = replace(@ResultVar,'ноя','ноября')
	set @ResultVar = replace(@ResultVar,'дек','декабря')

	set @ResultVar = replace(@ResultVar,'jan','января')
	set @ResultVar = replace(@ResultVar,'feb','февраля')
	set @ResultVar = replace(@ResultVar,'mar','марта')
	set @ResultVar = replace(@ResultVar,'apr','апреля')
	set @ResultVar = replace(@ResultVar,'may','мая')
	set @ResultVar = replace(@ResultVar,'jun','июня')
	set @ResultVar = replace(@ResultVar,'jul','июля')
	set @ResultVar = replace(@ResultVar,'aug','августа')
	set @ResultVar = replace(@ResultVar,'sep','сентября')
	set @ResultVar = replace(@ResultVar,'oct','октября')
	set @ResultVar = replace(@ResultVar,'nov','ноября')
	set @ResultVar = replace(@ResultVar,'dec','декабря')

	set @ResultVar = @ResultVar+'г'

	RETURN @ResultVar

END