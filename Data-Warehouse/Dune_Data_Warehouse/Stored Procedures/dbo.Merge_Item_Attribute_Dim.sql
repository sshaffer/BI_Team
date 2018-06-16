SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Item_Attribute_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_Item_Attribute_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Item_Attribute_Dim target
USING Dune_Data_Warehouse_Staging..Item_Attribute_Dim source 
	ON source.Item_Attribute_Dim_ID = target.Item_Attribute_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Attribute_Category_Code = source.Attribute_Category_Code
	,Attribute_Category_Name = source.Attribute_Category_Name
	,Attribute_Value_ID = source.Attribute_Value_ID
	,Attribute_Value_Name = source.Attribute_Value_Name
WHEN NOT MATCHED THEN	
INSERT(
	Item_Attribute_Dim_ID
	,Item_Dim_ID
	,Attribute_Category_Code
	,Attribute_Category_Name
	,Attribute_Value_ID
	,Attribute_Value_Name
) VALUES (
	 source.Item_Attribute_Dim_ID
	,source.Item_Dim_ID
	,source.Attribute_Category_Code
	,source.Attribute_Category_Name
	,source.Attribute_Value_ID
	,source.Attribute_Value_Name
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Item_Attribute_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
