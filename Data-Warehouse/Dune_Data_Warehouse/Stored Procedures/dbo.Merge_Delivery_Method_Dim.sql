SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC dbo.Merge_Delivery_Method_Dim
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
EXEC dbo.Log_Start @Source, 'Merge_Delivery_Method_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Delivery_Method_Dim target
USING Dune_Data_Warehouse_Staging..Delivery_Method_Dim source
ON source.Delivery_Method_Dim_ID = target.Delivery_Method_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Carrier_Code = source.Carrier_Code,
	Delivery_Method_Desc = source.Delivery_Method_Desc,
	Additional_Charge_to_Customer = source.Additional_Charge_to_Customer
WHEN NOT MATCHED THEN
INSERT (
	Delivery_Method_Dim_ID
	,Delivery_Method_Code
	,Carrier_Code
	,Delivery_Method_Desc
	,Additional_Charge_to_Customer
) VALUES (
	source.Delivery_Method_Dim_ID 
	,source.Delivery_Method_Code
	,source.Carrier_Code 
	,source.Delivery_Method_Desc
	,source.Additional_Charge_to_Customer
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Delivery_Method_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;




EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
