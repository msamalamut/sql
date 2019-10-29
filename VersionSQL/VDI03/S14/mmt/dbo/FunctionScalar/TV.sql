/****** Object:  Function [dbo].[TV]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION TV(@p varchar(32))
RETURNS varchar(32)
AS
BEGIN
	RETURN @p
END
