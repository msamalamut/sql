/****** Object:  Table [dbo].[с_ПЛисты]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[с_ПЛисты](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL CONSTRAINT [DF_с_ПЛисты_SYS_ID]  DEFAULT (replace(newid(),'-','')),
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
	[Дата] [datetime] NULL,
	[Номер] [varchar](255) NULL,
	[Автотехника] [varchar](255) NULL,
	[Автоприцеп] [varchar](255) NULL,
	[МТР] [varchar](255) NULL,
	[Водитель] [varchar](255) NULL,
	[Смена] [int] NULL,
	[МТР_Начало] [money] NULL,
	[МТР_Выдан] [money] NULL,
	[Спидометр_Начало] [money] NULL,
	[Моточасы_Начало] [money] NULL,
	[Часы_движение] [money] NULL,
	[Часы_прогрев] [money] NULL,
	[Часы_отопитель] [money] NULL,
	[Часы_оборудование] [money] NULL,
	[Пробег_Всего] [money] NULL,
	[Пробег_Сгрузом] [money] NULL,
	[Тонны] [money] NULL,
	[Диспетчер] [varchar](255) NULL,
	[Механик] [varchar](255) NULL,
	[Таксировщик] [varchar](255) NULL,
	[НачУчастка] [varchar](255) NULL,
	[Задание] [varchar](255) NULL,
	[Маршрут] [varchar](255) NULL,
	[Участок] [varchar](255) NULL,
	[Заказчик] [varchar](255) NULL,
	[Заказчик2] [varchar](255) NULL,
	[Серия] [varchar](255) NULL,
	[Норма_РаботаОборудования] [money] NULL,
	[Норма_прогрев] [money] NULL,
	[Норма_отопитель] [money] NULL,
	[Норма_100] [money] NULL,
	[Норма_коэфДорога] [money] NULL,
	[Норма_коэфПогода] [money] NULL,
	[Моточасы_Всего] [money] NULL,
	[Часы_отработано] [money] NULL,
	[УчастокВыполнения] [varchar](255) NULL,
	[ДатаВыполнения] [datetime] NULL,
	[Расход_План] [money] NULL,
	[Расход_Факт] [money] NULL,
	[МТР_Конец] [money] NULL,
	[Спидометр_Конец] [money] NULL,
	[Моточасы_Конец] [money] NULL,
	[НО_прогрев] [money] NULL,
	[НО_отопитель] [money] NULL,
	[НО_оборудование] [money] NULL,
	[НО_пробег] [money] NULL,
	[НО_кДорога] [money] NULL,
	[НО_кПогода] [money] NULL,
	[НО_моточасы] [money] NULL,
	[НО_скорость] [money] NULL,
	[ДатаДо] [datetime] NULL,
	[ШПЛ] [varchar](255) NULL,
	[ПЛВид] [varchar](255) NULL,
	[ЗЧ_ВыездПлан] [datetime] NULL,
	[ЗЧ_ВыездФакт] [datetime] NULL,
	[ЗЧ_ПриездПлан] [datetime] NULL,
	[ЗЧ_ПриездФакт] [datetime] NULL,
	[НО_ткм] [money] NULL,
	[Автоприцеп2] [varchar](255) NULL,
	[Маршрут2] [varchar](255) NULL,
	[Ответственный1] [varchar](255) NULL,
	[Ответственный2] [varchar](255) NULL,
	[Ответственный3] [varchar](255) NULL,
	[Ответственный4] [varchar](255) NULL,
	[Стропальщик1] [varchar](255) NULL,
	[Стропальщик2] [varchar](255) NULL,
	[Стропальщик3] [varchar](255) NULL,
	[Стропальщик4] [varchar](255) NULL,
	[Расход_Распред] [money] NULL,
	[ПредПЛист] [varchar](255) NULL,
	[Рейсов] [int] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Тонно_КМ] [money] NULL,
	[Организация] [varchar](32) NULL,
	[ФинОрг] [varchar](32) NULL,
	[ОткудаМесто] [varchar](32) NULL,
	[КудаМесто] [varchar](32) NULL,
 CONSTRAINT [PK_с_ПЛисты] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_с_ПЛисты_OneValue] ON [dbo].[с_ПЛисты]
(
	[SYS_U] ASC,
	[Автотехника] ASC,
	[Дата] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_с_ПЛисты_STK] ON [dbo].[с_ПЛисты]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_с_ПЛисты_SYS_T] ON [dbo].[с_ПЛисты]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_с_ПЛисты_SYS_U] ON [dbo].[с_ПЛисты]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
