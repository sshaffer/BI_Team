SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_OCS_Fulfillment_Rejection_Trans_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_OCS_Fulfillment_Rejection_Trans_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.OCS_Fulfillment_Rejection_Trans_Fact target
USING Dune_Data_Warehouse_Staging.dbo.OCS_Fulfillment_Rejection_Trans_Fact source
ON source.OCS_Fulfillment_Order_Dim_Id = target.OCS_Fulfillment_Order_Dim_Id
    AND source.Sending_Store_Dim_Id = target.Sending_Store_Dim_Id
    AND source.Item_Dim_Id = target.Item_Dim_Id
    AND source.Sending_Store_Rejected_Date_Dim_ID = target.Sending_Store_Rejected_Date_Dim_ID
    AND source.Sending_Store_Rejected_Time_Dim_ID = target.Sending_Store_Rejected_Time_Dim_ID
	AND source.Layby_Store_Dim_ID = target.Layby_Store_Dim_ID
WHEN MATCHED THEN
    UPDATE SET
               TransferNumber = source.TransferNumber
              ,TransferLine = source.TransferLine
              ,SendingStoreRejUser = source.SendingStoreRejUser
WHEN NOT MATCHED THEN
    INSERT
           (OCS_Fulfillment_Order_Dim_Id
           ,Sending_Store_Dim_Id
           ,Item_Dim_Id
           ,Sending_Store_Rejected_Date_Dim_ID
           ,Sending_Store_Rejected_Time_Dim_ID
           ,TransferNumber
           ,TransferLine
           ,SendingStoreRejUser
		   ,Layby_Store_Dim_ID
           )
    VALUES (source.OCS_Fulfillment_Order_Dim_Id
           ,source.Sending_Store_Dim_Id
           ,source.Item_Dim_Id
           ,source.Sending_Store_Rejected_Date_Dim_ID
           ,source.Sending_Store_Rejected_Time_Dim_ID
           ,source.TransferNumber
           ,source.TransferLine
           ,source.SendingStoreRejUser
		   ,source.Layby_Store_Dim_ID
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_OCS_Fulfillment_Rejection_Trans_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
