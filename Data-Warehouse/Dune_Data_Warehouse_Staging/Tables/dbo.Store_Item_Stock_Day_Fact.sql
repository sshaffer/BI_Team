CREATE TABLE [dbo].[Store_Item_Stock_Day_Fact]
(
[Calendar_Dim_ID] [date] NOT NULL,
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
[Stock_Net_in_Hand_Markdown_Sales_Value] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Item_Stock_Day_Fact] ADD CONSTRAINT [Store_Item_Stock_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_ID], [Item_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Item_Stock_Day_Fact_Item_Dim_FKX] ON [dbo].[Store_Item_Stock_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Item_Stock_Day_Fact_Store_Dim_FKX] ON [dbo].[Store_Item_Stock_Day_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Stock valuation as at the end of the day.', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Physical Cost Value of Stock in Store as at end of fiscal day', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Hand_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of items at Full Price', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Hand_Full_Price_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of items at Markdown', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Hand_Markdown_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Physical Stock Quantity in Store as at the end of day', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Hand_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Transit cost  value as at the end of day', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Transit_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of In Transit items at Full Price', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Transit_Full_Price_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of In Transit items at Markdown', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Transit_Markdown_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'In Transit quantity as at the end of day', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_in_Transit_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost Value of Physical Stock + In Transit Stock as at end of fiscal day', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_Net_in_Hand_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value of Physical Stock + In Transit Stock as at end of fiscal day at Full Price', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_Net_in_Hand_Full_Price_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Physical Stock + In Transit Stock as at end of day at Markdown price', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_Net_in_Hand_Markdown_Sales_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Physical Stock + In Transit Quantity in Store as at the end of day', 'SCHEMA', N'dbo', 'TABLE', N'Store_Item_Stock_Day_Fact', 'COLUMN', N'Stock_Net_in_Hand_Qty'
GO
