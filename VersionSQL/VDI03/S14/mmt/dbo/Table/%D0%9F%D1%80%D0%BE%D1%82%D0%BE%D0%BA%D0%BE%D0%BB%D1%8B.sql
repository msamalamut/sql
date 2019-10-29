/****** Object:  Table [dbo].[Протоколы]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Протоколы](
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
	[Дата] [datetime] NULL,
	[Номер] [varchar](255) NULL,
	[Протокол] [varchar](255) NULL,
	[МестоПроведения] [varchar](255) NULL,
	[Сотрудник1] [varchar](255) NULL,
	[Сотрудник2] [varchar](255) NULL,
	[Сотрудник3] [varchar](255) NULL,
	[ДатаРаспор] [datetime] NULL,
	[НомерРаспор] [varchar](255) NULL,
	[Шапка1] [varchar](255) NULL,
	[Шапка2] [varchar](255) NULL,
	[Вид] [varchar](255) NULL,
	[НомерПриказ] [varchar](255) NULL,
	[ДатаПриказ] [datetime] NULL,
	[Подразделение] [varchar](255) NULL,
	[Участок] [varchar](255) NULL,
	[СотрудникиТип] [varchar](255) NULL,
	[ДатаСлед] [datetime] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Протоколы] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Протоколы_STK] ON [dbo].[Протоколы]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Протоколы_SYS_T] ON [dbo].[Протоколы]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Протоколы_SYS_U] ON [dbo].[Протоколы]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Протоколы] ADD  CONSTRAINT [DF_Протоколы_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
