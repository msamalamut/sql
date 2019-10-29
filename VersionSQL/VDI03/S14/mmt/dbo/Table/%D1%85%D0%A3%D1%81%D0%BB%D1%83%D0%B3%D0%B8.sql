/****** Object:  Table [dbo].[хУслуги]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хУслуги](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_хУслуги_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Номер] [varchar](32) NULL,
	[Дата] [datetime] NULL,
	[Поручение] [varchar](32) NULL,
	[МОЛисполнитель] [varchar](32) NULL,
	[МОЛпорученец] [varchar](32) NULL,
	[Организация] [varchar](32) NULL,
	[Контрагент] [varchar](32) NULL,
	[Договор] [varchar](32) NULL,
	[ЗаявкиСписок] [varchar](255) NULL,
	[НомерСФ] [varchar](32) NULL,
	[Сумма] [money] NULL,
 CONSTRAINT [PK_хУслуги] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

