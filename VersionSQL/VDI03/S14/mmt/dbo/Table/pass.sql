/****** Object:  Table [dbo].[pass]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[pass](
	[pass] [varchar](32) NOT NULL,
	[hash] [varchar](32) NOT NULL,
 CONSTRAINT [PK_pass] PRIMARY KEY CLUSTERED 
(
	[pass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

