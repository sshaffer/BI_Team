SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Customer_Item_Order_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Customer_Item_Order_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Customer_Item_Order_Day_Fact target
USING (
	SELECT 
		Order_Date_Dim_ID
		,Order_Time_Dim_ID
		,Customer_Dim_ID
		,Order_No
		,Item_Dim_ID
		,Order_Source_Dim_ID
		,Order_Type_Dim_ID
		,Delivery_Method_Dim_ID
		,Channel_Dim_ID
		,Collection_Store_Dim_ID
		,Time_Store_Acknowledged_Dim_ID
		,Time_Store_Contacted_Dim_ID
		,Time_Waiting_Dim_ID
		,Discount_Reason_Dim_ID
		,Store_Dim_ID
		,Order_Status_Code
		,SUM(Order_Qty) AS Order_Qty
		,SUM(Gross_Order_Value_Home) AS Gross_Order_Value_Home
		,SUM(Gross_Order_Value_Curr) AS Gross_Order_Value_Curr
		,SUM(Reserved_Qty) AS Reserved_Qty
		,SUM(Pending_Qty) AS Pending_Qty
		,SUM(Discount_Value_Home) AS Discount_Value_Home
		,SUM(Discount_Value_Curr) AS Discount_Value_Curr
		,SUM(Gift_Charge_Value_Home) AS Gift_Charge_Value_Home
		,SUM(Gift_Charge_Value_Curr) AS Gift_Charge_Value_Curr
		,SUM(Shipping_Charge_Value_Home) AS Shipping_Charge_Value_Home
		,SUM(Shipping_Charge_Value_Curr) AS Shipping_Charge_Value_Curr
		,SUM(VAT_Value_Home) AS VAT_Value_Home
		,SUM(VAT_Value_Curr) AS VAT_Value_Curr
		,SUM(Goodwill_Value_Home) AS Goodwill_Value_Home
		,SUM(Goodwill_Value_Curr) AS Goodwill_Value_Curr
		,SUM(Goodwill_Discount_Value_Home) AS Goodwill_Discount_Value_Home
		,SUM(Goodwill_Discount_Value_Curr) AS Goodwill_Discount_Value_Curr
		,SUM(Net_Value_Home) AS Net_Value_Home
		,SUM(Net_Value_Curr) AS Net_Value_Curr
		,Date_Received_Dim_ID
	FROM Dune_Data_Warehouse_Staging..Customer_Item_Order_Day_Fact
	GROUP BY
		Order_Date_Dim_ID
		,Order_Time_Dim_ID
		,Customer_Dim_ID
		,Order_No
		,Item_Dim_ID
		,Order_Source_Dim_ID
		,Order_Type_Dim_ID
		,Delivery_Method_Dim_ID
		,Channel_Dim_ID
		,Collection_Store_Dim_ID
		,Time_Store_Acknowledged_Dim_ID
		,Time_Store_Contacted_Dim_ID
		,Time_Waiting_Dim_ID
		,Discount_Reason_Dim_ID
		,Order_Status_Code
		,Date_Received_Dim_ID
		,Store_Dim_ID
) source
ON source.Order_Date_Dim_ID = target.Order_Date_Dim_ID
AND source.Order_Time_Dim_ID = target.Order_Time_Dim_ID
AND source.Customer_Dim_ID = target.Customer_Dim_ID
AND source.Order_No = target.Order_No
AND source.Item_Dim_ID = target.Item_Dim_ID
AND source.Delivery_Method_Dim_ID = target.Delivery_Method_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Order_Source_Dim_ID = source.Order_Source_Dim_ID
	,Order_Type_Dim_ID = source.Order_Type_Dim_ID
	,Delivery_Method_Dim_ID = source.Delivery_Method_Dim_ID
	,Channel_Dim_ID = source.Channel_Dim_ID
	,Collection_Store_Dim_ID = source.Collection_Store_Dim_ID
	,Time_Store_Acknowledged_Dim_ID = source.Time_Store_Acknowledged_Dim_ID
	,Time_Store_Contacted_Dim_ID = source.Time_Store_Contacted_Dim_ID
	,Time_Waiting_Dim_ID = source.Time_Waiting_Dim_ID
	,Discount_Reason_Dim_ID = source.Discount_Reason_Dim_ID
	,Store_Dim_ID = source.Store_Dim_ID
	,Order_Status_Code = source.Order_Status_Code
	,Order_Qty = source.Order_Qty
	,Gross_Order_Value_Home = source.Gross_Order_Value_Home
	,Gross_Order_Value_Curr = source.Gross_Order_Value_Curr
	,Reserved_Qty = source.Reserved_Qty
	,Pending_Qty = source.Pending_Qty
	,Discount_Value_Home = source.Discount_Value_Home
	,Discount_Value_Curr = source.Discount_Value_Curr
	,Gift_Charge_Value_Home = source.Gift_Charge_Value_Home
	,Gift_Charge_Value_Curr = source.Gift_Charge_Value_Curr
	,Shipping_Charge_Value_Home = source.Shipping_Charge_Value_Home
	,Shipping_Charge_Value_Curr = source.Shipping_Charge_Value_Curr
	,VAT_Value_Home = source.VAT_Value_Home
	,VAT_Value_Curr = source.VAT_Value_Curr
	,Goodwill_Value_Home = source.Goodwill_Value_Home
	,Goodwill_Value_Curr = source.Goodwill_Value_Curr
	,Goodwill_Discount_Value_Home = source.Goodwill_Discount_Value_Home
	,Goodwill_Discount_Value_Curr = source.Goodwill_Discount_Value_Curr
	,Net_Value_Home = source.Net_Value_Home
	,Net_Value_Curr = source.Net_Value_Curr
	,Date_Received_Dim_ID = source.Date_Received_Dim_ID
WHEN NOT MATCHED THEN
INSERT (
	Order_Date_Dim_ID
	,Order_Time_Dim_ID
	,Customer_Dim_ID
	,Order_No
	,Item_Dim_ID
	,Order_Source_Dim_ID
	,Order_Type_Dim_ID
	,Delivery_Method_Dim_ID
	,Channel_Dim_ID
	,Collection_Store_Dim_ID
	,Time_Store_Acknowledged_Dim_ID
	,Time_Store_Contacted_Dim_ID
	,Time_Waiting_Dim_ID
	,Discount_Reason_Dim_ID
	,Store_Dim_ID
	,Order_Status_Code
	,Order_Qty
	,Gross_Order_Value_Home
	,Gross_Order_Value_Curr
	,Reserved_Qty
	,Pending_Qty
	,Discount_Value_Home
	,Discount_Value_Curr
	,Gift_Charge_Value_Home
	,Gift_Charge_Value_Curr
	,Shipping_Charge_Value_Home
	,Shipping_Charge_Value_Curr
	,VAT_Value_Home
	,VAT_Value_Curr
	,Goodwill_Value_Home
	,Goodwill_Value_Curr
	,Goodwill_Discount_Value_Home
	,Goodwill_Discount_Value_Curr
	,Net_Value_Home
	,Net_Value_Curr
	,Date_Received_Dim_ID
) VALUES (
	source.Order_Date_Dim_ID
	,source.Order_Time_Dim_ID
	,source.Customer_Dim_ID
	,source.Order_No
	,source.Item_Dim_ID
	,source.Order_Source_Dim_ID
	,source.Order_Type_Dim_ID
	,source.Delivery_Method_Dim_ID
	,source.Channel_Dim_ID
	,source.Collection_Store_Dim_ID
	,source.Time_Store_Acknowledged_Dim_ID
	,source.Time_Store_Contacted_Dim_ID
	,source.Time_Waiting_Dim_ID
	,source.Discount_Reason_Dim_ID
	,source.Store_Dim_ID
	,source.Order_Status_Code
	,source.Order_Qty
	,source.Gross_Order_Value_Home
	,source.Gross_Order_Value_Curr
	,source.Reserved_Qty
	,source.Pending_Qty
	,source.Discount_Value_Home
	,source.Discount_Value_Curr
	,source.Gift_Charge_Value_Home
	,source.Gift_Charge_Value_Curr
	,source.Shipping_Charge_Value_Home
	,source.Shipping_Charge_Value_Curr
	,source.VAT_Value_Home
	,source.VAT_Value_Curr
	,source.Goodwill_Value_Home
	,source.Goodwill_Value_Curr
	,source.Goodwill_Discount_Value_Home
	,source.Goodwill_Discount_Value_Curr
	,source.Net_Value_Home
	,source.Net_Value_Curr
	,source.Date_Received_Dim_ID
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Customer_Item_Order_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;



EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
