SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Flash_Sales_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Flash_Sales_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Flash_Sales_Day_Fact target
USING Dune_Data_Warehouse_Staging..Flash_Sales_Day_Fact source
	ON source.Calendar_Dim_ID = target.Calendar_Dim_ID
	AND source.Store_Dim_ID = target.Store_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Sale_Qty = source.Sale_Qty
	,Sale_Value_Home = source.Sale_Value_Home
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Dim_ID,
	Store_Dim_ID,
	Sale_Qty,
	Sale_Value_Home
) VALUES (
	source.Calendar_Dim_ID,
	source.Store_Dim_ID,
	source.Sale_Qty,
	source.Sale_Value_Home
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Flash_Sales_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
