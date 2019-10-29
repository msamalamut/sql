/****** Object:  View [dbo].[хОстатки_S]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE view [хОстатки_S]
AS
	--	Реальные остатки
	--	select * from хОстатки_S where мест<>ceiling(мест)
	SELECT		o.Где, o.Что, o.Количество

--, cast(b.КолДЕИ		* a.Количество / b.КолБЕИ as decimal(18,6)) КолДЕИ
, m.КолБЕИ КолБЕИПриход
, o.Количество КолБЕИ
, case when m.КолБЕИ<>0 then cast(m.КолДЕИ		* o.Количество / m.КолБЕИ as decimal(18,3)	) end КолДЕИ
, case when m.КолБЕИ<>0 then cast(m.КолАЕИ		* o.Количество / m.КолБЕИ as decimal(18,3)	) end КолАЕИ
, case when m.КолБЕИ<>0 then cast(m.ВесКгНетто	* o.Количество / m.КолБЕИ as decimal(18,0)	) end ВесКгНетто
, case when m.КолБЕИ<>0 then cast(m.ВесКгБрутто * o.Количество / m.КолБЕИ as decimal(18,0)	) end ВесКгБрутто
, case when m.КолБЕИ<>0 then cast(m.Мест		* o.Количество / m.КолБЕИ as decimal(18,3)	) end Мест
, case when m.КолБЕИ<>0 then cast(m.Стоимость	* o.Количество / m.КолБЕИ as money			) end Стоимость
, case when m.КолБЕИ<>0 then cast(m.Сумма		* o.Количество / m.КолБЕИ as money			) end Сумма
, case when m.КолБЕИ<>0 then cast(				  o.Количество / m.КолБЕИ as money			) end КолПроц
	FROM		хОстатки			AS o
	inner join	хОбъекты			AS m on m.SYS_ID=o.Что
	WHERE		o.Количество<>0