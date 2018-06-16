
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Sale_Week_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Sale_Week_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Sale_Week_Fact target
USING (
	SELECT 
		wk.Calendar_Week_Dim_Id
		,f.Item_Dim_ID
		,f.Store_Dim_ID
		,f.Channel_Dim_ID
		,f.Currency_Dim_ID
		,SUM(f.Sales_Qty) AS Sales_Qty
		,SUM(f.Cost_Value_Home) AS Cost_Value_Home
		,SUM(f.Cost_Value_Curr) AS Cost_Value_Curr
		,SUM(f.Actual_Sales_Value_Home) AS Actual_Sales_Value_Home
		,SUM(f.Actual_Sales_Value_Curr) AS Actual_Sales_Value_Curr
		,SUM(f.Gross_Sales_Value_Home) AS Gross_Sales_Value_Home
		,SUM(f.Gross_Sales_Value_Curr) AS Gross_Sales_Value_Curr
		,SUM(f.Actual_FP_Sales_Value_Home) AS Actual_FP_Sales_Value_Home
		,SUM(f.Actual_FP_Sales_Value_Curr) AS Actual_FP_Sales_Value_Curr
		,SUM(f.Actual_MD_Sales_Value_Home) AS Actual_MD_Sales_Value_Home
		,SUM(f.Actual_MD_Sales_Value_Curr) AS Actual_MD_Sales_Value_Curr
		,SUM(f.Actual_Promo_Sales_Value_Home) AS Actual_Promo_Sales_Value_Home
		,SUM(f.Actual_Promo_Sales_Value_Curr) AS Actual_Promo_Sales_Value_Curr
		,SUM(f.Cost_of_Markdown_Value_Home) AS Cost_of_Markdown_Value_Home
		,SUM(f.Cost_of_Markdown_Value_Curr) AS Cost_of_Markdown_Value_Curr
		,SUM(f.Cost_of_Promo_Value_Home) AS Cost_of_Promo_Value_Home
		,SUM(f.Cost_of_Promo_Value_Curr) AS Cost_of_Promo_Value_Curr
		,SUM(f.Gift_Card_Value_Home) AS Gift_Card_Value_Home
		,SUM(f.Gift_Card_Value_Curr) AS Gift_Card_Value_Curr
		,SUM(f.Discount_Value_Home) AS Discount_Value_Home
		,SUM(f.Discount_Value_Curr) AS Discount_Value_Curr
		,SUM(f.VAT_Value_Home) AS VAT_Value_Home
		,SUM(f.VAT_Value_Curr) AS VAT_Value_Curr
		,SUM(f.Gross_Profit_Value_Home) AS Gross_Profit_Value_Home
		,SUM(f.Gross_Profit_Value_Curr) AS Gross_Profit_Value_Curr
		,SUM(f.FP_Qty) AS FP_Qty
		,SUM(f.MD_Qty) AS MD_Qty
		,SUM(FP_VAT_Value_Home) AS FP_VAT_Value_Home
		,SUM(FP_VAT_Value_Curr) AS FP_VAT_Value_Curr
		,SUM(MD_VAT_Value_Home) AS MD_VAT_Value_Home
		,SUM(MD_VAT_Value_Curr) AS MD_VAT_Value_Curr
		,SUM(FP_Cost_Value_Home) AS FP_Cost_Value_Home
		,SUM(FP_Cost_Value_Curr) AS FP_Cost_Value_Curr
		,SUM(MD_Cost_Value_Home) AS MD_Cost_Value_Home
		,SUM(MD_Cost_Value_Curr) AS MD_Cost_Value_Curr
		,SUM(FP_Gross_Profit_Value_Home) AS FP_Gross_Profit_Value_Home
		,SUM(FP_Gross_Profit_Value_Curr) AS FP_Gross_Profit_Value_Curr
		,SUM(MD_Gross_Profit_Value_Home) AS MD_Gross_Profit_Value_Home
		,SUM(MD_Gross_Profit_Value_Curr) AS MD_Gross_Profit_Value_Curr
	FROM dbo.Sale_Day_Fact f
	JOIN dbo.Calendar_Dim cal ON cal.Calendar_Dim_Id = f.Sale_Day_Dim_ID
	JOIN dbo.Calendar_Week_Dim wk ON wk.Fiscal_Week = cal.Fiscal_Week
		AND wk.Fiscal_Year = cal.Fiscal_Year
	WHERE wk.Calendar_Week_Dim_Id >= -32462 /* we only want data from this point onwards (2015/16) as we have history from IPWKHST before this. We cant merge the stuff in before this as the IPWKHST data is not accurate. */
	GROUP BY 
		wk.Calendar_Week_Dim_Id
		,f.Item_Dim_ID
		,f.Store_Dim_ID
		,f.Channel_Dim_ID
		,f.Currency_Dim_ID
) source
	ON source.Calendar_Week_Dim_Id = target.Sale_Week_Dim_ID
	AND source.Item_Dim_ID = target.Item_Dim_ID
	AND source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Channel_Dim_ID = target.Channel_Dim_ID
	AND source.Currency_Dim_ID = target.Currency_Dim_ID
WHEN MATCHED THEN 
UPDATE SET
	Sales_Qty = source.Sales_Qty
	,Cost_Value_Home = source.Cost_Value_Home
	,Cost_Value_Curr = source.Cost_Value_Curr
	,Actual_Sales_Value_Home = source.Actual_Sales_Value_Home
	,Actual_Sales_Value_Curr = source.Actual_Sales_Value_Curr
	,Gross_Sales_Value_Home = source.Gross_Sales_Value_Home
	,Gross_Sales_Value_Curr = source.Gross_Sales_Value_Curr
	,Actual_FP_Sales_Value_Home = source.Actual_FP_Sales_Value_Home
	,Actual_FP_Sales_Value_Curr = source.Actual_FP_Sales_Value_Curr
	,Actual_MD_Sales_Value_Home = source.Actual_MD_Sales_Value_Home
	,Actual_MD_Sales_Value_Curr = source.Actual_MD_Sales_Value_Curr
	,Actual_Promo_Sales_Value_Home = source.Actual_Promo_Sales_Value_Home
	,Actual_Promo_Sales_Value_Curr = source.Actual_Promo_Sales_Value_Curr
	,Cost_of_Markdown_Value_Home = source.Cost_of_Markdown_Value_Home
	,Cost_of_Markdown_Value_Curr = source.Cost_of_Markdown_Value_Curr
	,Cost_of_Promo_Value_Home = source.Cost_of_Promo_Value_Home
	,Cost_of_Promo_Value_Curr = source.Cost_of_Promo_Value_Curr
	,Gift_Card_Value_Home = source.Gift_Card_Value_Home
	,Gift_Card_Value_Curr = source.Gift_Card_Value_Curr
	,Discount_Value_Home = source.Discount_Value_Home
	,Discount_Value_Curr = source.Discount_Value_Curr
	,VAT_Value_Home = source.VAT_Value_Home
	,VAT_Value_Curr = source.VAT_Value_Curr
	,Gross_Profit_Value_Home = source.Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr = source.Gross_Profit_Value_Curr
	,FP_Qty = source.FP_Qty
	,MD_Qty = source.MD_Qty
	,FP_VAT_Value_Home = source.FP_VAT_Value_Home
	,FP_VAT_Value_Curr = source.FP_VAT_Value_Curr
	,MD_VAT_Value_Home = source.MD_VAT_Value_Home
	,MD_VAT_Value_Curr = source.MD_VAT_Value_Curr
	,FP_Cost_Value_Home = source.FP_Cost_Value_Home
	,FP_Cost_Value_Curr = source.FP_Cost_Value_Curr
	,MD_Cost_Value_Home = source.MD_Cost_Value_Home
	,MD_Cost_Value_Curr = source.MD_Cost_Value_Curr
	,FP_Gross_Profit_Value_Home = source.FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr = source.FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home = source.MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr = source.MD_Gross_Profit_Value_Curr
WHEN NOT MATCHED THEN
INSERT (
	Sale_Week_Dim_ID
	,Item_Dim_ID
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
	,Gross_Profit_Value_Curr
	,FP_Qty
	,MD_Qty
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
) VALUES (
	source.Calendar_Week_Dim_Id
	,source.Item_Dim_ID
	,source.Store_Dim_ID
	,source.Channel_Dim_ID
	,source.Currency_Dim_ID
	,source.Sales_Qty
	,source.Cost_Value_Home
	,source.Cost_Value_Curr
	,source.Actual_Sales_Value_Home
	,source.Actual_Sales_Value_Curr
	,source.Gross_Sales_Value_Home
	,source.Gross_Sales_Value_Curr
	,source.Actual_FP_Sales_Value_Home
	,source.Actual_FP_Sales_Value_Curr
	,source.Actual_MD_Sales_Value_Home
	,source.Actual_MD_Sales_Value_Curr
	,source.Actual_Promo_Sales_Value_Home
	,source.Actual_Promo_Sales_Value_Curr
	,source.Cost_of_Markdown_Value_Home
	,source.Cost_of_Markdown_Value_Curr
	,source.Cost_of_Promo_Value_Home
	,source.Cost_of_Promo_Value_Curr
	,source.Gift_Card_Value_Home
	,source.Gift_Card_Value_Curr
	,source.Discount_Value_Home
	,source.Discount_Value_Curr
	,source.VAT_Value_Home
	,source.VAT_Value_Curr
	,source.Gross_Profit_Value_Home
	,source.Gross_Profit_Value_Curr
	,source.FP_Qty
	,source.MD_Qty
	,source.FP_VAT_Value_Home
	,source.FP_VAT_Value_Curr
	,source.MD_VAT_Value_Home
	,source.MD_VAT_Value_Curr
	,source.FP_Cost_Value_Home
	,source.FP_Cost_Value_Curr
	,source.MD_Cost_Value_Home
	,source.MD_Cost_Value_Curr
	,source.FP_Gross_Profit_Value_Home
	,source.FP_Gross_Profit_Value_Curr
	,source.MD_Gross_Profit_Value_Home
	,source.MD_Gross_Profit_Value_Curr
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Sale_Week_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;



EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
