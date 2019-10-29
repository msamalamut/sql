/****** Object:  Table [dbo].[Поперации]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Поперации](
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
	[Название] [varchar](255) NULL,
	[Дата] [datetime] NULL,
	[Номер] [varchar](255) NULL,
	[Тип] [varchar](255) NULL,
	[ДатаНачало] [datetime] NULL,
	[ДатаКонец] [datetime] NULL,
	[Сотрудник1] [varchar](255) NULL,
	[Сотрудник2] [varchar](255) NULL,
	[Сотрудник3] [varchar](255) NULL,
	[Вид] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Участок] [varchar](255) NULL,
	[КолвоНарушений] [int] NULL,
	[ОбластьПроверки] [varchar](255) NULL,
 CONSTRAINT [PK_Поперации] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Поперации_STK] ON [dbo].[Поперации]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Поперации_SYS_T] ON [dbo].[Поперации]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Поперации_SYS_U] ON [dbo].[Поперации]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Поперации] ADD  CONSTRAINT [DF_Поперации_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
