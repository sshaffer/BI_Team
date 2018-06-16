CREATE TABLE [dbo].[Apparel_Intake_Day_Fact]
(
[Calendar_Dim_Id] [smallint] NOT NULL,
[Store_Dim_Id] [int] NOT NULL,
[Item_Dim_Id] [int] NOT NULL,
[Qty] [int] NOT NULL,
[Item_Cost_1_AED] [numeric] (19, 7) NOT NULL,
[Item_Cost_1_GBP] [numeric] (19, 7) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Apparel_Intake_Day_Fact] ADD CONSTRAINT [Apparel_Intake_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_Id], [Store_Dim_Id], [Item_Dim_Id]) ON [PRIMARY]
GO
