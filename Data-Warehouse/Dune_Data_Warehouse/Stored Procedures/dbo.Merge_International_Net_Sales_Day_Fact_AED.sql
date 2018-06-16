SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_International_Net_Sales_Day_Fact_AED]
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
EXEC dbo.Log_Start @Source, 'Merge_International_Net_Sales_Day_Fact_AED', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.[International_Net_Sales_Day_Fact_AED] target
USING
    ( SELECT
        f.Sale_Date_Dim_ID
       ,f.International_Partner_Dim_ID
       ,f.Item_Dim_ID
       ,f.Sale_Qty
       ,f.Actual_FP_Sales_Value_Home
       ,f.Actual_FP_Sales_Value_Curr
       ,f.Actual_MD_Sales_Value_Home
       ,f.Actual_MD_Sales_Value_Curr
       ,f.Discount_Value_Home
       ,f.Discount_Value_Curr
       ,f.Original_Sales_Value_Home
       ,f.Original_Sales_Value_Curr
       ,f.VAT_Value_Home
       ,f.VAT_Value_Curr
       ,f.Gross_Sales_Value_Home
       ,f.Gross_Sales_Value_Curr
       ,f.Cost_of_Markdown_Home
       ,f.Cost_of_Markdown_Curr
       ,f.FP_Qty
       ,f.MD_Qty
       ,FP_Sales_Value_AED = CONVERT(MONEY, Actual_FP_Sales_Value_Home
        / exchRate.Rate)
       ,MD_Sales_Value_AED = CONVERT(MONEY, Actual_MD_Sales_Value_Home
        / exchRate.Rate)
       ,Discount_Value_AED = CONVERT(MONEY, Discount_Value_Home
        / exchRate.Rate)
       ,Original_Sales_Value_AED = CONVERT(MONEY, Original_Sales_Value_Home
        / exchRate.Rate)
       ,Original_VAT_AED = CONVERT(MONEY, VAT_Value_Home / exchRate.Rate)
       ,Gross_Sales_Value_AED = CONVERT(MONEY, Gross_Sales_Value_Home
        / exchRate.Rate)
       ,Cost_of_Markdown_AED = CONVERT(MONEY, Cost_of_Markdown_Home
        / exchRate.Rate)
      FROM
        dbo.International_Net_Sales_Day_Fact f
      JOIN
        dbo.International_Partner_Dim p
        ON p.International_Partner_Dim_ID = f.International_Partner_Dim_ID
      JOIN
        dbo.Calendar_Dim cal
        ON cal.Calendar_Dim_Id = f.Sale_Date_Dim_ID
      LEFT JOIN ( SELECT
                    Currency_Code
                   ,From_Date
                   ,To_Date
                   ,Rate
                  FROM
                    dbo.International_Currency_Conversion_Rate_Fact_View
                  WHERE
                    Currency_Code = 'AED'
                ) exchRate
        ON cal.Calendar_Date BETWEEN exchRate.From_Date
                             AND     exchRate.To_Date
    ) source
ON source.Sale_Date_Dim_ID = target.Sale_Date_Dim_ID
    AND source.International_Partner_Dim_ID = target.International_Partner_Dim_ID
    AND source.Item_Dim_ID = target.Item_Dim_ID
WHEN MATCHED THEN
    UPDATE SET
               Sale_Qty = source.Sale_Qty
              ,Actual_FP_Sales_Value_Home = source.Actual_FP_Sales_Value_Home
              ,Actual_FP_Sales_Value_Curr = source.Actual_FP_Sales_Value_Curr
              ,Actual_MD_Sales_Value_Home = source.Actual_MD_Sales_Value_Home
              ,Actual_MD_Sales_Value_Curr = source.Actual_MD_Sales_Value_Curr
              ,Discount_Value_Home = source.Discount_Value_Home
              ,Discount_Value_Curr = source.Discount_Value_Curr
              ,Original_Sales_Value_Home = source.Original_Sales_Value_Home
              ,Original_Sales_Value_Curr = source.Original_Sales_Value_Curr
              ,VAT_Value_Home = source.VAT_Value_Home
              ,VAT_Value_Curr = source.VAT_Value_Curr
              ,Gross_Sales_Value_Home = source.Gross_Sales_Value_Home
              ,Gross_Sales_Value_Curr = source.Gross_Sales_Value_Curr
              ,Cost_of_Markdown_Home = source.Cost_of_Markdown_Home
              ,Cost_of_Markdown_Curr = source.Cost_of_Markdown_Curr
              ,FP_Qty = source.FP_Qty
              ,MD_Qty = source.MD_Qty
              ,FP_Sales_Value_AED = source.FP_Sales_Value_AED
              ,MD_Sales_Value_AED = source.MD_Sales_Value_AED
              ,Discount_Value_AED = source.Discount_Value_AED
              ,Original_Sales_Value_AED = source.Original_Sales_Value_AED
              ,Original_VAT_AED = source.Original_VAT_AED
              ,Gross_Sales_Value_AED = source.Gross_Sales_Value_AED
              ,Cost_of_Markdown_AED = source.Cost_of_Markdown_AED
WHEN NOT MATCHED THEN
    INSERT
           (Sale_Date_Dim_ID
           ,International_Partner_Dim_ID
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
           ,FP_Sales_Value_AED
           ,MD_Sales_Value_AED
           ,Discount_Value_AED
           ,Original_Sales_Value_AED
           ,Original_VAT_AED
           ,Gross_Sales_Value_AED
           ,Cost_of_Markdown_AED
           )
    VALUES (source.Sale_Date_Dim_ID
           ,source.International_Partner_Dim_ID
           ,source.Item_Dim_ID
           ,source.Sale_Qty
           ,source.Actual_FP_Sales_Value_Home
           ,source.Actual_FP_Sales_Value_Curr
           ,source.Actual_MD_Sales_Value_Home
           ,source.Actual_MD_Sales_Value_Curr
           ,source.Discount_Value_Home
           ,source.Discount_Value_Curr
           ,source.Original_Sales_Value_Home
           ,source.Original_Sales_Value_Curr
           ,source.VAT_Value_Home
           ,source.VAT_Value_Curr
           ,source.Gross_Sales_Value_Home
           ,source.Gross_Sales_Value_Curr
           ,source.Cost_of_Markdown_Home
           ,source.Cost_of_Markdown_Curr
           ,source.FP_Qty
           ,source.MD_Qty
           ,source.FP_Sales_Value_AED
           ,source.MD_Sales_Value_AED
           ,source.Discount_Value_AED
           ,source.Original_Sales_Value_AED
           ,source.Original_VAT_AED
           ,source.Gross_Sales_Value_AED
           ,source.Cost_of_Markdown_AED
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_International_Net_Sales_Day_Fact_AED: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
