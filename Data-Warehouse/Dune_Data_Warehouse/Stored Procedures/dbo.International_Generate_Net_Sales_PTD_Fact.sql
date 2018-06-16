SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[International_Generate_Net_Sales_PTD_Fact]
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
EXEC dbo.Log_Start @Source, 'International_Generate_Net_Sales_PTD_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

TRUNCATE TABLE International_Net_Sales_PTD_Fact;

INSERT INTO dbo.International_Net_Sales_PTD_Fact (
	International_Partner_Dim_ID
	,Item_Dim_ID
	,Sale_Qty
	,Actual_FP_Sales_Value_Home
	,Actual_FP_Sales_Value_Curr
	,Actual_MD_Sales_Value_Home
	,Actual_MD_Sales_Value_Curr
	,Discount_Value_Home
	,Discount_Value_Curr
	,Original_Sales_Value_Home
	,Original_Sales_Value_Curr
	,VAT_Value_Home
	,VAT_Value_Curr
	,Gross_Sales_Value_Home
	,Gross_Sales_Value_Curr
	,Cost_of_Markdown_Home
	,Cost_of_Markdown_Curr
	,FP_Qty
	,MD_Qty
)
SELECT 
	f.International_Partner_Dim_ID
	,f.Item_Dim_ID
	,SUM(f.Sale_Qty) Sale_Qty
	,SUM(f.Actual_FP_Sales_Value_Home) Actual_FP_Sales_Value_Home
	,SUM(f.Actual_FP_Sales_Value_Curr) Actual_FP_Sales_Value_Curr
	,SUM(f.Actual_MD_Sales_Value_Home) Actual_MD_Sales_Value_Home
	,SUM(f.Actual_MD_Sales_Value_Curr) Actual_MD_Sales_Value_Curr
	,SUM(f.Discount_Value_Home) Discount_Value_Home
	,SUM(f.Discount_Value_Curr) Discount_Value_Curr
	,SUM(f.Original_Sales_Value_Home) Original_Sales_Value_Home
	,SUM(f.Original_Sales_Value_Curr) Original_Sales_Value_Curr
	,SUM(f.VAT_Value_Home) VAT_Value_Home
	,SUM(f.VAT_Value_Curr) VAT_Value_Curr
	,SUM(f.Gross_Sales_Value_Home) Gross_Sales_Value_Home
	,SUM(f.Gross_Sales_Value_Curr) Gross_Sales_Value_Curr
	,SUM(f.Cost_of_Markdown_Home) Cost_of_Markdown_Home
	,SUM(f.Cost_of_Markdown_Curr) Cost_of_Markdown_Curr
	,SUM(f.FP_Qty) FP_Qty
	,SUM(f.MD_Qty) MD_Qty
FROM dbo.International_Net_Sales_Day_Fact f
JOIN Calendar_Dim cal
	ON cal.Calendar_Dim_ID = f.Sale_Date_Dim_ID
WHERE cal.Current_Period = 0
AND cal.Current_Year = 0
AND cal.Current_Week < 0
GROUP BY 
	f.International_Partner_Dim_ID
	,f.Item_Dim_ID

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.International_Generate_Net_Sales_PTD_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
