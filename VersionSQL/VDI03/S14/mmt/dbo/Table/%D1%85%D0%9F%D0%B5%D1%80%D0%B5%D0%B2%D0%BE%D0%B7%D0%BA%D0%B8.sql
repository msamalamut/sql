/****** Object:  Table [dbo].[хПеревозки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хПеревозки](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL,
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
	[Проект] [varchar](32) NULL,
	[Тип] [varchar](32) NULL,
	[Откуда] [varchar](32) NULL,
	[Куда] [varchar](32) NULL,
	[ТС] [varchar](32) NULL,
	[ТСНомер] [varchar](32) NULL,
	[ТСМарка] [varchar](32) NULL,
	[Водитель] [varchar](32) NULL,
	[Маршрут] [varchar](255) NULL,
	[Пробег] [money] NULL,
	[ВесКг] [decimal](18, 3) NULL,
	[Исполнитель] [varchar](32) NULL,
	[Заказчик] [varchar](32) NULL,
	[Подрядчик] [varchar](32) NULL,
	[Груз] [varchar](255) NULL,
	[ДатаЗаказчик] [datetime] NULL,
	[НомерЗаказчик] [varchar](32) NULL,
	[ДатаПодрядчик] [datetime] NULL,
	[НомерПодрядчик] [varchar](32) NULL,
	[СтоимостьЗаказ] [money] NULL,
	[СтоимостьПодряд] [money] NULL,
	[СтоимостьДоход] [money] NULL,
	[СтоимостьРасход] [money] NULL,
	[Прожект] [varchar](32) NULL,
	[ДатаСФЗаказ] [datetime] NULL,
	[ДатаСФПодряд] [datetime] NULL,
	[НомерИД] [varchar](32) NULL,
	[ОтсрочкаКД] [int] NULL,
	[ОтсрочкаРД] [int] NULL,
	[ДатаОплаты] [datetime] NULL,
 CONSTRAINT [PK_хПеревозки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_хПеревозки_STK] ON [dbo].[хПеревозки]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хПеревозки_SYS_T] ON [dbo].[хПеревозки]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хПеревозки_SYS_U] ON [dbo].[хПеревозки]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[хПеревозки] ADD  CONSTRAINT [DF_хПеревозки_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
