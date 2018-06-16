SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_VIP_Sale_Trans_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_VIP_Sale_Trans_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.VIP_Sale_Trans_Fact target
USING Dune_Data_Warehouse_Staging..VIP_Sale_Trans_Fact source
ON source.ID_STR_RT = target.ID_STR_RT
    AND source.ID_WS = target.ID_WS
    AND source.AI_TRN = target.AI_TRN
    AND source.DC_DY_BSN = target.DC_DY_BSN
    AND source.AI_LN_ITM = target.AI_LN_ITM
    AND source.AI_SEQ = target.AI_SEQ
WHEN MATCHED THEN
    UPDATE SET
               VIP_Customer_Dim_ID = source.VIP_Customer_Dim_ID
              ,Calendar_Dim_ID = source.Calendar_Dim_ID
              ,Time_Dim_ID = source.Time_Dim_ID
              ,Item_Dim_ID = source.Item_Dim_ID
              ,Sale_Price = source.Sale_Price
              ,Store_Dim_ID = source.Store_Dim_ID
              ,Discount_Value = source.Discount_Value
              ,VAT_Value = source.VAT_Value
              ,Sale_Price_Curr = source.Sale_Price_Curr
              ,FP_Sale_Price = source.FP_Sale_Price
              ,FP_Sale_Price_Curr = source.FP_Sale_Price_Curr
              ,MD_Sale_Price = source.MD_Sale_Price
              ,MD_Sale_Price_Curr = source.MD_Sale_Price_Curr
              ,Discount_Value_Home = source.Discount_Value_Home
              ,Discount_Value_Curr = source.Discount_Value_Curr
              ,Cost_Price_Home = source.Cost_Price_Home
              ,Cost_Price_Curr = source.Cost_Price_Curr
              ,FP_Qty = source.FP_Qty
              ,MD_Qty = source.MD_Qty
              ,Qty = source.Qty
              ,VAT_Value_Home = source.VAT_Value_Home
              ,VAT_Value_Curr = source.VAT_Value_Curr
              ,Gross_Sales_Price_Home = source.Gross_Sales_Price_Home
              ,Gross_Sales_Price_Curr = source.Gross_Sales_Price_Curr
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
              ,MD_Gross_Progit_Value_Home = source.MD_Gross_Progit_Value_Home
              ,MD_Gross_Profit_Value_Curr = source.MD_Gross_Profit_Value_Curr
WHEN NOT MATCHED THEN
    INSERT
           (VIP_Customer_Dim_ID
           ,Calendar_Dim_ID
           ,Time_Dim_ID
           ,Item_Dim_ID
           ,Sale_Price
           ,Store_Dim_ID
           ,Discount_Value
           ,VAT_Value
           ,ID_STR_RT
           ,ID_WS
           ,AI_TRN
           ,DC_DY_BSN
           ,Sale_Price_Curr
           ,FP_Sale_Price
           ,FP_Sale_Price_Curr
           ,MD_Sale_Price
           ,MD_Sale_Price_Curr
           ,Discount_Value_Home
           ,Discount_Value_Curr
           ,Cost_Price_Home
           ,Cost_Price_Curr
           ,FP_Qty
           ,MD_Qty
           ,Qty
           ,VAT_Value_Home
           ,VAT_Value_Curr
           ,Gross_Sales_Price_Home
           ,Gross_Sales_Price_Curr
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
           ,MD_Gross_Progit_Value_Home
           ,MD_Gross_Profit_Value_Curr
           ,AI_LN_ITM
           ,AI_SEQ
           )
    VALUES (source.VIP_Customer_Dim_ID
           ,source.Calendar_Dim_ID
           ,source.Time_Dim_ID
           ,source.Item_Dim_ID
           ,source.Sale_Price
           ,source.Store_Dim_ID
           ,source.Discount_Value
           ,source.VAT_Value
           ,source.ID_STR_RT
           ,source.ID_WS
           ,source.AI_TRN
           ,source.DC_DY_BSN
           ,source.Sale_Price_Curr
           ,source.FP_Sale_Price
           ,source.FP_Sale_Price_Curr
           ,source.MD_Sale_Price
           ,source.MD_Sale_Price_Curr
           ,source.Discount_Value_Home
           ,source.Discount_Value_Curr
           ,source.Cost_Price_Home
           ,source.Cost_Price_Curr
           ,source.FP_Qty
           ,source.MD_Qty
           ,source.Qty
           ,source.VAT_Value_Home
           ,source.VAT_Value_Curr
           ,source.Gross_Sales_Price_Home
           ,source.Gross_Sales_Price_Curr
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
           ,source.MD_Gross_Progit_Value_Home
           ,source.MD_Gross_Profit_Value_Curr
           ,source.AI_LN_ITM
           ,source.AI_SEQ
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_VIP_Sale_Trans_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
