/****** Object:  Table [dbo].[хПеревозкиПодряд]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хПеревозкиПодряд](
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
	[Операция] [varchar](32) NOT NULL,
	[Подрядчик] [varchar](32) NOT NULL,
	[ТС] [varchar](32) NULL,
	[ТСНомер] [varchar](32) NULL,
	[ТСМарка] [varchar](32) NULL,
	[Водитель] [varchar](32) NULL,
	[Дата] [datetime] NULL,
	[Номер] [varchar](32) NULL,
	[СтоимостьСчет] [money] NULL,
	[СтоимостьОплата] [money] NULL,
	[ДатаСФ] [datetime] NULL,
	[ОтсрочкаКД] [int] NULL,
	[ОтсрочкаРД] [int] NULL,
	[ДатаОплаты] [datetime] NULL,
 CONSTRAINT [PK_хПеревозкиПодряд] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_хПеревозкиПодряд_STK] ON [dbo].[хПеревозкиПодряд]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хПеревозкиПодряд_SYS_T] ON [dbo].[хПеревозкиПодряд]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хПеревозкиПодряд_SYS_U] ON [dbo].[хПеревозкиПодряд]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[хПеревозкиПодряд] ADD  CONSTRAINT [DF_хПеревозкиПодряд_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
