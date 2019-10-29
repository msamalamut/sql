/****** Object:  Table [dbo].[Проводки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Проводки](
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
	[Проект] [varchar](32) NULL,
	[Тип] [varchar](32) NULL,
	[Дата] [datetime] NULL,
	[Сумма] [money] NULL,
	[ОтсрочкаДР] [int] NULL,
	[ОтсрочкаДК] [int] NULL,
	[ДатаК] [datetime] NULL,
	[ОткудаКА] [varchar](32) NULL,
	[КудаКА] [varchar](32) NULL,
	[Участок] [varchar](32) NULL,
	[Подразделение] [varchar](32) NULL,
	[Договор] [varchar](32) NULL,
	[Аналитика] [varchar](32) NULL,
	[ОткудаКарман] [varchar](32) NULL,
	[КудаКарман] [varchar](32) NULL,
 CONSTRAINT [PK_Проводки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Проводки] ADD  CONSTRAINT [DF_Проводки_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
