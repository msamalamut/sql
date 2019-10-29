/****** Object:  Table [dbo].[sys_D]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sys_D](
	[Sys_D] [varchar](255) NOT NULL,
	[LastSyncAuto] [datetime] NULL,
	[LastSyncManual] [datetime] NULL,
 CONSTRAINT [PK_sys_D] PRIMARY KEY CLUSTERED 
(
	[Sys_D] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

