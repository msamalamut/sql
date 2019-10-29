/****** Object:  Procedure [dbo].[ListCode]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[ListCode] (@filter as nvarchar(200) = null)
AS
BEGIN
	-- exec aa.ListCode 'ListCode'
	SET NOCOUNT ON;
	
	if @filter is null	select @filter = '%'	
	else				select @filter = '%'+@filter+'%'	

	SELECT		*
	FROM		dbo.fn_ListCode()
	WHERE		texte like @filter
	ORDER BY	sort, SchemaName, ObjectName

END
