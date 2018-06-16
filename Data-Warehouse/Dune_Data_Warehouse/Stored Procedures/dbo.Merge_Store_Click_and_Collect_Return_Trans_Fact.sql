SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Merge_Store_Click_and_Collect_Return_Trans_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Store_Click_and_Collect_Return_Trans_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Store_Click_and_Collect_Return_Trans_Fact target
USING (
	SELECT
	    Sale_Commission_Date_Dim_ID
	   ,Time_Dim_ID
	   ,Store_Dim_ID
	   ,Item_Dim_ID
	   ,Return_Reason_Dim_ID
	   ,SUM(Return_Value) Return_Value
	   ,SUM(Return_Qty) Return_Qty
	FROM Dune_Data_Warehouse_Staging..Store_Click_and_Collect_Return_Trans_Fact
	GROUP BY 
		Sale_Commission_Date_Dim_ID
	   ,Time_Dim_ID
	   ,Store_Dim_ID
	   ,Item_Dim_ID
	   ,Return_Reason_Dim_ID
) source
	ON source.Sale_Commission_Date_Dim_ID = target.Sale_Commission_Date_Dim_ID
	AND source.Time_Dim_ID = target.Time_Dim_ID
	AND source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Item_Dim_ID = target.Item_Dim_ID
	AND source.Return_Reason_Dim_ID = target.Return_Reason_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Return_Value = source.Return_Value,
	Return_Qty = source.Return_Qty
WHEN NOT MATCHED THEN
INSERT (
	Sale_Commission_Date_Dim_ID,
	Time_Dim_ID,
	Store_Dim_ID,
	Item_Dim_ID,
	Return_Reason_Dim_ID,
	Return_Value,
	Return_Qty
) VALUES (
	source.Sale_Commission_Date_Dim_ID,
	source.Time_Dim_ID,
	source.Store_Dim_ID,
	source.Item_Dim_ID,
	source.Return_Reason_Dim_ID,
	source.Return_Value,
	source.Return_Qty
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Store_Click_and_Collect_Return_Trans_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;


GO
