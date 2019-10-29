/****** Object:  Procedure [dbo].[СотрудникиИсправить]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [СотрудникиИсправить]
as
begin 
	--	[dbo].[хОстаткиПересчет]
	SET NOCOUNT ON;

	declare @i int, @m varchar(4000)
	SELECT @m=''

	-- привязка физлиц
	update s set s.SYS_S=4, s.Физлицо=f.SYS_ID
	from Сотрудники S
	left outer join Физлица f on s.Фамилия=F.Фамилия and s.Имя=f.Имя and isnull(s.отчество,'')=isnull(f.отчество,'')
	where s.Физлицо is null and f.SYS_ID is not null
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' Сотрудники, привязно физлиц' + char(13) + char(10) 

	---- Удаление уволенных сотрудников
	--update s set sys_s=1, sys_u=1, Изменен=getdate(), Изменил='СотрудникиУволенУдалить'
	--from Сотрудники s
	--where SYS_U is null and Статус='93E09D38474B4763ACD225E162141BE2' --Уволен
	---- сколько исправили
	--SELECT @i=@@rowcount
	--if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' Сотрудники, удалено уволенных сотрудников' + char(13) + char(10) 

	---- Удаление пользователей-сотрудников, по удаленным сотрудникам
	--update p set p.sys_s=1, p.sys_u=1
	--from Пользователи p
	--inner join Сотрудники s on p.Сотрудник=s.SYS_ID
	--where s.SYS_U is not null and p.SYS_U is null
	---- сколько исправили
	--SELECT @i=@@rowcount
	--if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' пользователи, удалено уволенных сотрудников' + char(13) + char(10) 




	-- отчет
	select @m msg

end