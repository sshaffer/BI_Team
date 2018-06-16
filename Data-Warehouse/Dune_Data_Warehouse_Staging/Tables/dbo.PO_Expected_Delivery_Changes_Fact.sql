CREATE TABLE [dbo].[PO_Expected_Delivery_Changes_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Purchase_Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_No] [numeric] (3, 0) NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Expected_Delivery_Date_Dim_ID] [smallint] NOT NULL,
[Expected_Delivery_Qty] [int] NOT NULL,
[Expected_Delivery_Component_Qty] [int] NOT NULL,
[Expected_Delivery_Cost_Value] [money] NOT NULL,
[Expected_Delivery_Selling_Value] [money] NOT NULL,
[Store_Dim_ID] [int] NOT NULL CONSTRAINT [PO_Expected_Delivery_Changes_Fact_Store_Dim_ID_DF] DEFAULT ((-2147483648))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Expected_Delivery_Changes_Fact_Calendar_Day_Dim_FKX] ON [dbo].[PO_Expected_Delivery_Changes_Fact] ([Calendar_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Dim_PO_Expected_Del_Changes_Fact_Expected_Del_Date_Date_FKX] ON [dbo].[PO_Expected_Delivery_Changes_Fact] ([Expected_Delivery_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Expected_Del_Hist_Expd_Date_IDX] ON [dbo].[PO_Expected_Delivery_Changes_Fact] ([Expected_Delivery_Date_Dim_ID], [Purchase_Order_No], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Expected_Delivery_Changes_Fact_Item_Dim_FKX] ON [dbo].[PO_Expected_Delivery_Changes_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Expected_Delivery_Changes_Fact_PO_Expected_Delivery_Curr_Fact_FKX] ON [dbo].[PO_Expected_Delivery_Changes_Fact] ([Item_Dim_ID], [Purchase_Order_No], [Expected_Delivery_Date_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost value of the expected items', 'SCHEMA', N'dbo', 'TABLE', N'PO_Expected_Delivery_Changes_Fact', 'COLUMN', N'Expected_Delivery_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Selling Value of the expected delivery', 'SCHEMA', N'dbo', 'TABLE', N'PO_Expected_Delivery_Changes_Fact', 'COLUMN', N'Expected_Delivery_Selling_Value'
GO
