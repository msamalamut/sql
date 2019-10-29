/****** Object:  Table [dbo].[Доступ]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Доступ](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_Доступ_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Операция] [varchar](255) NOT NULL,
	[Роль] [varchar](255) NOT NULL,
	[УровеньПрав] [int] NOT NULL CONSTRAINT [DF__Доступ__УровеньП__4AD81681]  DEFAULT ((0)),
	[ППодвал] [int] NULL,
	[ПДокументы] [int] NULL,
	[ПКонтакты] [int] NULL,
	[ПЗадачи] [int] NULL,
	[Создать] [varchar](255) NULL,
	[Изменить] [varchar](255) NULL,
	[Копия] [varchar](255) NULL,
	[Ввод] [varchar](255) NULL,
	[Печать] [varchar](255) NULL,
	[Просмотр] [varchar](255) NULL,
	[Место] [varchar](255) NULL,
	[Черновик] [varchar](255) NULL,
	[Блок] [varchar](255) NULL,
	[Вработе] [varchar](255) NULL,
	[Выполнен] [varchar](255) NULL,
	[Отмена] [varchar](255) NULL,
	[НаСогласовании] [varchar](255) NULL,
	[Согласовано] [varchar](255) NULL,
	[ПроведеноВбух] [varchar](255) NULL,
	[ПровереноМехаником] [varchar](255) NULL,
	[Архив] [varchar](255) NULL,
	[КП] [varchar](255) NULL,
	[ЗаявкаОтклонена] [varchar](255) NULL,
	[ДоговорПодготовка] [varchar](255) NULL,
	[ДоговорПодписан] [varchar](255) NULL,
	[КПОтклонено] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ПровереноОМТО] [varchar](32) NULL,
	[Проверен] [varchar](32) NULL,
 CONSTRAINT [PK_Доступ] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

CREATE UNIQUE NONCLUSTERED INDEX [IX_Доступ] ON [dbo].[Доступ]
(
	[Операция] ASC,
	[Роль] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Доступ_STK] ON [dbo].[Доступ]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Доступ_SYS_T] ON [dbo].[Доступ]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Доступ_SYS_U] ON [dbo].[Доступ]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
