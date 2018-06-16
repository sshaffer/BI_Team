CREATE TABLE [dbo].[Apparel_Intake_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Qty] [int] NOT NULL,
[Item_Cost_1_AED] [numeric] (19, 7) NOT NULL,
[Item_Cost_1_GBP] [numeric] (19, 7) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Apparel_Intake_Week_Fact] ADD CONSTRAINT [Apparel_Intake_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Store_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
