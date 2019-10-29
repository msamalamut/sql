/****** Object:  Table [dbo].[хПереЗаявки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хПереЗаявки](
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
	[РегионОтправки] [varchar](32) NULL,
	[Менеджер] [varchar](32) NULL,
	[Описание] [varchar](max) NULL,
	[Статус] [varchar](32) NULL,
	[НомерКП] [varchar](32) NULL,
	[ДатаКП] [datetime] NULL,
	[СуммаКП] [money] NULL,
	[Маржа] [money] NULL,
	[Результат] [varchar](32) NULL,
	[Компания] [varchar](255) NULL,
 CONSTRAINT [PK_хПереЗаявки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[хПереЗаявки] ADD  CONSTRAINT [DF_хПереЗаявки_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
