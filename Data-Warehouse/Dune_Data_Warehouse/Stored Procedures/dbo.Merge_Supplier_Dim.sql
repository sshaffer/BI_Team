SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC dbo.Merge_Supplier_Dim
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
EXEC dbo.Log_Start @Source, 'Merge_Supplier_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Supplier_Dim target
USING Dune_Data_Warehouse_Staging..Supplier_Dim source
ON source.Supplier_Dim_ID = target.Supplier_Dim_ID
WHEN MATCHED THEN
UPDATE SET 
	Supplier_Name = source.Supplier_Name
	,Supplier_Contact_Name = source.Supplier_Contact_Name
	,Supplier_Address_Line_1 = source.Supplier_Address_Line_1
	,Supplier_Address_Line_2 = source.Supplier_Address_Line_2
	,Supplier_City = source.Supplier_City
	,Supplier_State = source.Supplier_State
	,Supplier_Post_Code = source.Supplier_Post_Code
	,Country_Dim_ID = source.Country_Dim_ID
	,Contact_Telephone_No = source.Contact_Telephone_No
	,Default_Terms_Description = source.Default_Terms_Description
	,Default_Terms_Code = source.Default_Terms_Code
	,Expected_Lead_Time = source.Expected_Lead_Time
	,Factory_Name = source.Factory_Name
	,Factory_Address_Line_1 = source.Factory_Address_Line_1
	,Factory_Address_Line_2 = source.Factory_Address_Line_2
	,Factory_City = source.Factory_City
	,Factory_State = source.Factory_State
	,Factory_Post_Code = source.Factory_Post_Code
	,Factory_Country_Name = source.Factory_Country_Name
	,FOB_Point = source.FOB_Point
	,FOB_Terms_Description = source.FOB_Terms_Description
	,FOB_Terms_Code = source.FOB_Terms_Code
WHEN NOT MATCHED THEN
INSERT (
	Supplier_Dim_ID
	,Supplier_Code
	,Supplier_Name
	,Supplier_Contact_Name
	,Supplier_Address_Line_1
	,Supplier_Address_Line_2
	,Supplier_City
	,Supplier_State
	,Supplier_Post_Code
	,Country_Dim_ID
	,Contact_Telephone_No
	,Default_Terms_Description
	,Default_Terms_Code
	,Expected_Lead_Time
	,Factory_Name
	,Factory_Address_Line_1
	,Factory_Address_Line_2
	,Factory_City
	,Factory_State
	,Factory_Post_Code
	,Factory_Country_Name
	,FOB_Point
	,FOB_Terms_Description
	,FOB_Terms_Code
) VALUES (
	source.Supplier_Dim_ID
	,source.Supplier_Code
	,source.Supplier_Name
	,source.Supplier_Contact_Name
	,source.Supplier_Address_Line_1
	,source.Supplier_Address_Line_2
	,source.Supplier_City
	,source.Supplier_State
	,source.Supplier_Post_Code
	,source.Country_Dim_ID
	,source.Contact_Telephone_No
	,source.Default_Terms_Description
	,source.Default_Terms_Code
	,source.Expected_Lead_Time
	,source.Factory_Name
	,source.Factory_Address_Line_1
	,source.Factory_Address_Line_2
	,source.Factory_City
	,source.Factory_State
	,source.Factory_Post_Code
	,source.Factory_Country_Name
	,source.FOB_Point
	,source.FOB_Terms_Description
	,source.FOB_Terms_Code
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Supplier_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
