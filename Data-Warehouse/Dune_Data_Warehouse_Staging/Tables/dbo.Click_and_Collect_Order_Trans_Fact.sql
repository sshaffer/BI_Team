CREATE TABLE [dbo].[Click_and_Collect_Order_Trans_Fact]
(
[Order_Number] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Layby_Number] [int] NOT NULL,
[Line_Number] [int] NOT NULL,
[Transfer_Status] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Tracking_Number] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Delivery_Method] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_Value] [money] NOT NULL,
[Order_Qty] [int] NOT NULL,
[Value_Collected] [money] NOT NULL,
[Qty_Collected] [int] NOT NULL,
[Qty_Await_Fullfilment] [int] NOT NULL,
[Qty_Awaiting_Acknowledgement] [int] NOT NULL,
[Qty_Awaiting_Collection] [int] NOT NULL,
[Qty_Late] [int] NOT NULL,
[Qty_Overdue] [int] NOT NULL,
[Qty_Uncollected] [int] NOT NULL,
[Order_Created_Date_Dim_ID] [smallint] NOT NULL,
[Order_Created_Time_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Ultimate_Store_Dim_ID] [int] NOT NULL,
[Issuing_Store_Dim_ID] [int] NOT NULL,
[Due_Date_Dim_ID] [smallint] NOT NULL,
[Breach_of_Promise_Date_Dim_ID] [smallint] NOT NULL,
[Target_Store_Estimated_Arrival_Date_Dim_ID] [smallint] NOT NULL,
[Ultimate_Store_Estimated_Arrival_Date_Dim_ID] [smallint] NOT NULL,
[Enroute_Date_Dim_ID] [smallint] NOT NULL,
[Enroute_Time_Dim_ID] [smallint] NOT NULL,
[Destination_Store_Ack_Date_Dim_ID] [smallint] NOT NULL,
[Destination_Store_Ack_Time_Dim_ID] [smallint] NOT NULL,
[Collected_Date_Dim_ID] [smallint] NOT NULL,
[Collected_Time_Dim_ID] [smallint] NOT NULL,
[Uncollected_Date_Dim_ID] [smallint] NOT NULL,
[Uncollected_Time_Dim_ID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Click_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Click_and_Collect_Order_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([Order_Number], [Layby_Number], [Line_Number]) ON [PRIMARY]
GO
