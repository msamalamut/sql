/****** Object:  Procedure [dbo].[хОстаткиПересчет]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [хОстаткиПересчет]
as
begin 
	--	[dbo].[хОстаткиПересчет]
	SET NOCOUNT ON;

	declare @i int, @m varchar(4000)
	SELECT @m=''

	--добавить новые
	insert into хОстатки (SYS_ID, Где, Что, Количество, SYS_D, SYS_S, Код, Создал, Создан, Изменил, Изменен, Состояние)
	SELECT				 r.Где+';'+r.Что, r.Где, r.Что, r.Количество, 'хОстаткиПересчет',99,888888,'au',getdate(),'au',getdate(),'Добавлено'
	FROM				хНомос r
	LEFT OUTER JOIN     хОстатки o ON r.Что=o.Что AND r.Где=o.Где
	where				o.SYS_ID is null
	-- сколько добавили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=Cast(isnull(@i,0) as varchar(100)) + ' хОстатки добавлено'  + char(13) + char(10) 



	-- сравнить исправить
	update o set		o.SYS_S=34, o.Количество=isnull(r.Количество,0), o.Изменил='хОстаткиПересчет', o.Изменен=getdate(), o.Состояние='Обновлено'
	FROM				хОстатки o
	LEFT OUTER JOIN		хНомос r ON o.Что = r.Что AND o.Где = r.Где
	where				isnull(o.Количество,0)<>isnull(r.Количество,0)
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хОстатки исправлено' + char(13) + char(10) 



	-- исправить ПартияНомер, НомерДата
	update o set		o.SYS_S=34, o.ПартияДата=d.Дата, o.ПартияНомер=d.Номер, o.Изменил='хОстаткиПересчет', o.Изменен=getdate(), o.Состояние='Обновлено'
	FROM				хОбъекты  o
	INNER JOIN			хДвижение d ON d.SYS_ID = o.Партия
	where				isnull(o.ПартияДата,'')<>isnull(d.Дата,'') or isnull(o.ПартияНомер,'')<>isnull(d.Номер,'')
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хОбъекты исправлено реквизитов (партия дата и номер)' + char(13) + char(10) 


	-- исправить привязку тары у нас на остатках
	update a set a.sys_s=3, a.Подчинен=o.Где
	from хОбъекты a
	inner join хОстатки o on a.SYS_ID=o.что
	where a.тип in ('Тара','Груз') and o.Количество=1 and (a.Подчинен<>o.Где or a.Подчинен is null)
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хОбъекты исправлено записей с привязкой тары и грузомест у нас на остатках' + char(13) + char(10) 


	-- исправить привязку тары на коклажедателя
	update a set a.sys_s=3, a.Подчинен=d.Откуда
	from хОбъекты a
	inner join хДвижение d on a.Партия=d.SYS_ID
	left outer join (select distinct Что from хОстатки where Количество=1) o on a.SYS_ID=o.что
	where a.тип in ('Тара','Груз') and o.что is null and (a.Подчинен<>d.Откуда or a.Подчинен is null)
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хОбъекты, исправлено записей с привязкой тары и грузомест без остатков на поклажедателя' + char(13) + char(10) 


	-- Удаление хОбъекты-МТР по удаленым операциям и строкам
	update o set o.SYS_S=1, o.SYS_U=1, o.Изменен=getdate(), o.Изменил='хПересчет'
	from		хОбъекты		o
	inner join	хДвижение		a on o.Партия=a.SYS_ID
	inner join	хДвижениеСтроки b on a.SYS_ID=b.Операция and o.SYS_ID=b.Что
	where (a.SYS_U is not null or b.SYS_U is not null) and o.SYS_U is null
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хОбъекты, удалено ненужных ТМЦ по удаленым операциям и строкам' + char(13) + char(10) 


	-- Восстановление хОбъекты-МТР по вернутым операциям и строкам
	update o set o.SYS_S=1, o.SYS_U=null, o.Изменен=getdate(), o.Изменил='хПересчет'
	from		хОбъекты		o
	inner join	хДвижение		a on o.Партия=a.SYS_ID
	inner join	хДвижениеСтроки b on a.SYS_ID=b.Операция and o.SYS_ID=b.Что
	where a.SYS_U is null and b.SYS_U is null and o.SYS_U is not null
	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хОбъекты, возвращено нужных ТМЦ по возвращенным операциям и строкам' + char(13) + char(10) 





	---- исправить Контрагент
	--update o set		o.SYS_S=34, o.Контрагент=s.Контрагент, o.Изменил='хОстаткиПересчет', o.Изменен=getdate()
	--FROM				хОбъекты	o
	--INNER JOIN			хДвижение	d ON d.SYS_ID = o.Партия
	--INNER JOIN			хОбъекты	s ON s.SYS_ID = d.Откуда
	--where				o.Контрагент is null
	---- сколько исправили
	--SELECT @i=@@rowcount
	--if @i>0	SELECT @m=@m+Cast(isnull(@i,0) as varchar(100)) + ' хОбъекты, исправлено записей влад-покл в приходах' + char(13) + char(10) 



	-- отчет
	select @m msg


	---- исправить склады
	--update хОбъекты set хОбъекты.Подчинен=хОстатки.Где, хОбъекты.SYS_S=3
	--from хОбъекты
	--inner join хОстатки on хОбъекты.SYS_ID=хОстатки.Что
	--where хОбъекты.Тип='Тара' and хОстатки.Количество=1 and хОбъекты.Подчинен<>хОстатки.Где

end