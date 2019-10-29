/****** Object:  Procedure [dbo].[FixAll]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [FixAll]
AS
BEGIN
	--	exec FixAll
	SET NOCOUNT ON;

	Declare @r varchar(max)
	Declare @T Table (r varchar(max))

	Insert @T Exec хОстаткиПересчет

--	Insert @T Exec хСкладыДерево -- только после хОстаткиПересчет

	Insert @T Exec хПеревозкиСуммы

	Insert @T Exec хОстаткиТопливоПересчет

	Insert @T Exec СотрудникиИсправить

	select @r =isnull(@r,'')+isnull(r,'') from @t
	if @r='' select @r='Все в порядке, пересчет ничего не изменил.'
	select @r msg

	
END