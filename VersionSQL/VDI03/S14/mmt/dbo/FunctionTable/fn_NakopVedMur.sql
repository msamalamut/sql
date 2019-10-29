/****** Object:  Function [dbo].[fn_NakopVedMur]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [fn_NakopVedMur](@project varchar(32))
RETURNS TABLE 
AS
RETURN 
(	-- select * from fn_NakopVedMur('Мурманск') order by npp, np2
	with 
	--	подзапрос - выдача
	op as (
		SELECT a.Дата ДатаР, a.Номер НомерР, b.Что, b.Количество, b.Мест МестР, a.ТС ТСР, a.ТСНомер ТСНомерР, a.ДатаДоставки ДатаДоставкиР
		FROM			хДвижение		AS a
		INNER JOIN      хДвижениеСтроки AS b ON a.SYS_ID	= b.Операция
		where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 
					and a.Проект=@project and a.Тип='выдача'
	), 
	--	текущие остатки
	os as (
		SELECT			a.Что
		, cast(SUM(a.Количество)	as decimal(18,3)) КолО
		, cast(SUM(a.ВесКгБрутто)	as decimal(18,0)) БруттоО
		, cast(SUM(a.Мест)	as decimal(18,3)) МестО
		FROM            хОстатки_S		AS a
		INNER JOIN      хСклады_S		AS s ON a.Где=s.SYS_SKLAD
		WHERE			s.ТипТоп='Склад' and s.Проект=@project
		GROUP BY		a.Что
	), 
	--	подзапрос - ТМЦ и Поклажедатель
	pt as (
		SELECT m.SYS_ID, m.Код, m.Проект, m.Тип, a.Дата ДатаМХ1, a.Номер МХ1, a.Статус, a.ДатаДоставки
		, n.Укрупненка, n.Артикул, n.Название Номенклатура
		, m.Название ТМЦ, m.Габариты, m.Маркировка, m.Упаковка, m.ОбъемМ3, m.ДлинаМ, m.ШиринаМ, m.ВысотаМ
		, m.КолБЕИ, m.БЕИ
		, cast(m.ВесКгБрутто	as decimal(18,0)) ВесКгБрутто
		, m.Мест
	
		, a.ТС, a.ТСНомер, a.ТСД, a.ТСДНомер, a.ТСДДата, p.Название Поставщик, v.Название Поклажедатель, h.Название Хранитель
		, k.Название СкладПриемки, a.АОФПричина, a.ГрузСборный, a.ГрузУпаковка
		, fd.Сканов
		FROM			хДвижение		AS a
		left outer JOIN	хДвижениеСтроки	AS b ON a.SYS_ID = b.Операция and b.SYS_U is null -- and b.Количество<>0
		left outer JOIN хОбъекты		AS m ON b.Что  = m.SYS_ID
		left outer JOIN хОбъекты		AS k ON b.Куда = k.SYS_ID

		-- поклажедатель
		LEFT OUTER JOIN Контрагенты		AS v ON a.ОткудаКА=v.SYS_ID
		-- хранитель
		LEFT OUTER JOIN Контрагенты		AS H ON a.кудаКА=h.SYS_ID
		-- Поставщик
		LEFT OUTER JOIN Контрагенты		AS p ON a.Поставщик=p.SYS_ID
		-- Номенклатура
		LEFT OUTER JOIN хНоменклатура	AS n ON m.Номенклатура=n.SYS_ID
		-- документы
		LEFT OUTER JOIN (select Операция, count(*) Сканов from документы where SYS_U is null and Скан='+' group by Операция) as fd on a.SYS_ID=fd.Операция
		WHERE			a.Проект=@project and a.SYS_U is null
--		WHERE			a.Проект='Мурманск' and a.SYS_U is null
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
			where			a.SYS_U is null and b.SYS_U is null and b.Количество<>0 and a.Тип in ('Приемка','Приход') and a.Проект=@project
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

		SELECT m.ТС, m.ТСНомер, m.ТСД, m.ТСДНомер, m.ТСДДата, m.Поставщик, m.Поклажедатель, m.Хранитель, m.СкладПриемки
		, m.МХ1, m.ДатаМХ1, m.Статус, m.АОФПричина, m.ГрузСборный, m.ГрузУпаковка, m.ДатаДоставки

		, substring(replace(replace(s.lvl,'-00','.'),'-0','.'),2,200) ПН
		, m.ТМЦ, m.Укрупненка, m.Номенклатура, m.Упаковка, m.Маркировка, m.Габариты, m.Тип, m.БЕИ, m.ОбъемМ3, m.ДлинаМ, m.ШиринаМ, m.ВысотаМ, m.Артикул
	
		-- приемка
		, m.КолБЕИ КолП, m.Мест МестП
		, cast(m.ВесКгБрутто	as decimal(18,0)) БруттоП

		-- в наличии
		, g.КолО, g.МестО, g.БруттоО

		-- операция
		, p.ДатаР, p.ДатаДоставкиР , p.ТСНомерр, p.ТСр

		-- движение (расход)
		, p.Количество
		, p.МестР
		, case when m.КолБЕИ<>0 then cast(m.ВесКгБрутто*p.Количество/m.КолБЕИ as decimal(18,0)) end БруттоР

		-- документы
		, m.Сканов
		
		-- сортировки	 
		, ROW_NUMBER() over(order by m.ДатаМХ1, m.МХ1, s.lvl, p.ДатаР, p.НомерР) npp
		, ROW_NUMBER() over(partition by m.SYS_ID    order by p.ДатаР, p.НомерР) np2

		FROM			pt			AS m 
		LEFT OUTER JOIN op			AS p ON m.SYS_ID	= p.Что
		LEFT OUTER JOIN os			as g on m.SYS_ID	= g.Что
		LEFT OUTER JOIN st			as s on m.SYS_ID	= s.Что
	)


	-- итог
	SELECT МХ1, ТСДДата, Поклажедатель, Хранитель, ДатаДоставки ДатаПлан, Статус, ДатаМХ1, ТСДНомер, ТСНомер
	, Сканов
	, null ДопУслуги
	, null КолвоДопУслуг
	, null ЗатаркаРастарка
	, Артикул
	, null НоменклатураДоговор
	, null НоменклатураСкладская
	, ГрузСборный --НоменклатураСкладская
	, ТМЦ
	, null НомКНТ
	, АОФПричина
	, СкладПриемки
	, ОбъемМ3
	, substring(
		  isnull(', длина ' +cast(cast(ДлинаМ as float) as varchar(30))+'м','')
		+ isnull(', ширина '+cast(cast(ШиринаМ as float) as varchar(30))+'м','')
		+ isnull(', высота '+cast(cast(ВысотаМ as float) as varchar(30))+'м','')
		,3,1000) Размер
--	, Габариты
	, Упаковка

	, case when np2=1					then МестП   end МестП
	, case when np2=1					then БруттоП end БруттоП

	-- выдача
	, ТСР, ТСНомерР, МестР, БруттоР, ДатаР, ДатаДоставкиР

	-- Остаток
	, case when np2=1					then МестО   end МестО
	, case when np2=1					then БруттоО end БруттоО

	, npp, np2

	from aa 
)