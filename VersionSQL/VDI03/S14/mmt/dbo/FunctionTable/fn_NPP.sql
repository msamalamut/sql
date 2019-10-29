/****** Object:  Function [dbo].[fn_NPP]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_NPP](@ID varchar(32))
RETURNS TABLE 
AS
RETURN 
(
--	select * from fn_npp('87534BD542F845EEA90044339C1E1C93') j order by Сортировка

	with aa as (
		-- top level iт oper
		select format(ROW_NUMBER() over(partition by a.SYS_ID order by case when b.Количество<>0 then 1 else 2 end, o.Тип, b.Код, b.ID),'-000') Lvl
		, b.SYS_ID	-- для привязки в операции
		, b.Операция, b.Что, b.Куда	-- для этого запроса
		
		-- для отчета
--		, k.Название ТопКуда--, k.Тип ТопКудаТип
		, case when a.Тип='Выдача' and o.Тип='Тара' then o.Название else k.Название end ТопКуда--, k.Тип ТопКудаТип
--		, cast(case when o.тип in ('тара','груз') then o.Название else ' ТМЦ' end as varchar(max)) ГрузоМесто
		, case when o.тип in ('тара','груз') then format(ROW_NUMBER() over(partition by a.SYS_ID order by  o.Тип, b.Код),'-000') else '-999' end LvlGm
		 -- т.к. это тара или груз, колбеи=1 - то вес можно не пересчитывать
		, k.ВесКгНетто ТопВесКгНетто, k.ВесКгБрутто ТопВесКгБрутто
		, k.ПартияНомер ТопПартия, k.Маркировка ТопМаркировка, k.Упаковка ТопУпаковка, k.Габариты ТопГабариты
		from			хДвижение a
		inner join		хДвижениеСтроки b on a.SYS_ID=b.Операция
		inner join		хОбъекты		o on o.SYS_ID=b.Что
		inner join		хОбъекты		k on k.SYS_ID=b.Куда
		left outer join	хДвижениеСтроки t on b.Куда=t.Что and b.Операция=t.Операция
		where			a.SYS_ID=@id and b.SYS_U is null and t.SYS_ID is null and (b.Количество<>0 or o.КолБЕИДок<>0 and a.тип in ('Приемка','Приход'))

	union all

		select t.Lvl+format(ROW_NUMBER() over(partition by a.SYS_ID, t.Куда order by case when b.Количество<>0 then 1 else 2 end, o.Тип, b.Код, b.ID),'-000') Lvl
		, b.SYS_ID
		, b.Операция, b.Что, b.Куда
		, t.ТопКуда--, t.ТопКудаТип
--		, cast(k.Название as varchar(max)) ГрузоМесто
		, t.LvlGM
		, t.ТопВесКгНетто, t.ТопВесКгБрутто
		, t.ТопПартия, t.ТопМаркировка, t.ТопУпаковка, t.ТопГабариты

		from			хДвижение a
		inner join		хДвижениеСтроки b on a.SYS_ID=b.Операция
		inner join		хОбъекты		o on o.SYS_ID=b.Что
		inner join		хОбъекты		k on k.SYS_ID=b.Куда
		inner join		aa				t on b.Куда=t.Что and b.Операция=t.Операция
		where			a.SYS_ID=@id and b.SYS_U is null and (b.Количество<>0 or o.КолБЕИДок<>0 and a.тип in ('Приемка','Приход'))
	
	)

	select aa.SYS_ID
	, cast(substring(replace(replace(lvl,'-00','.'),'-0','.'),2,500) as varchar(255)) ПН
	, cast(lvl  as varchar(255)) Сортировка
	, ТопКуда, ТопВесКгНетто, ТопВесКгБрутто--, ТопКудаТип, ГрузоМесто
	, ТопПартия, ТопМаркировка, ТопУпаковка, ТопГабариты
	, LvlGm
	from aa 
--	inner join хОбъекты o on aa.Куда=o.SYS_ID
)