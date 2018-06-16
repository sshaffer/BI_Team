CREATE TABLE [dbo].[PO_Ship_Hist_Fact]
(
[Calendar_Date_Dim_ID] [smallint] NOT NULL,
[Ship_Date_Dim_ID] [smallint] NOT NULL,
[Purchase_Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_No] [numeric] (3, 0) NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Vessel_Name] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Booking_Reference] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Freight_Forwarder_Code] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_PO_Ship_Hist] ON [dbo].[PO_Ship_Hist_Fact] ([Calendar_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_PO_Ship_Hist_Ship_Date] ON [dbo].[PO_Ship_Hist_Fact] ([Ship_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PO_Ship_Hist_Fact_PO_Ship_Curr_Fact_FKX] ON [dbo].[PO_Ship_Hist_Fact] ([Ship_Date_Dim_ID], [Purchase_Order_No], [Item_Dim_ID]) ON [PRIMARY]
GO
