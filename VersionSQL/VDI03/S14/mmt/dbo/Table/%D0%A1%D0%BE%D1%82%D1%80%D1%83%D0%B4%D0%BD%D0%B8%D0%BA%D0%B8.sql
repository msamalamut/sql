/****** Object:  Table [dbo].[Сотрудники]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Сотрудники](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_Сотрудники_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Название] [varchar](255) NOT NULL,
	[Фамилия] [varchar](255) NULL,
	[Имя] [varchar](255) NULL,
	[Отчество] [varchar](255) NULL,
	[Должность] [varchar](255) NULL,
	[Участок] [varchar](255) NULL,
	[Подразделение] [varchar](255) NULL,
	[Тип] [varchar](255) NULL,
	[Емайл] [varchar](255) NULL,
	[Удостоверение] [varchar](255) NULL,
	[УдостоверениеКласс] [varchar](255) NULL,
	[УдостоверениеДата] [datetime] NULL,
	[Телефон] [varchar](255) NULL,
	[Код1С] [varchar](255) NULL,
	[Статус] [varchar](255) NULL,
	[УсловияНайма] [varchar](255) NULL,
	[МетодРаботы] [varchar](255) NULL,
	[УчастокТабель] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ДатаМедучет] [datetime] NULL,
	[ТелефонВнутр] [varchar](255) NULL,
	[Организация] [varchar](32) NULL,
	[Физлицо] [varchar](32) NULL,
	[ДатаРаботаПрием] [datetime] NULL,
	[ДатаРаботаУвольнение] [datetime] NULL,
	[Скайп] [varchar](32) NULL,
 CONSTRAINT [PK_Сотрудники] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Сотрудники_STK] ON [dbo].[Сотрудники]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Сотрудники_SYS_T] ON [dbo].[Сотрудники]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Сотрудники_SYS_U] ON [dbo].[Сотрудники]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
