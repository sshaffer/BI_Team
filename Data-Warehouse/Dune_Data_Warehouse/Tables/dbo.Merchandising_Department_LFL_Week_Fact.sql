CREATE TABLE [dbo].[Merchandising_Department_LFL_Week_Fact]
(
[Store_Dim_ID] [int] NOT NULL,
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[LFL] [int] NOT NULL,
[LFL_LY] [int] NOT NULL
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)
GO
ALTER TABLE [dbo].[Merchandising_Department_LFL_Week_Fact] ADD CONSTRAINT [Merchandise_Department_LFL_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Store_Dim_ID], [Department_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
