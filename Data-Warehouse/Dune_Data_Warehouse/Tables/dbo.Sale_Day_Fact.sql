CREATE TABLE [dbo].[Sale_Day_Fact]
(
[Sale_Day_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
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
[Gift_Card_Value_Home] [money] NOT NULL,
[Gift_Card_Value_Curr] [money] NOT NULL,
[Discount_Value_Home] [money] NOT NULL,
[Discount_Value_Curr] [money] NOT NULL,
[VAT_Value_Home] [money] NOT NULL,
[VAT_Value_Curr] [money] NOT NULL,
[Gross_Profit_Value_Home] [money] NOT NULL,
[Gross_Profit_Value_Curr] [money] NOT NULL,
[FP_Qty] [int] NOT NULL CONSTRAINT [Sale_Day_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [Sale_Day_Fact_MD_Qty_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Sale_Day_Fact_MD_Gross_Profit_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sale_Day_Fact] ADD CONSTRAINT [Sale_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Sale_Day_Dim_ID], [Item_Dim_ID], [Store_Dim_ID], [Channel_Dim_ID], [Currency_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Sale_Day_Fact_Store_Calendar_IX] ON [dbo].[Sale_Day_Fact] ([Store_Dim_ID], [Sale_Day_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sale_Day_Fact] ADD CONSTRAINT [Sale_Day_Fact_Channel_Dim_FK] FOREIGN KEY ([Channel_Dim_ID]) REFERENCES [dbo].[Channel_Dim] ([Channel_Dim_ID])
GO
ALTER TABLE [dbo].[Sale_Day_Fact] ADD CONSTRAINT [Sale_Day_Fact_Currency_Dim_FK] FOREIGN KEY ([Currency_Dim_ID]) REFERENCES [dbo].[Currency_Dim] ([Currency_Dim_ID])
GO
ALTER TABLE [dbo].[Sale_Day_Fact] ADD CONSTRAINT [Sale_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Sale_Day_Fact] ADD CONSTRAINT [Sale_Day_Fact_Calendar_Day_Dim_FK] FOREIGN KEY ([Sale_Day_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Sale_Day_Fact] ADD CONSTRAINT [Sale_Day_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', 'Total net sales values by fiscal day (sales + returns)', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_FP_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_FP_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Markdown Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_MD_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Markdown Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_MD_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Promo Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_Promo_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Sale was at Promo Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_Promo_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The actual value paid for the sale', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The actual value paid for the sale', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Actual_Sales_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The markdowned value of the sale (Gross Sales Value - Actual Sales Value)', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Cost_of_Markdown_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The markdowned value of the sale (Gross Sales Value - Actual Sales Value)', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Cost_of_Markdown_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Cost of Promotional Value ', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Cost_of_Promo_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Cost of Promotional Value ', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Cost_of_Promo_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Cost value in local currency', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Cost_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Cost value in sterling.', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Cost_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Discount Value of sale.', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Discount_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Discount Value of sale.', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Discount_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The portion of the sale value that was paid for by gift card', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Gift_Card_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The portion of the sale value that was paid for by gift card', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Gift_Card_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Actual Sales Value - VAT - Cost Value', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Gross_Profit_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'Actual Sales Value - VAT - Cost Value', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Gross_Profit_Value_Home'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The sale at the original Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Gross_Sales_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', 'The sale at the original Full Selling Price', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Day_Fact', 'COLUMN', N'Gross_Sales_Value_Home'
GO
