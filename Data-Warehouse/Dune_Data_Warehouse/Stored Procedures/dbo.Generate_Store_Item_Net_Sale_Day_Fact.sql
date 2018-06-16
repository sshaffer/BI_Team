
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_Store_Item_Net_Sale_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_Store_Item_Net_Sale_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;



BEGIN TRY

BEGIN TRANSACTION

/* Generate Aggregate */
;WITH netSales
AS (
	SELECT Sale_Date_Dim_ID
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
		,Actual_FP_Sale_Value_Curr
		,Actual_MD_Sale_Value_Home
		,Actual_MD_Sale_Value_Curr
		,Cost_of_Markdown_Value_Home
		,Cost_of_Markdown_Value_Curr
		,VAT_Value_Home
		,VAT_Value_Curr
		,FP_Qty
		,MD_Qty
		,Gross_Profit_Value_Home
		,Gross_Profit_Value_Curr
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
	FROM Store_Item_Sale_Day_Fact f
	WHERE EXISTS (
			SELECT 1
			FROM Dune_Data_Warehouse_Staging..Store_Item_Sale_Trans_Fact
			WHERE Sale_Date_Dim_ID = f.Sale_Date_Dim_ID
			)
		OR EXISTS (
			SELECT 1
			FROM Dune_Data_Warehouse_Staging..Store_Item_Return_Trans_Fact
			WHERE Return_Date_Dim_ID = f.Sale_Date_Dim_ID
			)
	
	UNION ALL
	
	SELECT Return_Date_Dim_ID AS Sale_Date_Dim_ID
		,Item_Dim_ID
		,Store_Dim_ID
		,Channel_Dim_ID
		,Currency_Dim_ID
		,Return_Qty AS Sales_Qty
		,Return_Cost_Value_Home AS Cost_Value_Home
		,Return_Cost_Value_Curr AS Cost_Value_Curr
		,Return_Value_Home AS Actual_Sales_Value_Home
		,Return_Value_Curr AS Actual_Sales_Value_Curr
		,Return_Value_Home AS Gross_Sales_Value_Home
		,Return_Value_Curr AS Gross_Sales_Value_Curr
		,FP_Return_Value_Home AS Actual_FP_Sales_Value_Home
		,FP_Return_Value_Curr AS Actual_FP_Sales_Value_Curr
		,MD_Return_Value_Home AS Actual_MD_Sales_Value_Home
		,MD_Return_Value_Curr AS Actual_MD_Sales_Value_Curr
		,Return_Value_Home - MD_Return_Value_Home AS Cost_of_Markdown_Value_Home
		,Return_Value_Curr - MD_Return_Value_Curr AS Cost_of_Markdown_Value_Curr
		,VAT_Value_Home
		,VAT_Value_Curr
		,FP_Qty
		,MD_Qty
		,Gross_Profit_Value_Home
		,Gross_Profit_value_Curr
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
		,0 AS Discount_Value_Home
		,0 AS Discount_Value_Curr
	FROM Store_Item_Return_Day_Fact f
	WHERE EXISTS (
			SELECT 1
			FROM Dune_Data_Warehouse_Staging..Store_Item_Sale_Trans_Fact
			WHERE Sale_Date_Dim_ID = f.Return_Date_Dim_ID
			)
		OR EXISTS (
			SELECT 1
			FROM Dune_Data_Warehouse_Staging..Store_Item_Return_Trans_Fact
			WHERE Return_Date_Dim_ID = f.Return_Date_Dim_ID
			)
)

MERGE INTO dbo.Store_Item_Net_Sale_Day_Fact target
USING (
	SELECT 
		Sale_Date_Dim_ID
		,Item_Dim_ID
		,Store_Dim_ID
		,Channel_Dim_ID
		,Currency_Dim_ID
		,SUM(Sales_Qty) Sales_Qty
		,SUM(Cost_Value_Home) Cost_Value_Home
		,SUM(Cost_Value_Curr) Cost_Value_Curr
		,SUM(Actual_Sales_Value_Home) Actual_Sales_Value_Home
		,SUM(Actual_Sales_Value_Curr) Actual_Sales_Value_Curr
		,SUM(Gross_Sales_Value_Home) Gross_Sales_Value_Home
		,SUM(Gross_Sales_Value_Curr) Gross_Sales_Value_Curr
		,SUM(Actual_FP_Sales_Value_Home) Actual_FP_Sales_Value_Home
		,SUM(Actual_FP_Sale_Value_Curr) Actual_FP_Sale_Value_Curr
		,SUM(Actual_MD_Sale_Value_Home) Actual_MD_Sale_Value_Home
		,SUM(Actual_MD_Sale_Value_Curr) Actual_MD_Sale_Value_Curr
		,SUM(Cost_of_Markdown_Value_Home) Cost_of_Markdown_Value_Home
		,SUM(Cost_of_Markdown_Value_Curr) Cost_of_Markdown_Value_Curr
		,SUM(VAT_Value_Home) VAT_Value_Home
		,SUM(VAT_Value_Curr) VAT_Value_Curr
		,SUM(FP_Qty) FP_Qty
		,SUM(MD_Qty) MD_Qty
		,SUM(Gross_Profit_Value_Home) Gross_Profit_Value_Home
		,SUM(Gross_Profit_Value_Curr) Gross_Profit_Value_Curr
		,SUM(FP_VAT_Value_Home) FP_VAT_Value_Home
		,SUM(FP_VAT_Value_Curr) FP_VAT_Value_Curr
		,SUM(MD_VAT_Value_Home) MD_VAT_Value_Home
		,SUM(MD_VAT_Value_Curr) MD_VAT_Value_Curr
		,SUM(FP_Cost_Value_Home) FP_Cost_Value_Home
		,SUM(FP_Cost_Value_Curr) FP_Cost_Value_Curr
		,SUM(MD_Cost_Value_Home) MD_Cost_Value_Home
		,SUM(MD_Cost_Value_Curr) MD_Cost_Value_Curr
		,SUM(FP_Gross_Profit_Value_Home) FP_Gross_Profit_Value_Home
		,SUM(FP_Gross_Profit_Value_Curr) FP_Gross_Profit_Value_Curr
		,SUM(MD_Gross_Profit_Value_Home) MD_Gross_Profit_Value_Home
		,SUM(MD_Gross_Profit_Value_Curr) MD_Gross_Profit_Value_Curr
		,SUM(Discount_Value_Home) Discount_Value_Home
		,SUM(Discount_Value_Curr) Discount_Value_Curr
	FROM netSales
	GROUP BY Sale_Date_Dim_ID
		,Item_Dim_ID
		,Store_Dim_ID
		,Channel_Dim_ID
		,Currency_Dim_ID
	) source
	ON source.Sale_Date_Dim_ID = target.Sale_Date_Dim_ID
		AND source.Item_Dim_ID = target.Item_Dim_ID
		AND source.Store_Dim_ID = target.Store_Dim_ID
		AND source.Channel_Dim_ID = target.Channel_Dim_ID
		AND source.Currency_Dim_ID = target.Currency_Dim_ID
WHEN MATCHED
	THEN
		UPDATE
		SET Sales_Qty = source.Sales_Qty
			,Cost_Value_Home = source.Cost_Value_Home
			,Cost_Value_Curr = source.Cost_Value_Curr
			,Actual_Sales_Value_Home = source.Actual_Sales_Value_Home
			,Actual_Sales_Value_Curr = source.Actual_Sales_Value_Curr
			,Gross_Sales_Value_Home = source.Gross_Sales_Value_Home
			,Gross_Sales_Value_Curr = source.Gross_Sales_Value_Curr
			,Actual_FP_Sales_Value_Home = source.Actual_FP_Sales_Value_Home
			,Actual_FP_Sale_Value_Curr = source.Actual_FP_Sale_Value_Curr
			,Actual_MD_Sale_Value_Home = source.Actual_MD_Sale_Value_Home
			,Actual_MD_Sale_Value_Curr = source.Actual_MD_Sale_Value_Curr
			,Cost_of_Markdown_Value_Home = source.Cost_of_Markdown_Value_Home
			,Cost_of_Markdown_Value_Curr = source.Cost_of_Markdown_Value_Curr
			,VAT_Value_Home = source.VAT_Value_Home
			,VAT_Value_Curr = source.VAT_Value_Curr
			,FP_Qty = source.FP_Qty
			,MD_Qty = source.MD_Qty
			,Gross_Profit_Value_Home = source.Gross_Profit_Value_Home
			,Gross_Profit_Value_Curr = source.Gross_Profit_Value_Curr
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
			,Discount_Value_Home = source.Discount_Value_Home
			,Discount_Value_Curr = source.Discount_Value_Curr
WHEN NOT MATCHED
	THEN
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
			,Gross_Profit_Value_Home
			,Gross_Profit_Value_Curr
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
		VALUES (
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
			,source.Gross_Sales_Value_Home
			,source.Gross_Sales_Value_Curr
			,source.Actual_FP_Sales_Value_Home
			,source.Actual_FP_Sale_Value_Curr
			,source.Actual_MD_Sale_Value_Home
			,source.Actual_MD_Sale_Value_Curr
			,source.Cost_of_Markdown_Value_Home
			,source.Cost_of_Markdown_Value_Curr
			,source.VAT_Value_Home
			,source.VAT_Value_Curr
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
			,source.Discount_Value_Home
			,source.Discount_Value_Curr
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_Store_Item_Net_Sale_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
