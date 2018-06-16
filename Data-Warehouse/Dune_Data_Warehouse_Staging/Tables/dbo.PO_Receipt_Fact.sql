CREATE TABLE [dbo].[PO_Receipt_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Purchase_Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_No] [numeric] (3, 0) NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[PO_Receipt_Qty] [int] NOT NULL,
[PO_Receipt_Component_Qty] [int] NOT NULL,
[PO_Receipt_Cost_Value] [money] NOT NULL,
[PO_Receipt_Selling_Value] [money] NOT NULL,
[Store_Dim_ID] [int] NOT NULL CONSTRAINT [PO_Receipt_Fact_Store_Dim_ID_DF] DEFAULT ((-2147483648))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_PO_Receipt_Receipt_DateX] ON [dbo].[PO_Receipt_Fact] ([Calendar_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Receipt_Fact_Item_Dim_FKX] ON [dbo].[PO_Receipt_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost value of the intake quantity', 'SCHEMA', N'dbo', 'TABLE', N'PO_Receipt_Fact', 'COLUMN', N'PO_Receipt_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Intake quantity', 'SCHEMA', N'dbo', 'TABLE', N'PO_Receipt_Fact', 'COLUMN', N'PO_Receipt_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Selling Value of the intake quantity', 'SCHEMA', N'dbo', 'TABLE', N'PO_Receipt_Fact', 'COLUMN', N'PO_Receipt_Selling_Value'
GO
