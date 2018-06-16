SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Customer_Item_Ship_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Customer_Item_Ship_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Customer_Item_Ship_Day_Fact target
USING (
	SELECT 
	Ship_Date_Dim_ID
	,Order_No
	,Item_Dim_ID
	,Customer_Dim_ID
	,Store_Dim_ID
	,Order_Source_Dim_ID
	,Delivery_Method_Dim_ID
	,Order_Type_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
	,SUM(Ship_Qty) AS Ship_Qty
	,SUM(Cost_Value_Home) AS Cost_Value_Home
	,SUM(Cost_Value_Curr) AS Cost_Value_Curr
	,SUM(Shipping_Charge_Home) AS Shipping_Charge_Home
	,SUM(Shipping_Charge_Curr) AS Shipping_Charge_Curr
FROM Dune_Data_Warehouse_Staging.dbo.Customer_Item_Ship_Day_Fact f
GROUP BY
	Ship_Date_Dim_ID
	,Order_No
	,Item_Dim_ID
	,Customer_Dim_ID
	,Store_Dim_ID
	,Order_Source_Dim_ID
	,Delivery_Method_Dim_ID
	,Order_Type_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
) source
ON source.Ship_Date_Dim_ID = target.Ship_Date_Dim_ID
AND source.Order_No = target.Order_No
AND source.Item_Dim_ID = target.Item_Dim_ID
AND source.Customer_Dim_ID = target.Customer_Dim_ID
AND source.Delivery_Method_Dim_ID = target.Delivery_Method_Dim_ID
WHEN MATCHED THEN
UPDATE SET 
	Store_Dim_ID = source.Store_Dim_ID
	,Order_Source_Dim_ID = source.Order_Source_Dim_ID
	,Delivery_Method_Dim_ID = source.Delivery_Method_Dim_ID
	,Order_Type_Dim_ID = source.Order_Type_Dim_ID
	,Channel_Dim_ID = source.Channel_Dim_ID
	,Currency_Dim_ID = source.Currency_Dim_ID
	,Ship_Qty = source.Ship_Qty
	,Cost_Value_Home = source.Cost_Value_Home
	,Cost_Value_Curr = source.Cost_Value_Curr
	,Shipping_Charge_Home = source.Shipping_Charge_Home
	,Shipping_Charge_Curr = source.Shipping_Charge_Curr
WHEN NOT MATCHED THEN
INSERT (
	Ship_Date_Dim_ID
	,Order_No
	,Item_Dim_ID
	,Customer_Dim_ID
	,Store_Dim_ID
	,Order_Source_Dim_ID
	,Delivery_Method_Dim_ID
	,Order_Type_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Ship_Qty
	,Cost_Value_Home
	,Cost_Value_Curr
	,Shipping_Charge_Home
	,Shipping_Charge_Curr
) VALUES (
	source.Ship_Date_Dim_ID
	,source.Order_No
	,source.Item_Dim_ID
	,source.Customer_Dim_ID
	,source.Store_Dim_ID
	,source.Order_Source_Dim_ID
	,source.Delivery_Method_Dim_ID
	,source.Order_Type_Dim_ID
	,source.Channel_Dim_ID
	,source.Currency_Dim_ID
	,source.Ship_Qty
	,source.Cost_Value_Home
	,source.Cost_Value_Curr
	,source.Shipping_Charge_Home
	,source.Shipping_Charge_Curr
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Customer_Item_Ship_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
