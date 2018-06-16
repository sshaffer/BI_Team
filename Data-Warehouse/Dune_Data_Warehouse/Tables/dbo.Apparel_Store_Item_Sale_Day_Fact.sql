CREATE TABLE [dbo].[Apparel_Store_Item_Sale_Day_Fact]
(
[Store_Dim_ID] [int] NOT NULL,
[Calendar_Dim_Id] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Sales_Qty] [int] NOT NULL,
[FP_Qty] [int] NOT NULL,
[MD_Qty] [int] NOT NULL,
[Actual_Sales_Value_Curr] [numeric] (38, 7) NOT NULL,
[Actual_Sales_Value_FP_Curr] [numeric] (38, 7) NOT NULL,
[Actual_Sales_Value_MD_Curr] [numeric] (38, 7) NOT NULL,
[Actual_Sales_Value_AED] [numeric] (38, 19) NOT NULL,
[Actual_Sales_Value_FP_AED] [numeric] (38, 19) NOT NULL,
[Actual_Sales_Value_MD_AED] [numeric] (38, 19) NOT NULL,
[Actual_Sales_Value_GBP] [numeric] (38, 19) NOT NULL,
[Actual_Sales_Value_FP_GBP] [numeric] (38, 19) NOT NULL,
[Actual_Sales_Value_MD_GBP] [numeric] (38, 19) NOT NULL,
[Discount_Value_Curr] [numeric] (38, 7) NOT NULL,
[Discount_Value_FP_Curr] [numeric] (38, 7) NOT NULL,
[Discount_Value_MD_Curr] [numeric] (38, 7) NOT NULL,
[Discount_Value_AED] [numeric] (38, 19) NOT NULL,
[Discount_Value_FP_AED] [numeric] (38, 19) NOT NULL,
[Discount_Value_MD_AED] [numeric] (38, 19) NOT NULL,
[Discount_Value_GBP] [numeric] (38, 19) NOT NULL,
[Discount_Value_FP_GBP] [numeric] (38, 19) NOT NULL,
[Discount_Value_MD_GBP] [numeric] (38, 19) NOT NULL,
[Item_Cost_2_Curr] [numeric] (38, 7) NOT NULL,
[Item_Cost_2_FP_Curr] [numeric] (38, 7) NOT NULL,
[Item_Cost_2_MD_Curr] [numeric] (38, 7) NOT NULL,
[Item_Cost_2_AED] [numeric] (38, 19) NOT NULL,
[Item_Cost_2_FP_AED] [numeric] (38, 19) NOT NULL,
[Item_Cost_2_MD_AED] [numeric] (38, 19) NOT NULL,
[Item_Cost_2_GBP] [numeric] (38, 19) NOT NULL,
[Item_Cost_2_FP_GBP] [numeric] (38, 19) NOT NULL,
[Item_Cost_2_MD_GBP] [numeric] (38, 19) NOT NULL,
[Gross_Profit_Curr] AS ([Actual_Sales_Value_Curr]-[Item_Cost_2_Curr]),
[Gross_Profit_AED] AS ([Actual_Sales_Value_AED]-[Item_Cost_2_AED]),
[Gross_Profit_GBP] AS ([Actual_Sales_Value_GBP]-[Item_Cost_2_GBP]),
[Gross_Profit_FP_Curr] AS ([Actual_Sales_Value_FP_Curr]-[Item_Cost_2_FP_Curr]),
[Gross_Profit_FP_AED] AS ([Actual_Sales_Value_FP_AED]-[Item_Cost_2_FP_AED]),
[Gross_Profit_FP_GBP] AS ([Actual_Sales_Value_FP_GBP]-[Item_Cost_2_FP_GBP]),
[Gross_Profit_MD_Curr] AS ([Actual_Sales_Value_MD_Curr]-[Item_Cost_2_MD_Curr]),
[Gross_Profit_MD_AED] AS ([Actual_Sales_Value_MD_AED]-[Item_Cost_2_MD_AED]),
[Gross_Profit_MD_GBP] AS ([Actual_Sales_Value_MD_GBP]-[Item_Cost_2_MD_GBP])
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Apparel_Store_Item_Sale_Day_Fact] ADD CONSTRAINT [Apparel_Store_Item_Sale_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_Id], [Store_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Apparel_Store_Item_Sale_Day_Fact] ADD CONSTRAINT [Apparel_Store_Item_Sale_Day_Fact_Calendar_FK] FOREIGN KEY ([Calendar_Dim_Id]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Apparel_Store_Item_Sale_Day_Fact] ADD CONSTRAINT [Apparel_Store_Item_Sale_Day_Fact_Item_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Apparel_Store_Item_Sale_Day_Fact] ADD CONSTRAINT [Apparel_Store_Item_Sale_Day_Fact_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
