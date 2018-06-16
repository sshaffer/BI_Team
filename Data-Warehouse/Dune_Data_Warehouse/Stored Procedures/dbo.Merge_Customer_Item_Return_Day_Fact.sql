SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Customer_Item_Return_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Customer_Item_Return_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


MERGE INTO dbo.Customer_Item_Return_Day_Fact target
USING (
	SELECT 
		 f.Return_Date_Dim_ID
		,f.Order_No
		,f.Customer_Dim_ID
		,f.Item_Dim_ID
		,f.Store_Dim_ID
		,f.Return_Status_Code
		,f.Order_Source_Dim_ID
		,f.Order_Type_Dim_ID
		,f.Channel_Dim_ID
		,f.Return_Reason_Dim_ID
		,f.Currency_Dim_ID
		,f.Delivery_Method_Dim_ID
		,SUM(f.Return_Qty) AS Return_Qty
		,SUM(f.Return_Value_Home) AS Return_Value_Home
		,SUM(f.Return_Value_Curr) AS Return_Value_Curr
		,SUM(f.Return_Cost_Value_Home) AS Return_Cost_Value_Home
		,SUM(f.Return_Cost_Value_Curr) AS Return_Cost_Value_Curr
		,SUM(f.Return_VAT_Value_Home) AS Return_VAT_Value_Home
		,SUM(f.Return_VAT_Value_Curr) AS Return_VAT_Value_Curr
		,SUM(f.Gross_Profit_Value_Home) AS Gross_Profit_Value_Home
		,SUM(f.Gross_Profit_Value_Curr) AS Gross_Profit_Value_Curr
		,SUM(f.FP_Return_Value_Home) AS FP_Return_Value_Home
		--,SUM(CASE 
		-- WHEN p.FP_MD_Flag = 'F' OR p.FP_MD_Flag IS NULL THEN f.Return_Value_Home
		-- ELSE 0 
		-- END) AS FP_Return_Value_Home
		,SUM(f.FP_Return_Value_Curr) AS FP_Return_Value_Curr
		--,SUM(CASE 
		-- WHEN p.FP_MD_Flag = 'F' OR p.FP_MD_Flag IS NULL THEN f.Return_Value_Curr
		-- ELSE 0 
		-- END) AS FP_Return_Value_Curr
		,SUM(f.MD_Return_Value_Home) AS MD_Return_Value_Home
		--,SUM(CASE 
		-- WHEN p.FP_MD_Flag = 'M' THEN f.Return_Value_Home
		-- ELSE 0 
		-- END) AS MD_Return_Value_Home
		,SUM(f.MD_Return_Value_Curr) AS MD_Return_Value_Curr
		--,SUM(CASE 
		-- WHEN p.FP_MD_Flag = 'M' THEN f.Return_Value_Curr
		-- ELSE 0 
		-- END) AS MD_Return_Value_Curr
		,0 AS Promo_Return_Value_Home
		--,SUM(CASE 
		-- WHEN p.Promotion_Flag = 'Y' THEN f.Return_Value_Home
		-- ELSE 0 
		-- END) AS Promo_Return_Value_Home
		,0 AS Promo_Return_Value_Curr
		--,SUM(CASE
		-- WHEN p.Promotion_Flag = 'Y' THEN f.Return_Value_Curr
		-- ELSE 0
		-- END) AS Promo_Return_Value_Curr
		,SUM(f.FP_Return_Qty) AS FP_Qty
		--,SUM(CASE
		-- WHEN p.FP_MD_Flag = 'F' OR p.FP_MD_Flag IS NULL THEN f.Return_Qty
		-- ELSE 0
		-- END) AS FP_Qty
		,SUM(f.MD_Return_Qty) AS MD_Qty
		--,SUM(CASE
		-- WHEN p.FP_MD_Flag = 'M' THEN f.Return_Qty
		-- ELSE 0
		-- END) AS MD_Qty
		,SUM(f.FP_Cost_Value_Home) AS FP_Cost_Value_Home
		,SUM(f.FP_Cost_Value_Curr) AS FP_Cost_Value_Curr
		,SUM(f.MD_Cost_Value_Home) AS MD_Cost_Value_Home
		,SUM(f.MD_Cost_Value_Curr) AS MD_Cost_Value_Curr
		,SUM(f.FP_VAT_Value_Home) AS FP_VAT_Value_Home
		,SUM(f.FP_VAT_Value_Curr) AS FP_VAT_Value_Curr
		,SUM(f.MD_VAT_Value_Home) AS MD_VAT_Value_Home
		,SUM(f.MD_VAT_Value_Curr) AS MD_VAT_Value_Curr
		,SUM(f.FP_Gross_Profit_Value_Home) AS FP_Gross_Profit_Value_Home
		,SUM(f.FP_Gross_Profit_Value_Curr) AS FP_Gross_Profit_Value_Curr
		,SUM(f.MD_Gross_Profit_Value_Home) AS MD_Gross_Profit_Value_Home
		,SUM(f.MD_Gross_Profit_Value_Curr) AS MD_Gross_Profit_Value_Curr
	FROM Dune_Data_Warehouse_Staging..Customer_Item_Return_Day_Fact f
	--JOIN Store_Item_Price_Day_Fact p
	--	ON p.Store_Dim_ID = f.Store_Dim_ID
	--	AND p.Item_Dim_ID = f.Item_Dim_ID
	--	AND p.Calendar_Dim_ID = f.Return_Date_Dim_ID
	GROUP BY 
		 f.Return_Date_Dim_ID
		,f.Order_No
		,f.Customer_Dim_ID
		,f.Item_Dim_ID
		,f.Store_Dim_ID
		,f.Return_Status_Code
		,f.Order_Source_Dim_ID
		,f.Order_Type_Dim_ID
		,f.Channel_Dim_ID
		,f.Return_Reason_Dim_ID
		,f.Currency_Dim_ID
		,f.Delivery_Method_Dim_ID
) source
ON source.Return_Date_Dim_ID = target.Return_Date_Dim_ID
AND source.Order_No = target.Order_No
AND source.Customer_Dim_ID = target.Customer_Dim_ID
AND source.Item_Dim_ID = target.Item_Dim_ID
AND source.Return_Reason_Dim_ID = target.Return_Reason_Dim_ID
and source.Return_Status_Code = target.Return_Status_Code
WHEN MATCHED THEN
UPDATE SET
	Store_Dim_ID = source.Store_Dim_ID
	,Return_Status_Code = source.Return_Status_Code
	,Order_Source_Dim_ID = source.Order_Source_Dim_ID
	,Order_Type_Dim_ID = source.Order_Type_Dim_ID
	,Channel_Dim_ID = source.Channel_Dim_ID
	,Return_Reason_Dim_ID = source.Return_Reason_Dim_ID
	,Currency_Dim_ID = source.Currency_Dim_ID
	,Return_Qty = source.Return_Qty
	,Return_Value_Home = source.Return_Value_Home
	,Return_Value_Curr = source.Return_Value_Curr
	,Return_Cost_Value_Home = source.Return_Cost_Value_Home
	,Return_Cost_Value_Curr = source.Return_Cost_Value_Curr
	,Return_VAT_Value_Home = source.Return_VAT_Value_Home
	,Return_VAT_Value_Curr = source.Return_VAT_Value_Curr
	,Gross_Profit_Value_Home = source.Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr = source.Gross_Profit_Value_Curr
	,FP_Return_Value_Home = source.FP_Return_Value_Home
	,FP_Return_Value_Curr = source.FP_Return_Value_Curr
	,MD_Return_Value_Home = source.MD_Return_Value_Home
	,MD_Return_Value_Curr = source.MD_Return_Value_Curr
	,Promo_Return_Value_Home = source.Promo_Return_Value_Home
	,Promo_Return_Value_Curr = source.Promo_Return_Value_Curr
	,FP_Qty = source.FP_Qty
	,MD_Qty = source.MD_Qty
	,Delivery_Method_Dim_ID = source.Delivery_Method_Dim_ID
	,FP_Cost_Value_Home = source.FP_Cost_Value_Home
	,FP_Cost_Value_Curr = source.FP_Cost_Value_Curr
	,MD_Cost_Value_Home = source.MD_Cost_Value_Home
	,MD_Cost_Value_Curr = source.MD_Cost_Value_Curr
	,FP_VAT_Value_Home = source.FP_VAT_Value_Home
	,FP_VAT_Value_Curr = source.FP_VAT_Value_Curr
	,MD_VAT_Value_Home = source.MD_VAT_Value_Home
	,MD_VAT_Value_Curr = source.MD_VAT_Value_Curr
	,FP_Gross_Profit_Value_Home = source.FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr = source.FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home = source.MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr = source.MD_Gross_Profit_Value_Curr
WHEN NOT MATCHED THEN
INSERT (
	Return_Date_Dim_ID
	,Order_No
	,Customer_Dim_ID
	,Item_Dim_ID
	,Store_Dim_ID
	,Return_Status_Code
	,Order_Source_Dim_ID
	,Order_Type_Dim_ID
	,Channel_Dim_ID
	,Return_Reason_Dim_ID
	,Currency_Dim_ID
	,Return_Qty
	,Return_Value_Home
	,Return_Value_Curr
	,Return_Cost_Value_Home
	,Return_Cost_Value_Curr
	,Return_VAT_Value_Home
	,Return_VAT_Value_Curr
	,Gross_Profit_Value_Home
	,Gross_Profit_Value_Curr
	,FP_Return_Value_Home 
	,FP_Return_Value_Curr 
	,MD_Return_Value_Home 
	,MD_Return_Value_Curr 
	,Promo_Return_Value_Home
	,Promo_Return_Value_Curr
	,FP_Qty
	,MD_Qty
	,Delivery_Method_Dim_ID
	,FP_Cost_Value_Home 
	,FP_Cost_Value_Curr
	,MD_Cost_Value_Home
	,MD_Cost_Value_Curr
	,FP_VAT_Value_Home
	,FP_VAT_Value_Curr
	,MD_VAT_Value_Home
	,MD_VAT_Value_Curr
	,FP_Gross_Profit_Value_Home
	,FP_Gross_Profit_Value_Curr
	,MD_Gross_Profit_Value_Home
	,MD_Gross_Profit_Value_Curr
) VALUES ( 
	source.Return_Date_Dim_ID
	,source.Order_No
	,source.Customer_Dim_ID
	,source.Item_Dim_ID
	,source.Store_Dim_ID
	,source.Return_Status_Code
	,source.Order_Source_Dim_ID
	,source.Order_Type_Dim_ID
	,source.Channel_Dim_ID
	,source.Return_Reason_Dim_ID
	,source.Currency_Dim_ID
	,source.Return_Qty
	,source.Return_Value_Home
	,source.Return_Value_Curr
	,source.Return_Cost_Value_Home
	,source.Return_Cost_Value_Curr
	,source.Return_VAT_Value_Home
	,source.Return_VAT_Value_Curr
	,source.Gross_Profit_Value_Home
	,source.Gross_Profit_Value_Curr
	,source.FP_Return_Value_Home 
	,source.FP_Return_Value_Curr 
	,source.MD_Return_Value_Home 
	,source.MD_Return_Value_Curr 
	,source.Promo_Return_Value_Home
	,source.Promo_Return_Value_Curr
	,source.FP_Qty
	,source.MD_Qty
	,source.Delivery_Method_Dim_ID
	,source.FP_Cost_Value_Home 
	,source.FP_Cost_Value_Curr
	,source.MD_Cost_Value_Home
	,source.MD_Cost_Value_Curr
	,source.FP_VAT_Value_Home
	,source.FP_VAT_Value_Curr
	,source.MD_VAT_Value_Home
	,source.MD_VAT_Value_Curr
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Customer_Item_Return_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;



EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
