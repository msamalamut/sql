/****** Object:  Table [dbo].[хПоручения]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хПоручения](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_хПоручения_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Номер] [varchar](32) NULL,
	[Откуда] [varchar](32) NULL,
	[Куда] [varchar](32) NULL,
	[ОткудаКА] [varchar](32) NULL,
	[КудаКА] [varchar](32) NULL,
	[ОткудаМОЛ] [varchar](32) NULL,
	[КудаМОЛ] [varchar](32) NULL,
	[ПВДата] [datetime] NULL,
	[ПВНомер] [varchar](32) NULL,
	[Клиент] [varchar](32) NULL,
	[Грузовладелец] [varchar](32) NULL,
 CONSTRAINT [PK_хПоручения] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

