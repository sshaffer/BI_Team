CREATE TABLE [dbo].[VIP_Net_Sale_Day_Fact]
(
[VIP_Customer_Dim_ID] [bigint] NOT NULL,
[Calendar_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Sale_Price] [money] NOT NULL,
[Actual_FP_Sale_Price_Home] [money] NOT NULL,
[ACtual_FP_Sale_Price_Curr] [money] NOT NULL,
[Actual_MD_Sale_Price_Home] [money] NOT NULL,
[Actual_MD_Sale_Price_Curr] [money] NOT NULL,
[Promo_Sale_Price_Home] [money] NOT NULL,
[Promo_Sale_Price_Curr] [money] NOT NULL,
[Discount_Value_Home] [money] NOT NULL,
[Discount_Value_Curr] [money] NOT NULL,
[VAT_Value_Home] [money] NOT NULL,
[VAT_Value_Curr] [money] NOT NULL,
[Cost_Price_Home] [money] NOT NULL,
[Cost_Price_Curr] [money] NOT NULL,
[Gorss_Sale_Value_Home] [money] NOT NULL,
[Gross_Sale_Value_Curr] [money] NOT NULL,
[FP_Qty] [int] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_MD_Qty_DF] DEFAULT ((0)),
[Sale_Qty] [int] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_Sale_Qty_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Net_Sale_Day_Fact_MD_Gross_Profit_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VIP_Net_Sale_Day_Fact] ADD CONSTRAINT [VIP_Net_Sale_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([VIP_Customer_Dim_ID], [Calendar_Dim_ID], [Item_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VIP_Net_Sale_Day_Fact] ADD CONSTRAINT [VIP_Net_Sale_Day_Fact_Calendar_Dim_FK] FOREIGN KEY ([Calendar_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[VIP_Net_Sale_Day_Fact] ADD CONSTRAINT [VIP_Net_Sale_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[VIP_Net_Sale_Day_Fact] ADD CONSTRAINT [VIP_Net_Sale_Day_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[VIP_Net_Sale_Day_Fact] ADD CONSTRAINT [VIP_Net_Sale_Day_Fact_VIP_Customer_Dim_FK] FOREIGN KEY ([VIP_Customer_Dim_ID]) REFERENCES [dbo].[VIP_Customer_Dim] ([VIP_Customer_Dim_ID])
GO
