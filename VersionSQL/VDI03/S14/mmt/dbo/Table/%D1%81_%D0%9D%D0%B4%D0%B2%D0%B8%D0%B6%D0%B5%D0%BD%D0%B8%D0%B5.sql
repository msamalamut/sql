/****** Object:  Table [dbo].[с_Ндвижение]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[с_Ндвижение](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL,
	[SYS_T] [int] NULL,
	[SYS_U] [smallint] NULL,
	[SYS_S] [smallint] NULL,
	[SYS_D] [varchar](255) NULL,
	[Состояние] [varchar](255) NULL,
	[Создал] [varchar](255) NULL,
	[Создан] [datetime] NULL,
	[Изменил] [varchar](255) NULL,
	[Изменен] [datetime] NULL,
	[Примечания] [varchar](max) NULL,
	[Направление] [varchar](255) NULL,
	[Тип] [varchar](255) NULL,
	[Дата] [datetime] NULL,
	[Номер] [varchar](255) NULL,
	[Заказчик] [varchar](255) NULL,
	[Откуда] [varchar](255) NULL,
	[Куда] [varchar](255) NULL,
	[Контрагент] [varchar](255) NULL,
	[Сотрудник1] [varchar](255) NULL,
	[Сотрудник2] [varchar](255) NULL,
	[Сотрудник3] [varchar](255) NULL,
	[Пдата] [datetime] NULL,
	[Сдата] [datetime] NULL,
	[Пномер] [varchar](255) NULL,
	[Сномер] [varchar](255) NULL,
	[Пстоимость] [money] NULL,
	[Сстоимость] [money] NULL,
	[Стоимость] [money] NULL,
	[ДатаПлан] [datetime] NULL,
	[ДатаФакт] [datetime] NULL,
	[ФормаОплаты] [varchar](255) NULL,
	[ФормаДоставки] [varchar](255) NULL,
	[Плотность] [money] NULL,
	[МТР] [varchar](255) NULL,
	[Температура] [money] NULL,
	[ТТН_МаркаАвтомобиля] [varchar](255) NULL,
	[ТТН_ГосНомерАвтомобиля] [varchar](255) NULL,
	[ТТН_МаркаПрицепа] [varchar](255) NULL,
	[ТТН_ГосНомерПрицепа] [varchar](255) NULL,
	[ТТН_Водитель] [varchar](255) NULL,
	[ТТН_ВодительУдостоверение] [varchar](255) NULL,
	[ТТН_Перевозчик] [varchar](255) NULL,
	[ТТН_Заказчик] [varchar](255) NULL,
	[ТТН_ПунктРазгрузки] [varchar](255) NULL,
	[ТТН_ПунктПогрузки] [varchar](255) NULL,
	[ТТН_ВидПеревозки] [varchar](255) NULL,
	[ТТН_ЛицензионнаяКарточка] [varchar](255) NULL,
	[ТТН_СрокДоставки] [datetime] NULL,
	[М7_МестоСоставления] [varchar](255) NULL,
	[М7_ВремяНачало] [varchar](255) NULL,
	[М7_ВремяКонец] [varchar](255) NULL,
	[М7_ПринятОсмотрен] [varchar](255) NULL,
	[М7_УдостКачества] [varchar](255) NULL,
	[М7_СоСтанцииПристани] [varchar](255) NULL,
	[М7_Отправитель] [varchar](255) NULL,
	[М7_Поставщик] [varchar](255) NULL,
	[М7_Получатель] [varchar](255) NULL,
	[М7_Страховщик] [varchar](255) NULL,
	[М7_ДатаОтправки] [datetime] NULL,
	[М7_Телефонограмма] [varchar](255) NULL,
	[М7_УсловияХранения] [varchar](255) NULL,
	[М7_СостояниеТарыУпаковки] [varchar](255) NULL,
	[М7_КолвоНедостПрод] [varchar](255) NULL,
	[М7_ДругиеДанные] [varchar](255) NULL,
	[М7_ЗаключениеКомиссии] [varchar](255) NULL,
	[М7_Приложение] [varchar](255) NULL,
	[ТТН_ПЛНомер] [varchar](255) NULL,
	[М15_Основание] [varchar](255) NULL,
	[М15_КомуФио] [varchar](255) NULL,
	[М15_КомуДолжность] [varchar](255) NULL,
	[М7_ДВ_ПрибытиеНаСтанцию] [datetime] NULL,
	[М7_ДВ_ВыдачаГруза] [datetime] NULL,
	[М7_ДВ_ВскрытияВагона] [datetime] NULL,
	[М7_ДВ_ДОставкаНаСклад] [datetime] NULL,
	[М7_ПоТСДНомер] [varchar](255) NULL,
	[М7_ПоТСДДата] [datetime] NULL,
	[М7_ПоТСДВагоны] [varchar](255) NULL,
	[М7_ДоговорПоставкиДата] [datetime] NULL,
	[М7_ДоговорПоставкиНомер] [varchar](255) NULL,
	[Счетчик] [varchar](255) NULL,
	[СУчастка] [varchar](255) NULL,
	[ИзЗакупки] [varchar](255) NULL,
	[Бномер] [varchar](255) NULL,
	[Бдата] [datetime] NULL,
	[Чномер] [varchar](255) NULL,
	[Чдата] [datetime] NULL,
	[Ономер] [varchar](255) NULL,
	[Одата] [datetime] NULL,
	[Тномер] [varchar](255) NULL,
	[Тдата] [datetime] NULL,
	[Челенджер] [varchar](255) NULL,
	[ПутевойЛист] [varchar](255) NULL,
	[ПитНормы] [varchar](255) NULL,
	[Человеков] [money] NULL,
	[ТТН_Плательщик] [varchar](255) NULL,
	[ТТН_ДоверенностьНомер] [varchar](255) NULL,
	[ТТН_ДоверенностьДата] [datetime] NULL,
	[ТТН_ДоверенностьВыдана] [varchar](255) NULL,
	[Подотчётник] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Приоритет] [varchar](255) NULL,
	[ДатаНачало] [datetime] NULL,
	[ДатаКонец] [datetime] NULL,
	[ЧеловекВсего] [int] NULL,
	[Договор] [varchar](32) NULL,
	[Код1С] [varchar](32) NULL,
 CONSTRAINT [PK_с_Ндвижение] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_с_Ндвижение_STK] ON [dbo].[с_Ндвижение]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_с_Ндвижение_SYS_T] ON [dbo].[с_Ндвижение]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_с_Ндвижение_SYS_U] ON [dbo].[с_Ндвижение]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_с_Ндвижение_Тип] ON [dbo].[с_Ндвижение]
(
	[Тип] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[с_Ндвижение] ADD  CONSTRAINT [DF_с_Ндвижение_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
