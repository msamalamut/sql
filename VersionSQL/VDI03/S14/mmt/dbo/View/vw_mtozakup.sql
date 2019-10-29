/****** Object:  View [dbo].[vw_mtozakup]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view vw_mtozakup
as
	select ф.Код, ф.Дата, ф.ПДата, ф.Номер, ф.Направление, ф.Состояние, ф.Код1С, с.Название ФормаОплаты, к.Название Контрагент, п.Название Подотчётник, ф.Стоимость
	from с_Ндвижение ф
	left outer join У_УС у on ф.ОтКуда=у.SYS_ID
	left outer join Контрагенты к on у.Контрагент=к.SYS_ID
	left outer join Справочники с on ф.ФормаОплаты=с.SYS_ID
	left outer join Сотрудники п on ф.Подотчётник=п.SYS_ID
	where ф.Направление<>'Топливо' and ф.Тип='Закупки' and ф.SYS_U is null and datediff(d,ф.Дата,GETDATE())<150 and  ф.Код1С is null