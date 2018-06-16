CREATE TABLE [dbo].[PO_Curr_Fact]
(
[Purchase_Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_No] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Purchase_Order_Date_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Buyer_ID] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Ship_Via] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Agent_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Terms_Description] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Closed_Order] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Closed_Item] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Handling_Type] [char] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Unit_Cost_Price] [money] NOT NULL,
[Retail_Price] [money] NOT NULL,
[Purchase_Order_Quantity] [int] NOT NULL,
[Purchase_Order_Component_Qty] [int] NOT NULL CONSTRAINT [PO_Curr_Fact_Comp_Qty_DF] DEFAULT ((0)),
[Frieght_Cost_Per_Unit] [money] NOT NULL,
[Duty_Value] [money] NOT NULL,
[Agent_Fees] [money] NOT NULL,
[Carriage_Cost_per_Unit] [money] NOT NULL,
[Landed_Cost] [money] NOT NULL,
[Margin_Calc_Value] [money] NOT NULL,
[User_ID] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [PO_Curr_Fact_User_ID_DF] DEFAULT (''),
[Supplier_Cost] [money] NOT NULL CONSTRAINT [PO_Curr_Fact_Supplier_Cost_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Curr_Fact_Store] ON [dbo].[PO_Curr_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PO_Curr_Fact] ADD CONSTRAINT [PO_Curr_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[PO_Curr_Fact] ADD CONSTRAINT [PO_Curr_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
