CREATE TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact]
(
[OCS_Fulfillment_Order_Dim_Id] [int] NOT NULL,
[Sending_Store_Dim_Id] [int] NOT NULL,
[Store_Dim_Id] [int] NOT NULL,
[Ultimate_Store_Dim_Id] [int] NOT NULL,
[Item_Dim_Id] [int] NOT NULL,
[DeliveryDue_Date_Dim_ID] [smallint] NOT NULL,
[Order_Created_Date_Dim_ID] [smallint] NOT NULL,
[Order_Created_Time_Dim_ID] [smallint] NOT NULL,
[Truck_Pickup_Date_Dim_ID] [smallint] NOT NULL,
[Target_Store_Date_Dim_ID] [smallint] NOT NULL,
[Ultimate_Store_Date_Dim_ID] [smallint] NOT NULL,
[Sending_Store_Acknowledge_Date_Dim_ID] [smallint] NOT NULL,
[Sending_Store_Acknowledge_Time_Dim_ID] [smallint] NOT NULL,
[Sending_Store_Rejected_Date_Dim_ID] [smallint] NOT NULL,
[Sending_Store_Rejected_Time_Dim_ID] [smallint] NOT NULL,
[Packed_Date_Dim_ID] [smallint] NOT NULL,
[Packed_Time_Dim_ID] [smallint] NOT NULL,
[Enroute_Date_Dim_ID] [smallint] NOT NULL,
[Enroute_Time_Dim_ID] [smallint] NOT NULL,
[Shipvia_Date_Dim_ID] [smallint] NOT NULL,
[Shipvia_Time_Dim_ID] [smallint] NOT NULL,
[Receiving_Store_Acknowledged_Date_Dim_ID] [smallint] NOT NULL,
[Receiving_Store_Acknowledged_Time_Dim_ID] [smallint] NOT NULL,
[Cancelled_Date_Dim_ID] [smallint] NOT NULL,
[Cancelled_Time_Dim_ID] [smallint] NOT NULL,
[Collected_Date_Dim_ID] [smallint] NOT NULL,
[Collected_Time_Dim_ID] [smallint] NOT NULL,
[Uncollected_Date_Dim_ID] [smallint] NOT NULL,
[Uncollected_Time_Dim_ID] [smallint] NOT NULL,
[Backorder_Date_Dim_ID] [smallint] NOT NULL,
[Backorder_Time_Dim_ID] [smallint] NOT NULL,
[Final_Store_Acknowledged_Date_Dim_ID] [smallint] NOT NULL,
[Final_Store_Acknowledged_Time_Dim_ID] [smallint] NOT NULL,
[Final_Enroute_Date_Dim_ID] [smallint] NOT NULL,
[Final_Enroute_Time_Dim_ID] [smallint] NOT NULL,
[TransferNumber] [int] NOT NULL,
[TransferLine] [int] NOT NULL,
[TransferType] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TransferStatus] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Quantity] [int] NOT NULL,
[Value] [money] NOT NULL,
[CreatedUser] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SendingStoreAckUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SendingStoreRejUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PackedUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EnrouteUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShipviaUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReceivingStoreAckUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CancelledUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CollectedUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UncollectedUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Reason] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TrackingNumber] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeliveryMethod] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Carrier] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Comments] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FinalStoreAckUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FinalEnrouteUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CartonCode] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CartonStatus] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Acknowledged] [int] NOT NULL,
[UnAcknowledgeQty] [int] NOT NULL,
[UnAcknowledgeValue] [money] NOT NULL,
[AwaitingPackingQty] [int] NOT NULL,
[AwaitingPackingValue] [money] NOT NULL,
[PackedQty] [int] NOT NULL,
[PackedValue] [money] NOT NULL,
[EnrouteQty] [int] NOT NULL,
[EnrouteValue] [money] NOT NULL,
[AwaitingFulfillmentQty] [int] NOT NULL,
[AwaitingFulfillmentValue] [money] NOT NULL,
[ShippedQty] [int] NOT NULL,
[ShippedValue] [money] NOT NULL,
[BackorderQty] [int] NOT NULL,
[BackorderValue] [money] NOT NULL,
[CancelledQty] [int] NOT NULL,
[CancelledValue] [money] NOT NULL,
[ClearedQty] [int] NOT NULL,
[ClearedValue] [money] NOT NULL,
[Layby_Store_Dim_ID] [int] NOT NULL,
[Qty_Collected] [int] NOT NULL,
[Qty_AwaitFulfillment] [int] NOT NULL,
[Qty_Awaiting_Acknowledgement] [int] NOT NULL,
[Qty_Awaiting_Collection] [int] NOT NULL,
[Qty_Late] [int] NOT NULL,
[Qty_Overdue] [int] NOT NULL,
[Qty_Uncollected] [int] NOT NULL,
[Value_Collected] [money] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD 
CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([OCS_Fulfillment_Order_Dim_Id], [Order_Created_Date_Dim_ID], [Order_Created_Time_Dim_ID], [Layby_Store_Dim_ID], [Sending_Store_Dim_Id], [TransferLine], [Item_Dim_Id]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_BackorderDate_FK] FOREIGN KEY ([Backorder_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_BackorderTime_FK] FOREIGN KEY ([Backorder_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_CancelledDate_FK] FOREIGN KEY ([Cancelled_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_CancelledTime_FK] FOREIGN KEY ([Cancelled_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_CollectedDate_FK] FOREIGN KEY ([Collected_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_CollectedTime_FK] FOREIGN KEY ([Collected_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_DeliveryDueDate_FK] FOREIGN KEY ([DeliveryDue_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_EnrouteDate_FK] FOREIGN KEY ([Enroute_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_EnrouteTime_FK] FOREIGN KEY ([Enroute_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_FinalEnrouteDate_FK] FOREIGN KEY ([Final_Enroute_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_FinalEnrouteTime_FK] FOREIGN KEY ([Final_Enroute_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_FinalStoreAckDate_FK] FOREIGN KEY ([Final_Store_Acknowledged_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_FinalStoreAckTime_FK] FOREIGN KEY ([Final_Store_Acknowledged_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_Item_FK] FOREIGN KEY ([Item_Dim_Id]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_LaybyStore_FK] FOREIGN KEY ([Layby_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_OrderCreatedDate_FK] FOREIGN KEY ([Order_Created_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_OrderCreatedTime_FK] FOREIGN KEY ([Order_Created_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_PackedDate_FK] FOREIGN KEY ([Packed_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_PackedTime_FK] FOREIGN KEY ([Packed_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_ReceivingStoreAckDate_FK] FOREIGN KEY ([Receiving_Store_Acknowledged_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_ReceivingStoreAckTime_FK] FOREIGN KEY ([Receiving_Store_Acknowledged_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_SendingStoreAckDate_FK] FOREIGN KEY ([Sending_Store_Acknowledge_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_SendingStoreAckTime_FK] FOREIGN KEY ([Sending_Store_Acknowledge_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_SendingStore_FK] FOREIGN KEY ([Sending_Store_Dim_Id]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_SendingStoreRejDate_FK] FOREIGN KEY ([Sending_Store_Rejected_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_SendingStoreRefTime_FK] FOREIGN KEY ([Sending_Store_Rejected_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_ShipviaDate_FK] FOREIGN KEY ([Shipvia_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_ShipviaTime_FK] FOREIGN KEY ([Shipvia_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_Store_FK] FOREIGN KEY ([Store_Dim_Id]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_TargetStoreDate_FK] FOREIGN KEY ([Target_Store_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_TruckPickupDate_FK] FOREIGN KEY ([Truck_Pickup_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_UltimateStoreDate_FK] FOREIGN KEY ([Ultimate_Store_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_UltimateStore_FK] FOREIGN KEY ([Ultimate_Store_Dim_Id]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_UncollectedDate_FK] FOREIGN KEY ([Uncollected_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Transfer_Tracking_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Transfer_Tracking_Trans_Fact_UncollectedTime_FK] FOREIGN KEY ([Uncollected_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
