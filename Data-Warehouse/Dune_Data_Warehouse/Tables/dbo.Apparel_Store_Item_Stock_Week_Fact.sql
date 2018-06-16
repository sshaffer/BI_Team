CREATE TABLE [dbo].[Apparel_Store_Item_Stock_Week_Fact]
(
[Item_Dim_ID] [int] NOT NULL,
[Calendar_Week_Dim_Id] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Intransit_FP_Qty] [int] NOT NULL,
[Intransit_MD_Qty] [int] NOT NULL,
[Intransit_Qty] AS ([Intransit_FP_Qty]+[Intransit_MD_Qty]),
[OnHand_FP_Qty] [int] NOT NULL,
[OnHand_MD_Qty] [int] NOT NULL,
[OnHand_Qty] AS ([OnHand_FP_Qty]+[OnHand_MD_Qty]),
[FP_Item_Cost_2_Curr] [numeric] (38, 7) NOT NULL,
[MD_Item_Cost_2_Curr] [numeric] (38, 7) NOT NULL,
[Item_Cost_2_Curr] AS ([FP_Item_Cost_2_Curr]+[MD_Item_Cost_2_Curr]),
[FP_Retail_Price_Curr] [numeric] (38, 7) NOT NULL,
[MD_Retail_Price_Curr] [numeric] (38, 7) NOT NULL,
[Retail_Price_Curr] AS ([FP_Retail_Price_Curr]+[MD_Retail_Price_Curr]),
[FP_Item_Cost_2_AED] [numeric] (38, 7) NOT NULL,
[MD_Item_Cost_2_AED] [numeric] (38, 7) NOT NULL,
[Item_Cost_2_AED] AS ([FP_Item_Cost_2_AED]+[MD_Item_Cost_2_AED]),
[FP_Retail_Price_AED] [numeric] (38, 7) NOT NULL,
[MD_Retail_Price_AED] [numeric] (38, 7) NOT NULL,
[Retail_Price_AED] AS ([FP_Retail_Price_AED]+[MD_Retail_Price_AED]),
[FP_Item_Cost_2_GBP] [numeric] (38, 7) NOT NULL,
[MD_Item_Cost_2_GBP] [numeric] (38, 7) NOT NULL,
[Item_Cost_2_GBP] AS ([FP_Item_Cost_2_GBP]+[MD_Item_Cost_2_GBP]),
[FP_Retail_Price_GBP] [numeric] (38, 7) NOT NULL,
[MD_Retail_Price_GBP] [numeric] (38, 7) NOT NULL,
[Retail_Price_GBP] AS ([FP_Retail_Price_GBP]+[MD_Retail_Price_GBP]),
[Net_OnHand_Qty] AS (([OnHand_FP_Qty]+[OnHand_MD_Qty])+([Intransit_FP_Qty]+[Intransit_MD_Qty])),
[Net_OnHand_FP_Qty] AS ([OnHand_FP_Qty]+[Intransit_FP_Qty]),
[Net_OnHand_MD_Qty] AS ([OnHand_MD_Qty]+[Intransit_MD_Qty])
) ON [PRIMARY]
ALTER TABLE [dbo].[Apparel_Store_Item_Stock_Week_Fact] ADD 
CONSTRAINT [Apparel_Store_Item_Stock_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_Id], [Store_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
