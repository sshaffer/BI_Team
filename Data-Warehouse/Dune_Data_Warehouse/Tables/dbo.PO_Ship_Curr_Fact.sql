CREATE TABLE [dbo].[PO_Ship_Curr_Fact]
(
[Ship_Date_Dim_ID] [smallint] NOT NULL,
[Purchase_Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_No] [numeric] (3, 0) NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Vessel_Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Booking_Reference] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Freight_Forwarder_Code] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PO_Ship_Curr_Fact] ADD CONSTRAINT [PO_Ship_Curr_Fact_PK] PRIMARY KEY CLUSTERED  ([Ship_Date_Dim_ID], [Item_Dim_ID], [Purchase_Order_No], [Purchase_Order_Sequence_No]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Ship_Curr_Fact_Item_Dim_FKX] ON [dbo].[PO_Ship_Curr_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_PO_Ship_Curr_Fact_Ship_Date_FKX] ON [dbo].[PO_Ship_Curr_Fact] ([Ship_Date_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PO_Ship_Curr_Fact] ADD CONSTRAINT [PO_Ship_Curr_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[PO_Ship_Curr_Fact] ADD CONSTRAINT [Calendar_Day_PO_Ship_Curr_Fact_Ship_Date_FK] FOREIGN KEY ([Ship_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
