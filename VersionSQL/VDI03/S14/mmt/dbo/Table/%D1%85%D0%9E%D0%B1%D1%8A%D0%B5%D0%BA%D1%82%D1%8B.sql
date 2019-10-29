/****** Object:  Table [dbo].[хОбъекты]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[хОбъекты](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Код] [int] NULL,
	[SYS_ID] [varchar](32) NOT NULL CONSTRAINT [DF_хОбъекты_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Проект] [varchar](32) NOT NULL,
	[Тип] [varchar](32) NOT NULL,
	[Ссылка] [varchar](32) NULL,
	[Подчинен] [varchar](32) NULL,
	[СтрукПодр] [varchar](255) NULL,
	[Контрагент] [varchar](32) NULL,
	[Договор] [varchar](32) NULL,
	[Номенклатура] [varchar](32) NULL,
	[Комплект] [varchar](32) NULL,
	[Партия] [varchar](32) NULL,
	[ПартияНомер] [varchar](32) NULL,
	[ПартияДата] [datetime] NULL,
	[Цена] [money] NULL,
	[Стоимость] [money] NULL,
	[СтавкаНДС] [money] NULL,
	[НДС] [money] NULL,
	[Сумма] [money] NULL,
	[ГоденДо] [datetime] NULL,
	[БЕИ] [varchar](32) NOT NULL CONSTRAINT [DF_хОбъекты_БЕИ]  DEFAULT ('unit'),
	[ДЕИ] [varchar](32) NULL,
	[АЕИ] [varchar](32) NULL,
	[КолБЕИ] [decimal](18, 3) NULL,
	[КолДЕИ] [decimal](18, 3) NULL,
	[КолАЕИ] [decimal](18, 3) NULL,
	[ВесКгНетто] [decimal](18, 3) NULL,
	[ВесКгБрутто] [decimal](18, 3) NULL,
	[Мест] [int] NULL,
	[Маркировка] [varchar](255) NULL,
	[СерийныйНомер] [varchar](255) NULL,
	[ЗаводскойНомер] [varchar](255) NULL,
	[ИнвентарныйНомер] [varchar](255) NULL,
	[Упаковка] [varchar](32) NULL,
	[Счет1] [varchar](32) NULL,
	[Описание] [varchar](255) NULL,
	[КолБЕИДок] [decimal](18, 3) NULL,
	[ВесКгБруттоДок] [decimal](18, 3) NULL,
	[МестДок] [int] NULL,
	[Недостача] [decimal](18, 3) NULL,
	[Излишек] [decimal](18, 3) NULL,
	[Брак] [decimal](18, 3) NULL,
	[Бой] [decimal](18, 3) NULL,
	[ПаспортСертификат] [varchar](255) NULL,
	[Автотехника] [varchar](32) NULL,
	[Габариты] [varchar](32) NULL,
	[Пломба] [varchar](32) NULL,
	[Заявка] [varchar](32) NULL,
	[Код1С] [varchar](32) NULL,
	[Прожект] [varchar](32) NULL,
	[ДлинаМ] [decimal](18, 3) NULL,
	[ШиринаМ] [decimal](18, 3) NULL,
	[ВысотаМ] [decimal](18, 3) NULL,
	[ОбъемМ3] [decimal](18, 6) NULL,
	[ВесКгНеттоДок] [decimal](18, 3) NULL,
	[БракБой] [decimal](18, 3) NULL,
	[КодПартииГруза] [varchar](32) NULL,
	[Цена2] [money] NULL,
	[Цена3] [money] NULL,
 CONSTRAINT [PK_хОбъекты] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_хОбъекты_STK] ON [dbo].[хОбъекты]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хОбъекты_SYS_T] ON [dbo].[хОбъекты]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_хОбъекты_SYS_U] ON [dbo].[хОбъекты]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_хОбъекты_Проект] ON [dbo].[хОбъекты]
(
	[Проект] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_хОбъекты_Состояние] ON [dbo].[хОбъекты]
(
	[Состояние] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_хОбъекты_Тип] ON [dbo].[хОбъекты]
(
	[Тип] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER [dbo].[trg_Volume_Modified]
   ON [dbo].[хОбъекты]
   AFTER UPDATE, INSERT
AS BEGIN
    SET NOCOUNT ON;
    IF UPDATE (ДлинаМ) OR UPDATE (ШиринаМ) OR UPDATE (ВысотаМ)
    BEGIN
        UPDATE хОбъекты 
        SET ОбъемМ3 = CAST(ISNULL(O.ДлинаМ, 0) * ISNULL(O.ШиринаМ, 0) * ISNULL(O.ВысотаМ, 0) AS DECIMAL(18, 6))
        FROM хОбъекты O INNER JOIN Inserted I ON O.SYS_ID = I.SYS_ID
    END 
END
