SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Customer_Item_Backorder_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Customer_Item_Backorder_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


MERGE INTO dbo.Customer_Item_Backorder_Day_Fact target
USING (
	SELECT
	Backorder_Date_Dim_ID
	,Order_No
	,Customer_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Channel_Dim_ID
	,Order_Source_Dim_ID
	,Order_Type_Dim_ID
	,Currency_Dim_ID
	,SUM(Backorder_Qty) AS Backorder_Qty
	,SUM(Backorder_Value_Home) AS Backorder_Value_Home
	,SUM(Backorder_Value_Curr) AS Backorder_Value_Curr
	,SUM(Backorder_Cost_Value_Home) AS Backorder_Cost_Value_Home
	,SUM(Backorder_Cost_Value_Curr) AS Backorder_Cost_Value_Curr
	,SUM(Backorder_VAT_Value_Home) AS Backorder_VAT_Value_Home
	,SUM(Backorder_VAT_Value_Curr) AS Backorder_VAT_Value_Curr
	FROM Dune_Data_Warehouse_Staging.dbo.Customer_Item_BackOrder_Day_Fact
	GROUP BY 
		Backorder_Date_Dim_ID
		,Order_No
		,Customer_Dim_ID
		,Item_Dim_ID
		,Item_Dim_ID
		,Store_Dim_ID
		,Channel_Dim_ID
		,Order_Source_Dim_ID
		,Order_Type_Dim_ID
		,Currency_Dim_ID
) source
ON source.Backorder_Date_Dim_ID = target.Backorder_Date_Dim_ID
AND source.Order_No = target.Order_No
AND source.Customer_Dim_ID = target.Customer_Dim_ID
AND source.Item_Dim_ID = target.Item_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Store_Dim_ID = source.Store_Dim_ID
	,Channel_Dim_ID = source.Channel_Dim_ID
	,Order_Source_Dim_ID = source.Order_Source_Dim_ID
	,Order_Type_Dim_ID = source.Order_Type_Dim_ID
	,Currency_Dim_ID = source.Currency_Dim_ID
	,Backorder_Qty = source.Backorder_Qty
	,Backorder_Value_Home = source.Backorder_Value_Home
	,Backorder_Value_Curr = source.Backorder_Value_Curr
	,Backorder_Cost_Value_Home = source.Backorder_Cost_Value_Home
	,Backorder_Cost_Value_Curr = source.Backorder_Cost_Value_Curr
	,Backorder_VAT_Value_Home = source.Backorder_VAT_Value_Home
	,Backorder_VAT_Value_Curr = source.Backorder_VAT_Value_Curr
WHEN NOT MATCHED THEN
INSERT (
	Backorder_Date_Dim_ID
	,Order_No
	,Customer_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Channel_Dim_ID
	,Order_Source_Dim_ID
	,Order_Type_Dim_ID
	,Currency_Dim_ID
	,Backorder_Qty
	,Backorder_Value_Home
	,Backorder_Value_Curr
	,Backorder_Cost_Value_Home
	,Backorder_Cost_Value_Curr
	,Backorder_VAT_Value_Home
	,Backorder_VAT_Value_Curr
) VALUES (
	source.Backorder_Date_Dim_ID
	,source.Order_No
	,source.Customer_Dim_ID
	,source.Item_Dim_ID
	,source.Store_Dim_ID
	,source.Channel_Dim_ID
	,source.Order_Source_Dim_ID
	,source.Order_Type_Dim_ID
	,source.Currency_Dim_ID
	,source.Backorder_Qty
	,source.Backorder_Value_Home
	,source.Backorder_Value_Curr
	,source.Backorder_Cost_Value_Home
	,source.Backorder_Cost_Value_Curr
	,source.Backorder_VAT_Value_Home
	,source.Backorder_VAT_Value_Curr
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Customer_Item_Backorder_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;



EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
