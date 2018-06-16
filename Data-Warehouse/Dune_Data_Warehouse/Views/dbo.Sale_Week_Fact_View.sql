
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[Sale_Week_Fact_View]
AS
SELECT 
    f.Sale_Week_Dim_ID
   ,f.Item_Dim_ID
   ,f.Store_Dim_ID
   ,f.Channel_Dim_ID
   ,f.Currency_Dim_ID
   ,f.Sales_Qty
   ,f.Cost_Value_Home
   ,f.Cost_Value_Curr
   ,f.Actual_Sales_Value_Home
   ,f.Actual_Sales_Value_Curr
   ,f.Gross_Sales_Value_Home
   ,f.Gross_Sales_Value_Curr
   ,f.Actual_FP_Sales_Value_Home
   ,f.Actual_FP_Sales_Value_Curr
   ,f.Actual_MD_Sales_Value_Home
   ,f.Actual_MD_Sales_Value_Curr
   ,f.Actual_Promo_Sales_Value_Home
   ,f.Actual_Promo_Sales_Value_Curr
   ,f.Cost_of_Markdown_Value_Home
   ,f.Cost_of_Markdown_Value_Curr
   ,f.Cost_of_Promo_Value_Home
   ,f.Cost_of_Promo_Value_Curr
   ,f.Gift_Card_Value_Home
   ,f.Gift_Card_Value_Curr
   ,f.Discount_Value_Home
   ,f.Discount_Value_Curr
   ,f.VAT_Value_Home
   ,f.VAT_Value_Curr
   ,f.Gross_Profit_Value_Home
   ,f.Gross_Profit_Value_Curr
   ,f.FP_Qty
   ,f.MD_Qty
   ,f.FP_VAT_Value_Home
   ,f.FP_VAT_Value_Curr
   ,f.MD_VAT_Value_Home
   ,f.MD_VAT_Value_Curr
   ,f.FP_Cost_Value_Home
   ,f.FP_Cost_Value_Curr
   ,f.MD_Cost_Value_Home
   ,f.MD_Cost_Value_Curr
   ,f.FP_Gross_Profit_Value_Home
   ,f.FP_Gross_Profit_Value_Curr
   ,f.MD_Gross_Profit_Value_Home
   ,f.MD_Gross_Profit_Value_Curr
   ,f.Net_Sale_Value_Home
   ,f.Net_Sale_Value_FP_Home
   ,f.Net_Sale_Value_MD_Home
   ,f.Net_Sale_Value_Curr
   ,f.Net_Sale_Value_FP_Curr
   ,f.Net_Sale_Value_MD_Curr
   /* Store LFL */
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Net_Sale_Value_Home ELSE 0 END AS Net_Sale_Value_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Net_Sale_Value_FP_Home ELSE 0 END AS Net_Sale_Value_FP_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Net_Sale_Value_MD_Home ELSE 0 END AS Net_Sale_Value_MD_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Net_Sale_Value_Curr ELSE 0 END AS Net_Sale_Value_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Net_Sale_Value_FP_Curr ELSE 0 END AS Net_Sale_Value_FP_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Net_Sale_Value_MD_Curr ELSE 0 END AS Net_Sale_Value_MD_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Net_Sale_Value_Home ELSE 0 END AS Net_Sale_Value_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Net_Sale_Value_FP_Home ELSE 0 END AS Net_Sale_Value_FP_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Net_Sale_Value_MD_Home ELSE 0 END AS Net_Sale_Value_MD_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Net_Sale_Value_Curr ELSE 0 END AS Net_Sale_Value_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Net_Sale_Value_FP_Curr ELSE 0 END AS Net_Sale_Value_FP_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Net_Sale_Value_MD_Curr ELSE 0 END AS Net_Sale_Value_MD_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Gross_Profit_Value_Home ELSE 0 END AS Gross_Profit_Value_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.FP_Gross_Profit_Value_Home ELSE 0 END AS FP_Gross_Profit_Value_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.MD_Gross_Profit_Value_Home ELSE 0 END AS MD_Gross_Profit_Value_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Gross_Profit_Value_Curr ELSE 0 END AS Gross_Profit_Value_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.FP_Gross_Profit_Value_Curr ELSE 0 END AS FP_Gross_Profit_Value_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.MD_Gross_Profit_Value_Curr ELSE 0 END AS MD_Gross_Profit_Value_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Gross_Profit_Value_Home ELSE 0 END AS Gross_Profit_Value_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f. FP_Gross_Profit_Value_Home ELSE 0 END AS FP_Gross_Profit_Value_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f. MD_Gross_Profit_Value_Home ELSE 0 END AS MD_Gross_Profit_Value_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Gross_Profit_Value_Curr ELSE 0 END AS Gross_Profit_Value_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.FP_Gross_Profit_Value_Curr ELSE 0 END AS FP_Gross_Profit_Value_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.MD_Gross_Profit_Value_Curr ELSE 0 END AS MD_Gross_Profit_Value_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Actual_Sales_Value_Home ELSE 0 END AS Actual_Sale_Value_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Actual_FP_Sales_Value_Home ELSE 0 END AS Actual_FP_Sale_Value_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Actual_MD_Sales_Value_Home ELSE 0 END AS Actual_MD_Sale_Value_Home_Store_LFL
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Actual_Sales_Value_Home ELSE 0 END AS Actual_Sale_Value_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Actual_FP_Sales_Value_Home ELSE 0 END AS Actual_FP_Sale_Value_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Actual_MD_Sales_Value_Home ELSE 0 END AS Actual_MD_Sale_Value_Home_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Actual_Sales_Value_Curr ELSE 0 END AS Actual_Sale_Value_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Actual_FP_Sales_Value_Curr ELSE 0 END AS Actual_FP_Sale_Value_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Actual_MD_Sales_Value_Curr ELSE 0 END AS Actual_MD_Sale_Value_Curr_Store_LFL
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Actual_Sales_Value_Curr ELSE 0 END AS Actual_Sale_Value_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Actual_FP_Sales_Value_Curr ELSE 0 END AS Actual_FP_Sale_Value_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Actual_MD_Sales_Value_Curr ELSE 0 END AS Actual_MD_Sale_Value_Curr_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Sales_Qty ELSE 0 END AS Sale_Qty_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.FP_Qty ELSE 0 END AS FP_Qty_Store_LFL
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.MD_Qty ELSE 0 END AS MD_Qty_Store_LFL
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Sales_Qty ELSE 0 END AS Sale_Qty_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.FP_Qty ELSE 0 END AS FP_Qty_Store_LFL_LY
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.MD_Qty ELSE 0 END AS MD_Qty_Store_LFL_LY
   /* Merch LFL */
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Net_Sale_Value_Home ELSE 0 END AS Net_Sale_Value_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Net_Sale_Value_FP_Home ELSE 0 END AS Net_Sale_Value_FP_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Net_Sale_Value_MD_Home ELSE 0 END AS Net_Sale_Value_MD_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Net_Sale_Value_Curr ELSE 0 END AS Net_Sale_Value_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Net_Sale_Value_FP_Curr ELSE 0 END AS Net_Sale_Value_FP_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Net_Sale_Value_MD_Curr ELSE 0 END AS Net_Sale_Value_MD_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Net_Sale_Value_Home ELSE 0 END AS Net_Sale_Value_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Net_Sale_Value_FP_Home ELSE 0 END AS Net_Sale_Value_FP_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Net_Sale_Value_MD_Home ELSE 0 END AS Net_Sale_Value_MD_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Net_Sale_Value_Curr ELSE 0 END AS Net_Sale_Value_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Net_Sale_Value_FP_Curr ELSE 0 END AS Net_Sale_Value_FP_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Net_Sale_Value_MD_Curr ELSE 0 END AS Net_Sale_Value_MD_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Gross_Profit_Value_Home ELSE 0 END AS Gross_Profit_Value_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.FP_Gross_Profit_Value_Home ELSE 0 END AS FP_Gross_Profit_Value_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.MD_Gross_Profit_Value_Home ELSE 0 END AS MD_Gross_Profit_Value_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Gross_Profit_Value_Curr ELSE 0 END AS Gross_Profit_Value_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.FP_Gross_Profit_Value_Curr ELSE 0 END AS FP_Gross_Profit_Value_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.MD_Gross_Profit_Value_Curr ELSE 0 END AS MD_Gross_Profit_Value_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Gross_Profit_Value_Home ELSE 0 END AS Gross_Profit_Value_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f. FP_Gross_Profit_Value_Home ELSE 0 END AS FP_Gross_Profit_Value_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f. MD_Gross_Profit_Value_Home ELSE 0 END AS MD_Gross_Profit_Value_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Gross_Profit_Value_Curr ELSE 0 END AS Gross_Profit_Value_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.FP_Gross_Profit_Value_Curr ELSE 0 END AS FP_Gross_Profit_Value_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.MD_Gross_Profit_Value_Curr ELSE 0 END AS MD_Gross_Profit_Value_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Actual_Sales_Value_Home ELSE 0 END AS Actual_Sale_Value_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Actual_FP_Sales_Value_Home ELSE 0 END AS Actual_FP_Sale_Value_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Actual_MD_Sales_Value_Home ELSE 0 END AS Actual_MD_Sale_Value_Home_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Actual_Sales_Value_Home ELSE 0 END AS Actual_Sale_Value_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Actual_FP_Sales_Value_Home ELSE 0 END AS Actual_FP_Sale_Value_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Actual_MD_Sales_Value_Home ELSE 0 END AS Actual_MD_Sale_Value_Home_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Actual_Sales_Value_Curr ELSE 0 END AS Actual_Sale_Value_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Actual_FP_Sales_Value_Curr ELSE 0 END AS Actual_FP_Sale_Value_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Actual_MD_Sales_Value_Curr ELSE 0 END AS Actual_MD_Sale_Value_Curr_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Actual_Sales_Value_Curr ELSE 0 END AS Actual_Sale_Value_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Actual_FP_Sales_Value_Curr ELSE 0 END AS Actual_FP_Sale_Value_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Actual_MD_Sales_Value_Curr ELSE 0 END AS Actual_MD_Sale_Value_Curr_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Sales_Qty ELSE 0 END AS Sale_Qty_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.FP_Qty ELSE 0 END AS FP_Qty_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.MD_Qty ELSE 0 END AS MD_Qty_Merch_LFL
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Sales_Qty ELSE 0 END AS Sale_Qty_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.FP_Qty ELSE 0 END AS FP_Qty_Merch_LFL_LY
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.MD_Qty ELSE 0 END AS MD_Qty_Merch_LFL_LY
FROM dbo.Sale_Week_Fact f
LEFT JOIN dbo.Store_LFL_Week_Fact lfl
	ON lfl.Store_Dim_ID = f.Store_Dim_ID
	AND lfl.Sale_Week_Dim_ID = f.Sale_Week_Dim_ID
JOIN Item_Dim i
	ON i.Item_Dim_ID = f.Item_Dim_ID
LEFT JOIN dbo.Merchandise_LFL_Week_Fact merchLFL
	ON merchLFL.Store_Dim_ID = f.Store_Dim_ID
	AND merchLFL.Calendar_Week_Dim_ID = f.Sale_Week_Dim_ID
	AND merchLFL.Department_Dim_ID = i.Department_Dim_ID

GO
