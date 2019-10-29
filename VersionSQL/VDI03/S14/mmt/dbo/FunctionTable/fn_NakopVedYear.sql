/****** Object:  Function [dbo].[fn_NakopVedYear]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[fn_NakopVedYear](@project varchar(32))
RETURNS TABLE 
AS
RETURN 
(
with 
	--	подзапрос - движение, но не приемка и подпрыгивание внутритарки
	op as (
		SELECT a.Проект, a.Дата, a.Номер, a.ОткудаКА, b.Откуда, b.Куда, b.Что, b.Количество, b.Мест
		, o.Тип ТипОткуда, k.Тип ТипКуда, h.Тип ТипЧто
		, a.ТСНомер Транспорт
		, a.ТСДНомер ТН
		, case 
			when a.Тип='Перемещения' and k.Тип='Тара' then 'Затарка' 
			when a.Тип='Перемещения' and f.Тип='Тара' then 'Затарка' 
			when a.Тип='Перемещения' and o.Тип='Тара' then 'Вытарка' 
			else a.Тип end Тип						

		, case 
			when a.Тип='Перемещения' and k.Тип='Тара' then k.Название -- затарка товара в КНТ
			when a.Тип='Выдача'		 and o.Тип='Тара' then k.Название -- выдача КНТ
			when b.Откуда = b.Куда	 and k.Тип='Тара' then k.Название -- внутритарка КНТ
			when k.Тип='Груз'		 and f.Тип='Тара' then f.Название -- внутритарка груза в КНТ
			end КНТ						
		, a.SYS_ID 
		FROM			хДвижение		AS a
		INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
		INNER JOIN		хОбъекты		AS o ON b.Откуда	= o.SYS_ID
		INNER JOIN		хОбъекты		AS k ON b.куда		= k.SYS_ID
		INNER JOIN		хОбъекты		AS h ON b.Что		= h.SYS_ID

		-- в грузоместе, еще выше контейнер?
		left outer JOIN хДвижениеСтроки AS g ON b.Куда		= g.Что and a.SYS_ID=g.Операция and g.SYS_U is null and g.Количество=1
		left outer JOIN	хОбъекты		AS f ON g.Куда		= f.SYS_ID

		where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
		and a.Проект=@project
		and a.Тип not in ('Приемка','Приход','Упаковка')
	--	and b.Откуда<>b.Куда
	), 
	--	текущие остатки
	os as (
		SELECT			a.Что
		, cast(SUM(a.Количество)	as decimal(18,3)) КолО
		, cast(SUM(a.ВесКгНетто)	as decimal(18,0)) НеттоО
		, cast(SUM(a.ВесКгБрутто)	as decimal(18,0)) БруттоО
		, cast(SUM(a.Мест)	as decimal(18,3)) МестО
		FROM            хОстатки_S		AS a
		INNER JOIN      хСклады_S		AS s ON a.Где=s.SYS_SKLAD
		WHERE			s.ТипТоп='Склад' and s.Проект=@project
		GROUP BY		a.Что
	), 
	--	подзапрос - ТМЦ и Поклажедатель
	pt as (
		SELECT m.SYS_ID, m.Код, m.Проект, m.Тип, m.ПартияДата ДатаМХ1, m.ПартияНомер МХ1
		, m.Название ТМЦ, m.Габариты, m.Маркировка, m.КодПартииГруза
		, a.УслХранения
		, m.Упаковка, n.Укрупненка
		, m.КолБЕИ, m.БЕИ
		, cast(m.ВесКгНетто		as decimal(18,0)) ВесКгНетто
		, cast(m.ВесКгБрутто	as decimal(18,0)) ВесКгБрутто
		, m.Мест
	
		, a.ТС, a.ТСНомер, a.ТСД, a.ТСДНомер, a.ТСДДата, p.Название Поставщик, v.Название Поклажедатель, a.КодЮрика, a.Сегмент
		, m.Заявка НомерЗаказа, n.Артикул КодМТР, n.Название Номенклатура, m.Прожект, a.АОФ, a.АОФПричина

		FROM			хОбъекты		AS m
		INNER JOIN      хДвижение		AS a ON m.Партия = a.SYS_ID
		INNER JOIN      хДвижениеСтроки	AS b ON a.SYS_ID = b.Операция and m.SYS_ID=b.Что
		-- проверка грузомест
		INNER JOIN		хОбъекты		AS k on b.Куда=k.SYS_ID
		-- поклажедатель
		LEFT OUTER JOIN Контрагенты		AS v ON a.ОткудаКА=v.SYS_ID
		-- Поставщик
		LEFT OUTER JOIN Контрагенты		AS p ON a.Поставщик=p.SYS_ID
		-- Номенклатура
		LEFT OUTER JOIN хНоменклатура	AS n ON m.Номенклатура=n.SYS_ID
		WHERE			m.Проект=@project and m.КолБЕИ<>0 and m.Тип in ('товар','груз','тара')
		and m.SYS_U is null and a.SYS_U is null and b.SYS_U is null
	),
	-- Сортировка в приемках в грузоместах
	st as (
			select	 format(ROW_NUMBER() over(partition by a.SYS_ID, k.SYS_ID order by h.Тип, b.Код),'-000')  Lvl
			, b.Что, b.Операция
			from			хДвижение		a
			inner join		хДвижениеСтроки	b on a.SYS_ID=b.Операция
			-- всё тара - топ уровень - другое не интересно
			inner join		хОбъекты		k on k.SYS_ID=b.Куда 
			inner join		хОбъекты		h on h.SYS_ID=b.Что 
			where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 and a.Тип in ('Приемка','Приход','Упаковка') and a.Проект=@project
			and k.тип in ('склад','сектор','место')
		union all
			select t.Lvl+format(ROW_NUMBER() over(partition by b.Куда order by o.тип, o.Название),'-000') Lvl
			, b.Что, t.Операция
			from			хДвижениеСтроки	b
			inner join		хОбъекты		o on o.SYS_ID=b.Что 
			inner join		st				t on b.Куда=t.Что and b.Операция=t.Операция
			where			b.SYS_U is null and b.Количество<>0
	),
	-- Почти итог
	aa as (

		SELECT m.ТС, m.ТСНомер, m.ТСД, m.ТСДНомер, m.ТСДДата, m.Поставщик, m.Поклажедатель, m.КодЮрика, m.Сегмент
		, m.НомерЗаказа,m.КодПартииГруза, m.КодМТР, m.Прожект Проект, m.АОФ, m.АОФПричина, m.МХ1, m.ДатаМХ1

		, substring(replace(replace(s.lvl,'-00','.'),'-0','.'),2,200) ПН
		, m.ТМЦ, m.Укрупненка, m.Упаковка, m.Маркировка
		, m.УслХранения
		, m.Габариты, m.Тип, m.БЕИ
	
		-- приемка
		, m.КолБЕИ КолП, m.Мест МестП
		, cast(m.ВесКгНетто		as decimal(18,0)) НеттоП
		, cast(m.ВесКгБрутто	as decimal(18,0)) БруттоП

		-- в наличии
		, g.КолО, g.МестО, g.НеттоО, g.БруттоО

		-- операция
		, p.тип Операция, p.Дата, p.Номер, p.Транспорт, p.ТН, p.КНТ

		-- движение
		, p.Количество
		, p.Мест
		, case when m.КолБЕИ<>0 then cast(m.ВесКгНетто *p.Количество/m.КолБЕИ as decimal(18,0)) end Нетто
		, case when m.КолБЕИ<>0 then cast(m.ВесКгБрутто*p.Количество/m.КолБЕИ as decimal(18,0)) end Брутто

		-- сортировки	 
		, ROW_NUMBER() over(order by m.ДатаМХ1, m.МХ1, s.lvl, p.Дата, p.Номер) npp
		, ROW_NUMBER() over(partition by m.SYS_ID    order by p.Дата, p.Номер) np2

		-- test
		, m.Код
		, m.Номенклатура
		, p.ТипЧто
		, p.SYS_ID
		FROM			pt			AS m 
		LEFT OUTER JOIN op			AS p ON m.SYS_ID	= p.Что
		LEFT OUTER JOIN os			as g on m.SYS_ID	= g.Что
		LEFT OUTER JOIN st			as s on m.SYS_ID	= s.Что
		where Year(m.ДатаМХ1) = YEAR(getdate()) or m.ДатаМХ1 >= DATEADD(mm,-3,getdate())  or g.КолО <> 0
	)

	--- Вывод

	select ТС, ТСНомер, ТСД, ТСДНомер, ТСДДата, Поставщик, Поклажедатель, КодЮрика, Сегмент
		, НомерЗаказа,КодПартииГруза as КодПартии, КодМТР, Проект, АОФ, АОФПричина
		, МХ1, ДатаМХ1
		, ПН, ТМЦ, Маркировка
		, УслХранения
		, Укрупненка, Упаковка, Габариты

		, case when Тип='Товар' then БЕИ end БЕИ

		-- приемка
		, case when np2=1 and Тип='Товар'	then КолП    end КолП
		, case when np2=1					then МестП   end МестП
		, case when np2=1					then НеттоП  end НеттоП
		, case when np2=1					then БруттоП end БруттоП

		-- в наличии
		, case when np2=1 and Тип='Товар'	then КолО    end КолО
		, case when np2=1					then МестО   end МестО
		, case when np2=1					then НеттоО  end НеттоО
		, case when np2=1					then БруттоО end БруттоО


		-- операция
		, Операция, Дата, Номер, Транспорт, ТН, КНТ

		-- движение
		, case when Операция<>'Выдача' and Тип='Товар' then Количество end КолД
		, case when Операция<>'Выдача' then Мест   end МестД
		, case when Операция<>'Выдача' then Нетто  end НеттоД
		, case when Операция<>'Выдача' then Брутто end БруттоД

		-- расход
		, case when Операция ='Выдача' and Тип='Товар' then Количество end КолР
		, case when Операция ='Выдача' then Мест   end МестР
		, case when Операция ='Выдача' then Нетто  end НеттоР
		, case when Операция ='Выдача' then Брутто end БруттоР

		, npp
	---- test
	--, Код, npp, nullif(np2,1) np2
		, ТипЧто
		, Номенклатура
		, SYS_ID
	from aa 
)