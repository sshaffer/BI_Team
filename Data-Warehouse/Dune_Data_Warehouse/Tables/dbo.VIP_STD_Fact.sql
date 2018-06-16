CREATE TABLE [dbo].[VIP_STD_Fact]
(
[VIP_Customer_Dim_ID] [bigint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Sale_Price] [money] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Actual_FP_Sale_Price_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Actual_FP_Sale_Price_Home_DF] DEFAULT ((0)),
[Actual_FP_Sale_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Actual_FP_Sale_Price_Curr_DF] DEFAULT ((0)),
[Actual_MD_Sale_Price_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Actual_MD_Sale_Price_Home_DF] DEFAULT ((0)),
[Actual_MD_Sale_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Actual_MD_Sale_Price_Curr_DF] DEFAULT ((0)),
[Promo_Sale_Price_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Promo_Sale_Price_Home_DF] DEFAULT ((0)),
[Promo_Sale_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Promo_Sale_Price_Curr_DF] DEFAULT ((0)),
[Discount_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Discount_Value_Home_DF] DEFAULT ((0)),
[Discount_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Discount_Value_Curr_DF] DEFAULT ((0)),
[VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_VAT_Value_Home_DF] DEFAULT ((0)),
[VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_VAT_Value_Curr_DF] DEFAULT ((0)),
[Cost_Price_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Cost_Price_Home_DF] DEFAULT ((0)),
[Cost_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Cost_Price_Curr_DF] DEFAULT ((0)),
[Gorss_Sale_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Gross_Sales_Value_Home_DF] DEFAULT ((0)),
[Gross_Sale_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_Gross_Sales_Value_Curr_DF] DEFAULT ((0)),
[FP_Qty] [int] NOT NULL CONSTRAINT [VIP_STD_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [VIP_STD_Fact_MD_Qty_DF] DEFAULT ((0)),
[Sale_Qty] [int] NOT NULL CONSTRAINT [VIP_STD_Fact_Sale_Qty_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_STD_Fact_MD_Gross_Profit_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VIP_STD_Fact] ADD CONSTRAINT [VIP_STD_Fact_PK] PRIMARY KEY CLUSTERED  ([VIP_Customer_Dim_ID], [Item_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VIP_STD_Fact] ADD CONSTRAINT [VIP_STD_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[VIP_STD_Fact] ADD CONSTRAINT [VIP_STD_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[VIP_STD_Fact] ADD CONSTRAINT [VIP_STD_Fact_VIP_Customer_Dim_FK] FOREIGN KEY ([VIP_Customer_Dim_ID]) REFERENCES [dbo].[VIP_Customer_Dim] ([VIP_Customer_Dim_ID])
GO
