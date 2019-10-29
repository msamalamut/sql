/****** Object:  View [dbo].[хСклады_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [хСклады_S]
AS 
-- новый хсклады_s - все через подчинен
/*	
select * from хСклады_S where проект='Устькут' and SYS_U is null
--ТипОбъекта ='автотехника'
order by SortLevel, СКЛАДПОЛНЫЙ
*/

	with 
	-- склады
	tree	as (
			-- топсклады
			select				format(ROW_NUMBER() over(order by a.Проект, case a.Тип when 'Склад' then 1 when 'Контрагент' then 2 when 'Ресурс' then 3 when 'Автотехника' then 4 else 5 end, a.Название),'-000') SortLevel
							,	a.SYS_ID							AS SYS_SKLAD 
							,	CAST(a.Название as varchar(max))	AS СКЛАД
							,	a.SYS_ID							AS SYS_TOP
							,	CAST(a.Название as varchar(max))	AS СКЛАДТОП
							,	CAST(a.SYS_ID   as varchar(max))	as SYS_FULL
							,	CAST(a.Название as varchar(max))	AS СКЛАДПОЛНЫЙ
							,	CAST(a.Название as varchar(max))	AS СКЛАДДВ
							,	CAST(null		as varchar(max))	AS СКЛАДполутоп
							,	1 as lvl, a.Тип as ТипОбъекта, a.Тип ТипТоп, a.Проект, a.SYS_U, a.Контрагент, a.Автотехника, a.Маркировка, a.ПартияНомер
						--	,	CAST(case when a.Тип='Склад' then '-001' when a.Тип='Ресурс' then '-002' else '-003' end as varchar(max)) SortLevel
			FROM				хОбъекты a 
			WHERE				a.Тип in ('Склад','Контрагент','Ресурс','Автотехника','МОЛ') AND a.Подчинен is null -- and a.SYS_U is null

			union all

			-- дочки складов, но не тара
			select				t.SortLevel+format(ROW_NUMBER() over(partition by t.SYS_SKLAD order by a.Проект, case a.Тип when 'Сектор' then 1 when 'Место' then 2 when 'Тара' then 3 when 'Груз' then 4 else 5 end, a.Название),'-000') SortLevel
							,	a.SYS_ID									AS SYS_SKLAD 
							,	CAST(a.Название	as varchar(max))			AS СКЛАД
							,	t.SYS_TOP
							,	t.СКЛАДТОП
							,	t.SYS_FULL   +'->'+a.SYS_ID					AS SYS_FULL
							,	CAST(t.СКЛАДПОЛНЫЙ+'->'+a.Название as varchar(max)) as СКЛАДПОЛНЫЙ
							,	CAST(t.СКЛАДПОЛНЫЙ+'->'+a.Название as varchar(max))	as СКЛАДДВ
							,	isnull(t.СКЛАДполутоп+'->','')+a.Название	as СКЛАДполутоп
							,	t.lvl+1 AS lvl, a.Тип, t.ТипТоп, a.Проект, a.SYS_U, a.Контрагент, a.Автотехника, a.Маркировка, a.ПартияНомер
						--	,	t.SortLevel + case when a.Тип='Сектор' then '-001' when a.Тип='Место' then '-002' else '-003' end SortLevel
			FROM				хОбъекты a
			INNER JOIN			tree t on a.Подчинен = t.SYS_SKLAD
--			WHERE				хОбъекты.Тип IN ('Сектор','Место')

	)
	-- дерево 
	select		SYS_SKLAD	
			,	СКЛАД
			,	SYS_TOP		
			,	СКЛАДТОП
			,	SYS_FULL	
			,	cast(СКЛАДПОЛНЫЙ + case when ТипОбъекта in ('Тара','Груз') then ' ['+isnull(Маркировка+'; ','')+isnull(ПартияНомер,'')+']' else '' end as varchar(255)) as СКЛАДПОЛНЫЙ
			,	cast(СКЛАДДВ	 + case when ТипОбъекта in ('Тара','Груз') then ' ['+isnull(Маркировка+'; ','')+isnull(ПартияНомер,'')+']' else '' end as varchar(255)) as СКЛАДДВ
			,	cast(СКЛАДполутоп	as varchar(255)) as СКЛАДполутоп
			,	lvl, ТипОбъекта, ТипТоп, Проект, tree.SYS_U, Контрагент, Автотехника
			,	SortLevel
	from tree