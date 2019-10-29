/****** Object:  Procedure [dbo].[хПеревозкиСуммы]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [хПеревозкиСуммы]
as
begin 
	--	[dbo].[хОстаткиПересчет]
	SET NOCOUNT ON;

	declare @i int, @m varchar(4000)
	SELECT @m=''



	-- сравнить исправить
--	select *
	update o set		o.SYS_S=34, o.Изменил='хОстаткиПересчет', o.Изменен=getdate()
	, o.СтоимостьПодряд=isnull(r.СтоимостьСчет,0), o.СтоимостьРасход=isnull(r.СтоимостьОплата,0)
	FROM				хПеревозки o
	LEFT OUTER JOIN	(	select Операция, sum(СтоимостьСчет) СтоимостьСчет, sum(СтоимостьОплата) СтоимостьОплата from хПеревозкиПодряд where SYS_U is null group by Операция) r ON o.SYS_ID = r.Операция
	where				isnull(o.СтоимостьПодряд,0)<>isnull(r.СтоимостьСчет,0) OR isnull(o.СтоимостьРасход,0)<>isnull(r.СтоимостьОплата,0)

	-- сколько исправили
	SELECT @i=@@rowcount
	if @i>0	SELECT @m=Cast(isnull(@i,0) as varchar(100)) + ' хПеревозки, исправлено записей перевозски суммы подряда счета-оплаты ' + char(13) + char(10) 





	-- отчет
	select @m msg

end