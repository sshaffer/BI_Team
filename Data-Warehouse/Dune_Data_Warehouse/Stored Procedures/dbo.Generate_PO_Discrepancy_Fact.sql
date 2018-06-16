SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_PO_Discrepancy_Fact]
	@Source VARCHAR(100),
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
EXEC dbo.Log_Start @Source, 'Generate_PO_Discrepancy_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY
BEGIN TRANSACTION

/* Truncate Table */
TRUNCATE TABLE dbo.PO_Discrepancy_Fact

/* Insert data */
INSERT INTO dbo.PO_Discrepancy_Fact (
	Calendar_Dim_ID
	,Item_Dim_ID
	,Purchase_Order_No
	,Purchase_Order_Sequence_No
	,PO_Discrepancy_Qty
	,PO_Discrepancy_Component_Qty
	,PO_Discrepancy_Cost_Value
	,PO_Discrepancy_Selling_Value
	,Store_Dim_ID
)
SELECT
	rec.Calendar_Dim_ID
	,rec.Item_Dim_ID
	,rec.Purchase_Order_No
	,rec.Purchase_Order_Sequence_No
	,rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0) AS PO_Descrepency_Qty
	,rec.PO_Receipt_Component_Qty - COALESCE(cur.Purchase_Order_Component_Qty,0) AS PO_Descrepency_Component_Qty
	,CASE 
		WHEN cur.Landed_Cost IS NULL THEN 0
		ELSE cur.Landed_Cost * (rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0))
	END AS PO_Descrepency_Cost_Value
	,CASE	
		WHEN cur.Retail_Price IS NULL THEN 0
		ELSE Cur.Retail_Price * (rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0))
	END AS PO_Descrepency_Selling_Value
	,rec.Store_Dim_ID
FROM dbo.PO_Receipt_Fact rec
LEFT JOIN dbo.PO_Curr_Fact cur
ON cur.Purchase_Order_No = rec.Purchase_Order_No
AND cur.Purchase_Order_Sequence_No = rec.Purchase_Order_Sequence_No
WHERE cur.Purchase_Order_Quantity <> rec.PO_Receipt_Qty

UNION  

SELECT
	rec.Calendar_Dim_ID
	,cur.Item_Dim_ID
	,rec.Purchase_Order_No
	,rec.Purchase_Order_Sequence_No
	,rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0) AS PO_Descrepency_Qty
	,rec.PO_Receipt_Component_Qty - COALESCE(cur.Purchase_Order_Component_Qty,0) AS PO_Descrepency_Component_Qty
	,CASE 
		WHEN cur.Landed_Cost IS NULL THEN 0
		ELSE cur.Landed_Cost * (rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0))
	END AS PO_Descrepency_Cost_Value
	,CASE	
		WHEN cur.Retail_Price IS NULL THEN 0
		ELSE Cur.Retail_Price * (rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0))
	END AS PO_Descrepency_Selling_Value
	,rec.Store_Dim_ID
FROM PO_Receipt_Fact rec
JOIN PO_Curr_Fact cur
ON rec.Purchase_Order_No = cur.Purchase_Order_No
AND rec.Purchase_Order_Sequence_No = cur.Purchase_Order_Sequence_No
WHERE rec.Item_Dim_ID <> cur.Item_Dim_ID

UNION 

SELECT
	rec.Calendar_Dim_ID
	,rec.Item_Dim_ID
	,rec.Purchase_Order_No
	,rec.Purchase_Order_Sequence_No
	,rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0) AS PO_Descrepency_Qty
	,rec.PO_Receipt_Component_Qty - COALESCE(cur.Purchase_Order_Component_Qty,0) AS PO_Descrepency_Component_Qty
	,CASE 
		WHEN cur.Landed_Cost IS NULL THEN 0
		ELSE cur.Landed_Cost * (rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0))
	END AS PO_Descrepency_Cost_Value
	,CASE	
		WHEN cur.Retail_Price IS NULL THEN 0
		ELSE Cur.Retail_Price * (rec.PO_Receipt_Qty - COALESCE(cur.Purchase_Order_Quantity,0))
	END AS PO_Descrepency_Selling_Value
	,rec.Store_Dim_ID
FROM PO_Receipt_Fact rec
JOIN PO_Curr_Fact cur
ON rec.Purchase_Order_No = cur.Purchase_Order_No
AND rec.Purchase_Order_Sequence_No = cur.Purchase_Order_Sequence_No
WHERE rec.Item_Dim_ID <> cur.Item_Dim_ID


SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_PO_Discrepancy_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
