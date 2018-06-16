CREATE TABLE [dbo].[Store_Item_Stock_Period_Fact]
(
[Calendar_Period_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Stock_in_Hand_Qty] [int] NOT NULL,
[Stock_in_Hand_Cost_Value] [money] NOT NULL,
[Stock_in_Hand_Full_Price_Sales_Value] [money] NOT NULL,
[Stock_in_Hand_Markdown_Sales_Value] [money] NOT NULL,
[Stock_in_Transit_Qty] [int] NOT NULL,
[Stock_in_Transit_Cost_Value] [money] NOT NULL,
[Stock_in_Transit_Full_Price_Sales_Value] [money] NOT NULL,
[Stock_in_Transit_Markdown_Sales_Value] [money] NOT NULL,
[Stock_Net_in_Hand_Qty] [int] NOT NULL,
[Stock_Net_in_Hand_Cost_Value] [money] NOT NULL,
[Stock_Net_in_Hand_Full_Price_Sales_Value] [money] NOT NULL,
[Stock_Net_in_Hand_Markdown_Sales_Value] [money] NOT NULL,
[Stock_in_Hand_FP_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Stock_Period_Fact_Stock_in_Hand_FP_Qty_DF] DEFAULT ((0)),
[Stock_in_Hand_MD_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Stock_Period_Fact_Stock_in_Hand_MD_Qty_DF] DEFAULT ((0)),
[Stock_in_Transit_FP_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Stock_Period_Fact_Stock_in_Transit_FP_Qty_DF] DEFAULT ((0)),
[Stock_in_Transit_MD_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Stock_Period_Fact_Stock_in_Transit_MD_Qty_DF] DEFAULT ((0)),
[Stock_Net_in_Hand_FP_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Stock_Period_Fact_Stock_Net_in_Hand_FP_Qty_DF] DEFAULT ((0)),
[Stock_Net_in_Hand_MD_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Stock_Period_Fact_Stock_Net_in_Hand_MD_Qty_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Item_Stock_Period_Fact] ADD CONSTRAINT [Store_Item_Stock_Period_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Period_Dim_ID], [Item_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Period_Store_Item_Stock_PeriodX] ON [dbo].[Store_Item_Stock_Period_Fact] ([Calendar_Period_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Item_Stock_Period_Fact_Item_Dim_FKX] ON [dbo].[Store_Item_Stock_Period_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Item_Stock_Period_Fact_Store_Dim_FKX] ON [dbo].[Store_Item_Stock_Period_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Item_Stock_Period_Fact] WITH NOCHECK ADD CONSTRAINT [Calendar_Period_Store_Item_Stock_Period] FOREIGN KEY ([Calendar_Period_Dim_ID]) REFERENCES [dbo].[Calendar_Period_Dim] ([Calendar_Period_Dim_Id])
GO
ALTER TABLE [dbo].[Store_Item_Stock_Period_Fact] WITH NOCHECK ADD CONSTRAINT [Store_Item_Stock_Period_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Item_Stock_Period_Fact] WITH NOCHECK ADD CONSTRAINT [Store_Item_Stock_Period_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Stock valuation as at the end of the week.', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Physical Cost Value of Stock in Store as at end of fiscal period', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Hand_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of items at Full Price', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Hand_Full_Price_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of items at Markdown', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Hand_Markdown_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Physical Stock Quantity in Store as at the end of fiscal period', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Hand_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Transit cost  value as at the end of period', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Transit_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of In Transit items at Full Price', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Transit_Full_Price_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of In Transit items at Markdown', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Transit_Markdown_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Transit quantity as at the end of period', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_in_Transit_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost Value of Physical + In Transit Stock in Store as at end of fiscal period', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_Net_in_Hand_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of items at Full Price'' , ''TABLE'' , ''Store_Item_Stock_Period_Fact', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_Net_in_Hand_Full_Price_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of items at Markdown', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_Net_in_Hand_Markdown_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Physical Stock + In Transit Quantity in Store as at the end of fiscal period', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Period_Fact', 'COLUMN', N'Stock_Net_in_Hand_Qty'
GO
