/****** Object:  Table [dbo].[к_Заявки]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[к_Заявки](
	[Код] [int] NULL,
	[SYS_ID] [varchar](255) NOT NULL,
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
	[Номер] [varchar](255) NULL,
	[Дата] [datetime] NULL,
	[ДатаВРаботу] [datetime] NULL,
	[ФормаЗаявки] [varchar](255) NULL,
	[Заказчик] [varchar](255) NULL,
	[ЗаявкаСодержание] [varchar](max) NULL,
	[ОбъемыРабот] [varchar](max) NULL,
	[Сроки] [varchar](max) NULL,
	[Куратор] [varchar](255) NULL,
	[Исполнитель] [varchar](255) NULL,
	[КомментарийКО] [varchar](255) NULL,
	[КомментарийИсполнитель] [varchar](max) NULL,
	[Направление] [varchar](255) NULL,
	[КПНомер] [varchar](255) NULL,
	[КПДата] [datetime] NULL,
	[КПДатаОтправкиПлан] [datetime] NULL,
	[КПДатаОтправкиФакт] [datetime] NULL,
	[КПДатаСвязиПлан] [datetime] NULL,
	[КПДатаСвязиФакт] [datetime] NULL,
	[КПСодержание] [varchar](max) NULL,
	[КПРезультат] [varchar](max) NULL,
	[ДоговорДатаЗаключен] [datetime] NULL,
	[ДоговорНомер] [varchar](255) NULL,
	[ДоговорДата] [datetime] NULL,
	[ДоговорСодержание] [varchar](max) NULL,
	[ОбзвонДатаПлан] [datetime] NULL,
	[ОбзвонДатаФакт] [datetime] NULL,
	[ОбзвонРезультат] [varchar](max) NULL,
	[Откуда] [varchar](255) NULL,
	[Куда] [varchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_к_Заявки] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_к_Заявки_STK] ON [dbo].[к_Заявки]
(
	[SYS_S] ASC,
	[SYS_T] ASC,
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_к_Заявки_SYS_T] ON [dbo].[к_Заявки]
(
	[SYS_T] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_к_Заявки_SYS_U] ON [dbo].[к_Заявки]
(
	[SYS_U] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[к_Заявки] ADD  CONSTRAINT [DF_к_Заявки_SYS_ID]  DEFAULT (replace(newid(),'-','')) FOR [SYS_ID]
