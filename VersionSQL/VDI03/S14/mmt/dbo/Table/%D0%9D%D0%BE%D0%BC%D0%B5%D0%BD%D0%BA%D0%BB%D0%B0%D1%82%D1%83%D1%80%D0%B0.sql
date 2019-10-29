/****** Object:  Table [dbo].[Номенклатура]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Номенклатура](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_Номенклатура_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Группа] [varchar](255) NULL,
	[ЕдИзм] [varchar](255) NULL,
	[СерийныйНомер] [varchar](255) NULL,
	[Характеристики] [varchar](255) NULL,
	[СрокИспользования] [int] NULL,
	[Тип] [varchar](255) NULL,
	[СсылкаНом1С] [varchar](255) NULL,
	[СсылкаНомУ1] [varchar](255) NULL,
	[СсылкаНомУ2] [varchar](255) NULL,
	[ЕдИзм2] [varchar](255) NULL,
	[ЕИКПересчет] [money] NULL,
	[НомерКаталог] [varchar](255) NULL,
	[Направление] [varchar](255) NULL,
	[ИнвентарныйНомер] [varchar](255) NULL,
	[Модель] [varchar](255) NULL,
	[Марка] [varchar](255) NULL,
	[Вес] [money] NULL,
	[ММДлина] [int] NULL,
	[ММШирина] [int] NULL,
	[ММВысота] [int] NULL,
	[ГоденДо] [datetime] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[СтавкаНДС] [money] NULL,
 CONSTRAINT [PK_Номенклатура] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Номенклатура_STK] ON [dbo].[Номенклатура]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Номенклатура_SYS_T] ON [dbo].[Номенклатура]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Номенклатура_SYS_U] ON [dbo].[Номенклатура]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
