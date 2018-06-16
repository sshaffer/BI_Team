SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Generate_Store_Item_Sale_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_Store_Item_Sale_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

;WITH sales AS (
	SELECT
		 sale.Sale_Date_Dim_ID
		,sale.Item_Dim_ID
		,sale.Store_Dim_ID
		,sale.Channel_Dim_ID
		,sale.Currency_Dim_ID
		,SUM(sale.Sales_Qty) AS Sales_Qty
		,SUM(sale.Cost_Value_Home) AS Cost_Value_Home
		,SUM(sale.Cost_Value_Curr) AS Cost_Value_Curr
		,SUM(sale.Actual_Sales_Value_Home) AS Actual_Sales_Value_Home
		,SUM(sale.Actual_Sales_Value_Curr) AS Actual_Sales_Value_Curr
		,SUM(sale.Discount_Value_Home) AS Discount_Value_Home
		,SUM(sale.Discount_Value_Curr) AS Discount_Value_Curr
		,SUM(sale.Gift_Card_Value_Home) AS Gift_Card_Value_Home
		,SUM(sale.Gift_Card_Value_Curr) AS Gift_Card_Value_Curr
		,SUM(sale.Gross_Sales_Value_Home) AS Gross_Sales_Value_Home
		--,SUM(sale.Actual_Sales_Value_Home) AS Gross_Sales_Value_Home
		,SUM(sale.Gross_Sales_Value_Curr) AS Gross_Sales_Value_Curr
		--,CASE
		-- WHEN curr.Currency_Code = '' THEN SUM(sale.Actual_Sales_Value_Home)
		-- ELSE SUM(sale.Actual_Sales_Value_Curr)
		-- END AS Gross_Sales_Value_Curr	
		,SUM(sale.Actual_FP_Sales_Value_Home) AS Actual_FP_Sales_Value_Home
		--,SUM(CASE
		-- WHEN price.FP_MD_Flag = 'F' OR price.FP_MD_Flag IS NULL THEN sale.Actual_Sales_Value_Home
		-- ELSE 0
		-- END) AS Actual_FP_Sale_Value_Home
		,SUM(Actual_FP_Sales_Value_Curr) AS Actual_FP_Sales_Value_Curr
		--,SUM(CASE
		-- WHEN price.FP_MD_Flag ='F' OR Price.FP_MD_Flag IS NULL THEN sale.Actual_Sales_Value_Curr
		-- ELSE 0
		-- END) AS Actual_FP_Sale_Value_Curr
		,SUM(Actual_MD_Sales_Value_Home) AS Actual_MD_Sales_Value_Home
		--,SUM(CASE
		-- WHEN price.FP_MD_Flag = 'M' THEN sale.Actual_Sales_Value_Home
		-- ELSE 0
		-- END) AS Actual_MD_Sale_Value_Home
		,SUM(Actual_MD_Sales_Value_Curr) AS Actual_MD_Sales_Value_Curr
		--,SUM(CASE
		-- WHEN price.FP_MD_Flag ='M' THEN sale.Actual_Sales_Value_Curr
		-- ELSE 0
		-- END) AS Actual_MD_Sale_Value_Curr
		,SUM(sale.FP_Qty) AS FP_Qty
		--,SUM(CASE
		-- WHEN price.FP_MD_Flag = 'F' OR price.FP_MD_Flag IS NULL THEN sale.Sales_Qty
		-- ELSE 0
		-- END) AS FP_Qty
		,SUM(sale.MD_Qty) AS MD_Qty
		--,SUM(CASE
		-- WHEN price.FP_MD_Flag = 'M' THEN sale.Sales_Qty
		-- ELSE 0
		-- END) AS MD_Qty
		,SUM(sale.VAT_Value_Home) AS VAT_Value_Home
		,SUM(sale.VAT_Value_Curr) AS VAT_Value_Curr
		--,SUM(Actual_Sales_Value_Home - VAT_Value_Home - Cost_Value_Home) AS Gross_Profit_Value_Home
		--,SUM(Actual_Sales_Value_Curr - VAT_Value_Curr - Cost_Value_Curr) AS Gross_Profit_Value_Curr
		,SUM(Gross_Profit_Value_Home) AS Gross_Profit_Value_Home
		,SUM(Gross_Profit_Value_Curr) AS Gross_Profit_Value_Curr
		,SUM(sale.FP_VAT_Value_Home) AS FP_VAT_Value_Home
		,SUM(sale.FP_VAT_Value_Curr) AS FP_VAT_Value_Curr
		,SUM(sale.MD_VAT_Value_Home) AS MD_VAT_Value_Home
		,SUM(sale.MD_VAT_Value_Curr) AS MD_VAT_Value_Curr
		,SUM(sale.FP_Cost_Value_Home) AS FP_Cost_Value_Home
		,SUM(sale.FP_Cost_Value_Curr) AS FP_Cost_Value_Curr
		,SUM(sale.MD_Cost_Value_Home) AS MD_Cost_Value_Home
		,SUM(sale.MD_Cost_Value_Curr) AS MD_Cost_Value_Curr
		,SUM(sale.FP_Gross_Profit_Value_Home) AS FP_Gross_Profit_Value_Home
		,SUM(sale.FP_Gross_Profit_Value_Curr) AS FP_Gross_Profit_Value_Curr
		,SUM(sale.MD_Gross_Profit_Value_Home) AS MD_Gross_Profit_Value_Home
		,SUM(sale.MD_Gross_Profit_Value_Curr) AS MD_Gross_Profit_Value_Curr
	FROM Store_Item_Sale_Trans_Fact sale
	--JOIN Currency_Dim curr
	--ON curr.Currency_Dim_ID = sale.Currency_Dim_ID
	--JOIN Store_Item_Price_Original_Fact price
	--ON price.Item_Dim_ID = sale.Item_Dim_ID
	--AND price.Store_Dim_ID = sale.Store_Dim_ID
	--LEFT JOIN Store_Item_Price_Day_Fact price
	--ON price.Item_Dim_ID = sale.Item_Dim_ID
	--AND price.Store_Dim_ID = sale.Store_Dim_ID
	--AND price.Calendar_Dim_ID = sale.Sale_Date_Dim_ID
	--AND price.Currency_Dim_ID = sale.Currency_Dim_ID
	WHERE EXISTS (
		SELECT 1
		FROM Dune_Data_Warehouse_Staging..Store_Item_Sale_Trans_Fact
		WHERE Sale_Date_Dim_ID = sale.Sale_Date_Dim_ID
		AND Item_Dim_ID = sale.Item_Dim_ID
		AND Store_Dim_ID = sale.Store_Dim_ID
		AND Channel_Dim_ID = sale.Channel_Dim_ID
		AND Currency_Dim_ID = sale.Currency_Dim_ID
	)
	GROUP BY
		sale.Sale_Date_Dim_ID
		,sale.Item_Dim_ID
		,sale.Store_Dim_ID
		,sale.Channel_Dim_ID
		,sale.Currency_Dim_ID
		--,curr.Currency_Code
)
--,
--actuals AS (
--	SELECT 
--		sales.Sale_Date_Dim_ID
--		,sales.Item_Dim_ID
--		,sales.Store_Dim_ID
--		,sales.Channel_Dim_ID
--		,sales.Currency_Dim_ID
--		,sales.Sales_Qty
--		,sales.Cost_Value_Home
--		,sales.Cost_Value_Curr
--		,sales.Actual_Sales_Value_Home
--		,sales.Actual_Sales_Value_Curr
--		,sales.Discount_Value_Home
--		,sales.Discount_Value_Curr
--		,sales.Gift_Card_Value_Home
--		,sales.Gift_Card_Value_Curr
--		,sales.Gross_Sales_Value_Home
--		,sales.Gross_Sales_Value_Curr
--		,CASE
--		 WHEN fp.FP_MD_Flag = 'F' THEN sales.Actual_Sales_Value_Home
--		 ELSE 0
--		 END AS Actual_FP_Sales_Value_Home
--		,CASE
--		 WHEN fp.FP_MD_Flag = 'F' THEN sales.Actual_Sales_Value_Curr
--		 ELSE 0
--		 END AS Actual_FP_Sale_Value_Curr
--		,CASE
--		 WHEN fp.FP_MD_Flag = 'M' THEN sales.Actual_Sales_Value_Home
--		 ELSE 0
--		 END AS Actual_MD_Sale_Value_Home
--		,CASE
--		 WHEN fp.FP_MD_Flag = 'M' THEN sales.Actual_Sales_Value_Curr
--		 ELSE 0
--		 END AS Actual_MD_Sale_Value_Curr
--		 ,sales.VAT_Value_Home
--		 ,sales.VAT_Value_Curr
--	FROM sales
--	JOIN Store_Item_Price_Day_Fact fp
--	ON fp.Item_Dim_ID = sales.Item_Dim_ID
--	AND fp.Store_Dim_ID = sales.Store_Dim_ID
--	AND fp.Calendar_Dim_ID = sales.Sale_Date_Dim_ID
--	AND fp.Currency_Dim_ID = sales.Currency_Dim_ID
--)

MERGE INTO Store_Item_Sale_Day_Fact target
USING (
	SELECT
		 sales.Sale_Date_Dim_ID
		,sales.Item_Dim_ID
		,sales.Store_Dim_ID
		,sales.Channel_Dim_ID
		,sales.Currency_Dim_ID
		,sales.Sales_Qty
		,sales.Cost_Value_Home
		,sales.Cost_Value_Curr
		,sales.Actual_Sales_Value_Home
		,sales.Actual_Sales_Value_Curr
		,sales.Discount_Value_Home
		,sales.Discount_Value_Curr
		,sales.Gift_Card_Value_Home
		,sales.Gift_Card_Value_Curr
		,sales.Gross_Sales_Value_Home
		,sales.Gross_Sales_Value_Curr
		,sales.Actual_FP_Sales_Value_Home
		,sales.Actual_FP_Sales_Value_Curr
		,sales.Actual_MD_Sales_Value_Home
		,sales.Actual_MD_Sales_Value_Curr
		,sales.Gross_Sales_Value_Home - sales.Actual_MD_Sales_Value_Home AS Cost_of_Markdown_Value_Home
		,sales.Gross_Sales_Value_Curr - sales.Actual_MD_Sales_Value_Curr AS Cost_of_Markdown_Value_Curr
		,sales.VAT_Value_Home
		,sales.VAT_Value_Curr
		,sales.FP_Qty
		,sales.MD_Qty
		,sales.Gross_Profit_Value_Home
		,sales.Gross_Profit_Value_Curr
		,sales.FP_VAT_Value_Home
		,sales.FP_VAT_Value_Curr
		,sales.MD_VAT_Value_Home
		,sales.MD_VAT_Value_Curr
		,sales.FP_Cost_Value_Home
		,sales.FP_Cost_Value_Curr
		,sales.MD_Cost_Value_Home
		,sales.MD_Cost_Value_Curr
		,sales.FP_Gross_Profit_Value_Home
		,sales.FP_Gross_Profit_Value_Curr
		,sales.MD_Gross_Profit_Value_Home
		,sales.MD_Gross_Profit_Value_Curr
	FROM sales
) source
	ON source.Sale_Date_Dim_ID = target.Sale_Date_Dim_ID
	AND source.Item_Dim_ID = target.Item_Dim_ID
	AND source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Channel_Dim_ID = target.Channel_Dim_ID
	AND source.Currency_Dim_ID = target.Currency_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Sale_Date_Dim_ID = source.Sale_Date_Dim_ID                         
	,Item_Dim_ID = source.Item_Dim_ID
	,Store_Dim_ID = source.Store_Dim_ID
	,Channel_Dim_ID = source.Channel_Dim_ID
	,Currency_Dim_ID = source.Currency_Dim_ID
	,Sales_Qty = source.Sales_Qty
	,Cost_Value_Home = source.Cost_Value_Home
	,Cost_Value_Curr = source.Cost_Value_Curr
	,Actual_Sales_Value_Home = source.Actual_Sales_Value_Home
	,Actual_Sales_Value_Curr = source.Actual_Sales_Value_Curr
	,Discount_Value_Home = source.Discount_Value_Home
	,Discount_Value_Curr = source.Discount_Value_Curr
	,Gift_Card_Value_Home = source.Gift_Card_Value_Home
	,Gift_Card_Value_Curr = source.Gift_Card_Value_Curr
	,Gross_Sales_Value_Home = source.Gross_Sales_Value_Home
	,Gross_Sales_Value_Curr = source.Gross_Sales_Value_Curr
	,Actual_FP_Sales_Value_Home = source.Actual_FP_Sales_Value_Home
	,Actual_FP_Sale_Value_Curr = source.Actual_FP_Sales_Value_Curr
	,Actual_MD_Sale_Value_Home = source.Actual_MD_Sales_Value_Home
	,Actual_MD_Sale_Value_Curr = source.Actual_MD_Sales_Value_Curr
	,Cost_of_Markdown_Value_Home = source.Cost_of_Markdown_Value_Home
	,Cost_of_Markdown_Value_Curr = source.Cost_of_Markdown_Value_Curr
	,VAT_Value_Home = source.VAT_Value_Home
	,VAT_Value_Curr = source.VAT_Value_Curr
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
	,Gross_Profit_Value_Home = source.Gross_Profit_Value_Home
	,Gross_Profit_value_Curr = source.Gross_Profit_Value_Curr
WHEN NOT MATCHED THEN
INSERT (
	 Sale_Date_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Sales_Qty
	,Cost_Value_Home
	,Cost_Value_Curr
	,Actual_Sales_Value_Home
	,Actual_Sales_Value_Curr
	,Discount_Value_Home
	,Discount_Value_Curr
	,Gift_Card_Value_Home
	,Gift_Card_Value_Curr
	,Gross_Sales_Value_Home
	,Gross_Sales_Value_Curr
	,Actual_FP_Sales_Value_Home
	,Actual_FP_Sale_Value_Curr
	,Actual_MD_Sale_Value_Home
	,Actual_MD_Sale_Value_Curr
	,Cost_of_Markdown_Value_Home
	,Cost_of_Markdown_Value_Curr
	,VAT_Value_Home
	,VAT_Value_Curr
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
	,Gross_Profit_Value_Home 
	,Gross_Profit_value_Curr
) VALUES (
	 source.Sale_Date_Dim_ID
	,source.Item_Dim_ID
	,source.Store_Dim_ID
	,source.Channel_Dim_ID
	,source.Currency_Dim_ID
	,source.Sales_Qty
	,source.Cost_Value_Home
	,source.Cost_Value_Curr
	,source.Actual_Sales_Value_Home
	,source.Actual_Sales_Value_Curr
	,source.Discount_Value_Home
	,source.Discount_Value_Curr
	,source.Gift_Card_Value_Home
	,source.Gift_Card_Value_Curr
	,source.Gross_Sales_Value_Home
	,source.Gross_Sales_Value_Curr
	,source.Actual_FP_Sales_Value_Home
	,source.Actual_FP_Sales_Value_Curr
	,source.Actual_MD_Sales_Value_Home
	,source.Actual_MD_Sales_Value_Curr
	,source.Cost_of_Markdown_Value_Home
	,source.Cost_of_Markdown_Value_Curr
	,source.VAT_Value_Home
	,source.VAT_Value_Curr
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
	,source.Gross_Profit_Value_Home 
	,source.Gross_Profit_Value_Curr 
);

SET @Row_Count = @@ROWCOUNT; /* Used for logging */


COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_Store_Item_Sale_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
