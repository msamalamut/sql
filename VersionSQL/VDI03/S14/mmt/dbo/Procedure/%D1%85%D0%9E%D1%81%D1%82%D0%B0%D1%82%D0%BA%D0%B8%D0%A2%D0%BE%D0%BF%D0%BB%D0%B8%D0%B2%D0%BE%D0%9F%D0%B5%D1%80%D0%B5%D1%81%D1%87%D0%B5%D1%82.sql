/****** Object:  Procedure [dbo].[хОстаткиТопливоПересчет]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [хОстаткиТопливоПересчет]
as
begin 
	--	[dbo].[хОстаткиПересчет]
	SET NOCOUNT ON;

	declare @i int, @m varchar(4000)
	SELECT @m=''


	-- исправить топливо заправки по строкам
	update a set a.SYS_S=1, a.КоличествоКГ=b.КоличествоКГ, a.КоличествоЛ=b.КоличествоЛ
	FROM            хТопливо AS a
	left outer join	(	select		Операция, sum(КоличествоКГ) КоличествоКГ, sum(КоличествоЛ) КоличествоЛ 
						from		хТопливоСтроки 
						where		SYS_U is null
						group by	Операция
					)	AS b on a.SYS_ID=b.Операция 
	where a.Тип='Заправки' and (isnull(b.КоличествоКГ,0)<>isnull(a.КоличествоКГ,0) or isnull(b.КоличествоЛ,0)<>isnull(a.КоличествоЛ,0))
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хТопливо, исправлено записей в заправках топлива' + char(13) + char(10) 


	--добавить новые
	insert into хТопливоОстатки (Где, Что, КоличествоКГ, SYS_D, SYS_S, Код, Создал, Создан, Изменил, Изменен, Состояние)
	SELECT				r.Где, r.Что, r.КоличествоКГ, 'хОстаткиПересчет',99,888888,'au',getdate(),'au',getdate(),'Добавлено'
	FROM				хНомосТопливо r
	LEFT OUTER JOIN     хТопливоОстатки o ON r.Что=o.Что AND r.Где=o.Где
	where				o.SYS_ID is null
	-- сколько добавили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хТопливоОстатки, добавлено записей с остатками топлива'  + char(13) + char(10) 



	-- сравнить исправить
	update o set		o.SYS_S=34, o.КоличествоКГ=isnull(r.КоличествоКГ,0), o.Изменил='хОстаткиПересчет', o.Изменен=getdate(), o.Состояние='Обновлено'
	FROM				хТопливоОстатки o
	LEFT OUTER JOIN		хНомосТопливо r ON o.Что = r.Что AND o.Где = r.Где
	where				isnull(o.КоличествоКГ,0)<>isnull(r.КоличествоКГ,0)
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хТопливоОстатки, исправлено записей с остатками топлива' + char(13) + char(10) 




	-- отчет
	select @m msg


end