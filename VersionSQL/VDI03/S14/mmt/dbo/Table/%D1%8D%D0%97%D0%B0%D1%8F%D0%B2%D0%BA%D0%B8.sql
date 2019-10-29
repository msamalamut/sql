/****** Object:  Table [dbo].[эЗаявки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[эЗаявки](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_эЗаявки_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Водитель] [varchar](32) NULL,
	[Автотехника] [varchar](32) NULL,
	[Пробег] [int] NULL,
	[ВесКг] [decimal](18, 3) NULL,
	[Маршрут] [varchar](255) NULL,
	[Груз] [varchar](255) NULL,
	[Задание] [varchar](255) NULL,
	[Заказчик] [varchar](32) NULL,
	[Грузоотправитель] [varchar](32) NULL,
	[Грузополучатель] [varchar](32) NULL,
	[Организация] [varchar](32) NULL,
	[Автоприцеп] [varchar](32) NULL,
 CONSTRAINT [PK_эЗаявки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

