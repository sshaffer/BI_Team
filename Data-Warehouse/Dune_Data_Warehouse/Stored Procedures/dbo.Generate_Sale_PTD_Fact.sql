SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_Sale_PTD_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_Sale_PTD_Fact', @Cache, @Process;
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
TRUNCATE TABLE dbo.Sale_PTD_Fact;

INSERT INTO dbo.Sale_PTD_Fact (
	Item_Dim_ID
	,Store_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Sales_Qty
	,Cost_Value_Home
	,Cost_Value_Curr
	,Actual_Sales_Value_Home
	,Actual_Sales_Value_Curr
	,Gross_Sales_Value_Home
	,Gross_Sales_Value_Curr
	,Actual_FP_Sales_Value_Home
	,Actual_FP_Sales_Value_Curr
	,Actual_MD_Sales_Value_Home
	,Actual_MD_Sales_Value_Curr
	,Actual_Promo_Sales_Value_Home
	,Actual_Promo_Sales_Value_Curr
	,Cost_of_Markdown_Value_Home
	,Cost_of_Markdown_Value_Curr
	,Cost_of_Promo_Value_Home
	,Cost_of_Promo_Value_Curr
	,Gift_Card_Value_Home
	,Gift_Card_Value_Curr
	,Discount_Value_Home
	,Discount_Value_Curr
	,VAT_Value_Home
	,VAT_Value_Curr
	,Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr,
	FP_Qty,
	MD_Qty
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
	)
SELECT 
	f.Item_Dim_ID
	,f.Store_Dim_ID
	,f.Channel_Dim_ID
	,f.Currency_Dim_ID
	,SUM(f.Sales_Qty)
	,SUM(f.Cost_Value_Home)
	,SUM(f.Cost_Value_Curr)
	,SUM(f.Actual_Sales_Value_Home)
	,SUM(f.Actual_Sales_Value_Curr)
	,SUM(f.Gross_Sales_Value_Home)
	,SUM(f.Gross_Sales_Value_Curr)
	,SUM(f.Actual_FP_Sales_Value_Home)
	,SUM(f.Actual_FP_Sales_Value_Curr)
	,SUM(f.Actual_MD_Sales_Value_Home)
	,SUM(f.Actual_MD_Sales_Value_Curr)
	,SUM(f.Actual_Promo_Sales_Value_Home)
	,SUM(f.Actual_Promo_Sales_Value_Curr)
	,SUM(f.Cost_of_Markdown_Value_Home)
	,SUM(f.Cost_of_Markdown_Value_Curr)
	,SUM(f.Cost_of_Promo_Value_Home)
	,SUM(f.Cost_of_Promo_Value_Curr)
	,SUM(f.Gift_Card_Value_Home)
	,SUM(f.Gift_Card_Value_Curr)
	,SUM(f.Discount_Value_Home)
	,SUM(f.Discount_Value_Curr)
	,SUM(f.VAT_Value_Home)
	,SUM(f.VAT_Value_Curr)
	,SUM(f.Gross_Profit_Value_Home)
	,SUM(f.Gross_Profit_Value_Curr),
	SUM(FP_Qty),
	SUM(MD_Qty)
	,SUM(FP_VAT_Value_Home)
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
FROM dbo.Sale_Day_Fact f
JOIN dbo.Calendar_Dim cal 
	ON cal.Calendar_Dim_Id = f.Sale_Day_Dim_ID
WHERE cal.Current_Period = 0
AND cal.Current_Year = 0
AND cal.Current_Week < 0
GROUP BY 
	f.Item_Dim_ID
	,f.Store_Dim_ID
	,f.Channel_Dim_ID
	,f.Currency_Dim_ID

SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_Sale_PTD_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
