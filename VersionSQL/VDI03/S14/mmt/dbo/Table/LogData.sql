/****** Object:  Table [dbo].[LogData]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LogData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SYS_ID] [varchar](255) NULL,
	[PoleName] [varchar](255) NULL,
	[PoleValue] [varchar](max) NULL,
	[PoleValue2] [varchar](max) NULL,
	[tapps] [varchar](255) NULL,
	[tappn] [varchar](255) NULL,
	[tdate] [datetime] NULL,
	[tuser] [varchar](255) NULL,
	[tcomp] [varchar](255) NULL,
 CONSTRAINT [PK_Лог] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[LogData] ADD  CONSTRAINT [DF_LogData_tdata]  DEFAULT (getdate()) FOR [tdate]
