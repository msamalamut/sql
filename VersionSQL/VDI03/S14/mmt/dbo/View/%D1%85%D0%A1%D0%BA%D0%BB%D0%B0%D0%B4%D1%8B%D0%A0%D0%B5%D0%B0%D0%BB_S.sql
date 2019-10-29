/****** Object:  View [dbo].[хСкладыРеал_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [хСкладыРеал_S]
AS 
--	Дерево складов!
/*	
select СКЛАД, ТипОбъекта, СКЛАДПОЛНЫЙ, ТипТоп, SYS_U, SortLevel 
from [хСкладыРеал_S] 
where проект='Устькут' and SYS_U is null
--ТипОбъекта ='автотехника'
order by SortLevel, СКЛАДПОЛНЫЙ
*/
	with 
	-- склады
	tree	as (
			-- топсклады
			select				a.SYS_ID SYS_SKLAD , a.Название		AS СКЛАД
							,	a.SYS_ID AS SYS_TOP, a.Название		AS СКЛАДТОП
							,	CAST(a.SYS_ID   as varchar(max))	as SYS_FULL
							,	CAST(a.Название as varchar(max))	AS СКЛАДПОЛНЫЙ
							,	CAST(a.Название as varchar(max))	AS СКЛАДДВ
							,	CAST(null		as varchar(max))	AS СКЛАДполутоп
							,	1 as lvl, a.Тип as ТипОбъекта, a.Тип ТипТоп, a.Проект, a.SYS_U, a.Контрагент, a.Автотехника
							,	CAST(case when a.Тип='Склад' then '-001' when a.Тип='Ресурс' then '-002' else '-003' end as varchar(max)) SortLevel
			FROM				хОбъекты a 
			WHERE				a.Тип in ('Склад','Контрагент','Ресурс')  AND a.Подчинен is null -- and a.SYS_U is null

			union all

			-- дочки складов, но не тара
			select				хОбъекты.SYS_ID, хОбъекты.Название
							,	tree.SYS_TOP, tree.СКЛАДТОП
							,	tree.SYS_FULL   +'->'+хОбъекты.SYS_ID
							,	tree.СКЛАДПОЛНЫЙ+'->'+хОбъекты.Название
							,	tree.СКЛАДПОЛНЫЙ+'->'+хОбъекты.Название
							,	isnull(tree.СКЛАДполутоп+'->','')+хОбъекты.Название
							,	tree.lvl+1 AS lvl, хОбъекты.Тип, tree.ТипТоп, хОбъекты.Проект, хОбъекты.SYS_U, хОбъекты.Контрагент, хОбъекты.Автотехника
							,	tree.SortLevel + case when хОбъекты.Тип='Сектор' then '-001' when хОбъекты.Тип='Место' then '-002' else '-003' end SortLevel
			FROM				хОбъекты
			INNER JOIN			tree on хОбъекты.Подчинен = tree.SYS_SKLAD
			WHERE				хОбъекты.Тип IN ('Сектор','Место')

	)
	-- дерево складов без тары
	select		SYS_SKLAD	, СКЛАД
			,	SYS_TOP		, СКЛАДТОП
			,	SYS_FULL	,	cast(СКЛАДПОЛНЫЙ as varchar(255)) as СКЛАДПОЛНЫЙ
			,	СКЛАДДВ, СКЛАДполутоп
			,	lvl, ТипОбъекта, ТипТоп, Проект, tree.SYS_U, Контрагент, Автотехника
			,	SortLevel
	from tree