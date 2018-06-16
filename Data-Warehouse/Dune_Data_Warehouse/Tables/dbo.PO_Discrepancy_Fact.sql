CREATE TABLE [dbo].[PO_Discrepancy_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Purchase_Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_No] [numeric] (3, 0) NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[PO_Discrepancy_Qty] [int] NOT NULL,
[PO_Discrepancy_Component_Qty] [int] NOT NULL,
[PO_Discrepancy_Cost_Value] [money] NOT NULL,
[PO_Discrepancy_Selling_Value] [money] NOT NULL,
[Store_Dim_ID] [int] NOT NULL CONSTRAINT [PO_Discrepancy_Fact_Store_Dim_ID_DF] DEFAULT ((-2147483648))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PO_Discrepancy_Fact] ADD CONSTRAINT [PO_Discrepancy_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_ID], [Purchase_Order_No], [Purchase_Order_Sequence_No], [Item_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_PO_Discrepancy_Delivery_Dated_FKX] ON [dbo].[PO_Discrepancy_Fact] ([Calendar_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Discrepancy_Fact_Item_Dim_FKX] ON [dbo].[PO_Discrepancy_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PO_Discrepancy_Fact] ADD CONSTRAINT [Calendar_Day_PO_Discrepancy_Delivery_Dated_FK] FOREIGN KEY ([Calendar_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[PO_Discrepancy_Fact] ADD CONSTRAINT [PO_Discrepancy_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[PO_Discrepancy_Fact] ADD CONSTRAINT [PO_Discrepancy_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost value of the quantity difference', 'SCHEMA', N'dbo', 'TABLE', N'PO_Discrepancy_Fact', 'COLUMN', N'PO_Discrepancy_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Selling value of the quantity difference', 'SCHEMA', N'dbo', 'TABLE', N'PO_Discrepancy_Fact', 'COLUMN', N'PO_Discrepancy_Selling_Value'
GO
