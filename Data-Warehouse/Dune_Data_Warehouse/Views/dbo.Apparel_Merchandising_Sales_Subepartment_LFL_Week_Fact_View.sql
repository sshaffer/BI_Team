
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[Apparel_Merchandising_Sales_Subepartment_LFL_Week_Fact_View]
AS

SELECT
	f.Calendar_Week_Dim_Id
   ,f.Store_Dim_ID
   ,f.Item_Dim_ID
   ,CASE WHEN lfl.LFL = 1 THEN f.Sales_Qty ELSE 0 END AS Sales_Qty_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.FP_Qty ELSE 0 END AS FP_Qty_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.MD_Qty ELSE 0 END AS MD_Qty_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_Curr ELSE 0 END AS Actual_Sales_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_FP_Curr ELSE 0 END AS Actual_Sales_Value_FP_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_MD_Curr ELSE 0 END AS Actual_Sales_Value_MD_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_AED ELSE 0 END AS Actual_Sales_Value_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_FP_AED ELSE 0 END AS Actual_Sales_Value_FP_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_MD_AED ELSE 0 END AS Actual_Sales_Value_MD_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_GBP ELSE 0 END AS Actual_Sales_Value_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_FP_GBP ELSE 0 END AS Actual_Sales_Value_FP_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Actual_Sales_Value_MD_GBP ELSE 0 END AS Actual_Sales_Value_MD_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_Curr ELSE 0 END AS Discount_Value_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_FP_Curr ELSE 0 END AS Discount_Value_FP_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_MD_Curr ELSE 0 END AS Discount_Value_MD_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_AED ELSE 0 END AS Discount_Value_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_FP_AED ELSE 0 END AS Discount_Value_FP_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_MD_AED ELSE 0 END AS Discount_Value_MD_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_GBP ELSE 0 END AS Discount_Value_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_FP_GBP ELSE 0 END AS Discount_Value_FP_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Discount_Value_MD_GBP ELSE 0 END AS Discount_Value_MD_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_Curr ELSE 0 END AS Item_Cost_2_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_FP_Curr ELSE 0 END AS Item_Cost_2_FP_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_MD_Curr ELSE 0 END AS Item_Cost_2_MD_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_AED ELSE 0 END AS Item_Cost_2_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_FP_AED ELSE 0 END AS Item_Cost_2_FP_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_MD_AED ELSE 0 END AS Item_Cost_2_MD_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_GBP ELSE 0 END AS Item_Cost_2_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_FP_GBP ELSE 0 END AS Item_Cost_2_FP_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_MD_GBP ELSE 0 END AS Item_Cost_2_MD_GBP_LFL      
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_Curr ELSE 0 END AS Gross_Profit_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_AED ELSE 0 END AS Gross_Profit_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_GBP ELSE 0 END AS Gross_Profit_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_FP_Curr ELSE 0 END AS Gross_Profit_FP_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_FP_AED ELSE 0 END AS Gross_Profit_FP_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_FP_GBP ELSE 0 END AS Gross_Profit_FP_GBP_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_MD_Curr ELSE 0 END AS Gross_Profit_MD_Curr_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_MD_AED ELSE 0 END AS Gross_Profit_MD_AED_LFL
   ,CASE WHEN lfl.LFL = 1 THEN f.Gross_Profit_MD_GBP ELSE 0 END AS Gross_Profit_MD_GBP_LFL
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Sales_Qty ELSE 0 END AS Sales_Qty_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Qty ELSE 0 END AS FP_Qty_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Qty ELSE 0 END AS MD_Qty_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_Curr ELSE 0 END AS Actual_Sales_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_FP_Curr ELSE 0 END AS Actual_Sales_Value_FP_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_MD_Curr ELSE 0 END AS Actual_Sales_Value_MD_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_AED ELSE 0 END AS Actual_Sales_Value_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_FP_AED ELSE 0 END AS Actual_Sales_Value_FP_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_MD_AED ELSE 0 END AS Actual_Sales_Value_MD_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_GBP ELSE 0 END AS Actual_Sales_Value_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_FP_GBP ELSE 0 END AS Actual_Sales_Value_FP_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Actual_Sales_Value_MD_GBP ELSE 0 END AS Actual_Sales_Value_MD_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_Curr ELSE 0 END AS Discount_Value_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_FP_Curr ELSE 0 END AS Discount_Value_FP_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_MD_Curr ELSE 0 END AS Discount_Value_MD_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_AED ELSE 0 END AS Discount_Value_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_FP_AED ELSE 0 END AS Discount_Value_FP_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_MD_AED ELSE 0 END AS Discount_Value_MD_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_GBP ELSE 0 END AS Discount_Value_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_FP_GBP ELSE 0 END AS Discount_Value_FP_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Discount_Value_MD_GBP ELSE 0 END AS Discount_Value_MD_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_Curr ELSE 0 END AS Item_Cost_2_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_FP_Curr ELSE 0 END AS Item_Cost_2_FP_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_MD_Curr ELSE 0 END AS Item_Cost_2_MD_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_AED ELSE 0 END AS Item_Cost_2_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_FP_AED ELSE 0 END AS Item_Cost_2_FP_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_MD_AED ELSE 0 END AS Item_Cost_2_MD_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_GBP ELSE 0 END AS Item_Cost_2_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_FP_GBP ELSE 0 END AS Item_Cost_2_FP_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_MD_GBP ELSE 0 END AS Item_Cost_2_MD_GBP_LFL_LY      
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_Curr ELSE 0 END AS Gross_Profit_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_AED ELSE 0 END AS Gross_Profit_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_GBP ELSE 0 END AS Gross_Profit_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_FP_Curr ELSE 0 END AS Gross_Profit_FP_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_FP_AED ELSE 0 END AS Gross_Profit_FP_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_FP_GBP ELSE 0 END AS Gross_Profit_FP_GBP_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_MD_Curr ELSE 0 END AS Gross_Profit_MD_Curr_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_MD_AED ELSE 0 END AS Gross_Profit_MD_AED_LFL_LY
   ,CASE WHEN lfl.LFL_LY = 1 THEN f.Gross_Profit_MD_GBP ELSE 0 END AS Gross_Profit_MD_GBP_LFL_LY   
FROM
    dbo.Apparel_Store_Item_Net_Sale_Week_Fact f
JOIN dbo.Item_Dim i
    ON i.Item_Dim_ID = f.Item_Dim_ID
JOIN dbo.Apparel_Merchandising_Subdepartment_LFL_Week_Fact lfl
    ON lfl.Store_Dim_ID = f.Store_Dim_ID
       AND lfl.Subdepartment_Dim_ID = i.Subdepartment_Dim_ID
       AND lfl.Calendar_Week_Dim_ID = f.Calendar_Week_Dim_Id



GO
