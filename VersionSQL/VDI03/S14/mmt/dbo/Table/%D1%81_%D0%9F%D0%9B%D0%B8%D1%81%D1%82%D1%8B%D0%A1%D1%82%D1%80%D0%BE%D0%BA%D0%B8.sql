/****** Object:  Table [dbo].[с_ПЛистыСтроки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[с_ПЛистыСтроки](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_с_ПЛистыСтроки_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Операция] [varchar](255) NULL,
	[Заказчик] [varchar](255) NULL,
	[ВидРабот] [varchar](255) NULL,
	[ЕдИзм] [varchar](255) NULL,
	[Количество] [money] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ВидТСД] [varchar](255) NULL,
	[НомерТСД] [varchar](255) NULL,
	[ДатаТСД] [datetime] NULL,
	[Пробег_Всего] [money] NULL,
	[Часы_отработано] [money] NULL,
 CONSTRAINT [PK_с_ПЛистыСтроки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_с_ПЛистыСтроки_STK] ON [dbo].[с_ПЛистыСтроки]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_с_ПЛистыСтроки_SYS_T] ON [dbo].[с_ПЛистыСтроки]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_с_ПЛистыСтроки_SYS_U] ON [dbo].[с_ПЛистыСтроки]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
