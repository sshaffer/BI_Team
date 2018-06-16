CREATE TABLE [dbo].[Store_Margin_Budget_Period_Fact]
(
[Calendar_Period_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Budget] [numeric] (19, 7) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Margin_Budget_Period_Fact] ADD CONSTRAINT [Store_Margin_Budget_Period_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Period_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Margin_Budget_Period_Fact] ADD CONSTRAINT [Store_Margin_Budget_Period_Fact_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
