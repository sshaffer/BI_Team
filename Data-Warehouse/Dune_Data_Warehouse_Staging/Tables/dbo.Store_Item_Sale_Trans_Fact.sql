CREATE TABLE [dbo].[Store_Item_Sale_Trans_Fact]
(
[Sale_Date_Dim_ID] [smallint] NOT NULL,
[Sale_Time_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Transaction_No] [char] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sequence_No] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Gift_Card_Serial_No] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Discount_Reason_Dim_ID] [tinyint] NOT NULL,
[Salesperson_ID] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sales_Qty] [decimal] (11, 3) NOT NULL,
[Cost_Value_Home] [money] NOT NULL,
[Cost_Value_Curr] [money] NOT NULL,
[Actual_Sales_Value_Home] [money] NOT NULL,
[Actual_Sales_Value_Curr] [money] NOT NULL,
[Discount_Value_Home] [money] NOT NULL,
[Discount_Value_Curr] [money] NOT NULL,
[Gift_Card_Value_Home] [money] NOT NULL,
[Gift_Card_Value_Curr] [money] NOT NULL,
[Processed_Timestamp] [datetime2] NOT NULL,
[VAT_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_VAT_Home_DF] DEFAULT ((0)),
[VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_VAT_Curr_DF] DEFAULT ((0)),
[Actual_FP_Sales_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_Home_DF] DEFAULT ((0)),
[Actual_FP_Sales_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_Curr_DF] DEFAULT ((0)),
[Actual_MD_Sales_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_Home_DF] DEFAULT ((0)),
[Actual_MD_Sales_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_Curr_DF] DEFAULT ((0)),
[FP_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_Qty_DF] DEFAULT ((0)),
[Gross_Sales_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_Gross_Home_DF] DEFAULT ((0)),
[Gross_Sales_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_Gross_Curr_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_Gross_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_FP_Gross_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_Gross_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_MD_Gross_Curr_DF] DEFAULT ((0)),
[Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_Gross_Profit_Home_DF] DEFAULT ((0)),
[Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Sale_Trans_Fact_Gross_Profit_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [Store_Item_Sale_Trans_Fact_CIX] ON [dbo].[Store_Item_Sale_Trans_Fact] ([Sale_Date_Dim_ID], [Sale_Time_Dim_ID], [Item_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', 'The value of the sale', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Actual_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The value of the sale', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Actual_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The Cost Value of the sale in store currency', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Cost_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The Cost Value of the sale', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Cost_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The discount value of the sale', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Discount_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The discount value of the sale', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Discount_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The amount of the sale that was paid for by a gift card', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Gift_Card_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The amount of the sale that was paid for by a gift card', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Gift_Card_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The no of units purchased', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Sale_Trans_Fact', 'COLUMN', N'Sales_Qty'
GO
