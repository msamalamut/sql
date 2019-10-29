/****** Object:  Table [dbo].[Контрагенты]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Контрагенты](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_Контрагенты_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[ОфНазвание] [varchar](255) NULL,
	[ОфАдрес] [varchar](255) NULL,
	[ОфТелефон] [varchar](255) NULL,
	[ФактАдрес] [varchar](255) NULL,
	[ПочтовыйАдрес] [varchar](255) NULL,
	[ИНН] [varchar](255) NULL,
	[КПП] [varchar](255) NULL,
	[ОКПО] [varchar](255) NULL,
	[ОГРЭН] [varchar](255) NULL,
	[Код1С] [varchar](255) NULL,
	[БанкРеквизиты] [varchar](max) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ШарепоинтИД] [int] NULL,
	[КонтактноеЛицо] [varchar](255) NULL,
	[Сайт] [varchar](255) NULL,
	[Емайл] [varchar](255) NULL,
	[ТШАктСписания] [varchar](max) NULL,
	[ОКВЭД] [varchar](32) NULL,
 CONSTRAINT [PK_Контрагенты] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Контрагенты_STK] ON [dbo].[Контрагенты]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Контрагенты_SYS_T] ON [dbo].[Контрагенты]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Контрагенты_SYS_U] ON [dbo].[Контрагенты]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
