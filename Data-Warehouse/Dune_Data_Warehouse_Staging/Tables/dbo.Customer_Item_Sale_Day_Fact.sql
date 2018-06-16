CREATE TABLE [dbo].[Customer_Item_Sale_Day_Fact]
(
[Sale_Date_Dim_ID] [smallint] NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Sales_Qty] [decimal] (11, 3) NOT NULL,
[Cost_Value_Home] [money] NOT NULL,
[Cost_Value_Curr] [money] NOT NULL,
[Actual_Sales_Value_Home] [money] NOT NULL,
[Actual_Sales_Value_Curr] [money] NOT NULL,
[Gross_Sales_Value_Home] [money] NOT NULL,
[Gross_Sales_Value_Curr] [money] NOT NULL,
[Actual_FP_Sales_Value_Home] [money] NOT NULL,
[Actual_FP_Sales_Value_Curr] [money] NOT NULL,
[Actual_MD_Sales_Value_Home] [money] NOT NULL,
[Actual_MD_Sales_Value_Curr] [money] NOT NULL,
[Actual_Promo_Sales_Value_Home] [money] NOT NULL,
[Actual_Promo_Sales_Value_Curr] [money] NOT NULL,
[Cost_of_Markdown_Value_Home] [money] NOT NULL,
[Cost_of_Markdown_Value_Curr] [money] NOT NULL,
[Cost_of_Promo_Value_Home] [money] NOT NULL,
[Cost_of_Promo_Value_Curr] [money] NOT NULL,
[Gift_Charge_Value_Home] [money] NOT NULL,
[Gift_Charge_Value_Curr] [money] NOT NULL,
[Discount_Value_Home] [money] NOT NULL,
[Discount_Value_Curr] [money] NOT NULL,
[Goodwill_Value_Home] [money] NOT NULL,
[Goodwill_Value_Curr] [money] NOT NULL,
[VAT_Value_Home] [money] NOT NULL,
[VAT_Value_Curr] [money] NOT NULL,
[Shipping_Charge_Value_Home] [money] NOT NULL,
[Shipping_Charge_Value_Curr] [money] NOT NULL,
[Gross_Profit_Value_Home] [money] NOT NULL,
[Gross_Profit_Value_Curr] [money] NOT NULL,
[FP_Qty] [int] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_MD_Qty_DF] DEFAULT ((0)),
[Store_Dim_ID] [int] NOT NULL,
[Delivery_Method_Dim_ID] [tinyint] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_Delivery_Method_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Sale_Day_Fact_MD_Gross_Profit_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Sale_Day_Fact_Channel_Dim_FKX] ON [dbo].[Customer_Item_Sale_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Sale_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Item_Sale_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Sale_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Item_Sale_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Sale_Day_Fact_Order_Type_Dim_FKX] ON [dbo].[Customer_Item_Sale_Day_Fact] ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calender_Day_Customer_Item_Sale_Day_FKX] ON [dbo].[Customer_Item_Sale_Day_Fact] ([Sale_Date_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', 'Customer Sales by day. All values are in sterling.', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_FP_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_FP_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Markdown Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_MD_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Markdown Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_MD_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Promotional Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_Promo_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Promotional Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_Promo_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The actual value paid for the sale', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The actual value paid for the sale', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Actual_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The markdowned value of the sale (Gross Sales Value - Actual Sales Value)???', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Cost_of_Markdown_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The markdowned value of the sale (Gross Sales Value - Actual Sales Value)???', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Cost_of_Markdown_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Local Currency cost value', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Cost_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sterling cost value', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Cost_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Discount value of sale (overriding discount)', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Discount_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Discount value of sale (overriding discount)', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Discount_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The portion of the sale value that was purchased with a gift card', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Gift_Charge_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The portion of the sale value that was purchased with a gift card', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Gift_Charge_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Goodwill value of the sale', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Goodwill_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Goodwill value of the sale', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Goodwill_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The sale at the original Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Gross_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The sale at the original Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Sale_Day_Fact', 'COLUMN', N'Gross_Sales_Value_Home'
GO
