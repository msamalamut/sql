/****** Object:  Table [dbo].[хУслугиСтроки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хУслугиСтроки](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_хУслугиСтроки_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Операция] [varchar](32) NULL,
	[Услуга] [varchar](32) NULL,
	[Груз] [varchar](255) NULL,
	[Мест] [int] NULL,
	[Тоннаж] [decimal](18, 3) NULL,
	[Дата] [datetime] NULL,
	[Поручение] [varchar](32) NULL,
	[ТСНомер] [varchar](32) NULL,
	[ТСДНомер] [varchar](32) NULL,
	[Движение] [varchar](32) NULL,
	[Количество] [money] NULL,
	[ЕИ] [varchar](32) NULL,
	[Цена] [money] NULL,
	[Стоимость] [money] NULL,
	[СтавкаНДС] [money] NULL,
	[НДС] [money] NULL,
	[Сумма] [money] NULL,
	[Привязка] [varchar](32) NULL,
 CONSTRAINT [PK_хУслугиСтроки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

