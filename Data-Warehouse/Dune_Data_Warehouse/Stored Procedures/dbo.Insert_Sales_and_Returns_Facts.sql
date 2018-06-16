
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Insert_Sales_and_Returns_Facts]
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
EXEC dbo.Log_Start @Source, 'Insert_Sales_and_Returns_Facts', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

DELETE f
FROM Store_Item_Sale_Trans_Fact f
WHERE EXISTS (
	SELECT 1 
	FROM Dune_Data_Warehouse_Staging..Store_Item_Sale_Trans_Fact
	WHERE Processed_Timestamp = f.Processed_Timestamp
)

DELETE f
FROM Store_Item_Return_Trans_Fact f
WHERE EXISTS (
	SELECT 1
	FROM Dune_Data_Warehouse_Staging..Store_Item_Return_Trans_Fact
	WHERE Processed_Timestamp = f.Processed_Timestamp
)	

/* Insert Sales */
INSERT INTO dbo.Store_Item_Sale_Trans_Fact (
	Sale_Date_Dim_ID
	,Sale_Time_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Transaction_No
	,Sequence_No
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Gift_Card_Serial_No
	,Discount_Reason_Dim_ID
	,Salesperson_ID
	,Sales_Qty
	,Cost_Value_Home
	,Cost_Value_Curr
	,Actual_Sales_Value_Home
	,Actual_Sales_Value_Curr
	,Discount_Value_Home
	,Discount_Value_Curr
	,Gift_Card_Value_Home
	,Gift_Card_Value_Curr
	,Processed_Timestamp
	,VAT_Value_Home
	,VAT_Value_Curr
	,Actual_FP_Sales_Value_Home
	,Actual_FP_Sales_Value_Curr
	,Actual_MD_Sales_Value_Home
	,Actual_MD_Sales_Value_Curr
	,FP_Qty
	,MD_Qty
	,Gross_Sales_Value_Home
	,Gross_Sales_Value_Curr
	,FP_VAT_Value_Home
	,FP_VAT_Value_Curr
	,MD_VAT_Value_Home
	,MD_VAT_Value_Curr
	,FP_Cost_Value_Home
	,FP_Cost_Value_Curr
	,MD_Cost_Value_Home
	,MD_Cost_Value_Curr
	,FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr
	,Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr
) 
SELECT
	Sale_Date_Dim_ID
	,Sale_Time_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Transaction_No
	,Sequence_No
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Gift_Card_Serial_No
	,Discount_Reason_Dim_ID
	,Salesperson_ID
	,Sales_Qty
	,Cost_Value_Home
	,Cost_Value_Curr
	,Actual_Sales_Value_Home
	,Actual_Sales_Value_Curr
	,Discount_Value_Home
	,Discount_Value_Curr
	,Gift_Card_Value_Home
	,Gift_Card_Value_Curr
	,Processed_Timestamp
	,VAT_Value_Home
	,VAT_Value_Curr
	,Actual_FP_Sales_Value_Home
	,Actual_FP_Sales_Value_Curr
	,Actual_MD_Sales_Value_Home
	,Actual_MD_Sales_Value_Curr
	,FP_Qty
	,MD_Qty
	,Gross_Sales_Value_Home
	,Gross_Sales_Value_Curr
	,FP_VAT_Value_Home
	,FP_VAT_Value_Curr
	,MD_VAT_Value_Home
	,MD_VAT_Value_Curr
	,FP_Cost_Value_Home
	,FP_Cost_Value_Curr
	,MD_Cost_Value_Home
	,MD_Cost_Value_Curr
	,FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr
	,Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr
FROM Dune_Data_Warehouse_Staging.dbo.Store_Item_Sale_Trans_Fact;

/* Insert Returns */
INSERT INTO dbo.Store_Item_Return_Trans_Fact (
	Return_Date_Dim_ID
	,Time_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Return_Reason_Dim_ID
	,Salesperson_ID
	,Return_Qty
	,Return_Value_Home
	,Return_Value_Curr
	,Processed_Timestamp
	,VAT_Value_Home
	,VAT_Value_Curr
	,Actual_FP_Returns_Value_Home
	,Actual_FP_Returns_Value_Curr
	,Actual_MD_Returns_Value_Home
	,Actual_MD_Returns_Value_Curr
	,FP_Qty
	,MD_Qty
	,Gross_Returns_Value_Home
	,Gross_Returns_Value_Curr
	,Return_Cost_Value_Home
	,Return_Cost_Value_Curr
	,FP_VAT_Value_Home
	,FP_VAT_Value_Curr
	,MD_VAT_Value_Home
	,MD_VAT_Value_Curr
	,FP_Cost_Value_Home
	,FP_Cost_Value_Curr
	,MD_Cost_Value_Home
	,MD_Cost_Value_Curr
	,FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr
	,Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr
)
SELECT 
	Return_Date_Dim_ID
	,Time_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Return_Reason_Dim_ID
	,Salesperson_ID
	,Return_Qty
	,Return_Value_Home
	,Return_Value_Curr
	,Processed_Timestamp
	,VAT_Value_Home
	,VAT_Value_Curr
	,Actual_FP_Returns_Value_Home
	,Actual_FP_Returns_Value_Curr
	,Actual_MD_Returns_Value_Home
	,Actual_MD_Returns_Value_Curr
	,FP_Qty
	,MD_Qty
	,Gross_Returns_Value_Home
	,Gross_Returns_Value_Curr
	,Return_Cost_Value_Home
	,Return_Cost_Value_Curr
	,FP_VAT_Value_Home
	,FP_VAT_Value_Curr
	,MD_VAT_Value_Home
	,MD_VAT_Value_Curr
	,FP_Cost_Value_Home
	,FP_Cost_Value_Curr
	,MD_Cost_Value_Home
	,MD_Cost_Value_Curr
	,FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr
	,Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr
FROM Dune_Data_Warehouse_Staging.dbo.Store_Item_Return_Trans_Fact;

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Insert_Sales_and_Returns_Facts: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
