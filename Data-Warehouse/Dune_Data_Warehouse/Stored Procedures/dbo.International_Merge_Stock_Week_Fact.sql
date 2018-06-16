SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[International_Merge_Stock_Week_Fact]
	@Source VARCHAR(MAX),
	@Log_ID BIGINT,
	@Cache BIT,
	@Process BIT
	
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE (
	val BIGINT
)
INSERT INTO @return
EXEC dbo.Log_Start @Source, 'International_Insert_Stock_Week_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION

MERGE INTO dbo.International_Stock_Week_Fact TARGET
USING (
	SELECT
		Calendar_Week_Dim_ID ,
		International_Partner_Dim_ID ,
		Item_Dim_ID ,
		SUM(Stock_Qty) Stock_Qty
	FROM Dune_Data_Warehouse_Staging..International_Stock_Week_Fact
	GROUP BY Calendar_Week_Dim_ID, International_Partner_Dim_ID, Item_Dim_ID
) SOURCE
	ON SOURCE.Calendar_Week_Dim_ID = TARGET.Calendar_Week_Dim_ID
	AND SOURCE.International_Partner_Dim_ID = TARGET.International_Partner_Dim_ID
	AND SOURCE.Item_Dim_ID = TARGET.Item_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Stock_Qty = SOURCE.Stock_Qty
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Week_Dim_ID,
	International_Partner_Dim_ID,
	Item_Dim_ID,
	Stock_Qty
)
VALUES (
	Calendar_Week_Dim_ID,
	SOURCE.International_Partner_Dim_ID,
	SOURCE.Item_Dim_ID,
	SOURCE.Stock_Qty
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.International_Insert_Stock_Week_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
