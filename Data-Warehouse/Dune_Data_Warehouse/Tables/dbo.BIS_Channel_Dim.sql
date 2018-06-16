CREATE TABLE [dbo].[BIS_Channel_Dim]
(
[Channel_Dim_ID] [tinyint] NOT NULL,
[Channel_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Channel_Name] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Zone_Dim_ID] [tinyint] NOT NULL,
[Zone_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Zone_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Territory_Dim_ID] [tinyint] NOT NULL,
[Territory_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Territory_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Region_Dim_ID] [tinyint] NOT NULL,
[Region_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Region_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[District_Dim_ID] [tinyint] NOT NULL,
[District_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[District_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Number] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Channel_Dim_Store_DF] DEFAULT ('00000'),
[Store_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Channel_Dim_StoreName_DF] DEFAULT ('')
) ON [PRIMARY]
GO
