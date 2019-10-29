/****** Object:  Procedure [dbo].[хСкладыДерево]    Committed by VersionSQL https://www.versionsql.com ******/

create procedure [dbo].[хСкладыДерево]
as
begin 
	--	[хСкладыДерево]
	SET NOCOUNT ON;

	declare @i int, @m varchar(4000)
	SELECT @m=''


	-- сравнить исправить
	update s set s.SYS_S=34, s.SYS_FULL=t.SYS_FULL, s.SYS_TOP=t.SYS_TOP, s.ТипТоп=t.ТипТоп, s.СКЛАДТОП=t.СКЛАДТОП, s.СКЛАДПОЛНЫЙ=t.СКЛАДПОЛНЫЙ, s.SortLevel=t.SortLevel
	, s.Изменил='au', s.Изменен=getdate()
	from хСклады_test t
	inner  join хСклады s on s.SYS_ID=t.SYS_SKLAD
	where t.SYS_FULL<>s.SYS_FULL or t.SYS_TOP<>s.SYS_TOP or t.ТипТоп<>s.ТипТоп or t.СКЛАДТОП<>s.СКЛАДТОП or t.СКЛАДПОЛНЫЙ<>s.СКЛАДПОЛНЫЙ or t.SortLevel<>s.SortLevel
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хСклады исправлено' + char(13) + char(10) 

	-- отчет
	select @m msg


end