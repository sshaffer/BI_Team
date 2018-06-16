CREATE TABLE [dbo].[Store_LFL_Week_Fact]
(
[Store_Dim_ID] [int] NOT NULL,
[Sale_Week_Dim_ID] [smallint] NOT NULL,
[Store_LFL] [bit] NOT NULL,
[Store_LFL_LY] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_LFL_Week_Fact] ADD CONSTRAINT [Store_LFL_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID], [Sale_Week_Dim_ID]) ON [PRIMARY]
GO
