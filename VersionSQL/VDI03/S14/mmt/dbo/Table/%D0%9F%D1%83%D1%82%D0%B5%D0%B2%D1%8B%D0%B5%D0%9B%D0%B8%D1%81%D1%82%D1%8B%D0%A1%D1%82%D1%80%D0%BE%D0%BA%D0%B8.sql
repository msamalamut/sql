/****** Object:  Table [dbo].[ПутевыеЛистыСтроки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ПутевыеЛистыСтроки](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_ПутевыеЛистыСтроки_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Заказчик] [varchar](32) NULL,
	[Дата] [datetime] NULL,
	[Номер] [varchar](32) NULL,
	[Тонны] [money] NULL,
	[Часы] [money] NULL,
	[Пробег] [money] NULL,
	[Операция] [varchar](32) NULL,
	[ТКМ] [money] NULL,
	[ВидРабот] [varchar](255) NULL,
	[ЕдИзм] [varchar](32) NULL,
	[Количество] [money] NULL,
 CONSTRAINT [PK_ПутевыеЛистыСтроки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

