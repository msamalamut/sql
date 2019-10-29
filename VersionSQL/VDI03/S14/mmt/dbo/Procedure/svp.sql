/****** Object:  Procedure [dbo].[svp]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[svp](@oper varchar(255), @ID varchar(255), @Data datetime)
AS
BEGIN
	SET NOCOUNT ON;

	declare @z varchar(max), @T varchar(max), @K money
	declare @t2 table (l varchar(255),P varchar(255),K money,T varchar(max))





	--	Табелируется
	SELECT @T = null, @K=0, @z=''

	SELECT		@K = @K+1 
			,	@T = (case when @z=isnull(Должности.Название,'Золушка: ') then isnull(@T + ', ','')+' '+Сотрудники.Название else isnull(@T + char(13) + char(10),'')+isnull(Должности.Название+': ','Золушка: ')+' '+Сотрудники.Название end)
			,	@z = isnull(Должности.Название,'Золушка') 	
	FROM            Табель 
	INNER JOIN		ТабельСтроки	ON Табель.SYS_ID			=	ТабельСтроки.Операция
	INNER JOIN		Сотрудники		ON ТабельСтроки.Сотрудник	=	Сотрудники.SYS_ID
	LEFT OUTER JOIN	Должности		ON Сотрудники.Должность		=	Должности.SYS_ID
	WHERE			Табель.SYS_U is null and ТабельСтроки.SYS_U is null and Табель.Участок=@ID AND Табель.Дата=@Data AND ТабельСтроки.КодБукв<>''
	ORDER BY		Должности.Сортировка, Должности.Название, Сотрудники.Название

	insert into @t2 (l,P,K,T) select 'Табелируется', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='746C5645293A46F2A1517119E9393F5A' AND SYS_U is null





	--	Из них на больничном
	SELECT @T = null, @K=0, @z=''

	SELECT		@K = @K+1 
			,	@T = (case when @z=isnull(Должности.Название,'Золушка: ') then isnull(@T + ', ','')+' '+Сотрудники.Название else isnull(@T + char(13) + char(10),'')+isnull(Должности.Название+': ','Золушка: ')+' '+Сотрудники.Название end)
			,	@z = isnull(Должности.Название,'Золушка') 	
	FROM            Табель 
	INNER JOIN		ТабельСтроки	ON Табель.SYS_ID			=	ТабельСтроки.Операция
	INNER JOIN		Сотрудники		ON ТабельСтроки.Сотрудник	=	Сотрудники.SYS_ID
	LEFT OUTER JOIN	Должности		ON Сотрудники.Должность		=	Должности.SYS_ID
	WHERE			Табель.SYS_U is null and ТабельСтроки.SYS_U is null and Табель.Участок=@ID AND Табель.Дата=@Data AND ТабельСтроки.КодБукв='Б'
	ORDER BY		Должности.Сортировка, Должности.Название, Сотрудники.Название

	insert into @t2 (l,P,K,T) select 'Из них на больничном', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='73C837B2839A40D2AE5451935AA568BD' AND SYS_U is null





	--	Из них на отпусках
	SELECT @T = null, @K=0, @z=''

	SELECT		@K = @K+1 
			,	@T = (case when @z=isnull(Должности.Название,'Золушка: ') then isnull(@T + ', ','')+' '+Сотрудники.Название else isnull(@T + char(13) + char(10),'')+isnull(Должности.Название+': ','Золушка: ')+' '+Сотрудники.Название end)
			,	@z = isnull(Должности.Название,'Золушка') 	
	FROM            Табель 
	INNER JOIN		ТабельСтроки	ON Табель.SYS_ID			=	ТабельСтроки.Операция
	INNER JOIN		Сотрудники		ON ТабельСтроки.Сотрудник	=	Сотрудники.SYS_ID
	LEFT OUTER JOIN	Должности		ON Сотрудники.Должность		=	Должности.SYS_ID
	WHERE			Табель.SYS_U is null and ТабельСтроки.SYS_U is null and Табель.Участок=@ID AND Табель.Дата=@Data AND ТабельСтроки.КодБукв in ('ОТ','ОД')
	ORDER BY		Должности.Сортировка, Должности.Название, Сотрудники.Название

	insert into @t2 (l,P,K,T) select 'Из них на отпусках', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='EFCD7CE45A8A4293BED9CD9C4EBB2954' AND SYS_U is null







	--	Из них в декрете
	select @T = null, @K=0

	SELECT		@K = @K+1 
			,	@T = (case when @z=isnull(Должности.Название,'Золушка: ') then isnull(@T + ', ','')+' '+Сотрудники.Название else isnull(@T + char(13) + char(10),'')+isnull(Должности.Название+': ','Золушка: ')+' '+Сотрудники.Название end)
			,	@z = isnull(Должности.Название,'Золушка') 	
	FROM            Табель 
	INNER JOIN		ТабельСтроки	ON Табель.SYS_ID			=	ТабельСтроки.Операция
	INNER JOIN		Сотрудники		ON ТабельСтроки.Сотрудник	=	Сотрудники.SYS_ID
	LEFT OUTER JOIN	Должности		ON Сотрудники.Должность		=	Должности.SYS_ID
	WHERE			Табель.SYS_U is null and ТабельСтроки.SYS_U is null and Табель.Участок=@ID AND Табель.Дата=@Data AND ТабельСтроки.КодБукв in ('ОЖ','Р')
	ORDER BY		Должности.Сортировка, Должности.Название, Сотрудники.Название

	insert into @t2 (l,P,K,T) select 'Из них в декрете', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='9D4EB1696D7942C2A4DF8D49C0E3EC3A' AND SYS_U is null




	--	Из них выходной
	select @T = null, @K=0

	SELECT		@K = @K+1 
			,	@T = (case when @z=isnull(Должности.Название,'Золушка: ') then isnull(@T + ', ','')+' '+Сотрудники.Название else isnull(@T + char(13) + char(10),'')+isnull(Должности.Название+': ','Золушка: ')+' '+Сотрудники.Название end)
			,	@z = isnull(Должности.Название,'Золушка') 	
	FROM            Табель 
	INNER JOIN		ТабельСтроки	ON Табель.SYS_ID			=	ТабельСтроки.Операция
	INNER JOIN		Сотрудники		ON ТабельСтроки.Сотрудник	=	Сотрудники.SYS_ID
	LEFT OUTER JOIN	Должности		ON Сотрудники.Должность		=	Должности.SYS_ID
	WHERE			Табель.SYS_U is null and ТабельСтроки.SYS_U is null and Табель.Участок=@ID AND Табель.Дата=@Data AND ТабельСтроки.КодБукв in ('ВВ') 
	ORDER BY		Должности.Сортировка, Должности.Название, Сотрудники.Название

	insert into @t2 (l,P,K,T) select 'Из них выходной', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='6FA4E53545BF42D8B94E3B5D6762C8C2' AND SYS_U is null





	--	Из них в МО
	select @T = null, @K=0

	SELECT		@K = @K+1 
			,	@T = (case when @z=isnull(Должности.Название,'Золушка: ') then isnull(@T + ', ','')+' '+Сотрудники.Название else isnull(@T + char(13) + char(10),'')+isnull(Должности.Название+': ','Золушка: ')+' '+Сотрудники.Название end)
			,	@z = isnull(Должности.Название,'Золушка') 	
	FROM            Табель 
	INNER JOIN		ТабельСтроки	ON Табель.SYS_ID			=	ТабельСтроки.Операция
	INNER JOIN		Сотрудники		ON ТабельСтроки.Сотрудник	=	Сотрудники.SYS_ID
	LEFT OUTER JOIN	Должности		ON Сотрудники.Должность		=	Должности.SYS_ID
	WHERE			Табель.SYS_U is null and ТабельСтроки.SYS_U is null and Табель.Участок=@ID AND Табель.Дата=@Data AND ТабельСтроки.КодБукв in ('МО') 
	ORDER BY		Должности.Сортировка, Должности.Название, Сотрудники.Название

	insert into @t2 (l,P,K,T) select 'Из них в МО', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='D92A97D1A8FC4F52AFFEEEC583358CB9' AND SYS_U is null
	




	--	Всего на участке физически
	SELECT @T = null, @K=0, @z=''

	SELECT		@K = @K+1 
			,	@T = (case when @z=isnull(Должности.Название,'Золушка: ') then isnull(@T + ', ','')+' '+Сотрудники.Название else isnull(@T + char(13) + char(10),'')+isnull(Должности.Название+': ','Золушка: ')+' '+Сотрудники.Название end)
			,	@z = isnull(Должности.Название,'Золушка') 	
	from				Сотрудники 
	left outer join		Должности on Сотрудники.Должность=Должности.SYS_ID  
	WHERE				Участок=@ID and Сотрудники.SYS_U is null 
	order by			Должности.Сортировка, Должности.Название, Сотрудники.Название

	insert into @t2 (l,P,K,T) select 'Всего на участке физически', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='803D0E18591243808D5F20FBC0EF27B9' AND SYS_U is null





	--	Автотехника, Автотехника
	select @T = null, @K=0
	SELECT	@T = isnull(@T + char(13) + char(10),'') + [Название] + isnull('; форма владения: '+[ФормаВладения],'') + isnull('; тех состояние: '+[ТехСостояние],'') , @K = @K+1 from Автотехника WHERE Участок=@ID and SYS_U is null and Класс='91CB33C9095C463F8C69AFD00F71B1A6' order by Название
	insert into @t2 (l,P,K,T) select 'Автотехника', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='5E8D07BA61BC483190FD542404CD815F' AND SYS_U is null





	--	Автотехника, Дорожно-строительная техника
	select @T = null, @K=0
	SELECT	@T = isnull(@T + char(13) + char(10),'') + [Название] + isnull('; форма владения: '+[ФормаВладения],'') + isnull('; тех состояние: '+[ТехСостояние],'') , @K = @K+1 from Автотехника WHERE Участок=@ID and SYS_U is null and Класс='39298571936C4B73A427E81E43823B14' order by Название
	insert into @t2 (l,P,K,T) select 'Дорожно-строительная техника', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='12B83CBEBD034206A08E8A92704687BC' AND SYS_U is null



	--	Автотехника, ПРОЧЕЕ
	select @T = null, @K=0
	SELECT	@T = isnull(@T + char(13) + char(10),'') + [Название] + isnull('; форма владения: '+[ФормаВладения],'') + isnull('; тех состояние: '+[ТехСостояние],'') , @K = @K+1 from Автотехника WHERE Участок=@ID and SYS_U is null and (Класс is null or Класс not in ('91CB33C9095C463F8C69AFD00F71B1A6','39298571936C4B73A427E81E43823B14')) order by Класс, Название
	insert into @t2 (l,P,K,T) select 'Автотехника, ПРОЧЕЕ', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='02C2DB1A2FA243878900642287DAA4F3' AND SYS_U is null





	--	1 Остаток на начало дня Д/Т
	select @T = null, @K=0
	SELECT  @K = ROUND(SUM(Колво),0)/1000 from fn_Номос(dateadd(d,-1,@Data)) WHERE МТР='9394FA181DD74DD883BD85A9F8861595' AND Участок=@ID
	insert into @t2 (l,P,K,T) select 'Топливо остатки на утро', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='26DB43FF18444D858297B4003D0AF2C2' AND SYS_U is null



	--	1 Остаток на начало дня АИ-92
	select @T = null, @K=0
	SELECT  @K = ROUND(SUM(Колво),0)/1000 from fn_Номос(dateadd(d,-1,@Data)) WHERE МТР='BB93D3F7DACE4940920DE8453E41E959' AND Участок=@ID
	insert into @t2 (l,P,K,T) select 'Топливо остатки на утро', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='C58A1537506F4306B261A7FCB9AB29CB' AND SYS_U is null



	--	1 Остаток на начало дня АИ-95
	select @T = null, @K=0
	SELECT  @K = ROUND(SUM(Колво),0)/1000 from fn_Номос(dateadd(d,-1,@Data)) WHERE МТР='A1AFB9E9D7B04DE48A4EB9504E11A73E' AND Участок=@ID
	insert into @t2 (l,P,K,T) select 'Топливо остатки на утро', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='404CBFD2E1A9497BA99B7B08780933AF' AND SYS_U is null





	--	2 Поступления Д/Т
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.Куда		= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='9394FA181DD74DD883BD85A9F8861595'
				AND а.Тип='Закупки' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '2 Поступления Д/Т', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='350FDCAA61DF4CF699CD162D095B1156' AND SYS_U is null




	--	2 Поступления АИ-92
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.Куда		= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='BB93D3F7DACE4940920DE8453E41E959'
				AND а.Тип='Закупки' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '2 Поступления Д/Т', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='E78F6EAE39A748EDAE2BCDF3A6214EB9' AND SYS_U is null


	--	2 Поступления АИ-95
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.Куда		= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='A1AFB9E9D7B04DE48A4EB9504E11A73E'
				AND а.Тип='Закупки' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '2 Поступления Д/Т', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='EADC77483BC84A5DB37CBAE4509E5D49' AND SYS_U is null


	--	3 Перемещения на участок Д/Т
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.Куда		= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='9394FA181DD74DD883BD85A9F8861595'
				AND а.Тип='Перемещения' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '3 Перемещения на участок Д/Т', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='58A1DC0A127F424EB8A5FBCFAF6A60A5' AND SYS_U is null


	--	3 Перемещения на участок АИ-92
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.Куда		= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='BB93D3F7DACE4940920DE8453E41E959'
				AND а.Тип='Перемещения' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '3 Перемещения на участок АИ-92', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='F94F22F591544BCCAFDF4CC3B0EFE4DF' AND SYS_U is null


	--	3 Перемещения на участок АИ-95
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.Куда		= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='A1AFB9E9D7B04DE48A4EB9504E11A73E'
				AND а.Тип='Перемещения' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '3 Перемещения на участок АИ-95', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='CEFE90B691864FD9803AF1B4D6B6B61C' AND SYS_U is null



	--	4 Перемещения с участка Д/Т
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='9394FA181DD74DD883BD85A9F8861595'
				AND а.Тип='Перемещения' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '4 Перемещения с участка Д/Т', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='59F7CB2ACAF5496692F51384FCC0C22B' AND SYS_U is null


	--	4 Перемещения с участка АИ-92
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='BB93D3F7DACE4940920DE8453E41E959'
				AND а.Тип='Перемещения' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '4 Перемещения с участка АИ-92', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='3FCBB789FAE84D73A84DA88DD2E121D9' AND SYS_U is null


	--	4 Перемещения с участка АИ-95
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='A1AFB9E9D7B04DE48A4EB9504E11A73E'
				AND а.Тип='Перемещения' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '4 Перемещения с участка АИ-95', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='2F88D09D83B14631B8D25426994453E8' AND SYS_U is null



	--	5 Заправки Д/Т
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND а.МТР='9394FA181DD74DD883BD85A9F8861595'
				AND а.Тип='Заправки' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '5 Заправки Д/Т', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='C1357879F71B415AAD716C7516B5735C' AND SYS_U is null


	--	5 Заправки АИ-92
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND а.МТР='BB93D3F7DACE4940920DE8453E41E959'
				AND а.Тип='Заправки' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '5 Заправки АИ-92', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='7FF1488F8E78458B84949D9DC1E5A1AE' AND SYS_U is null


	--	5 Заправки АИ-95
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND а.МТР='A1AFB9E9D7B04DE48A4EB9504E11A73E'
				AND а.Тип='Заправки' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '5 Заправки АИ-95', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='E18955CF7AC644528CBAACBCDEF30445' AND SYS_U is null


	--	6 Реализация Д/Т
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='9394FA181DD74DD883BD85A9F8861595'
				AND а.Тип='Реализация' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '6 Реализация Д/Т', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='CB38193B111F4F0C970BF31DFF29B95E' AND SYS_U is null


	--	6 Реализация АИ-92
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='BB93D3F7DACE4940920DE8453E41E959'
				AND а.Тип='Реализация' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '6 Реализация АИ-92', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='33456BAC491D4502BDDCF1C1A563A391' AND SYS_U is null


	--	6 Реализация АИ-95
	select  @T = null, @K=0
	SELECT	@K = ROUND(SUM(б.Количество),0)/1000 
	FROM			с_Ндвижение			AS а 
	INNER JOIN		с_НдвижениеСтроки	AS б ON а.SYS_ID	= б.Операция
	INNER JOIN		У_УС				AS о ON а.ОтКуда	= о.sys_id
	WHERE			а.Направление='Топливо' AND а.SYS_U Is Null AND б.SYS_U Is Null AND б.Количество<>0 
				AND б.МТР='A1AFB9E9D7B04DE48A4EB9504E11A73E'
				AND а.Тип='Реализация' AND а.Дата=@Data AND о.Участок=@ID
	insert into @t2 (l,P,K,T) select '6 Реализация АИ-95', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='0ED9138968354C098C8F026689AC7007' AND SYS_U is null




	--	7 Остаток на конец дня Д/Т
	select @T = null, @K=0
	SELECT  @K = ROUND(SUM(Колво),0)/1000 from fn_Номос(@Data) WHERE МТР='9394FA181DD74DD883BD85A9F8861595' AND Участок=@ID
	insert into @t2 (l,P,K,T) select 'Топливо остатки на вечер', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='DEE4710A50494891BC9F7EE07CC58448' AND SYS_U is null



	--	7 Остаток на конец дня АИ-92
	select @T = null, @K=0
	SELECT  @K = ROUND(SUM(Колво),0)/1000 from fn_Номос(@Data) WHERE МТР='BB93D3F7DACE4940920DE8453E41E959' AND Участок=@ID
	insert into @t2 (l,P,K,T) select 'Топливо остатки на вечер', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='CA85B52C20AC4BBFAA46D23998B16F36' AND SYS_U is null



	--	7 Остаток на конец дня АИ-95
	select @T = null, @K=0
	SELECT  @K = ROUND(SUM(Колво),0)/1000 from fn_Номос(@Data) WHERE МТР='A1AFB9E9D7B04DE48A4EB9504E11A73E' AND Участок=@ID
	insert into @t2 (l,P,K,T) select 'Топливо остатки на вечер', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='6893345B952347B89E7224E74C9A121E' AND SYS_U is null






	--	Путевые листы 	declare @d date, @u varchar(32); select @d='20161024', @u='567AD3F6D24E4C6CB881069B08CC6F5B'
	
	--	1. Состояние (отличное от - "Выполнен") и участок открытия = участку сводки; 
	select @T = null, @K=0

	SELECT		@T = isnull(@T + char(13) + char(10),'') 
				+	isnull(b.Название,'')
				+	isnull(', номер '			+a.Номер,'')
				+	isnull(', пробег '			+cast(cast(a.Пробег_Всего	as real)	as varchar(20))+' км','')
				+	isnull(', пробег с грузом '	+cast(cast(a.Пробег_Сгрузом as real)	as varchar(20))+' км','')
				+	isnull(', тоннаж '			+cast(cast(a.Тонны			as real)	as varchar(20))+' тн','')
				+	isnull(', моточасы '		+cast(cast(a.Моточасы_Всего	as real)	as varchar(20))+' ч' ,'')
				+	isnull(', расход '			+cast(cast(a.Расход_Факт	as real)	as varchar(20))+' л' ,'')
				+	isnull(', заправки '		+cast(cast(a.МТР_Выдан		as real)	as varchar(20))+' л' ,'') 
				,	@K = @K+1 
	from			с_ПЛисты a
	left			outer join У_УС b on a.Автотехника=b.SYS_ID
	WHERE			a.SYS_U is null 
				and isnull(a.Состояние,'')<>'Выполнен' 
				and a.Дата=@Data and a.Участок=@ID
	order by	b.Название

	insert into @t2 (l,P,K,T) select 'Путевые листы. 1) Состояние (отличное от - "Выполнен")', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='13C3527A65AF455786B9EA13C7BAC4BD' AND SYS_U is null





--	2. Состояние ("Выполнен"), участок закрытия = участку сводки, дата закрытия = дате сводки.
	select @T = null, @K=0

	SELECT		@T = isnull(@T + char(13) + char(10),'') 
				+	isnull(b.Название,'')
				+	isnull(', номер '			+a.Номер,'')
				+	isnull(', пробег '			+cast(cast(a.Пробег_Всего	as real)	as varchar(20))+' км','')
				+	isnull(', пробег с грузом '	+cast(cast(a.Пробег_Сгрузом as real)	as varchar(20))+' км','')
				+	isnull(', тоннаж '			+cast(cast(a.Тонны			as real)	as varchar(20))+' тн','')
				+	isnull(', моточасы '		+cast(cast(a.Моточасы_Всего	as real)	as varchar(20))+' ч' ,'')
				+	isnull(', расход '			+cast(cast(a.Расход_Факт	as real)	as varchar(20))+' л' ,'')
				+	isnull(', заправки '		+cast(cast(a.МТР_Выдан		as real)	as varchar(20))+' л' ,'') 
				,	@K = @K+1 
	from			с_ПЛисты a
	left			outer join У_УС b on a.Автотехника=b.SYS_ID
	WHERE			a.SYS_U is null 
				and a.Состояние='Выполнен' 
				and a.ДатаДо=@Data and a.УчастокВыполнения=@ID
	order by	b.Название

	insert into @t2 (l,P,K,T) select 'Путевые листы. 2) Состояние ("Выполнен")', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='9D191AB83CD14E4DA69C75518D46A90D' AND SYS_U is null















	-- Всего выдано из FOX
	select @T = null, @K=0

	SELECT		@K = @K + isnull(round(SUM(P.Вес)/1000,3),0)
			,	@T = isnull(@T + char(13) + char(10),'') 	
				+ isnull(s2.Название,'') + ', '+ISNULL(к1.ОфНазвание, к1.Название)
				+ ', '+ isnull(cast(cast(round(SUM(P.Вес)/1000,3) as real) as varchar(32)),'')+' тн'
	FROM				fox.dbo.иМТР		AS P 
	INNER JOIN			fox.dbo.Склады		AS s1 ON P.Откуда		= s1.SYS_ID 
	INNER JOIN			fox.dbo.Склады		AS sf ON s1.ФСклад		= sf.SYS_ID

	INNER JOIN			fox.dbo.Склады		AS s2 ON P.Куда			= s2.SYS_ID 
	LEFT OUTER JOIN		fox.dbo.Склады		AS sg ON s2.ФСклад		= sg.SYS_ID
	LEFT OUTER JOIN		fox.dbo.Контрагенты AS к1 ON P.Получатель	= к1.SYS_ID
	WHERE			    P.Дата=@Data AND sf.Участок=@id AND P.Вес<>0 
					and P.Операция<>'Инвентаризация' AND P.Операция<>'Приход' AND P.Операция not like 'Переме%'
	GROUP BY			s2.Название, P.Операция, к1.ОфНазвание, к1.Название, sf.Участок, sg.Участок
	order by			s2.Название, P.Операция, к1.ОфНазвание, к1.Название, sf.Участок, sg.Участок

	insert into @t2 (l,P,K,T) select 'Всего выдано из FOX', SYS_ID, @K, @T from СводкаУчСпр where SYS_ID='D333DB472833444EA4BE19A0444DFB1E' AND SYS_U is null

















	--	результат
	select				b.SYS_ID, @oper as Операция, t.P as Параметр, t.K as Количество, t.T as Значение , t.L
	from				@t2 t
	left outer join		СводкаУчСтроки b on t.P=b.Параметр and @oper=b.Операция --and b.SYS_U is null
	where				isnull(t.K,0) <> isnull(b.Количество,0) or isnull(t.T,'') <> isnull(b.Значение,'')

END