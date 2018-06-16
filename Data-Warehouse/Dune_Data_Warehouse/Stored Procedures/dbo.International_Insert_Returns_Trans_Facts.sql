SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[International_Insert_Returns_Trans_Facts]
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
EXEC dbo.Log_Start @Source, 'International_Insert_Returns_Trans_Facts', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.International_Return_Trans_Fact target
USING (
	SELECT
		 Return_Date_Dim_ID
		,Time_Dim_ID
		,International_Partner_Dim_ID
		,Item_Dim_ID
		,SUM(Return_Qty) AS Return_Qty
		,SUM(Actual_FP_Return_Value_Home) AS Actual_FP_Return_Value_Home
		,SUM(Actual_FP_Return_Value_Curr) AS Actual_FP_Return_Value_Curr
		,SUM(Actual_MD_Return_Value_Home) AS Actual_MD_Return_Value_Home
		,SUM(Actual_MD_Return_Value_Curr) AS Actual_MD_Return_Value_Curr
		,SUM(Discount_Value_Home) AS Discount_Value_Home
		,SUM(Discount_Value_Curr) AS Discount_Value_Curr
		,SUM(Original_Sales_Value_Home) AS Original_Sales_Value_Home 
		,SUM(Original_Sales_Value_Curr) AS Original_Sales_Value_Curr
		,SUM(VAT_Value_Home) AS VAT_Value_Home
		,SUM(VAT_Value_Curr) AS VAT_Value_Curr
		,SUM(Gross_Return_Value_Home) AS Gross_Return_Value_Home
		,SUM(Gross_Return_Value_Curr) AS Gross_Return_Value_Curr
		,SUM(Cost_of_Markdown_Home) AS Cost_of_Markdown_Home
		,SUM(Cost_of_Markdown_Curr)	AS Cost_of_Markdown_Curr
	FROM Dune_Data_Warehouse_Staging..International_Return_Trans_Fact
	GROUP BY
		 Return_Date_Dim_ID
		,Time_Dim_ID
		,International_Partner_Dim_ID
		,Item_Dim_ID
) source
	ON target.Return_Date_Dim_ID = source.Return_Date_Dim_ID
	AND target.Time_Dim_ID = source.Time_Dim_ID
	AND target.International_Partner_Dim_ID = source.International_Partner_Dim_ID
	AND target.Item_Dim_ID = source.Item_Dim_ID
WHEN MATCHED THEN 
UPDATE SET 
	 Return_Qty = source.Return_Qty
	,Actual_FP_Return_Value_Home  = source.Actual_FP_Return_Value_Home
	,Actual_FP_Return_Value_Curr  = source.Actual_FP_Return_Value_Curr
	,Actual_MD_Return_Value_Home  = source.Actual_MD_Return_Value_Home
	,Actual_MD_Return_Value_Curr  = source.Actual_MD_Return_Value_Curr
	,Discount_Value_Home  = source.Discount_Value_Home
	,Discount_Value_Curr  = source.Discount_Value_Curr
	,Original_Sales_Value_Home  = source.Original_Sales_Value_Home
	,Original_Sales_Value_Curr  = source.Original_Sales_Value_Curr
	,VAT_Value_Home  = source.VAT_Value_Home
	,VAT_Value_Curr  = source.VAT_Value_Curr
	,Gross_Return_Value_Home  = source.Gross_Return_Value_Home
	,Gross_Return_Value_Curr  = source.Gross_Return_Value_Curr
	,Cost_of_Markdown_Home  = source.Cost_of_Markdown_Home
	,Cost_of_Markdown_Curr  = source.Cost_of_Markdown_Curr
WHEN NOT MATCHED THEN
INSERT (
	Return_Date_Dim_ID
	,Time_Dim_ID
	,International_Partner_Dim_ID
	,Item_Dim_ID
	,Return_Qty 
	,Actual_FP_Return_Value_Home 
	,Actual_FP_Return_Value_Curr 
	,Actual_MD_Return_Value_Home 
	,Actual_MD_Return_Value_Curr 
	,Discount_Value_Home 
	,Discount_Value_Curr 
	,Original_Sales_Value_Home 
	,Original_Sales_Value_Curr 
	,VAT_Value_Home 
	,VAT_Value_Curr 
	,Gross_Return_Value_Home 
	,Gross_Return_Value_Curr 
	,Cost_of_Markdown_Home 
	,Cost_of_Markdown_Curr
) VALUES (
	 source.Return_Date_Dim_ID
	,source.Time_Dim_ID
	,source.International_Partner_Dim_ID
	,source.Item_Dim_ID
	,source.Return_Qty 
	,source.Actual_FP_Return_Value_Home 
	,source.Actual_FP_Return_Value_Curr 
	,source.Actual_MD_Return_Value_Home 
	,source.Actual_MD_Return_Value_Curr 
	,source.Discount_Value_Home 
	,source.Discount_Value_Curr 
	,source.Original_Sales_Value_Home 
	,source.Original_Sales_Value_Curr 
	,source.VAT_Value_Home 
	,source.VAT_Value_Curr 
	,source.Gross_Return_Value_Home 
	,source.Gross_Return_Value_Curr 
	,source.Cost_of_Markdown_Home 
	,source.Cost_of_Markdown_Curr
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.International_Insert_Returns_Trans_Facts: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
