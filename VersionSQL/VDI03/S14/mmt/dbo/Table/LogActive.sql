/****** Object:  Table [dbo].[LogActive]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LogActive](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[d] [datetime] NULL,
	[a] [varchar](255) NULL,
	[o] [varchar](255) NULL,
	[i] [varchar](255) NULL,
	[tapps] [varchar](255) NULL,
	[tappn] [varchar](255) NULL,
	[tuser] [varchar](255) NULL,
	[tdate] [datetime] NULL,
	[tcomp] [varchar](255) NULL,
 CONSTRAINT [PK_ulog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[LogActive] ADD  CONSTRAINT [DF_LogActive_tdata]  DEFAULT (getdate()) FOR [tdate]
