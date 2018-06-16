CREATE TABLE [dbo].[PO_Expected_Delivery_Curr_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Purchase_Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_No] [numeric] (3, 0) NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Expected_Delivery_Qty] [int] NOT NULL,
[Expected_Delivery_Cost_Value] [money] NOT NULL,
[Expected_Delivery_Selling_Value] [money] NOT NULL,
[Store_Dim_ID] [int] NOT NULL CONSTRAINT [PO_Exp_Del_Curr_Store_DF] DEFAULT ((-2147483648))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PO_Expected_Delivery_Curr_Fact] ADD CONSTRAINT [PO_Expected_Delivery_Curr_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_ID], [Purchase_Order_No], [Purchase_Order_Sequence_No], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Expected_Delivery_Curr_Fact_Calendar_Day_Dim_FKX] ON [dbo].[PO_Expected_Delivery_Curr_Fact] ([Calendar_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Expected_Delivery_Curr_Fact_Item_Dim_FKX] ON [dbo].[PO_Expected_Delivery_Curr_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PO_Expected_Delivery_Curr_Fact] ADD CONSTRAINT [PO_Expected_Delivery_Curr_Fact_Calendar_Day_Dim_FK] FOREIGN KEY ([Calendar_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[PO_Expected_Delivery_Curr_Fact] ADD CONSTRAINT [PO_Expected_Delivery_Curr_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost value of the expected delivery quantity', 'SCHEMA', N'dbo', 'TABLE', N'PO_Expected_Delivery_Curr_Fact', 'COLUMN', N'Expected_Delivery_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Selling value of the expected delivery quantity', 'SCHEMA', N'dbo', 'TABLE', N'PO_Expected_Delivery_Curr_Fact', 'COLUMN', N'Expected_Delivery_Selling_Value'
GO
