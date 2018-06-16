SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_VIP_Net_Sale_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_VIP_Net_Sale_Day_Fact', @Cache, @Process;
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
TRUNCATE TABLE dbo.VIP_Net_Sale_Day_Fact;

WITH net AS ( 
	SELECT   
		VIP_Customer_Dim_ID ,
        Calendar_Dim_ID ,
        Item_Dim_ID ,
        Sale_Price ,
        Store_Dim_ID ,
        Actual_FP_Sale_Price_Home ,
        ACtual_FP_Sale_Price_Curr ,
        Actual_MD_Sale_Price_Home ,
        Actual_MD_Sale_Price_Curr ,
        Promo_Sale_Price_Home ,
        Promo_Sale_Price_Curr ,
        Discount_Value_Home ,
        Discount_Value_Curr ,
        VAT_Value_Home ,
        VAT_Value_Curr ,
        Cost_Price_Home ,
        Cost_Price_Curr ,
        Gorss_Sale_Value_Home ,
        Gross_Sale_Value_Curr,
		FP_Qty,
		MD_Qty,
		Sale_Qty
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
	FROM dbo.VIP_Sale_Day_Fact
	UNION ALL
	SELECT  
		VIP_Customer_Dim_ID ,
		Calendar_Dim_ID ,
		Item_Dim_ID ,
		Return_Price ,
		Store_Dim_ID ,
		Actual_FP_Return_Price_Home ,
		ACtual_FP_Return_Price_Curr ,
		Actual_MD_Return_Price_Home ,
		Actual_MD_Return_Price_Curr ,
		Promo_Return_Price_Home ,
		Promo_Return_Price_Curr ,
		Discount_Value_Home ,
		Discount_Value_Curr ,
		VAT_Value_Home ,
		VAT_Value_Curr ,
		Cost_Price_Home ,
		Cost_Price_Curr ,
		Gorss_Return_Value_Home ,
		Gross_Return_Value_Curr,
		FP_Qty,
		MD_Qty,
		Return_Qty
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
	FROM dbo.VIP_Return_Day_Fact
)
INSERT INTO dbo.VIP_Net_Sale_Day_Fact (
	VIP_Customer_Dim_ID ,
    Calendar_Dim_ID ,
    Item_Dim_ID ,
    Sale_Price ,
    Store_Dim_ID ,
    Actual_FP_Sale_Price_Home ,
    ACtual_FP_Sale_Price_Curr ,
    Actual_MD_Sale_Price_Home ,
    Actual_MD_Sale_Price_Curr ,
    Promo_Sale_Price_Home ,
    Promo_Sale_Price_Curr ,
    Discount_Value_Home ,
    Discount_Value_Curr ,
    VAT_Value_Home ,
    VAT_Value_Curr ,
    Cost_Price_Home ,
    Cost_Price_Curr ,
    Gorss_Sale_Value_Home ,
    Gross_Sale_Value_Curr,
	FP_Qty,
	MD_Qty,
	Sale_Qty
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
	VIP_Customer_Dim_ID ,
    Calendar_Dim_ID ,
    Item_Dim_ID ,
    SUM(Sale_Price) Sale_Price ,
    Store_Dim_ID ,
    SUM(Actual_FP_Sale_Price_Home) AS Actual_FP_Sale_Price_Home ,
    SUM(ACtual_FP_Sale_Price_Curr) AS ACtual_FP_Sale_Price_Curr ,
    SUM(Actual_MD_Sale_Price_Home) AS Actual_MD_Sale_Price_Home ,
    SUM(Actual_MD_Sale_Price_Curr) AS Actual_MD_Sale_Price_Curr ,
    SUM(Promo_Sale_Price_Home) AS Promo_Sale_Price_Home ,
    SUM(Promo_Sale_Price_Curr) AS Promo_Sale_Price_Curr ,
    SUM(Discount_Value_Home) AS Discount_Value_Home ,
    SUM(Discount_Value_Curr) AS Discount_Value_Curr ,
    SUM(VAT_Value_Home) AS VAT_Value_Home ,
    SUM(VAT_Value_Curr) AS VAT_Value_Curr ,
    SUM(Cost_Price_Home) AS Cost_Price_Home ,
    SUM(Cost_Price_Curr) AS Cost_Price_Curr ,
    SUM(Gorss_Sale_Value_Home) AS Gorss_Sale_Value_Home ,
    SUM(Gross_Sale_Value_Curr) AS Gross_Sale_Value_Curr,
	SUM(FP_Qty) AS FP_Qty,
	SUM(MD_Qty) AS MD_Qty,
	SUM(Sale_Qty) AS Sale_Qty
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
FROM net
GROUP BY 
	VIP_Customer_Dim_ID ,
    Calendar_Dim_ID ,
    Item_Dim_ID ,
	Store_Dim_ID

SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_VIP_Net_Sale_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
