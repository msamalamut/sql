/****** Object:  Function [dbo].[fn_РейсСписокЮтейр]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[fn_РейсСписокЮтейр](@SYS_ID varchar(32))
RETURNS 

	@t table (
		  npp int, Лист varchar(32), Код int, SYS_ID varchar(255), Дата datetime, Номер  varchar(32), ДатаНачало datetime
		, ОрганизацияРеквизиты varchar(max), ОткудаНазвание varchar(255), КудаНазвание varchar(255), ГрузВнутриКг money
		, ВылетВремя varchar(255), ТС varchar(255), НомерБорта varchar(255), FIO varchar(255), Паспорт varchar(255)
	)

AS
BEGIN

	-- откуда вылет
	declare @Tochka varchar(32)
	select @Tochka=Откуда from с_РейсыПодрейсы where Операция=@SYS_ID and НПП=1

	insert into @t (npp, Лист, Код, SYS_ID, Дата, Номер, ДатаНачало, ОрганизацияРеквизиты, ОткудаНазвание, КудаНазвание, ГрузВнутриКг, ВылетВремя, ТС, НомерБорта, FIO, Паспорт)

	SELECT cast(row_number() over(partition by a.SYS_ID, a.Лист order by a.SYS_ID, a.Лист, a.НПП1, a.НПП2, a.FIO) as int) as npp
	, Лист, Код, SYS_ID, Дата, Номер, ДатаНачало, ОрганизацияРеквизиты, ОткудаНазвание, КудаНазвание, ГрузВнутриКг, ВылетВремя, ТС, НомерБорта, FIO, Паспорт
	from (
	select 
--	  case when о.SYS_ID='97B52B6D9D8549C48B5D51392851A798' then 'Лист1' when к.SYS_ID='97B52B6D9D8549C48B5D51392851A798' then 'Лист2' else 'Лист0' end as Лист
--	  case when о.SYS_ID='97B52B6D9D8549C48B5D51392851A798' then 'Лист1' when к.SYS_ID='97B52B6D9D8549C48B5D51392851A798' then 'Лист2' else 'Лист2' end as Лист
	  case when о.SYS_ID=@Tochka then 'Лист1' else 'Лист2' end as Лист
	, с_Рейсы.Код, с_Рейсы.SYS_ID, с_Рейсы.Дата, с_Рейсы.Номер, с_Рейсы.ДатаНачало

	, isnull(б.ОфНазвание, б.Название) + isnull(', '+б.ОфАдрес, '') + isnull(', '+б.ОфТелефон, '') as ОрганизацияРеквизиты


	--, с_Рейсы.ДатаКонец
	, о.Название AS ОткудаНазвание, к.Название AS КудаНазвание
	, с_РейсыПодрейсы.ГрузВнутриКг
	, replace(convert(varchar(5),с_Рейсы.ДатаНачало,108),'00:00','') ВылетВремя
	, с_Рейсы.ТС
	, с_Рейсы.НомерБорта
	, с.FIO
	, с.Паспорт
	, с_РейсыПодрейсы.НПП НПП1, п.НПП НПП2
	FROM			с_Рейсы			
	INNER JOIN		с_РейсыПодрейсы		 ON с_Рейсы.SYS_ID=с_РейсыПодрейсы.Операция
	INNER JOIN		с_РейсыСтроки		 ON с_Рейсы.SYS_ID=с_РейсыСтроки.Операция AND с_РейсыПодрейсы.SYS_ID=с_РейсыСтроки.Остановка1
	INNER JOIN		с_РейсыПодрейсы AS п ON с_РейсыСтроки.Остановка2=п.SYS_ID AND с_Рейсы.SYS_ID=п.Операция
	LEFT OUTER JOIN	Сотрудники_S	as с ON с_РейсыСтроки.Сотрудник=с.SYS_ID
	LEFT OUTER JOIN	У_УС			AS о ON с_РейсыПодрейсы.Откуда =о.SYS_ID
	LEFT OUTER JOIN	У_УС			AS к ON п.Куда=к.SYS_ID 

	cross join (select * from Контрагенты where sys_id='88219B0B6CCC424E9312026C8BFCC635') as б 

	WHERE с_Рейсы.SYS_ID=@SYS_ID

	) a

	-- добавить пустографки на лист1 до 22 строк
	WHILE (select max(npp) from @t WHERE Лист='Лист1') < 22
	BEGIN
		insert into @t (npp, Лист, Код, SYS_ID) 
		select max(npp)+1, 'Лист1', Код, SYS_ID from @t WHERE Лист='Лист1' group by Код, SYS_ID
	END


	-- добавить пустографки на лист2 до 22 строк
	WHILE (select max(npp) from @t WHERE Лист='Лист2') < 22
	BEGIN
		insert into @t (npp, Лист, Код, SYS_ID) 
		select max(npp)+1, 'Лист2', Код, SYS_ID from @t WHERE Лист='Лист2' group by Код, SYS_ID
	END



	RETURN 
END