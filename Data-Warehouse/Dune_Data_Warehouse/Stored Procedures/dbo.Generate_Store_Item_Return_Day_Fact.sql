SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Generate_Store_Item_Return_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_Store_Item_Return_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION Sales_Returns_Facts

;WITH [returns] AS (
	SELECT 
	 r.Return_Date_Dim_ID
	,r.Item_Dim_ID
	,r.Store_Dim_ID
	,r.Channel_Dim_ID
	,r.Currency_Dim_ID
	--,curr.Currency_Code
	,r.Return_Reason_Dim_ID
	,SUM(r.Return_Qty) AS Return_Qty
	,SUM(r.Return_Value_Home) AS Return_Value_Home
	,SUM(r.Return_Value_Curr) AS Return_Value_Curr
	,SUM(r.VAT_Value_Home) AS VAT_Value_Home
	,SUM(r.VAT_Value_Curr) AS VAT_Value_Curr
	,SUM(r.Actual_FP_Returns_Value_Home) AS Actual_FP_Returns_Value_Home
	--,SUM(CASE 
	-- WHEN p.FP_MD_Flag = 'F' OR p.FP_MD_Flag IS NULL THEN r.Return_Value_Home
	-- ELSE 0
	-- END) AS FP_Return_Value_Home
	,SUM(r.Actual_FP_Returns_Value_Curr) AS Actual_FP_Returns_Value_Curr
	--,SUM(CASE 
	-- WHEN p.FP_MD_Flag = 'F' OR p.FP_MD_Flag IS NULL THEN r.Return_Value_Curr
	-- ELSE 0
	-- END) AS FP_Return_Value_Curr
	,SUM(r.Actual_MD_Returns_Value_Home) AS Actual_MD_Returns_Value_Home
	--,SUM(CASE p.FP_MD_Flag
	-- WHEN 'M' THEN r.Return_Value_Home
	-- ELSE 0
	-- END) AS MD_Return_Value_Home
	,SUM(r.Actual_MD_Returns_Value_Curr) AS Actual_MD_Returns_Value_Curr
	--,SUM(CASE p.FP_MD_Flag
	-- WHEN 'M' THEN r.Return_Value_Curr
	-- ELSE 0
	-- END) AS MD_Return_Value_Curr
	--,SUM(CASE p.Promotion_Flag
	-- WHEN 'Y' THEN r.Return_Value_Home
	-- ELSE 0
	-- END) AS Promo_Return_Value_Home
	--,SUM(CASE p.Promotion_Flag
	-- WHEN 'Y' THEN r.Return_Value_Curr
	-- ELSE 0
	-- END) AS Promo_Return_Value_Curr
	,SUM(r.FP_Qty) AS FP_Qty
	--,SUM(CASE
	-- WHEN p.FP_MD_Flag = 'F' OR p.FP_MD_Flag IS NULL THEN r.Return_Qty
	-- ELSE 0
	-- END) AS FP_Qty
	,SUM(r.MD_Qty) AS MD_Qty
	--,SUM(CASE
	-- WHEN p.FP_MD_Flag = 'M' THEN r.Return_Qty
	-- ELSE 0
	-- END) AS MD_Qty
	,SUM(r.Gross_Returns_Value_Home) AS Gross_Returns_Value_Home
	,SUM(r.Gross_Returns_Value_Curr) AS Gross_Returns_Value_Curr
	,SUM(r.Return_Cost_Value_Home) AS Return_Cost_Value_Home
	,SUM(r.Return_Cost_Value_Curr) AS Return_Cost_Value_Curr
	--,SUM(r.Return_Value_Home - r.VAT_Value_Home - r.Return_Cost_Value_Home) AS Gross_Profit_Value_Home
	--,SUM(r.Return_Value_Curr - r.VAT_Value_Curr - r.Return_Cost_Value_Curr) AS Gross_Profit_Value_Curr
	,SUM(r.Gross_Profit_Value_Home) AS Gross_Profit_Value_Home
	,SUM(r.Gross_Profit_Value_Curr) AS Gross_Profit_Value_Curr
	,SUM(r.FP_VAT_Value_Home) AS FP_VAT_Value_Home
	,SUM(r.FP_VAT_Value_Curr) AS FP_VAT_Value_Curr
	,SUM(r.MD_VAT_Value_Home) AS MD_VAT_Value_Home
	,SUM(r.MD_VAT_Value_Curr) AS MD_VAT_Value_Curr
	,SUM(r.FP_Cost_Value_Home) AS FP_Cost_Value_Home
	,SUM(r.FP_Cost_Value_Curr) AS FP_Cost_Value_Curr
	,SUM(r.MD_Cost_Value_Home) AS MD_Cost_Value_Home
	,SUM(r.MD_Cost_Value_Curr) AS MD_Cost_Value_Curr
	,SUM(r.FP_Gross_Profit_Value_Home) AS FP_Gross_Profit_Value_Home
	,SUM(r.FP_Gross_Profit_Value_Curr) AS FP_Gross_Profit_Value_Curr
	,SUM(r.MD_Gross_Profit_Value_Home) AS MD_Gross_Profit_Value_Home
	,SUM(r.MD_Gross_Profit_Value_Curr) AS MD_Gross_Profit_Value_Curr
FROM dbo.Store_Item_Return_Trans_Fact r
--LEFT JOIN Store_Item_Price_Day_Fact p
--	ON p.Calendar_Dim_ID = r.Return_Date_Dim_ID
--	AND p.Item_Dim_ID = r.Item_Dim_ID
--	AND p.Store_Dim_ID = r.Store_Dim_ID
--JOIN Currency_Dim curr
--	ON curr.Currency_Dim_ID = r.Currency_Dim_ID
WHERE EXISTS (
	SELECT 1
	FROM Dune_Data_Warehouse_Staging..Store_Item_Return_Trans_Fact
	WHERE Return_Date_Dim_ID = r.Return_Date_Dim_ID
	AND Item_Dim_ID = r.Item_Dim_ID
	AND Store_Dim_ID = r.Store_Dim_ID
	AND Channel_Dim_ID = r.Channel_Dim_ID
	AND Currency_Dim_ID = r.Currency_Dim_ID
	AND Return_Reason_Dim_ID = r.Return_Reason_Dim_ID
)
GROUP BY
	r.Return_Date_Dim_ID,
	r.Item_Dim_ID,
	r.Store_Dim_ID,
	r.Channel_Dim_ID,
	r.Currency_Dim_ID,
	--curr.Currency_Code,
	r.Return_Reason_Dim_ID
)
--,
--costs as (
--	SELECT
--		[returns].*,
--		cost.Item_Landed_Cost_Price * [returns].Return_Qty AS Return_Cost_Value_Home
--	FROM [returns]
--	JOIN (
--		SELECT
--			f.Item_Dim_ID,
--			f.Item_Landed_Cost_Price,
--			f.Calendar_Date_Dim_ID
--		FROM Item_Cost_Price_History_Fact f
--		JOIN (
--			SELECT 
--				Item_Dim_ID,
--				MIN(Calendar_Date_Dim_ID) Calendar_Date_Dim_ID
--			FROM Item_Cost_Price_History_Fact
--			GROUP BY Item_Dim_ID
--		) mincost
--		ON mincost.Item_Dim_ID = f.Item_Dim_ID
--		AND mincost.Calendar_Date_Dim_ID = f.Calendar_Date_Dim_ID
--	) cost
--	ON cost.Item_Dim_ID = [returns].Item_Dim_ID
--	AND [returns].Return_Date_Dim_ID >= cost.Calendar_Date_Dim_ID
--),
--currency AS (
--	SELECT
--		costs.*,
--		CASE
--		WHEN Currency_Code = '' THEN costs.Return_Cost_Value_Home
--		ELSE costs.Return_Cost_Value_Home * ex.Exchange_Rate
--		END AS Return_Cost_Value_Curr
--	FROM costs
--	JOIN Calendar_Dim cal
--	ON cal.Calendar_Dim_ID = costs.Return_Date_Dim_ID
--	LEFT JOIN Currency_Exchange_Rate_Fact_View ex
--	ON ex.From_Currency_Code = ''
--	AND ex.To_Currency_Code = costs.Currency_Code
--	AND cal.Calendar_Date BETWEEN ex.From_Effective_Date AND ex.To_Effective_Date
--),
--profit AS (
--	SELECT
--		currency.*,
--		Gross_Profit_Value_Home = currency.Return_Value_Home - currency.VAT_Value_Home - currency.Return_Cost_Value_Home,
--		Gross_Profit_Value_Curr = currency.Return_Value_Curr - currency.VAT_Value_Curr - currency.Return_Cost_Value_Curr
--	FROM currency
--)

MERGE INTO dbo.Store_Item_Return_Day_Fact target
USING [returns] source 
--USING (
--	SELECT
--		profit.Return_Date_Dim_ID, 
--		profit.Item_Dim_ID,
--		profit.Store_Dim_ID,
--		profit.Channel_Dim_ID,
--		profit.Currency_Dim_ID,
--		profit.Return_Reason_Dim_ID,
--		profit.Return_Qty,
--		profit.Return_Value_Home,
--		profit.Return_Value_Curr,
--		profit.Return_Cost_Value_Home,
--		profit.Return_Cost_Value_Curr,
--		profit.VAT_Value_Home,
--		profit.VAT_Value_Curr,
--		profit.FP_Return_Value_Home,
--		profit.FP_Return_Value_Curr,
--		profit.MD_Return_Value_Home,
--		profit.MD_Return_Value_Curr,
--		profit.Promo_Return_Value_Home,
--		profit.Promo_Return_Value_Curr,
--		FP_Qty,
--		MD_Qty,
--		Gross_Profit_Value_Home,
--		Gross_Profit_value_Curr
--	FROM profit
--) source
	ON  source.Return_Date_Dim_ID = target.Return_Date_Dim_ID
	AND source.Item_Dim_ID = target.Item_Dim_ID
	AND source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Channel_Dim_ID = target.Channel_Dim_ID
	AND source.Currency_Dim_ID = target.Currency_Dim_ID
	AND source.Return_Reason_Dim_ID = target.Return_Reason_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Return_Qty = source.Return_Qty
	,Return_Value_Home = source.Return_Value_Home
	,Return_Value_Curr = source.Return_Value_Curr
	,Return_Cost_Value_Home = source.Return_Cost_Value_Home
	,Return_Cost_Value_Curr = source.Return_Cost_Value_Curr
	,VAT_Value_Home = source.VAT_Value_Home
	,VAT_Value_Curr = source.VAT_Value_Curr
	,FP_Return_Value_Home = source.Actual_FP_Returns_Value_Home
	,FP_Return_Value_Curr = source.Actual_FP_Returns_Value_Curr
	,MD_Return_Value_Home = source.Actual_MD_Returns_Value_Home
	,MD_Return_Value_Curr = source.Actual_MD_Returns_Value_Home
	,Promo_Return_Value_Home = 0
	,Promo_Return_Value_Curr = 0
	,FP_Qty = source.FP_Qty
	,MD_Qty = source.MD_Qty
	,Gross_Profit_Value_Home = source.Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr = source.Gross_Profit_Value_Curr
	,FP_VAT_Value_Home = source.FP_VAT_Value_Home
	,FP_VAT_Value_Curr = source.FP_VAT_Value_Curr
	,MD_VAT_Value_Home = source.MD_VAT_Value_Home
	,MD_VAT_Value_Curr = source.MD_VAT_Value_Curr
	,FP_Cost_Value_Home = source.FP_Cost_Value_Home
	,FP_Cost_Value_Curr	= source.FP_Cost_Value_Curr
	,MD_Cost_Value_Home	= source.MD_Cost_Value_Home
	,MD_Cost_Value_Curr	= source.MD_Cost_Value_Curr
	,FP_Gross_Profit_Value_Home = source.FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr = source.FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home = source.MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr = source.MD_Gross_Profit_Value_Curr
WHEN NOT MATCHED THEN
INSERT (
	Return_Date_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Channel_Dim_ID
	,Currency_Dim_ID
	,Return_Reason_Dim_ID
	,Return_Qty
	,Return_Value_Home
	,Return_Value_Curr
	,Return_Cost_Value_Home
	,Return_Cost_Value_Curr
	,VAT_Value_Home
	,VAT_Value_Curr
	,FP_Return_Value_Home
	,FP_Return_Value_Curr
	,MD_Return_Value_Home
	,MD_Return_Value_Curr
	,Promo_Return_Value_Home
	,Promo_Return_Value_Curr,
	FP_Qty,
	MD_Qty,
	Gross_Profit_value_Home,
	Gross_Profit_Value_Curr
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
	source.Return_Date_Dim_ID
	,source.Item_Dim_ID
	,source.Store_Dim_ID
	,source.Channel_Dim_ID
	,source.Currency_Dim_ID
	,source.Return_Reason_Dim_ID
	,source.Return_Qty
	,source.Return_Value_Home
	,source.Return_Value_Curr
	,source.Return_Cost_Value_Home
	,source.Return_Cost_Value_Curr
	,source.VAT_Value_Home
	,source.VAT_Value_Curr
	,source.Actual_FP_Returns_Value_Home
	,source.Actual_FP_Returns_Value_Curr
	,source.Actual_MD_Returns_Value_Home
	,source.Actual_MD_Returns_Value_Curr
	,0
	,0
	,source.FP_Qty
	,source.MD_Qty
	,source.Gross_Profit_Value_Home
	,source.Gross_Profit_Value_Curr
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_Store_Item_Return_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
