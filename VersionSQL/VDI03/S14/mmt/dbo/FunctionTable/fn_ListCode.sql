/****** Object:  Function [dbo].[fn_ListCode]    Committed by VersionSQL https://www.versionsql.com ******/

create FUNCTION [dbo].[fn_ListCode]()
RETURNS TABLE 
AS
RETURN 
(	--------------------------------------------------------
--	select *, len(texte) from dbo.fn_ListCode() order by	[sort], [SchemaName], [Objectname]
--	'P'		-- procedure
--	'C'		-- CHECK_CONSTRAINT
--	'D'		-- DEFAULT_CONSTRAINT
--	'FN'	-- SQL_SCALAR_FUNCTION
--	'IF'	-- SQL_INLINE_TABLE_VALUED_FUNCTION
--	'TF'	-- SQL_TABLE_VALUED_FUNCTION
--	'TR'	-- SQL_TRIGGER
--	'U'		-- USER_TABLE
--	'V'		-- VIEW

	with
	t1 as 
		(	select			cast(b.name as nvarchar(50)) as SchemaName
						,	a.object_id, cast(a.type as nvarchar(50)) as type, a.type_desc, cast(a.name as nvarchar(50)) as ObjectName, a.modify_date
						,	c.colid as rn, cast(c.text as nvarchar(max)) as [text]
			from			sys.all_objects	as a
			inner join		sys.schemas		as b on b.schema_id=a.schema_id
			inner join		syscomments		as c on a.object_id=c.id
			where			a.is_ms_shipped=0 and a.type in ('FN','IF','P','TF','V','TR','U')
--			where			a.is_ms_shipped=0 and a.type in ('FN','IF','P','TF','V','TR','U')
--						and	a.name not like 'msmerge%'	--	минус огрызки репликации
		),
	tr([object_id], [SchemaName], [ObjectName], [type], [type_desc], [modify_date], [text], lev) as
		(select t1.[object_id], t1.[SchemaName], t1.[ObjectName], t1.[type], t1.[type_desc], t1.[modify_date], t1.[text] , 2 from t1 where t1.rn = 1
		union all
		select t1.[object_id], t1.[SchemaName], t1.[ObjectName], t1.[type], t1.[type_desc], t1.[modify_date], tr.[text]+t1.[text], lev + 1
		from t1 join tr on (t1.[object_id] = tr.[object_id] and t1.rn = tr.lev
		)
	)

	select			[type], [type_desc], [object_id], [SchemaName], [ObjectName], [modify_date], count(*) as rcc, max([text]) texte
				,	case [type] when 'FN' then 1
								when 'V'  then 2
								when 'IF' then 3
								when 'TF' then 4
								when 'P'  then 5
								else 9
					end as sort
	from			tr 
	group by		[object_id], [SchemaName], [ObjectName], [type], [type_desc], [modify_date]
	--order by		[type], [SchemaName], [Objectname]

	--------------------------------------------------------
)









