/****** Object:  Table [dbo].[Автотехника]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Автотехника](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_Автотехника_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Вид] [varchar](255) NULL,
	[ГосНомер] [varchar](255) NULL,
	[Марка] [varchar](255) NULL,
	[ГодВыпуска] [int] NULL,
	[Собственник] [varchar](255) NULL,
	[ФормаВладения] [varchar](255) NULL,
	[Топливо] [varchar](255) NULL,
	[ТехСостояние] [varchar](255) NULL,
	[ТОПоследнее] [datetime] NULL,
	[ТОСледующее] [datetime] NULL,
	[ДД_СТС] [varchar](255) NULL,
	[ДД_ПТС] [varchar](255) NULL,
	[ДД_ВинКод] [varchar](255) NULL,
	[ДД_БортНомер] [varchar](255) NULL,
	[ДД_Тахограф] [varchar](255) NULL,
	[ДД_GPSкарта] [varchar](255) NULL,
	[ДД_GPS] [varchar](255) NULL,
	[Каско_Страховщик] [varchar](255) NULL,
	[Каско_Дата] [datetime] NULL,
	[Каско_ДатаДо] [datetime] NULL,
	[Каско_Номер] [varchar](255) NULL,
	[Каско_Сумма] [money] NULL,
	[Осаго_Страховщик] [varchar](255) NULL,
	[Осаго_Дата] [datetime] NULL,
	[Осаго_ДатаДо] [datetime] NULL,
	[Осаго_Номер] [varchar](255) NULL,
	[Осаго_Сумма] [money] NULL,
	[Каско_ДатаОП] [datetime] NULL,
	[Лизинг_КА] [varchar](255) NULL,
	[Лизинг_Дата] [datetime] NULL,
	[Лизинг_ДатаДо] [datetime] NULL,
	[Лизинг_ДатаОП] [datetime] NULL,
	[Лизинг_Номер] [varchar](255) NULL,
	[Выкуп_КА] [varchar](255) NULL,
	[Выкуп_Дата] [datetime] NULL,
	[Выкуп_Номер] [varchar](255) NULL,
	[Диаг_КА] [varchar](255) NULL,
	[Диаг_Номер] [varchar](255) NULL,
	[Диаг_Дата] [datetime] NULL,
	[Диаг_ДатаДо] [datetime] NULL,
	[Диаг_Регион] [varchar](255) NULL,
	[Участок] [varchar](255) NULL,
	[Шасси] [varchar](255) NULL,
	[НО_пробег] [money] NULL,
	[НО_прогрев] [money] NULL,
	[НО_отопитель] [money] NULL,
	[НО_оборудование] [money] NULL,
	[НО_моточасы] [money] NULL,
	[НО_скорость] [money] NULL,
	[НО_массанетто] [money] NULL,
	[НО_массабрутто] [money] NULL,
	[НО_межсервпробег] [money] NULL,
	[НО_межсервмоточасы] [money] NULL,
	[Класс] [varchar](255) NULL,
	[НО_ткм] [money] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ТОтип] [varchar](32) NULL,
	[ТОинтервал] [int] NULL,
	[ТОсчетчикПоследнне] [int] NULL,
	[ТОсчетчикСледующее] [int] NULL,
	[Аренда_Номер] [varchar](32) NULL,
	[Аренда_Дата] [datetime] NULL,
	[Аренда_АПП] [varchar](32) NULL,
	[Аренда_АПП_Дата] [datetime] NULL,
	[Аренда_ДопСогл] [varchar](32) NULL,
	[Аренда_ДопСогл_Дата] [datetime] NULL,
 CONSTRAINT [PK_Автотехника] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Автотехника_STK] ON [dbo].[Автотехника]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Автотехника_SYS_T] ON [dbo].[Автотехника]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Автотехника_SYS_U] ON [dbo].[Автотехника]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
