/****** Object:  Table [dbo].[с_НдвижениеСтроки2]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[с_НдвижениеСтроки2](
	[Код] [int] NULL,
	[Дата] [datetime] NULL,
	[Тип] [varchar](255) NULL,
	[SYS_ID] [varchar](8000) NULL,
	[SYS_D] [varchar](255) NULL,
	[Состояние] [varchar](255) NULL,
	[Создал] [varchar](255) NULL,
	[Создан] [datetime] NULL,
	[Изменил] [varchar](255) NULL,
	[Изменен] [datetime] NULL,
	[Примечания] [varchar](max) NULL,
	[Операция] [varchar](255) NULL,
	[Откуда] [varchar](255) NULL,
	[Куда] [varchar](255) NULL,
	[мтр] [varchar](255) NULL,
	[Количество] [money] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

