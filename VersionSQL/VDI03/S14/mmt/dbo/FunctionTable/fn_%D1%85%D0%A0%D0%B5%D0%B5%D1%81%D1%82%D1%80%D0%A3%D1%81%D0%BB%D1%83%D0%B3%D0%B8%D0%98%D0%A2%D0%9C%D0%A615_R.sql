/****** Object:  Function [dbo].[fn_хРеестрУслугиИТМЦ15_R]    Committed by VersionSQL https://www.versionsql.com ******/

-- =============================================
-- Author:		<osmor>
-- Create date: <24052020>
-- Description:	<Реестр услуг Шлюмберже плюс ТМЦ из операций v15>
--Для ПРР цена3 по партиям до 2020 делится на 2 для партий после 2020 равна 0
-- =============================================
CREATE FUNCTION [dbo].[fn_хРеестрУслугиИТМЦ15_R]
(	
	@project nvarchar(255),
	@startdate datetime,
	@enddate datetime
)
RETURNS TABLE 
AS
RETURN 
(
	select	cast(ROW_NUMBER() over
			(order by [Дата Поручения], [Номер Поручения], Поклажедатель, Заявка, Маркировка desc, op, Название) as int) npp,		
			[Дата Поручения],
			[Номер Поручения],
			[Тип Поручения],
			[Дата ОЛДК],
			[Номер ОЛДК],
			[Дата Операции],
			[Номер Операции],
			[Тип Операции],
			TC,
			Сегмент,
			Поклажедатель,
			[Дата партии], -- osmor 14.05.2020 
			Партия,
			ТМЦ,
			Количество,
			ЕИ,
			вКНТ,
			[Дата акта],
			[Номер акта],
			[Тип акта],
			СчетФактура,
			Услуга,
			Груз,
			Мест,
			Тоннаж,
			Цена1,
			Стоимость1,
			Цена2,
			Стоимость2,
			Цена3,
			Стоимость3,
			КолвоУслуги,
			op,
			Название
from (	
		select	p.Дата [Дата Поручения],
				p.Номер [Номер Поручения],
				p.Тип [Тип Поручения],
				p.ПВДата [Дата ОЛДК],
				p.ПВНомер [Номер ОЛДК],
				a.Дата [Дата Операции],
				a.Номер [Номер Операции],
				a.Тип [Тип Операции],
				isnull(a.ТС,'')+isnull(' '+a.ТСНомер,'') TC,
				h.Сегмент,
				k.Название Поклажедатель,
				m.Маркировка,
				m.Заявка,
				m.ПартияДата [Дата партии], -- osmor 14.05.2020
				m.ПартияНомер Партия,
				m.Название + isnull(' ' + m.Маркировка, '') ТМЦ,
				s.Количество,
				s.ЕИ,
				null вКНТ,
				g.Дата [Дата акта],
				g.Номер [Номер акта],
				g.Тип [Тип акта],
				g.НомерСФ СчетФактура,
				u.Название Услуга,
				s.Груз,
				s.Мест,
				s.Тоннаж,
				u.Цена Цена1,
				cast(u.Цена * (case when u.ЕИК='Тоннаж' then s.Тоннаж when u.ЕИК='Мест' then s.мест else null end) as money) Стоимость1,
				u.Цена2,
				cast(u.Цена2*(case when u.ЕИК='Тоннаж' then s.Тоннаж when u.ЕИК='Мест' then s.мест else null end) as money) Стоимость2,
				cast(
					case 
						when u.Код <10  and a.Тип = 'Выдача'  then 
							case 
								when YEAR(m.ПартияДата) <2020 then u.Цена3/2 
								 else null
							end

						when u.код = 23 and a.Тип = 'Перемещения'  then
							case 
								when YEAR(m.ПартияДата) <2020 then u.Цена3
								 else null
							end
						else u.Цена3
						 end
						  as money ) Цена3,
				cast(case 
						when u.Код <10  and a.Тип = 'Выдача'  then 
							case 
								when YEAR(m.ПартияДата) <2020 then u.Цена3/2 
								 else null
							end

						when u.код = 23 and a.Тип = 'Перемещения'  then
							case 
								when YEAR(m.ПартияДата) <2020 then u.Цена3
								 else null
							end
						else u.Цена3
						end *
				(case when u.ЕИК='Тоннаж' then
					 s.Тоннаж when u.ЕИК='Мест' then s.мест else null end) 
				as money) Стоимость3,
				cast((case when u.ЕИК='Тоннаж' then s.Тоннаж when u.ЕИК='Мест' then s.мест else null end) as decimal(18,3)) КолвоУслуги,
				s.op,
				u.Название
		from (	
				select	'1 операции строки, привязаны услуги' T
						, m.SYS_ID MTR, a.SYS_ID OPR, d.Услуга USL, e.SYS_ID AKT, 2 op
						, b.Количество, b.мест
						, cast(m.ВесКгБрутто * b.Количество / m.КолБЕИ / 1000 as decimal(18, 3)) Тоннаж
						, m.БЕИ ЕИ, d.Груз
						, d.Поручение
						, case when a.тип='приемка' then a.ОткудаКА else a.кудаКА end PKL
				from	хДвижение		as a
						inner join		хДвижениеСтроки	as b on a.SYS_ID=b.Операция
						inner join		хУслугиСтроки	as d on d.SYS_ID=b.Привязка
						inner join		хУслугиСпр		as u on u.SYS_ID=d.Услуга
						inner join		хУслуги			as e on e.SYS_ID=d.Операция 
						inner join		хОбъекты		as m on m.SYS_ID=b.Что
				where	a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
					and a.Проект = @project
					and (a.Дата between @startdate and @enddate
					or	e.Дата between @startdate and @enddate)

			UNION ALL

				select	'2 услуги строки, привязаны тмц' T
						, m.SYS_ID MTR, a.SYS_ID OPR, d.Услуга USL, e.SYS_ID AKT, 4 op
						, d.Количество, d.мест
						, d.Тоннаж
						, u.ЕИ, d.Груз
						, d.Поручение
						, case when a.тип='приемка' then a.ОткудаКА else a.кудаКА end PKL
				from	хУслуги			as e  
						inner join		хУслугиСтроки	as d on e.SYS_ID=d.Операция  
						inner join		хУслугиСпр		as u on u.SYS_ID=d.Услуга
						inner join		хДвижениеСтроки	as b on b.SYS_ID=d.Привязка
						inner join		хДвижение		as a on a.SYS_ID=b.Операция
						inner join		хОбъекты		as m on m.SYS_ID=b.Что
				where	e.SYS_U is null and d.SYS_U is null and a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
					and a.Проект = @project
					and (a.Дата between @startdate and @enddate
					or	e.Дата between @startdate and @enddate)

			UNION ALL

				select	'3 услуги на операцию целиком' T
						, null MTR, a.SYS_ID OPR, d.Услуга USL, e.SYS_ID AKT, 1 op
						, d.Количество, d.мест
						, d.Тоннаж
						, u.ЕИ, d.Груз
						, d.Поручение
						, case when a.тип= 'приемка' then a.ОткудаКА else a.кудаКА end PKL
				from	хУслуги			as e  
						inner join		хУслугиСтроки	as d on e.SYS_ID=d.Операция  
						inner join		хУслугиСпр		as u on u.SYS_ID=d.Услуга
						inner join		хДвижение		as a on a.SYS_ID=d.Движение
				where	e.SYS_U is null and d.SYS_U is null and a.SYS_U is null and d.SYS_U is null and d.Количество<>0 and d.Привязка='операция' 
					and a.Проект = @project
					and (a.Дата between @startdate and @enddate
					or	e.Дата between @startdate and @enddate)

			UNION ALL

				select	'4 услуги построчно' T
						, m.SYS_ID MTR, a.SYS_ID OPR, d.Услуга USL, e.SYS_ID AKT, 3 op
						, b.Количество, b.мест
						, cast(m.ВесКгБрутто * b.Количество / m.КолБЕИ / 1000 as decimal(18, 3)) Тоннаж
						, m.БЕИ ЕИ, d.Груз
						, d.Поручение
						, case when a.тип= 'приемка' then a.ОткудаКА else a.кудаКА end PKL
				from	хДвижение		as a
						inner join		хДвижениеСтроки	as b on a.SYS_ID=b.Операция
						inner join		хОбъекты		as m on m.SYS_ID=b.Что
						inner join		хУслугиСтроки	as d on a.SYS_ID=d.Движение and d.Привязка='построчно'
						inner join		хУслугиСпр		as u on u.SYS_ID=d.Услуга
						inner join		хУслуги			as e on e.SYS_ID=d.Операция 
				where	e.SYS_U is null and d.SYS_U is null and a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
					and a.Проект = @project
					and (a.Дата between @startdate and @enddate
					or	e.Дата between @startdate and @enddate)
		) s
			left outer join	хУслугиСпр		as u on s.USL=u.SYS_ID
			left outer join	хОбъекты		as m on s.MTR=m.SYS_ID
			left outer join	хДвижение		as a on s.OPR=a.SYS_ID
			left outer join	хПоручения		as p on s.Поручение=p.SYS_ID
			left outer join	хУслуги			as g on s.AKT=g.SYS_ID
			left outer join	хДвижение		as h on M.Партия=h.SYS_ID
			left outer join	Контрагенты		as k on s.PKL=k.SYS_ID
	) x

)