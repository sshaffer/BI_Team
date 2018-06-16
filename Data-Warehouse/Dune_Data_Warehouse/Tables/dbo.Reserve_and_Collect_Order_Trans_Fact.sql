CREATE TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact]
(
[Order_Number] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Layby_Number] [int] NOT NULL,
[Line_Number] [int] NOT NULL,
[Order_Status] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_Qty] [int] NOT NULL,
[Order_Value] [money] NOT NULL,
[Response_Time_Sec] [int] NOT NULL,
[Reason_Code] [int] NOT NULL,
[Reason_Description] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Reason_Type] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Rejected_Qty] [int] NOT NULL,
[Rejected_Value] [money] NOT NULL,
[Cancelled_Cust_Serv_Qty] [int] NOT NULL,
[No_Show_Qty] [int] NOT NULL,
[Fit_Qty] [int] NOT NULL,
[Colour_Qty] [int] NOT NULL,
[Changed_Mind_Qty] [int] NOT NULL,
[Alternative_Qty] [int] NOT NULL,
[Collected_Qty] [int] NOT NULL,
[Collected_Value] [money] NOT NULL,
[SLA_Exceeded] [int] NOT NULL,
[Awaiting_Collection_Qty] [int] NOT NULL,
[Awaiting_Collection_Value] [money] NOT NULL,
[Expired_Qty] [int] NOT NULL,
[Unacknowledged_Qty] [int] NOT NULL,
[Unacknowledged_Value] [money] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Order_Created_Date_Dim_ID] [smallint] NOT NULL,
[Order_Created_Time_Dim_ID] [smallint] NOT NULL,
[Acknowledged_Date_Dim_ID] [smallint] NOT NULL,
[Rejected_Date_Dim_ID] [smallint] NOT NULL,
[Rejected_Time_Dim_ID] [smallint] NOT NULL,
[Collected_Date_Dim_ID] [smallint] NOT NULL,
[Collected_Time_Dim_ID] [smallint] NOT NULL,
[Cancelled_Date_Dim_ID] [smallint] NOT NULL,
[Cancelled_Time_Dim_ID] [smallint] NOT NULL,
[Acknowledged_Time_Dim_ID] [smallint] NOT NULL CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Ack_Time_DF] DEFAULT ((-32768))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([Order_Number], [Layby_Number], [Line_Number]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Acknowledged_Date_FK] FOREIGN KEY ([Acknowledged_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Ack_Time_FK] FOREIGN KEY ([Acknowledged_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Cancelled_Date_FK] FOREIGN KEY ([Cancelled_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Cancelled_Time_FK] FOREIGN KEY ([Cancelled_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Collected_Date_FK] FOREIGN KEY ([Collected_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Collected_Time_FK] FOREIGN KEY ([Collected_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Created_Date_FK] FOREIGN KEY ([Order_Created_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Created_Time_FK] FOREIGN KEY ([Order_Created_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Rejected_Date_FK] FOREIGN KEY ([Rejected_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Rejected_Time_FK] FOREIGN KEY ([Rejected_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Reserve_and_Collect_Order_Trans_Fact] ADD CONSTRAINT [Reserve_and_Collect_Order_Trans_Fact_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
