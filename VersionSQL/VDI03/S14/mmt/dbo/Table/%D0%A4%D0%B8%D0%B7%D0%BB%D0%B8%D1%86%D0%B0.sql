/****** Object:  Table [dbo].[Физлица]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Физлица](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_Физлица_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Фамилия] [varchar](255) NULL,
	[Имя] [varchar](255) NULL,
	[Отчество] [varchar](255) NULL,
	[ДеньРождения] [datetime] NULL,
	[МестоРождения] [varchar](255) NULL,
	[Фото] [varchar](32) NULL,
	[ПаспортСерия] [varchar](32) NULL,
	[ПаспортНомер] [varchar](32) NULL,
	[ПаспортДата] [datetime] NULL,
	[ПаспортВыдан] [varchar](255) NULL,
	[ПаспортКодПодр] [varchar](32) NULL,
	[Пол] [varchar](1) NULL,
	[Адрес] [varchar](255) NULL,
	[Телефон] [varchar](255) NULL,
	[Емайл] [varchar](255) NULL,
	[Скайп] [varchar](255) NULL,
	[Проект] [varchar](32) NULL,
	[СНИЛС] [varchar](32) NULL,
	[ИНН] [varchar](32) NULL,
 CONSTRAINT [PK_Физлица] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Физлица_STK] ON [dbo].[Физлица]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Физлица_SYS_T] ON [dbo].[Физлица]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Физлица_SYS_U] ON [dbo].[Физлица]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
