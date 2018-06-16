SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Reserve_and_Collect_Order_Trans_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Reserve_and_Collect_Order_Trans_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Reserve_and_Collect_Order_Trans_Fact target
USING Dune_Data_Warehouse_Staging..Reserve_and_Collect_Order_Trans_Fact source
ON source.Order_Number = target.Order_Number
    AND source.Layby_Number = target.Layby_Number
    AND source.Line_Number = target.Line_Number
WHEN MATCHED THEN
UPDATE SET
	Order_Status = source.Order_Status
	,Order_Qty = source.Order_Qty
	,Order_Value = source.Order_Value
	,Response_Time_Sec = source.Response_Time_Sec
	,Reason_Code = source.Reason_Code
	,Reason_Description = source.Reason_Description
	,Reason_Type = source.Reason_Type
	,Rejected_Qty = source.Rejected_Qty
	,Rejected_Value = source.Rejected_Value
	,Cancelled_Cust_Serv_Qty = source.Cancelled_Cust_Serv_Qty
	,No_Show_Qty = source.No_Show_Qty
	,Fit_Qty = source.Fit_Qty
	,Colour_Qty = source.Colour_Qty
	,Changed_Mind_Qty = source.Changed_Mind_Qty
	,Alternative_Qty = source.Alternative_Qty
	,Collected_Qty = source.Collected_Qty
	,Collected_Value = source.Collected_Value
	,SLA_Exceeded = source.SLA_Exceeded
	,Awaiting_Collection_Qty = source.Awaiting_Collection_Qty
	,Awaiting_Collection_Value = source.Awaiting_Collection_Value
	,Expired_Qty = source.Expired_Qty
	,Unacknowledged_Qty = source.Unacknowledged_Qty
	,Unacknowledged_Value = source.Unacknowledged_Value
	,Store_Dim_ID = source.Store_Dim_ID
	,Order_Created_Date_Dim_ID = source.Order_Created_Date_Dim_ID
	,Order_Created_Time_Dim_ID = source.Order_Created_Time_Dim_ID
	,Acknowledged_Date_Dim_ID = source.Acknowledged_Date_Dim_ID
	,Rejected_Date_Dim_ID = source.Rejected_Date_Dim_ID
	,Rejected_Time_Dim_ID = source.Rejected_Time_Dim_ID
	,Collected_Date_Dim_ID = source.Collected_Date_Dim_ID
	,Collected_Time_Dim_ID = source.Collected_Time_Dim_ID
	,Cancelled_Date_Dim_ID = source.Cancelled_Date_Dim_ID
	,Cancelled_Time_Dim_ID = source.Cancelled_Time_Dim_ID
	,Acknowledged_Time_Dim_ID = source.Acknowledged_Time_Dim_ID		
WHEN NOT MATCHED THEN
INSERT (
	Order_Number
	,Layby_Number
	,Line_Number
	,Order_Status
	,Order_Qty
	,Order_Value
	,Response_Time_Sec
	,Reason_Code
	,Reason_Description
	,Reason_Type
	,Rejected_Qty
	,Rejected_Value
	,Cancelled_Cust_Serv_Qty
	,No_Show_Qty
	,Fit_Qty
	,Colour_Qty
	,Changed_Mind_Qty
	,Alternative_Qty
	,Collected_Qty
	,Collected_Value
	,SLA_Exceeded
	,Awaiting_Collection_Qty
	,Awaiting_Collection_Value
	,Expired_Qty
	,Unacknowledged_Qty
	,Unacknowledged_Value
	,Store_Dim_ID
	,Order_Created_Date_Dim_ID
	,Order_Created_Time_Dim_ID
	,Acknowledged_Date_Dim_ID
	,Rejected_Date_Dim_ID
	,Rejected_Time_Dim_ID
	,Collected_Date_Dim_ID
	,Collected_Time_Dim_ID
	,Cancelled_Date_Dim_ID
	,Cancelled_Time_Dim_ID
	,Acknowledged_Time_Dim_ID
) VALUES (
	source.Order_Number
	,source.Layby_Number
	,source.Line_Number
	,source.Order_Status
	,source.Order_Qty
	,source.Order_Value
	,source.Response_Time_Sec
	,source.Reason_Code
	,source.Reason_Description
	,source.Reason_Type
	,source.Rejected_Qty
	,source.Rejected_Value
	,source.Cancelled_Cust_Serv_Qty
	,source.No_Show_Qty
	,source.Fit_Qty
	,source.Colour_Qty
	,source.Changed_Mind_Qty
	,source.Alternative_Qty
	,source.Collected_Qty
	,source.Collected_Value
	,source.SLA_Exceeded
	,source.Awaiting_Collection_Qty
	,source.Awaiting_Collection_Value
	,source.Expired_Qty
	,source.Unacknowledged_Qty
	,source.Unacknowledged_Value
	,source.Store_Dim_ID
	,source.Order_Created_Date_Dim_ID
	,source.Order_Created_Time_Dim_ID
	,source.Acknowledged_Date_Dim_ID
	,source.Rejected_Date_Dim_ID
	,source.Rejected_Time_Dim_ID
	,source.Collected_Date_Dim_ID
	,source.Collected_Time_Dim_ID
	,source.Cancelled_Date_Dim_ID
	,source.Cancelled_Time_Dim_ID
	,source.Acknowledged_Time_Dim_ID
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Reserve_and_Collect_Order_Trans_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
