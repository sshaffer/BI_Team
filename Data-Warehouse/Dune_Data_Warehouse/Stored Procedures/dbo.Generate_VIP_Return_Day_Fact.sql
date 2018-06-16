SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_VIP_Return_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_VIP_Return_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRANSACTION

BEGIN TRY

/* Truncate Table */
TRUNCATE TABLE dbo.VIP_Return_Day_Fact;

WITH [returns] AS (
SELECT
	ret.VIP_Customer_Dim_ID,
	ret.Calendar_Dim_ID,
	ret.Item_Dim_ID,
	ret.Store_Dim_ID,
	SUM(ret.Qty) AS Return_Qty,
	--COUNT(*) AS Return_Qty,
	SUM(ret.Return_Price) AS Return_Price,
	--SUM(ret.Return_Price) AS Return_Price,
	SUM(ret.FP_Return_Price) AS Actual_FP_Return_Price_Home,
	--CAST(SUM(CASE 
	--	WHEN price.FP_MD_Flag = 'F' OR price.FP_MD_Flag IS NULL THEN ret.Return_Price * COALESCE(exch.Exchange_Rate, 1)
	--	ELSE 0
	--END) AS MONEY)AS Actual_FP_Return_Price_Home,
	SUM(ret.FP_Return_Price_Curr) AS Actual_FP_Return_Price_Curr,
	--CAST(SUM(CASE 
	--	WHEN price.FP_MD_Flag = 'F' OR price.FP_MD_Flag IS NULL THEN ret.Return_Price
	--	ELSE 0
	--END) AS MONEY) AS Actual_FP_Return_Price_Curr,
	SUM(ret.MD_Return_Price) AS Actual_MD_Return_Price_Home,
	--CAST(SUM(CASE 
	--	WHEN price.FP_MD_Flag = 'M' THEN ret.Return_Price * COALESCE(exch.Exchange_Rate, 1)
	--	ELSE 0
	--END) AS MONEY) AS Actual_MD_Return_Price_Home,
	SUM(ret.MD_Return_Price_Curr) AS Actual_MD_Return_Price_Curr, 
	--CAST(SUM(CASE 
	--	WHEN price.FP_MD_Flag = 'M' THEN ret.Return_Price 
	--	ELSE 0
	--END) AS MONEY) AS Actual_MD_Return_Price_Curr,
	0 AS Promo_Return_Value_Home,
	--CAST(SUM(CASE 
	--	WHEN price.Promotion_Flag = 'Y' THEN ret.Return_Price * COALESCE(exch.Exchange_Rate, 1)
	--	ELSE 0
	--END) AS MONEY) AS Promo_Return_Value_Home,
	0 AS Promo_Return_Value_Curr,
	--CAST(SUM(CASE 
	--	WHEN price.Promotion_Flag = 'Y' THEN ret.Return_Price 
	--	ELSE 0
	--END) AS MONEY) AS Promo_Return_Value_Curr,
	SUM(ret.Discount_Value_Home) AS Discount_Value_Home,
	--CAST(SUM(ret.Discount_Value * COALESCE(exch.Exchange_Rate, 1)) AS MONEY) AS Discount_Value_Home,
	SUM(ret.Discount_Value_Curr) AS Discount_Value_Curr,
	--CAST(SUM(ret.Discount_Value) AS MONEY) AS Discount_Value_Curr,
	SUM(ret.VAT_Value_Home) AS VAT_Value_Home,
	--CAST(SUM(VAT_Value * COALESCE(exch.Exchange_Rate, 1)) AS MONEY) AS VAT_Value_Home,
	SUM(ret.VAT_Value_Curr) AS VAT_Value_Curr,
	--CAST(SUM(VAT_Value) AS MONEY) AS VAT_Value_Curr,
	SUM(ret.Cost_Price_Home) AS Cost_Price_Home,
	--CAST(SUM(COALESCE(cost.Item_Landed_Cost_Price, minCost.Item_Landed_Cost_Price) * COALESCE(exch.Exchange_Rate, 1)) AS MONEY) AS Cost_Price_Home,
	SUM(ret.Cost_Price_Home) AS Cost_Price_Curr,
	--CAST(SUM(COALESCE(cost.Item_Landed_Cost_Price, minCost.Item_Landed_Cost_Price)) AS MONEY) AS Cost_Price_Curr
	SUM(ret.FP_Qty) AS FP_Qty,
 --  ,SUM(CASE
	--WHEN price.FP_MD_Flag = 'F' OR price.FP_MD_Flag IS NULL THEN 1
	--ELSE 0
	--END) AS FP_Qty
	SUM(ret.MD_Qty) AS MD_Qty,
 --  ,SUM(CASE
 --   WHEN price.FP_MD_Flag = 'M' THEN 1
	--ELSE 0
	--END) AS MD_Qty
	SUM(ret.Gross_Return_Price_Home) AS Gross_Return_Price_Home,
	SUM(ret.Gross_Return_Price_Curr) AS Gross_Return_Price_Curr
	,SUM(ret.FP_VAT_Value_Curr) AS FP_VAT_Value_Curr
	,SUM(ret.FP_VAT_Value_Home) AS FP_VAT_Value_Home
	,SUM(ret.MD_VAT_Value_Curr) AS MD_VAT_Value_Curr
	,SUM(ret.MD_VAT_Value_Home) AS MD_VAT_Value_Home
	,SUM(ret.FP_Cost_Value_Curr) AS FP_Cost_Value_Curr
	,SUM(ret.FP_Cost_Value_Home) AS FP_Cost_Value_Home
	,SUM(ret.MD_Cost_Value_Curr) AS MD_Cost_Value_Curr
	,SUM(ret.MD_Cost_Value_Home) AS MD_Cost_Value_Home 
	,SUM(ret.FP_Gross_Profit_Value_Curr) AS FP_Gross_Profit_Value_Curr
	,SUM(ret.FP_Gross_Profit_Value_Home) AS FP_Gross_Profit_Value_Home
	,SUM(ret.MD_Gross_Profit_Value_Curr) AS MD_Gross_Profit_Value_Curr
	,SUM(ret.MD_Gross_Profit_Value_Home) AS MD_Gross_Profit_Value_Home
FROM VIP_Return_Trans_Fact ret
--JOIN dbo.Calendar_Dim cal
--	ON cal.Calendar_Dim_Id = ret.Calendar_Dim_ID
--JOIN dbo.Store_Dim store
--	ON store.Store_Dim_ID = ret.Store_Dim_ID
--JOIN dbo.Price_Group_Dim pg
--	ON pg.Price_Group_Dim_ID = store.Price_Group_ID
--JOIN dbo.Currency_Dim cur
--	ON cur.Currency_Dim_ID = pg.Currency_Dim_ID
--LEFT JOIN dbo.Store_Item_Price_Day_Fact price
--	ON price.Item_Dim_ID = ret.Item_Dim_ID
--	AND price.Store_Dim_ID = ret.Store_Dim_ID
--	AND price.Calendar_Dim_ID = ret.Calendar_Dim_ID
--LEFT JOIN dbo.Currency_Exchange_Rate_Fact_View exch
--	ON exch.From_Currency_Code = cur.Currency_Code
--	AND exch.To_Currency_Code = ''
--	AND From_Effective_Date <= cal.Calendar_Date
--	AND To_Effective_Date >= cal.Calendar_Date
--OUTER APPLY (
--	SELECT TOP 1
--		Item_Landed_Cost_Price
--	FROM dbo.Item_Cost_Price_History_Fact 
--	WHERE Calendar_Date_Dim_ID <= ret.Calendar_Dim_ID
--	AND Item_Dim_ID = ret.Item_Dim_ID
--	ORDER BY Calendar_Date_Dim_ID DESC
--) cost
--OUTER APPLY (
--	SELECT TOP 1
--		Item_Landed_Cost_Price
--	FROM dbo.Item_Cost_Price_History_Fact
--	WHERE Item_Dim_ID = Item_Dim_ID
--	AND cost.Item_Landed_Cost_Price IS NULL
--	ORDER BY Calendar_Date_Dim_ID
--) minCost
GROUP BY 
	ret.VIP_Customer_Dim_ID,
	ret.Calendar_Dim_ID,
	ret.Item_Dim_ID,
	ret.Store_Dim_ID
)
--, 
--gross AS (
--	SELECT
--		retrn.*,
--		(CASE
--		WHEN retrn.Actual_FP_Return_Price_Home <> 0 THEN retrn.Actual_FP_Return_Price_Home
--		ELSE retrn.Actual_MD_Return_Price_Home
--		END) * retrn.Return_Qty AS Gross_Return_Value_Home,
--		(CASE
--		WHEN retrn.Actual_FP_Return_Price_Curr <> 0 THEN retrn.Actual_FP_Return_Price_Curr
--		ELSE retrn.Actual_MD_Return_Price_Curr
--		END) * retrn.Return_Qty AS Gross_Return_Value_Curr
--	FROM retrn
--)

INSERT INTO dbo.VIP_Return_Day_Fact(
	VIP_Customer_Dim_ID
	,Calendar_Dim_ID
	,Item_Dim_ID
	,Return_Price
	,Store_Dim_ID
	,Actual_FP_Return_Price_Home
	,ACtual_FP_Return_Price_Curr
	,Actual_MD_Return_Price_Home
	,Actual_MD_Return_Price_Curr
	,Promo_Return_Price_Home
	,Promo_Return_Price_Curr
	,Discount_Value_Home
	,Discount_Value_Curr
	,VAT_Value_Home
	,VAT_Value_Curr
	,Cost_Price_Home
	,Cost_Price_Curr
	,Gorss_Return_Value_Home
	,Gross_Return_Value_Curr
	,FP_Qty
	,MD_Qty
	,Return_Qty
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
	VIP_Customer_Dim_ID
	,Calendar_Dim_ID
	,Item_Dim_ID
	,Return_Price
	,Store_Dim_ID
	,Actual_FP_Return_Price_Home
	,ACtual_FP_Return_Price_Curr
	,Actual_MD_Return_Price_Home
	,Actual_MD_Return_Price_Curr
	,Promo_Return_Value_Home
	,Promo_Return_Value_Curr
	,Discount_Value_Home
	,Discount_Value_Curr
	,VAT_Value_Home
	,VAT_Value_Curr
	,Cost_Price_Home
	,Cost_Price_Curr
	,Gross_Return_Price_Home
	,Gross_Return_Price_Curr
	,FP_Qty
	,MD_Qty
	,Return_Qty
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
FROM [returns]

SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_VIP_Return_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
