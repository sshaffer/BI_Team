SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Click_and_Collect_Order_Trans_Fact]
	@Source VARCHAR(MAX),
	@Log_ID BIGINT,
	@Cache BIT,
	@Process BIT
AS

SET NOCOUNT ON;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE (
	val BIGINT
)
INSERT INTO @return
EXEC dbo.Log_Start @Source, 'Merge_Click_and_Collect_Order_Trans_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE dbo.Click_and_Collect_Order_Trans_Fact target
USING Dune_Data_Warehouse_Staging.dbo.Click_and_Collect_Order_Trans_Fact source
ON source.Order_Number = target.Order_Number
    AND source.Layby_Number = target.Layby_Number
    AND source.Line_Number = target.Line_Number
WHEN MATCHED THEN
    UPDATE SET
               target.Transfer_Status = source.Transfer_Status
              ,target.Tracking_Number = source.Tracking_Number
              ,target.Delivery_Method = source.Delivery_Method
              ,target.Order_Value = source.Order_Value
              ,target.Order_Qty = source.Order_Qty
              ,target.Value_Collected = source.Value_Collected
              ,target.Qty_Collected = source.Qty_Collected
              ,target.Qty_Await_Fullfilment = source.Qty_Await_Fullfilment
              ,target.Qty_Awaiting_Acknowledgement = source.Qty_Awaiting_Acknowledgement
              ,target.Qty_Awaiting_Collection = source.Qty_Awaiting_Collection
              ,target.Qty_Late = source.Qty_Late
              ,target.Qty_Overdue = source.Qty_Overdue
              ,target.Qty_Uncollected = source.Qty_Uncollected
              ,target.Order_Created_Date_Dim_ID = source.Order_Created_Date_Dim_ID
              ,target.Order_Created_Time_Dim_ID = source.Order_Created_Time_Dim_ID
              ,target.Item_Dim_ID = source.Item_Dim_ID
              ,target.Ultimate_Store_Dim_ID = source.Ultimate_Store_Dim_ID
              ,target.Issuing_Store_Dim_ID = source.Issuing_Store_Dim_ID
              ,target.Due_Date_Dim_ID = source.Due_Date_Dim_ID
              ,target.Breach_of_Promise_Date_Dim_ID = source.Breach_of_Promise_Date_Dim_ID
              ,target.Target_Store_Estimated_Arrival_Date_Dim_ID = source.Target_Store_Estimated_Arrival_Date_Dim_ID
              ,target.Ultimate_Store_Estimated_Arrival_Date_Dim_ID = source.Ultimate_Store_Estimated_Arrival_Date_Dim_ID
              ,target.Enroute_Date_Dim_ID = source.Enroute_Date_Dim_ID
              ,target.Enroute_Time_Dim_ID = source.Enroute_Time_Dim_ID
              ,target.Destination_Store_Ack_Date_Dim_ID = source.Destination_Store_Ack_Date_Dim_ID
              ,target.Destination_Store_Ack_Time_Dim_ID = source.Destination_Store_Ack_Time_Dim_ID
              ,target.Collected_Date_Dim_ID = source.Collected_Date_Dim_ID
              ,target.Collected_Time_Dim_ID = source.Collected_Time_Dim_ID
              ,target.Uncollected_Date_Dim_ID = source.Uncollected_Date_Dim_ID
              ,target.Uncollected_Time_Dim_ID = source.Uncollected_Time_Dim_ID
WHEN NOT MATCHED THEN
    INSERT
           (Order_Number
           ,Layby_Number
           ,Line_Number
           ,Transfer_Status
           ,Tracking_Number
           ,Delivery_Method
           ,Order_Value
           ,Order_Qty
           ,Value_Collected
           ,Qty_Collected
           ,Qty_Await_Fullfilment
           ,Qty_Awaiting_Acknowledgement
           ,Qty_Awaiting_Collection
           ,Qty_Late
           ,Qty_Overdue
           ,Qty_Uncollected
           ,Order_Created_Date_Dim_ID
           ,Order_Created_Time_Dim_ID
           ,Item_Dim_ID
           ,Ultimate_Store_Dim_ID
           ,Issuing_Store_Dim_ID
           ,Due_Date_Dim_ID
           ,Breach_of_Promise_Date_Dim_ID
           ,Target_Store_Estimated_Arrival_Date_Dim_ID
           ,Ultimate_Store_Estimated_Arrival_Date_Dim_ID
           ,Enroute_Date_Dim_ID
           ,Enroute_Time_Dim_ID
           ,Destination_Store_Ack_Date_Dim_ID
           ,Destination_Store_Ack_Time_Dim_ID
           ,Collected_Date_Dim_ID
           ,Collected_Time_Dim_ID
           ,Uncollected_Date_Dim_ID
           ,Uncollected_Time_Dim_ID
           )
    VALUES (source.Order_Number
           ,source.Layby_Number
           ,source.Line_Number
           ,source.Transfer_Status
           ,source.Tracking_Number
           ,source.Delivery_Method
           ,source.Order_Value
           ,source.Order_Qty
           ,source.Value_Collected
           ,source.Qty_Collected
           ,source.Qty_Await_Fullfilment
           ,source.Qty_Awaiting_Acknowledgement
           ,source.Qty_Awaiting_Collection
           ,source.Qty_Late
           ,source.Qty_Overdue
           ,source.Qty_Uncollected
           ,source.Order_Created_Date_Dim_ID
           ,source.Order_Created_Time_Dim_ID
           ,source.Item_Dim_ID
           ,source.Ultimate_Store_Dim_ID
           ,source.Issuing_Store_Dim_ID
           ,source.Due_Date_Dim_ID
           ,source.Breach_of_Promise_Date_Dim_ID
           ,source.Target_Store_Estimated_Arrival_Date_Dim_ID
           ,source.Ultimate_Store_Estimated_Arrival_Date_Dim_ID
           ,source.Enroute_Date_Dim_ID
           ,source.Enroute_Time_Dim_ID
           ,source.Destination_Store_Ack_Date_Dim_ID
           ,source.Destination_Store_Ack_Time_Dim_ID
           ,source.Collected_Date_Dim_ID
           ,source.Collected_Time_Dim_ID
           ,source.Uncollected_Date_Dim_ID
           ,source.Uncollected_Time_Dim_ID
           );

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Click_and_Collect_Order_Trans_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;



EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
