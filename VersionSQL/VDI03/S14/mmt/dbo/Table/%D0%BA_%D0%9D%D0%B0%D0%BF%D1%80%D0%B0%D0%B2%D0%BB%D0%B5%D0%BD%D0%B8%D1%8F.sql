/****** Object:  Table [dbo].[к_Направления]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[к_Направления](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_к_Направления_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Ответственный] [varchar](255) NULL,
	[Место] [varchar](255) NULL,
	[Отдел] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_к_Направления] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_к_Направления_STK] ON [dbo].[к_Направления]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_к_Направления_SYS_T] ON [dbo].[к_Направления]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_к_Направления_SYS_U] ON [dbo].[к_Направления]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
