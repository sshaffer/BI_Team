SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_PO_Receipt_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_PO_Receipt_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 
DECLARE @Calendar_Dim_ID SMALLINT = (SELECT Calendar_Dim_ID FROM Calendar_Dim WHERE Relative_Day = 0);

/* Tidy up */
DELETE FROM dbo.PO_Receipt_Fact
WHERE Calendar_Dim_ID = @Calendar_Dim_ID;

MERGE dbo.PO_Receipt_Fact target
USING (
	SELECT
		Calendar_Dim_ID
		,Purchase_Order_No
		,Purchase_Order_Sequence_No
		,Item_Dim_ID
		,Store_Dim_ID
		,SUM(PO_Receipt_Qty) PO_Receipt_Qty
		,SUM(PO_Receipt_Component_Qty) PO_Receipt_Component_Qty
		,SUM(PO_Receipt_Cost_Value) PO_Receipt_Cost_Value
		,SUM(PO_Receipt_Selling_Value) PO_Receipt_Selling_Value
	FROM Dune_Data_Warehouse_Staging..PO_Receipt_Fact
	GROUP BY 
		Calendar_Dim_ID
		,Purchase_Order_No
		,Purchase_Order_Sequence_No
		,Item_Dim_ID
		,Store_Dim_ID
) source
	ON  source.Purchase_Order_No = target.Purchase_Order_No
	AND source.Purchase_Order_Sequence_No = target.Purchase_Order_Sequence_No
	AND source.Item_Dim_ID = target.Item_Dim_ID
	AND source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Calendar_Dim_ID = target.Calendar_Dim_ID
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Dim_ID
	,Purchase_Order_No
	,Purchase_Order_Sequence_No
	,Item_Dim_ID
	,PO_Receipt_Qty
	,PO_Receipt_Cost_Value
	,PO_Receipt_Selling_Value
	,PO_Receipt_Component_Qty
	,Store_Dim_ID
) VALUES (
	source.Calendar_Dim_ID
	,source.Purchase_Order_No
	,source.Purchase_Order_Sequence_No
	,source.Item_Dim_ID
	,source.PO_Receipt_Qty
	,source.PO_Receipt_Cost_Value
	,source.PO_Receipt_Selling_Value
	,source.PO_Receipt_Component_Qty
	,source.Store_Dim_ID
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_PO_Receipt_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
