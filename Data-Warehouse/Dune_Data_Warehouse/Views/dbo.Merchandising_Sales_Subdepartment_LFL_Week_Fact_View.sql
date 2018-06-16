SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[Merchandising_Sales_Subdepartment_LFL_Week_Fact_View]
AS
SELECT
    f.Sale_Week_Dim_ID
   ,f.Item_Dim_ID
   ,f.Store_Dim_ID
   ,f.Channel_Dim_ID
   ,f.Currency_Dim_ID
   ,CASE WHEN lfl.LFL = 1 THEN f.Sales_Qty
         ELSE 0
    END AS Sales_Qty_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Cost_Value_Home
         ELSE 0
    END AS Cost_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Cost_Value_Curr
         ELSE 0
    END AS Cost_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_Home
         ELSE 0
    END AS Actual_Sales_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_Curr
         ELSE 0
    END AS Actual_Sales_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Sales_Value_Home
         ELSE 0
    END AS Gross_Sales_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Sales_Value_Curr
         ELSE 0
    END AS Gross_Sales_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_FP_Sales_Value_Home
         ELSE 0
    END AS Actual_FP_Sales_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_FP_Sales_Value_Curr
         ELSE 0
    END AS Actual_FP_Sales_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_MD_Sales_Value_Home
         ELSE 0
    END AS Actual_MD_Sales_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_MD_Sales_Value_Curr
         ELSE 0
    END AS Actual_MD_Sales_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Promo_Sales_Value_Home
         ELSE 0
    END AS Actual_Promo_Sales_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Promo_Sales_Value_Curr
         ELSE 0
    END AS Actual_Promo_Sales_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Cost_of_Markdown_Value_Home
         ELSE 0
    END AS Cost_of_Markdown_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Cost_of_Markdown_Value_Curr
         ELSE 0
    END AS Cost_of_Markdown_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Cost_of_Promo_Value_Home
         ELSE 0
    END AS Cost_of_Promo_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Cost_of_Promo_Value_Curr
         ELSE 0
    END AS Cost_of_Promo_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gift_Card_Value_Home
         ELSE 0
    END AS Gift_Card_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gift_Card_Value_Curr
         ELSE 0
    END AS Gift_Card_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_Home
         ELSE 0
    END AS Discount_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_Curr
         ELSE 0
    END AS Discount_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.VAT_Value_Home
         ELSE 0
    END AS VAT_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.VAT_Value_Curr
         ELSE 0
    END AS VAT_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_Value_Home
         ELSE 0
    END AS Gross_Profit_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_Value_Curr
         ELSE 0
    END AS Gross_Profit_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_Qty
         ELSE 0
    END AS FP_Qty_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_Qty
         ELSE 0
    END AS MD_Qty_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_VAT_Value_Home
         ELSE 0
    END AS FP_VAT_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_VAT_Value_Curr
         ELSE 0
    END AS FP_VAT_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_VAT_Value_Home
         ELSE 0
    END AS MD_VAT_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_VAT_Value_Curr
         ELSE 0
    END AS MD_VAT_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_Cost_Value_Home
         ELSE 0
    END AS FP_Cost_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_Cost_Value_Curr
         ELSE 0
    END AS FP_Cost_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_Cost_Value_Home
         ELSE 0
    END AS MD_Cost_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_Cost_Value_Curr
         ELSE 0
    END AS MD_Cost_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_Gross_Profit_Value_Home
         ELSE 0
    END AS FP_Gross_Profit_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_Gross_Profit_Value_Curr
         ELSE 0
    END AS FP_Gross_Profit_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_Gross_Profit_Value_Home
         ELSE 0
    END AS MD_Gross_Profit_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_Gross_Profit_Value_Curr
         ELSE 0
    END AS MD_Gross_Profit_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Net_Sale_Value_Home
         ELSE 0
    END AS Net_Sale_Value_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Net_Sale_Value_FP_Home
         ELSE 0
    END AS Net_Sale_Value_FP_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Net_Sale_Value_MD_Home
         ELSE 0
    END AS Net_Sale_Value_MD_Home_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Net_Sale_Value_Curr
         ELSE 0
    END AS Net_Sale_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Net_Sale_Value_FP_Curr
         ELSE 0
    END AS Net_Sale_Value_FP_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Net_Sale_Value_MD_Curr
         ELSE 0
    END AS Net_Sale_Value_MD_Curr_LFL
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Sales_Qty
         ELSE 0
    END AS Sales_Qty_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Cost_Value_Home
         ELSE 0
    END AS Cost_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Cost_Value_Curr
         ELSE 0
    END AS Cost_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_Home
         ELSE 0
    END AS Actual_Sales_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_Curr
         ELSE 0
    END AS Actual_Sales_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Sales_Value_Home
         ELSE 0
    END AS Gross_Sales_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Sales_Value_Curr
         ELSE 0
    END AS Gross_Sales_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_FP_Sales_Value_Home
         ELSE 0
    END AS Actual_FP_Sales_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_FP_Sales_Value_Curr
         ELSE 0
    END AS Actual_FP_Sales_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_MD_Sales_Value_Home
         ELSE 0
    END AS Actual_MD_Sales_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_MD_Sales_Value_Curr
         ELSE 0
    END AS Actual_MD_Sales_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Promo_Sales_Value_Home
         ELSE 0
    END AS Actual_Promo_Sales_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Promo_Sales_Value_Curr
         ELSE 0
    END AS Actual_Promo_Sales_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Cost_of_Markdown_Value_Home
         ELSE 0
    END AS Cost_of_Markdown_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Cost_of_Markdown_Value_Curr
         ELSE 0
    END AS Cost_of_Markdown_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Cost_of_Promo_Value_Home
         ELSE 0
    END AS Cost_of_Promo_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Cost_of_Promo_Value_Curr
         ELSE 0
    END AS Cost_of_Promo_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gift_Card_Value_Home
         ELSE 0
    END AS Gift_Card_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gift_Card_Value_Curr
         ELSE 0
    END AS Gift_Card_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_Home
         ELSE 0
    END AS Discount_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_Curr
         ELSE 0
    END AS Discount_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.VAT_Value_Home
         ELSE 0
    END AS VAT_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.VAT_Value_Curr
         ELSE 0
    END AS VAT_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_Value_Home
         ELSE 0
    END AS Gross_Profit_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_Value_Curr
         ELSE 0
    END AS Gross_Profit_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Qty
         ELSE 0
    END AS FP_Qty_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Qty
         ELSE 0
    END AS MD_Qty_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_VAT_Value_Home
         ELSE 0
    END AS FP_VAT_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_VAT_Value_Curr
         ELSE 0
    END AS FP_VAT_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_VAT_Value_Home
         ELSE 0
    END AS MD_VAT_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_VAT_Value_Curr
         ELSE 0
    END AS MD_VAT_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Cost_Value_Home
         ELSE 0
    END AS FP_Cost_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Cost_Value_Curr
         ELSE 0
    END AS FP_Cost_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Cost_Value_Home
         ELSE 0
    END AS MD_Cost_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Cost_Value_Curr
         ELSE 0
    END AS MD_Cost_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Gross_Profit_Value_Home
         ELSE 0
    END AS FP_Gross_Profit_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Gross_Profit_Value_Curr
         ELSE 0
    END AS FP_Gross_Profit_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Gross_Profit_Value_Home
         ELSE 0
    END AS MD_Gross_Profit_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Gross_Profit_Value_Curr
         ELSE 0
    END AS MD_Gross_Profit_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Net_Sale_Value_Home
         ELSE 0
    END AS Net_Sale_Value_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Net_Sale_Value_FP_Home
         ELSE 0
    END AS Net_Sale_Value_FP_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Net_Sale_Value_MD_Home
         ELSE 0
    END AS Net_Sale_Value_MD_Home_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Net_Sale_Value_Curr
         ELSE 0
    END AS Net_Sale_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Net_Sale_Value_FP_Curr
         ELSE 0
    END AS Net_Sale_Value_FP_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Net_Sale_Value_MD_Curr
         ELSE 0
    END AS Net_Sale_Value_MD_Curr_LFL_LY
FROM
    dbo.Sale_Week_Fact f
JOIN dbo.Item_Dim i
    ON i.Item_Dim_ID = f.Item_Dim_ID
JOIN dbo.Merchandising_Subdepartment_LFL_Week_Fact lfl
    ON lfl.Store_Dim_ID = f.Store_Dim_ID
       AND lfl.Subdepartment_Dim_ID = i.Subdepartment_Dim_ID
       AND lfl.Calendar_Week_Dim_ID = f.Sale_Week_Dim_ID


GO
