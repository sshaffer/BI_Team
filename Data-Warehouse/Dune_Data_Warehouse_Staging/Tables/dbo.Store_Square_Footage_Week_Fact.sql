CREATE TABLE [dbo].[Store_Square_Footage_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Trading_Space] [smallint] NOT NULL,
[Non_Trading_Space] [smallint] NOT NULL,
[Total_Space] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Square_Footage_Week_Fact] ADD CONSTRAINT [Store_Square_Footage_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
