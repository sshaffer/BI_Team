CREATE TABLE [dbo].[Store_Budget_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Budget] [numeric] (19, 7) NOT NULL,
[Margin_Budget] [numeric] (19, 7) NOT NULL CONSTRAINT [Store_Budget_Week_Fact_Margin_Budget_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Budget_Week_Fact] ADD CONSTRAINT [Store_Budget_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Budget_Week_Fact] ADD CONSTRAINT [Store_Budget_Week_Fact_Period_FK] FOREIGN KEY ([Calendar_Week_Dim_ID]) REFERENCES [dbo].[Calendar_Week_Dim] ([Calendar_Week_Dim_Id])
GO
ALTER TABLE [dbo].[Store_Budget_Week_Fact] ADD CONSTRAINT [Store_Budget_Week_Fact_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
