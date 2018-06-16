
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_Customer_Item_Net_Sale_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_Customer_Item_Net_Sale_Day_Fact', @Cache, @Process;
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
TRUNCATE TABLE dbo.Customer_Item_Net_Sale_Day_Fact;

/* Generate Aggregate */
;WITH netSales AS (
SELECT 
	f.Sale_Date_Dim_ID,
	f.Item_Dim_ID,
	f.Store_Dim_ID,
	f.Channel_Dim_ID,
	f.Currency_Dim_ID,
	f.Order_No,
	f.Customer_Dim_ID,
	f.Order_Source_Dim_ID,
	f.Order_Type_Dim_ID,
	f.Sales_Qty,
	f.Cost_Value_Home,
	f.Cost_Value_Curr,
	f.Actual_Sales_Value_Home,
	f.Actual_Sales_Value_Curr,
	f.Gross_Sales_Value_Home,
	f.Gross_Sales_Value_Curr,
	f.VAT_Value_Home,
	f.VAT_Value_Curr,
	f.Actual_FP_Sales_Value_Home,
	f.Actual_FP_Sales_Value_Curr,
	f.Actual_MD_Sales_Value_Home,
	f.Actual_MD_Sales_Value_Curr,
	f.Cost_of_Markdown_Value_Home,
	f.Cost_of_Markdown_Value_Curr,
	f.FP_Qty,
	f.MD_Qty,
	f.Gross_Profit_Value_Home,
	f.Gross_Profit_Value_Curr,
	f.Delivery_Method_Dim_ID
	,f.FP_VAT_Value_Home
	,f.FP_VAT_Value_Curr
	,f.MD_VAT_Value_Home
	,f.MD_VAT_Value_Curr
	,f.FP_Cost_Value_Home
	,f.FP_Cost_Value_Curr
	,f.MD_Cost_Value_Home
	,f.MD_Cost_Value_Curr
	,f.FP_Gross_Profit_Value_Home
	,f.FP_Gross_Profit_Value_Curr
	,f.MD_Gross_Profit_Value_Home
	,f.MD_Gross_Profit_Value_Curr
	,f.Discount_Value_Home
	,f.Discount_Value_Curr
FROM Customer_Item_Sale_Day_Fact f

UNION ALL

SELECT 
	f.Return_Date_Dim_ID AS Sale_Date_Dim_ID,
	f.Item_Dim_ID,
	f.Store_Dim_ID,
	f.Channel_Dim_ID,
	f.Currency_Dim_ID,
	f.Order_No,
	f.Customer_Dim_ID,
	f.Order_Source_Dim_ID,
	f.Order_Type_Dim_ID,
	f.Return_Qty AS Sales_Qty,
	f.Return_Cost_Value_Home AS Cost_Value_Home,
	f.Return_Cost_Value_Curr AS Cost_Value_Curr,
	f.Return_Value_Home AS Actual_Sales_Value_Home,
	f.Return_Value_Curr AS Actual_Sales_Value_Curr,
	f.Return_Value_Home AS Gross_Sales_Value_Home,
	f.Return_Value_Curr AS Gross_Sales_Value_Curr,
	f.Return_VAT_Value_Home AS VAT_Value_Home,
	f.Return_VAT_Value_Curr AS VAT_Value_Curr,
	f.FP_Return_Value_Home AS Actual_FP_Sales_Value_Home,
	f.FP_Return_Value_Curr AS Actual_FP_Sales_Value_Curr,
	f.MD_Return_Value_Home AS Actual_MD_Sales_Value_Home,
	f.MD_Return_Value_Curr AS Actual_MD_Sale_Value_Curr,
	f.Return_Value_Home - MD_Return_Value_Home AS Cost_of_Markdown_Value_Home,
	f.Return_Value_Curr - MD_Return_Value_Curr AS Cost_of_Markdown_Value_Curr,
	f.FP_Qty,
	f.MD_Qty,
	f.Gross_Profit_Value_Home,
	f.Gross_Profit_Value_Curr,
	f.Delivery_Method_Dim_ID
	,f.FP_VAT_Value_Home
	,f.FP_VAT_Value_Curr
	,f.MD_VAT_Value_Home
	,f.MD_VAT_Value_Curr
	,f.FP_Cost_Value_Home
	,f.FP_Cost_Value_Curr
	,f.MD_Cost_Value_Home
	,f.MD_Cost_Value_Curr
	,f.FP_Gross_Profit_Value_Home
	,f.FP_Gross_Profit_Value_Curr
	,f.MD_Gross_Profit_Value_Home
	,f.MD_Gross_Profit_Value_Curr
	,0 AS Discount_Value_Home
	,0 AS Discount_Value_Curr
FROM Customer_Item_Return_Day_Fact f
)
INSERT INTO dbo.Customer_Item_Net_Sale_Day_Fact ( 
    Sale_Date_Dim_ID
   ,Item_Dim_ID
   ,Store_Dim_ID
   ,Channel_Dim_ID
   ,Currency_Dim_ID
   ,Order_No
   ,Customer_Dim_ID
   ,Order_Source_Dim_ID
   ,Order_Type_Dim_ID
   ,Sales_Qty
   ,Cost_Value_Home
   ,Cost_Value_Curr
   ,Actual_Sales_Value_Home
   ,Actual_Sales_Value_Curr
   ,Gross_Sales_Value_Home
   ,Gross_Sales_Value_Curr
   ,VAT_Value_Home
   ,VAT_Value_Curr
   ,Actual_FP_Sales_Value_Home
   ,Actual_FP_Sales_Value_Curr
   ,Actual_MD_Sales_Value_Home
   ,Actual_MD_Sales_Value_Curr
   ,Cost_of_Markdown_Value_Home
   ,Cost_of_Markdown_Value_Curr
   ,FP_Qty
   ,MD_Qty
   ,Gross_Profit_Value_Home
   ,Gross_Profit_Value_Curr
   ,Delivery_Method_Dim_ID
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
	,Discount_Value_Home
	,Discount_Value_Curr
)
SELECT
    Sale_Date_Dim_ID
   ,Item_Dim_ID
   ,Store_Dim_ID
   ,Channel_Dim_ID
   ,Currency_Dim_ID
   ,Order_No
   ,Customer_Dim_ID
   ,Order_Source_Dim_ID
   ,Order_Type_Dim_ID
   ,SUM(Sales_Qty) 
   ,SUM(Cost_Value_Home)
   ,SUM(Cost_Value_Curr)
   ,SUM(Actual_Sales_Value_Home)
   ,SUM(Actual_Sales_Value_Curr)
   ,SUM(Gross_Sales_Value_Home)
   ,SUM(Gross_Sales_Value_Curr)
   ,SUM(VAT_Value_Home)
   ,SUM(VAT_Value_Curr)
   ,SUM(Actual_FP_Sales_Value_Home)
   ,SUM(Actual_FP_Sales_Value_Curr)
   ,SUM(Actual_MD_Sales_Value_Home)
   ,SUM(Actual_MD_Sales_Value_Curr)
   ,SUM(Cost_of_Markdown_Value_Home)
   ,SUM(Cost_of_Markdown_Value_Curr)
   ,SUM(FP_Qty)
   ,SUM(MD_Qty)
   ,SUM(Gross_Profit_Value_Home)
   ,SUM(Gross_Profit_Value_Curr)
   ,Delivery_Method_Dim_ID
   , SUM(FP_VAT_Value_Home)
	,SUM(FP_VAT_Value_Curr)
	,SUM(MD_VAT_Value_Home)
	,SUM(MD_VAT_Value_Curr)
	,SUM(FP_Cost_Value_Home)
	,SUM(FP_Cost_Value_Curr)
	,SUM(MD_Cost_Value_Home)
	,SUM(MD_Cost_Value_Curr)
	,SUM(FP_Gross_Profit_Value_Home)
	,SUM(FP_Gross_Profit_Value_Curr)
	,SUM(MD_Gross_Profit_Value_Home)
	,SUM(MD_Gross_Profit_Value_Curr)
	,SUM(Discount_Value_Home)
	,SUM(Discount_Value_Curr)
FROM netSales
GROUP BY 
	Sale_Date_Dim_ID
   ,Item_Dim_ID
   ,Store_Dim_ID
   ,Channel_Dim_ID
   ,Currency_Dim_ID
   ,Order_No
   ,Customer_Dim_ID
   ,Order_Source_Dim_ID
   ,Order_Type_Dim_ID
   ,Delivery_Method_Dim_ID

SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_Customer_Item_Net_Sale_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
