SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC dbo.Merge_Customer_Ship_Address_Dim
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
EXEC dbo.Log_Start @Source, 'Merge_Customer_Ship_Address_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


MERGE INTO dbo.Customer_Ship_Address_Dim target
USING Dune_Data_Warehouse_Staging..Customer_Ship_Address_Dim source
ON source.Customer_Ship_Address_Dim_ID = target.Customer_Ship_Address_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Ship_Address_Line_1 = source.Ship_Address_Line_1
	,Ship_Address_Line_2 = source.Ship_Address_Line_2
	,Ship_City = source.Ship_City
	,Ship_State = source.Ship_State
	,Ship_Postal_Code = source.Ship_Postal_Code
	,Ship_Telephone_No = source.Ship_Telephone_No
	,Country_Dim_ID = source.Country_Dim_ID
WHEN NOT MATCHED THEN
INSERT (
	Customer_Ship_Address_Dim_ID
	,Customer_Dim_ID
	,Ship_Address_Sequence_No
	,Ship_Address_Line_1
	,Ship_Address_Line_2
	,Ship_City
	,Ship_State
	,Ship_Postal_Code
	,Ship_Telephone_No
	,Country_Dim_ID
) VALUES (
	source.Customer_Ship_Address_Dim_ID
	,source.Customer_Dim_ID
	,source.Ship_Address_Sequence_No
	,source.Ship_Address_Line_1
	,source.Ship_Address_Line_2
	,source.Ship_City
	,source.Ship_State
	,source.Ship_Postal_Code
	,source.Ship_Telephone_No
	,source.Country_Dim_ID
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Customer_Ship_Address_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;




EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
