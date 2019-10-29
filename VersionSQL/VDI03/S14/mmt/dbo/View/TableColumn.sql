/****** Object:  View [dbo].[TableColumn]    Committed by VersionSQL https://www.versionsql.com ******/


CREATE VIEW TableColumn
AS
	SELECT			o.name as TableName, c.name AS ColumnName, t.name AS TypeName, c.max_length, c.column_id
	FROM            sys.objects AS o 
	INNER JOIN		sys.columns AS c ON o.object_id = c.object_id
	INNER JOIN		sys.types		AS t ON c.system_type_id = t.system_type_id
	where			o.type='U' and o.is_ms_shipped=0
