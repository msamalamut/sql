/****** Object:  Table [dbo].[ТабельСпр]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ТабельСпр](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_ТабельСпр_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Группа] [varchar](255) NULL,
	[Название] [varchar](255) NULL,
	[КодБукв] [varchar](255) NULL,
	[КодЦифр] [varchar](255) NULL,
	[РаботаНеработа] [int] NULL,
	[СотрудникСтатус] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ТабельСпр] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ТабельСпр_STK] ON [dbo].[ТабельСпр]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ТабельСпр_SYS_T] ON [dbo].[ТабельСпр]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ТабельСпр_SYS_U] ON [dbo].[ТабельСпр]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
