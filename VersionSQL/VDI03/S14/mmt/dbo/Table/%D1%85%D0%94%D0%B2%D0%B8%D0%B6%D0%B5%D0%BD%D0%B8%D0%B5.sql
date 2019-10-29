/****** Object:  Table [dbo].[хДвижение]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хДвижение](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_хДвижение_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Дата] [datetime] NULL,
	[Номер] [varchar](32) NULL,
	[Откуда] [varchar](32) NULL,
	[Проект] [varchar](32) NOT NULL,
	[Тип] [varchar](32) NOT NULL,
	[Куда] [varchar](32) NULL,
	[Что] [varchar](32) NULL,
	[ОткудаДЬ] [varchar](32) NULL,
	[КудаДЬ] [varchar](32) NULL,
	[Стоимость] [money] NULL,
	[ОткудаМОЛ] [varchar](32) NULL,
	[КудаМОЛ] [varchar](32) NULL,
	[ОсобыеОтметки] [varchar](max) NULL,
	[ОсобыеОтметки2] [varchar](max) NULL,
	[Комиссар1] [varchar](32) NULL,
	[ТС] [varchar](32) NULL,
	[ТСНомер] [varchar](32) NULL,
	[ТСМарка] [varchar](32) NULL,
	[ПрицепНомер] [varchar](32) NULL,
	[ПрицепМарка] [varchar](32) NULL,
	[ПутевойЛист] [varchar](32) NULL,
	[ТСД] [varchar](32) NULL,
	[ТСДНомер] [varchar](32) NULL,
	[ТСДДата] [datetime] NULL,
	[ПриемкаЗамечания] [varchar](max) NULL,
	[Грузоотправитель] [varchar](32) NULL,
	[Грузополучатель] [varchar](32) NULL,
	[Перевозчик] [varchar](32) NULL,
	[Экспедитор] [varchar](32) NULL,
	[Кладовщик] [varchar](32) NULL,
	[МестоОтгрузки] [varchar](32) NULL,
	[СостояниеТары] [varchar](max) NULL,
	[ДругиеДанные] [varchar](max) NULL,
	[КоличествоНедостающей] [varchar](max) NULL,
	[УслХранения] [varchar](max) NULL,
	[НаличиеПаспортовСертификатов] [varchar](max) NULL,
	[Опломбирован] [varchar](max) NULL,
	[Ключи] [varchar](max) NULL,
	[Водитель] [varchar](32) NULL,
	[ФормаОплаты] [varchar](32) NULL,
	[ОткудаКА] [varchar](32) NULL,
	[КудаКА] [varchar](32) NULL,
	[Код1С] [varchar](32) NULL,
	[Поставщик] [varchar](32) NULL,
	[КодЮрика] [varchar](255) NULL,
	[Сегмент] [varchar](32) NULL,
	[Договор] [varchar](32) NULL,
	[Поручение] [varchar](32) NULL,
	[ПриемкаНачало] [datetime] NULL,
	[ПриемкаКонец] [datetime] NULL,
	[АОФ] [varchar](255) NULL,
	[НомерХ] [varchar](32) NULL,
	[АОФПричина] [varchar](255) NULL,
	[НомерШ] [varchar](32) NULL,
	[ПриемкаУбытие] [datetime] NULL,
	[ГрузСборный] [varchar](max) NULL,
	[ГрузОпасный] [varchar](max) NULL,
	[ТСДСписок] [varchar](max) NULL,
	[ГрузУпаковка] [varchar](32) NULL,
	[ТТН] [varchar](32) NULL,
	[ДатаДоставки] [datetime] NULL,
	[ВидОтправления] [varchar](32) NULL,
	[СтанцияОтправления] [varchar](32) NULL,
	[СФНомер] [varchar](32) NULL,
	[СФДата] [datetime] NULL,
	[Торг12Номер] [varchar](32) NULL,
	[Торг12Дата] [datetime] NULL,
	[Статус] [varchar](255) NULL,
	[ОткудаМесто] [varchar](32) NULL,
	[КудаМесто] [varchar](32) NULL,
	[ГрузПрибытие] [datetime] NULL,
	[ГрузВыдача] [datetime] NULL,
	[Плательщик] [varchar](32) NULL,
	[Тальман] [varchar](32) NULL,
	[ФинОрг] [varchar](32) NULL,
	[Клиент] [varchar](32) NULL,
	[Грузовладелец] [varchar](32) NULL,
 CONSTRAINT [PK_хДвижение] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_хДвижение_STK] ON [dbo].[хДвижение]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хДвижение_SYS_T] ON [dbo].[хДвижение]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хДвижение_SYS_U] ON [dbo].[хДвижение]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_хДвижение_Проект] ON [dbo].[хДвижение]
(
	[Проект] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_хДвижение_Состояние] ON [dbo].[хДвижение]
(
	[Состояние] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_хДвижение_Тип] ON [dbo].[хДвижение]
(
	[Тип] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
