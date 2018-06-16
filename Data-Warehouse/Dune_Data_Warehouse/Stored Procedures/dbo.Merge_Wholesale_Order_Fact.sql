
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Wholesale_Order_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Wholesale_Order_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

DECLARE @Yesteday DATE = (SELECT Calendar_Date FROM Dune_Data_Warehouse.dbo.Calendar_Dim WHERE Relative_Day = -1),
		@TheFuture DATE = '2025-01-01',
		@Today DATE = (SELECT Calendar_Date FROM Dune_Data_Warehouse.dbo.Calendar_Dim WHERE Relative_Day = 0)
		;

BEGIN TRANSACTION;

INSERT INTO Dune_Data_Warehouse.dbo.Wholesale_Order_Fact
        ( 
		Wholesale_Order_Dim_ID
        ,From_Date
        ,To_Date
        ,Current_Flag
        ,Sale_Order_Created_Date_Dim_ID
        ,Sale_Order_Line_Created_Date_Dim_ID
        ,Optional_Request_to_Ship_Date_Dim_ID
        ,Order_Type_Dim_ID
        ,Order_Source_Dim_ID
        ,Channel_Dim_ID
        ,Currency_Dim_ID
        ,Sales_Order_Received_Date_Dim_ID
        ,Customer_Dim_ID
        ,Store_Dim_ID
        ,Delivery_Method_Dim_ID
        ,Sales_Order_Actual_Ship_Date_Dim_ID
        ,Item_Dim_ID
        ,Sales_Order_Qty
        ,Sales_Order_Reserved_Qty
        ,Sales_Order_Allocated_Qty
        ,Sales_Order_Shipped_Qty
        ,Sales_Order_Backorder_Qty
        ,Sales_Order_Cancelled_Qty
        ,Entered_Unit_Price_Home
        ,Entered_Unit_Price_Curr
        ,VAT_Unit_Price_Home
        ,VAT_Unit_Price_Curr
        ,Additional_Shipping_Charge_Home
        ,Additional_Shipping_Charge_Curr
        ,Tax_Amount_Home
        ,Tax_Amount_Curr
        ,Cancellation_Reason_Code_Dim_ID
        ,Other_Charge_Home
        ,Other_Charge_Curr
        ,Other_Tax_Home
        ,Other_Tax_Curr
        ,Line_Message
        ,Purchase_Order_Dim_ID
		,Order_Status
		,Country_Code
		,Carraige_Sequence
		,Carraige_Routing_Method
		,Carraige_Value
		,International_Charge_Sequence
		,International_Charge_Routing_Method
		,International_Charge_Value
		,Licence_Fee_Sequence
		,Licence_Fee_Routing_Method
		,Licence_Fee_Value
		,Apply_Licence_Fee
		,Include_Licence_Fee_In_Cost
		,Retail_Minus_Cost_Plus
		,Retail_Factor
		,Licence_Fee_Per_Unit
        )
SELECT 
		Wholesale_Order_Dim_ID
        ,@Today /* From_Date */
        ,@TheFuture /* To_Date */
        ,1 /* Current_Flag */ 
        ,Sale_Order_Created_Date_Dim_ID
        ,Sale_Order_Line_Created_Date_Dim_ID
        ,Optional_Request_to_Ship_Date_Dim_ID
        ,Order_Type_Dim_ID
        ,Order_Source_Dim_ID
        ,Channel_Dim_ID
        ,Currency_Dim_ID
        ,Sales_Order_Received_Date_Dim_ID
        ,Customer_Dim_ID
        ,Store_Dim_ID
        ,Delivery_Method_Dim_ID
        ,Sales_Order_Actual_Ship_Date_Dim_ID
        ,Item_Dim_ID
        ,Sales_Order_Qty
        ,Sales_Order_Reserved_Qty
        ,Sales_Order_Allocated_Qty
        ,Sales_Order_Shipped_Qty
        ,Sales_Order_Backorder_Qty
        ,Sales_Order_Cancelled_Qty
        ,Entered_Unit_Price_Home
        ,Entered_Unit_Price_Curr
        ,VAT_Unit_Price_Home
        ,VAT_Unit_Price_Curr
        ,Additional_Shipping_Charge_Home
        ,Additional_Shipping_Charge_Curr
        ,Tax_Amount_Home
        ,Tax_Amount_Curr
        ,Cancellation_Reason_Code_Dim_ID
        ,Other_Charge_Home
        ,Other_Charge_Curr
        ,Other_Tax_Home
        ,Other_Tax_Curr
        ,Line_Message
        ,Purchase_Order_Dim_ID
		,Order_Status
		,Country_Code
		,Carraige_Sequence
		,Carraige_Routing_Method
		,Carraige_Value
		,International_Charge_Sequence
		,International_Charge_Routing_Method
		,International_Charge_Value
		,Licence_Fee_Sequence
		,Licence_Fee_Routing_Method
		,Licence_Fee_Value
		,Apply_Licence_Fee
		,Include_Licence_In_Cost
		,Retail_Minus_Cost_Plus
		,Retail_Factor
		,Licence_Fee_Per_Unit
FROM (
MERGE INTO Dune_Data_Warehouse.dbo.Wholesale_Order_Fact_UpdateView target
USING (
	SELECT
		d.Sales_Order_Number
		,d.Sales_Order_Line_Number
		,f.Wholesale_Order_Dim_ID
		,f.Sale_Order_Created_Date_Dim_ID
		,f.Sale_Order_Line_Created_Date_Dim_ID
		,f.Optional_Request_to_Ship_Date_Dim_ID
		,f.Order_Type_Dim_ID
		,f.Order_Source_Dim_ID
		,f.Channel_Dim_ID
		,f.Currency_Dim_ID
		,f.Sales_Order_Received_Date_Dim_ID
		,f.Customer_Dim_ID
		,f.Store_Dim_ID
		,f.Delivery_Method_Dim_ID
		,f.Sales_Order_Actual_Ship_Date_Dim_ID
		,f.Item_Dim_ID
		,f.Sales_Order_Qty
		,f.Sales_Order_Reserved_Qty
		,f.Sales_Order_Allocated_Qty
		,f.Sales_Order_Shipped_Qty
		,f.Sales_Order_Backorder_Qty
		,f.Sales_Order_Cancelled_Qty
		,f.Entered_Unit_Price_Home
		,f.Entered_Unit_Price_Curr
		,f.VAT_Unit_Price_Home
		,f.VAT_Unit_Price_Curr
		,f.Additional_Shipping_Charge_Home
		,f.Additional_Shipping_Charge_Curr
		,f.Tax_Amount_Home
		,f.Tax_Amount_Curr
		,f.Cancellation_Reason_Code_Dim_ID
		,f.Other_Charge_Home
		,f.Other_Charge_Curr
		,f.Other_Tax_Home
		,f.Other_Tax_Curr
		,f.Line_Message
		,f.Purchase_Order_Dim_ID
		,f.Order_Status
		,f.Country_Code
		,f.Carraige_Sequence
		,f.Carraige_Routing_Method
		,f.Carraige_Value
		,f.International_Charge_Sequence
		,f.International_Charge_Routing_Method
		,f.International_Charge_Value
		,f.Licence_Fee_Sequence
		,f.Licence_Fee_Routing_Method
		,f.Licence_Fee_Value
		,f.Apply_Licence_Fee
		,f.Include_Licence_In_Cost
		,f.Retail_Minus_Cost_Plus
		,f.Retail_Factor
		,f.Licence_Fee_Per_Unit
	FROM Dune_Data_Warehouse_Staging.dbo.Wholesale_Order_Fact f
	JOIN dbo.Wholesale_Order_Dim d
		ON d.Wholesale_Order_Dim_ID = f.Wholesale_Order_Dim_ID
) source
	ON source.Sales_Order_Number = target.Sales_Order_Number
	AND source.Sales_Order_Line_Number = target.Sales_Order_Line_Number
	AND @Today BETWEEN target.From_Date AND target.To_Date
WHEN MATCHED AND 
		(
		   source.Optional_Request_To_Ship_Date_Dim_ID <> target.Optional_Request_To_Ship_Date_Dim_ID
		   OR source.Order_Type_Dim_ID <> target.Order_Type_Dim_ID
		   OR source.Order_Source_Dim_ID <> target.Order_Source_Dim_ID
		   OR source.Channel_Dim_ID <> target.Channel_Dim_ID
		   OR source.Currency_Dim_ID <> target.Currency_Dim_ID
		   OR source.Sales_Order_Received_Date_Dim_ID <> target.Sales_Order_Received_Date_Dim_ID
		   OR source.Item_Dim_ID <> target.Item_Dim_ID
		   OR source.Purchase_Order_Dim_ID <> target.Purchase_Order_Dim_ID
		   OR source.Customer_Dim_ID <> target.Customer_Dim_ID
		   OR source.Store_Dim_ID <> target.Store_Dim_ID
		   OR source.Delivery_Method_Dim_ID <> target.Delivery_Method_Dim_ID
		   OR source.Sales_Order_Actual_Ship_Date_Dim_ID <> target.Sales_Order_Actual_Ship_Date_Dim_ID
		   OR source.Cancellation_Reason_Code_Dim_ID <> target.Cancellation_Reason_Code_Dim_ID
		   OR source.SALES_ORDER_QTY <> target.Sales_Order_Qty
		   OR source.SALES_ORDER_RESERVED_QTY <> target.Sales_Order_Reserved_Qty
		   OR source.SALES_ORDER_ALLOCATED_QTY <> target.Sales_Order_Allocated_Qty
		   OR source.SALES_ORDER_SHIPPED_QTY <> target.Sales_Order_Shipped_Qty
		   OR source.SALES_ORDER_BACKORDER_QTY <> target.Sales_Order_Backorder_Qty
		   OR source.SALES_ORDER_CANCELLED_QTY <> target.Sales_Order_Cancelled_Qty
		   OR source.ENTERED_UNIT_PRICE_HOME <> target.Entered_Unit_Price_Home
		   OR source.ENTERED_UNIT_PRICE_CURR <> target.Entered_Unit_Price_Curr
		   OR source.VAT_UNIT_PRICE_HOME <> target.VAT_Unit_Price_Home
		   OR source.VAT_UNIT_PRICE_CURR <> target.VAT_Unit_Price_Curr
		   OR source.ADDITIONAL_SHIPPING_CHARGE_HOME <> target.Additional_Shipping_Charge_Home
		   OR source.ADDITIONAL_SHIPPING_CHARGE_CURR <> target.Additional_Shipping_Charge_Curr
		   OR source.TAX_AMOUNT_HOME <> target.Tax_Amount_Home
		   OR source.TAX_AMOUNT_CURR <> target.Tax_Amount_Curr
		   OR source.OTHER_CHARGE_HOME <> target.Other_Charge_Home
		   OR source.OTHER_CHARGE_CURR <> target.Other_Charge_Curr
		   OR source.OTHER_TAX_HOME <> target.Other_Tax_Home
		   OR source.OTHER_TAX_CURR <> target.Other_Tax_Curr
		   OR source.LINE_MESSAGE <> target.Line_Message
		   OR source.ORDER_STATUS <> target.Order_Status
		   OR source.COUNTRY_CODE <> target.Country_Code
		   OR source.CARRAIGE_SEQUENCE <> target.Carraige_Sequence
		   OR source.CARRAIGE_ROUTING_METHOD <> target.Carraige_Routing_Method
		   OR source.CARRAIGE_VALUE <> target.Carraige_Value
		   OR source.INTERNATIONAL_CHARGE_SEQUENCE <> target.International_Charge_Sequence
		   OR source.INTERNATIONAL_CHARGE_ROUTING_METHOD <> target.International_Charge_Routing_Method
		   OR source.INTERNATIONAL_CHARGE_VALUE <> target.International_Charge_Value
		   OR source.LICENCE_FEE_SEQUENCE <> target.Licence_Fee_Sequence
		   OR source.LICENCE_FEE_ROUTING_METHOD <> target.Licence_Fee_Routing_Method
		   OR source.LICENCE_FEE_VALUE <> target.Licence_Fee_Value
		   OR source.APPLY_LICENCE_FEE <> target.Apply_Licence_Fee
		   OR source.INCLUDE_LICENCE_IN_COST <> target.Include_Licence_Fee_In_Cost
		   OR source.RETAIL_MINUS_COST_PLUS <> target.Retail_Minus_Cost_Plus
		   OR source.RETAIL_FACTOR <> target.Retail_Factor
		   OR source.LICENCE_FEE_PER_UNIT <> target.Licence_Fee_Per_Unit
		)
	THEN UPDATE SET 
		To_Date = @Yesteday
		,Current_Flag = 0
WHEN NOT MATCHED BY TARGET
	THEN INSERT (
		Wholesale_Order_Dim_ID
		,From_Date
		,To_Date
		,Current_Flag
		,Sale_Order_Created_Date_Dim_ID
		,Sale_Order_Line_Created_Date_Dim_ID
		,Optional_Request_to_Ship_Date_Dim_ID
		,Order_Type_Dim_ID
		,Order_Source_Dim_ID
		,Channel_Dim_ID
		,Currency_Dim_ID
		,Sales_Order_Received_Date_Dim_ID
		,Customer_Dim_ID
		,Store_Dim_ID
		,Delivery_Method_Dim_ID
		,Sales_Order_Actual_Ship_Date_Dim_ID
		,Item_Dim_ID
		,Sales_Order_Qty
		,Sales_Order_Reserved_Qty
		,Sales_Order_Allocated_Qty
		,Sales_Order_Shipped_Qty
		,Sales_Order_Backorder_Qty
		,Sales_Order_Cancelled_Qty
		,Entered_Unit_Price_Home
		,Entered_Unit_Price_Curr
		,VAT_Unit_Price_Home
		,VAT_Unit_Price_Curr
		,Additional_Shipping_Charge_Home
		,Additional_Shipping_Charge_Curr
		,Tax_Amount_Home
		,Tax_Amount_Curr
		,Cancellation_Reason_Code_Dim_ID
		,Other_Charge_Home
		,Other_Charge_Curr
		,Other_Tax_Home
		,Other_Tax_Curr
		,Line_Message
		,Purchase_Order_Dim_ID
		,Order_Status
		,Country_Code
		,Carraige_Sequence
		,Carraige_Routing_Method
		,Carraige_Value
		,International_Charge_Sequence
		,International_Charge_Routing_Method
		,International_Charge_Value
		,Licence_Fee_Sequence
		,Licence_Fee_Routing_Method
		,Licence_Fee_Value
		,Apply_Licence_Fee
		,Include_Licence_Fee_In_Cost
		,Retail_Minus_Cost_Plus
		,Retail_Factor
		,Licence_Fee_Per_Unit
	) VALUES (
		source.Wholesale_Order_Dim_ID
		,@Today /* From_Date */
		,@TheFuture /* To_Date */
		,1 /* Current_Flag */
		,source.Sale_Order_Created_Date_Dim_ID
		,source.Sale_Order_Line_Created_Date_Dim_ID
		,source.Optional_Request_to_Ship_Date_Dim_ID
		,source.Order_Type_Dim_ID
		,source.Order_Source_Dim_ID
		,source.Channel_Dim_ID
		,source.Currency_Dim_ID
		,source.Sales_Order_Received_Date_Dim_ID
		,source.Customer_Dim_ID
		,source.Store_Dim_ID
		,source.Delivery_Method_Dim_ID
		,source.Sales_Order_Actual_Ship_Date_Dim_ID
		,source.Item_Dim_ID
		,source.Sales_Order_Qty
		,source.Sales_Order_Reserved_Qty
		,source.Sales_Order_Allocated_Qty
		,source.Sales_Order_Shipped_Qty
		,source.Sales_Order_Backorder_Qty
		,source.Sales_Order_Cancelled_Qty
		,source.Entered_Unit_Price_Home
		,source.Entered_Unit_Price_Curr
		,source.VAT_Unit_Price_Home
		,source.VAT_Unit_Price_Curr
		,source.Additional_Shipping_Charge_Home
		,source.Additional_Shipping_Charge_Curr
		,source.Tax_Amount_Home
		,source.Tax_Amount_Curr
		,source.Cancellation_Reason_Code_Dim_ID
		,source.Other_Charge_Home
		,source.Other_Charge_Curr
		,source.Other_Tax_Home
		,source.Other_Tax_Curr
		,source.Line_Message
		,source.Purchase_Order_Dim_ID
		,source.Order_Status
		,source.Country_Code
		,source.Carraige_Sequence
		,source.Carraige_Routing_Method
		,source.Carraige_Value
		,source.International_Charge_Sequence
		,source.International_Charge_Routing_Method
		,source.International_Charge_Value
		,source.Licence_Fee_Sequence
		,source.Licence_Fee_Routing_Method
		,source.Licence_Fee_Value
		,source.Apply_Licence_Fee
		,source.Include_Licence_In_Cost
		,source.Retail_Minus_Cost_Plus
		,source.Retail_Factor
		,source.Licence_Fee_Per_Unit
	)
OUTPUT $action AS Action
	,source.*
) AS MergeOutput
WHERE MergeOutput.Action = 'UPDATE'			
;

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Wholesale_Order_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
