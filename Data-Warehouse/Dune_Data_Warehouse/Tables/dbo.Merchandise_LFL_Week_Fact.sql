CREATE TABLE [dbo].[Merchandise_LFL_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Merch_LFL] [bit] NULL,
[Merch_LFL_LY] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Merchandise_LFL_Week_Fact] ADD CONSTRAINT [Merchandise_LFL_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Store_Dim_ID], [Department_Dim_ID]) ON [PRIMARY]
GO
