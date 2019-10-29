/****** Object:  Table [dbo].[кнтДвижение]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[кнтДвижение](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_кнтПоставки_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Проект] [varchar](32) NOT NULL,
	[Тип] [varchar](32) NOT NULL,
	[Собственник] [varchar](32) NULL,
	[Заказчик] [varchar](32) NULL,
	[Организация] [varchar](32) NULL,
	[Статус] [varchar](32) NULL,
	[Склад] [varchar](32) NULL,
	[ОткудаКА] [varchar](32) NULL,
	[КудаКА] [varchar](32) NULL,
	[Откуда] [varchar](32) NULL,
	[Куда] [varchar](32) NULL,
 CONSTRAINT [PK_кнтПоставки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

