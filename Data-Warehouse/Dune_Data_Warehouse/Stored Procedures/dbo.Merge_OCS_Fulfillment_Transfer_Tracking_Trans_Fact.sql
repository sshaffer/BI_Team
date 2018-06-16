
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_OCS_Fulfillment_Transfer_Tracking_Trans_Fact]
    @Source VARCHAR(MAX)
   ,@Log_ID BIGINT
   ,@Cache BIT
   ,@Process BIT
AS
SET NOCOUNT ON;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE ( val BIGINT )
INSERT  INTO @return
        EXEC dbo.Log_Start
            @Source
           ,'Merge_OCS_Fulfillment_Transfer_Tracking_Trans_Fact'
           ,@Cache
           ,@Process;
SET @Log_Load_ID = ( SELECT TOP 1
                        val
                     FROM
                        @return
                   );

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

    BEGIN TRANSACTION 

    MERGE INTO dbo.OCS_Fulfillment_Transfer_Tracking_Trans_Fact target
    USING Dune_Data_Warehouse_Staging.dbo.OCS_Fulfillment_Transfer_Tracking_Trans_Fact source
    ON source.OCS_Fulfillment_Order_Dim_Id = target.OCS_Fulfillment_Order_Dim_Id
        AND source.Order_Created_Date_Dim_ID = target.Order_Created_Date_Dim_ID
        AND source.Order_Created_Time_Dim_ID = target.Order_Created_Time_Dim_ID
        AND source.Layby_Store_Dim_ID = target.Layby_Store_Dim_ID
        AND source.Sending_Store_Dim_Id = target.Sending_Store_Dim_Id
        AND source.TransferLine = target.TransferLine
        AND source.Item_Dim_Id = target.Item_Dim_Id
    WHEN MATCHED THEN
        UPDATE SET
               DeliveryDue_Date_Dim_ID = source.DeliveryDue_Date_Dim_ID
              ,Order_Created_Date_Dim_ID = source.Order_Created_Date_Dim_ID
              ,Order_Created_Time_Dim_ID = source.Order_Created_Time_Dim_ID
              ,Truck_Pickup_Date_Dim_ID = source.Truck_Pickup_Date_Dim_ID
              ,Target_Store_Date_Dim_ID = source.Target_Store_Date_Dim_ID
              ,Ultimate_Store_Date_Dim_ID = source.Ultimate_Store_Date_Dim_ID
              ,Sending_Store_Acknowledge_Date_Dim_ID = source.Sending_Store_Acknowledge_Date_Dim_ID
              ,Sending_Store_Acknowledge_Time_Dim_ID = source.Sending_Store_Acknowledge_Time_Dim_ID
              ,Sending_Store_Rejected_Date_Dim_ID = source.Sending_Store_Rejected_Date_Dim_ID
              ,Sending_Store_Rejected_Time_Dim_ID = source.Sending_Store_Rejected_Time_Dim_ID
              ,Packed_Date_Dim_ID = source.Packed_Date_Dim_ID
              ,Packed_Time_Dim_ID = source.Packed_Time_Dim_ID
              ,Enroute_Date_Dim_ID = source.Enroute_Date_Dim_ID
              ,Enroute_Time_Dim_ID = source.Enroute_Time_Dim_ID
              ,Shipvia_Date_Dim_ID = source.Shipvia_Date_Dim_ID
              ,Shipvia_Time_Dim_ID = source.Shipvia_Time_Dim_ID
              ,Receiving_Store_Acknowledged_Date_Dim_ID = source.Receiving_Store_Acknowledged_Date_Dim_ID
              ,Receiving_Store_Acknowledged_Time_Dim_ID = source.Receiving_Store_Acknowledged_Time_Dim_ID
              ,Cancelled_Date_Dim_ID = source.Cancelled_Date_Dim_ID
              ,Cancelled_Time_Dim_ID = source.Cancelled_Time_Dim_ID
              ,Collected_Date_Dim_ID = source.Collected_Date_Dim_ID
              ,Collected_Time_Dim_ID = source.Collected_Time_Dim_ID
              ,Uncollected_Date_Dim_ID = source.Uncollected_Date_Dim_ID
              ,Uncollected_Time_Dim_ID = source.Uncollected_Time_Dim_ID
              ,Backorder_Date_Dim_ID = source.Backorder_Date_Dim_ID
              ,Backorder_Time_Dim_ID = source.Backorder_Time_Dim_ID
              ,Final_Store_Acknowledged_Date_Dim_ID = source.Final_Store_Acknowledged_Date_Dim_ID
              ,Final_Store_Acknowledged_Time_Dim_ID = source.Final_Store_Acknowledged_Time_Dim_ID
              ,Final_Enroute_Date_Dim_ID = source.Final_Enroute_Date_Dim_ID
              ,Final_Enroute_Time_Dim_ID = source.Final_Enroute_Time_Dim_ID
              ,TransferNumber = source.TransferNumber
              ,TransferLine = source.TransferLine
              ,TransferType = source.TransferType
              ,TransferStatus = source.TransferStatus
              ,Quantity = source.Quantity
              ,Value = source.Value
              ,CreatedUser = source.CreatedUser
              ,SendingStoreAckUser = source.SendingStoreAckUser
              ,SendingStoreRejUser = source.SendingStoreRejUser
              ,PackedUser = source.PackedUser
              ,EnrouteUser = source.EnrouteUser
              ,ShipviaUser = source.ShipviaUser
              ,ReceivingStoreAckUser = source.ReceivingStoreAckUser
              ,CancelledUser = source.CancelledUser
              ,CollectedUser = source.CollectedUser
              ,UncollectedUser = source.UncollectedUser
              ,Reason = source.Reason
              ,TrackingNumber = source.TrackingNumber
              ,DeliveryMethod = source.DeliveryMethod
              ,Carrier = source.Carrier
              ,Comments = source.Comments
              ,FinalStoreAckUser = source.FinalStoreAckUser
              ,FinalEnrouteUser = source.FinalEnrouteUser
              ,CartonCode = source.CartonCode
              ,CartonStatus = source.CartonStatus
              ,Acknowledged = source.Acknowledged
              ,UnAcknowledgeQty = source.UnAcknowledgeQty
              ,UnAcknowledgeValue = source.UnAcknowledgeValue
              ,AwaitingPackingQty = source.AwaitingPackingQty
              ,AwaitingPackingValue = source.AwaitingPackingValue
              ,PackedQty = source.PackedQty
              ,PackedValue = source.PackedValue
              ,EnrouteQty = source.EnrouteQty
              ,EnrouteValue = source.EnrouteValue
              ,AwaitingFulfillmentQty = source.AwaitingFulfillmentQty
              ,AwaitingFulfillmentValue = source.AwaitingFulfillmentValue
              ,ShippedQty = source.ShippedQty
              ,ShippedValue = source.ShippedValue
              ,BackorderQty = source.BackorderQty
              ,BackorderValue = source.BackorderValue
              ,CancelledQty = source.CancelledQty
              ,CancelledValue = source.CancelledValue
              ,ClearedQty = source.ClearedQty
              ,ClearedValue = source.ClearedValue
              ,Qty_Collected = source.Qty_Collected
              ,Qty_AwaitFulfillment = source.Qty_AwaitFulfillment
              ,Qty_Awaiting_Acknowledgement = source.Qty_Awaiting_Acknowledgement
              ,Qty_Awaiting_Collection = source.Qty_Awaiting_Collection
              ,Qty_Late = source.Qty_Late
              ,Qty_Overdue = source.Qty_Overdue
              ,Qty_Uncollected = source.Qty_Uncollected
              ,Value_Collected = source.Value_Collected
    WHEN NOT MATCHED THEN
        INSERT
               ( OCS_Fulfillment_Order_Dim_Id
               ,Sending_Store_Dim_Id
               ,Store_Dim_Id
               ,Ultimate_Store_Dim_Id
               ,Item_Dim_Id
               ,DeliveryDue_Date_Dim_ID
               ,Order_Created_Date_Dim_ID
               ,Order_Created_Time_Dim_ID
               ,Truck_Pickup_Date_Dim_ID
               ,Target_Store_Date_Dim_ID
               ,Ultimate_Store_Date_Dim_ID
               ,Sending_Store_Acknowledge_Date_Dim_ID
               ,Sending_Store_Acknowledge_Time_Dim_ID
               ,Sending_Store_Rejected_Date_Dim_ID
               ,Sending_Store_Rejected_Time_Dim_ID
               ,Packed_Date_Dim_ID
               ,Packed_Time_Dim_ID
               ,Enroute_Date_Dim_ID
               ,Enroute_Time_Dim_ID
               ,Shipvia_Date_Dim_ID
               ,Shipvia_Time_Dim_ID
               ,Receiving_Store_Acknowledged_Date_Dim_ID
               ,Receiving_Store_Acknowledged_Time_Dim_ID
               ,Cancelled_Date_Dim_ID
               ,Cancelled_Time_Dim_ID
               ,Collected_Date_Dim_ID
               ,Collected_Time_Dim_ID
               ,Uncollected_Date_Dim_ID
               ,Uncollected_Time_Dim_ID
               ,Backorder_Date_Dim_ID
               ,Backorder_Time_Dim_ID
               ,Final_Store_Acknowledged_Date_Dim_ID
               ,Final_Store_Acknowledged_Time_Dim_ID
               ,Final_Enroute_Date_Dim_ID
               ,Final_Enroute_Time_Dim_ID
               ,TransferNumber
               ,TransferLine
               ,TransferType
               ,TransferStatus
               ,Quantity
               ,Value
               ,CreatedUser
               ,SendingStoreAckUser
               ,SendingStoreRejUser
               ,PackedUser
               ,EnrouteUser
               ,ShipviaUser
               ,ReceivingStoreAckUser
               ,CancelledUser
               ,CollectedUser
               ,UncollectedUser
               ,Reason
               ,TrackingNumber
               ,DeliveryMethod
               ,Carrier
               ,Comments
               ,FinalStoreAckUser
               ,FinalEnrouteUser
               ,CartonCode
               ,CartonStatus
               ,Acknowledged
               ,UnAcknowledgeQty
               ,UnAcknowledgeValue
               ,AwaitingPackingQty
               ,AwaitingPackingValue
               ,PackedQty
               ,PackedValue
               ,EnrouteQty
               ,EnrouteValue
               ,AwaitingFulfillmentQty
               ,AwaitingFulfillmentValue
               ,ShippedQty
               ,ShippedValue
               ,BackorderQty
               ,BackorderValue
               ,CancelledQty
               ,CancelledValue
               ,ClearedQty
               ,ClearedValue
               ,Layby_Store_Dim_ID
               ,Qty_Collected
               ,Qty_AwaitFulfillment
               ,Qty_Awaiting_Acknowledgement
               ,Qty_Awaiting_Collection
               ,Qty_Late
               ,Qty_Overdue
               ,Qty_Uncollected
               ,Value_Collected
               )
        VALUES ( source.OCS_Fulfillment_Order_Dim_Id
               ,source.Sending_Store_Dim_Id
               ,source.Store_Dim_Id
               ,source.Ultimate_Store_Dim_Id
               ,source.Item_Dim_Id
               ,source.DeliveryDue_Date_Dim_ID
               ,source.Order_Created_Date_Dim_ID
               ,source.Order_Created_Time_Dim_ID
               ,source.Truck_Pickup_Date_Dim_ID
               ,source.Target_Store_Date_Dim_ID
               ,source.Ultimate_Store_Date_Dim_ID
               ,source.Sending_Store_Acknowledge_Date_Dim_ID
               ,source.Sending_Store_Acknowledge_Time_Dim_ID
               ,source.Sending_Store_Rejected_Date_Dim_ID
               ,source.Sending_Store_Rejected_Time_Dim_ID
               ,source.Packed_Date_Dim_ID
               ,source.Packed_Time_Dim_ID
               ,source.Enroute_Date_Dim_ID
               ,source.Enroute_Time_Dim_ID
               ,source.Shipvia_Date_Dim_ID
               ,source.Shipvia_Time_Dim_ID
               ,source.Receiving_Store_Acknowledged_Date_Dim_ID
               ,source.Receiving_Store_Acknowledged_Time_Dim_ID
               ,source.Cancelled_Date_Dim_ID
               ,source.Cancelled_Time_Dim_ID
               ,source.Collected_Date_Dim_ID
               ,source.Collected_Time_Dim_ID
               ,source.Uncollected_Date_Dim_ID
               ,source.Uncollected_Time_Dim_ID
               ,source.Backorder_Date_Dim_ID
               ,source.Backorder_Time_Dim_ID
               ,source.Final_Store_Acknowledged_Date_Dim_ID
               ,source.Final_Store_Acknowledged_Time_Dim_ID
               ,source.Final_Enroute_Date_Dim_ID
               ,source.Final_Enroute_Time_Dim_ID
               ,source.TransferNumber
               ,source.TransferLine
               ,source.TransferType
               ,source.TransferStatus
               ,source.Quantity
               ,source.Value
               ,source.CreatedUser
               ,source.SendingStoreAckUser
               ,source.SendingStoreRejUser
               ,source.PackedUser
               ,source.EnrouteUser
               ,source.ShipviaUser
               ,source.ReceivingStoreAckUser
               ,source.CancelledUser
               ,source.CollectedUser
               ,source.UncollectedUser
               ,source.Reason
               ,source.TrackingNumber
               ,source.DeliveryMethod
               ,source.Carrier
               ,source.Comments
               ,source.FinalStoreAckUser
               ,source.FinalEnrouteUser
               ,source.CartonCode
               ,source.CartonStatus
               ,source.Acknowledged
               ,source.UnAcknowledgeQty
               ,source.UnAcknowledgeValue
               ,source.AwaitingPackingQty
               ,source.AwaitingPackingValue
               ,source.PackedQty
               ,source.PackedValue
               ,source.EnrouteQty
               ,source.EnrouteValue
               ,source.AwaitingFulfillmentQty
               ,source.AwaitingFulfillmentValue
               ,source.ShippedQty
               ,source.ShippedValue
               ,source.BackorderQty
               ,source.BackorderValue
               ,source.CancelledQty
               ,source.CancelledValue
               ,source.ClearedQty
               ,source.ClearedValue
               ,source.Layby_Store_Dim_ID
               ,source.Qty_Collected
               ,source.Qty_AwaitFulfillment
               ,source.Qty_Awaiting_Acknowledgement
               ,source.Qty_Awaiting_Collection
               ,source.Qty_Late
               ,source.Qty_Overdue
               ,source.Qty_Uncollected
               ,source.Value_Collected
               );

    SET @Row_Count = @@ROWCOUNT;
    COMMIT TRANSACTION;


END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;

    SELECT
        @Error_Message = ERROR_MESSAGE()
       ,@Error_Number = ERROR_NUMBER()
       ,@Error_Severity = ERROR_SEVERITY()
       ,@Error_State = ERROR_STATE();

    SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_OCS_Fulfillment_Transfer_Tracking_Trans_Fact: (%d)%s';
    RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

    EXEC dbo.Log_End
        @Row_Count
       ,@Log_ID
       ,@Log_Load_ID
       ,0;
    RETURN -1;

END CATCH;


EXEC dbo.Log_End
    @Row_Count
   ,@Log_ID
   ,@Log_Load_ID
   ,1;
RETURN 0;

GO
