
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[Store_Item_Stock_Week_Fact_View]
AS
SELECT
    f.Calendar_Week_Dim_ID
   ,f.Store_Dim_ID
   ,f.Item_Dim_ID
   ,f.Stock_in_Hand_Qty
   ,f.Stock_in_Hand_Cost_Value
   ,f.Stock_in_Hand_Full_Price_Sales_Value
   ,f.Stock_in_Hand_Markdown_Sales_Value
   ,f.Stock_in_Transit_Qty
   ,f.Stock_in_Transit_Cost_Value
   ,f.Stock_in_Transit_Full_Price_Sales_Value
   ,f.Stock_in_Transit_Markdown_Sales_Value
   ,f.Stock_Net_in_Hand_Qty
   ,f.Stock_Net_in_Hand_Cost_Value
   ,f.Stock_Net_in_Hand_Full_Price_Sales_Value
   ,f.Stock_Net_in_Hand_Markdown_Sales_Value
   ,f.Stock_in_Hand_FP_Qty
   ,f.Stock_in_Hand_MD_Qty
   ,f.Stock_in_Transit_FP_Qty
   ,f.Stock_in_Transit_MD_Qty
   ,f.Stock_Net_in_Hand_FP_Qty
   ,f.Stock_Net_in_Hand_MD_Qty
   /* Store LFL */
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Stock_in_Hand_Qty ELSE 0 END AS Stock_In_Hand_LFL_Qty
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Stock_in_Hand_FP_Qty ELSE 0 END AS Stock_In_Hand_LFL_FP_Qty
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Stock_in_Hand_MD_Qty ELSE 0 END AS Stock_In_Hand_LFL_MD_Qty
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value + f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_LFL_Value
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_In_Hand_LFL_FP_Value
   ,CASE WHEN lfl.Store_LFL = 1 THEN f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_LFL_MD_Value
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Stock_in_Hand_Qty ELSE 0 END AS Stock_In_Hand_LFL_LY_Qty
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Stock_in_Hand_FP_Qty ELSE 0 END AS Stock_In_Hand_LFL_LY_FP_Qty
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Stock_in_Hand_MD_Qty ELSE 0 END AS Stock_In_Hand_LFL_LY_MD_Qty
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value + Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_LFL_LY_Value
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_In_Hand_LFL_FP_LY_Value
   ,CASE WHEN lfl.Store_LFL_LY = 1 THEN f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_LFL_MD_LY_Value
   /* Merch LFL */
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Stock_in_Hand_Qty ELSE 0 END AS Stock_In_Hand_Merch_LFL_Qty
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Stock_in_Hand_FP_Qty ELSE 0 END AS Stock_In_Hand_Merch_LFL_FP_Qty
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Stock_in_Hand_MD_Qty ELSE 0 END AS Stock_In_Hand_Merch_LFL_MD_Qty
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value + f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_Merch_LFL_Value
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_In_Hand_Merch_LFL_FP_Value
   ,CASE WHEN merchLFL.Merch_LFL = 1 THEN f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_Merch_LFL_MD_Value
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Stock_in_Hand_Qty ELSE 0 END AS Stock_In_Hand_Merch_LFL_LY_Qty   
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Stock_in_Hand_FP_Qty ELSE 0 END AS Stock_In_Hand_Merch_LFL_LY_FP_Qty
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Stock_in_Hand_MD_Qty ELSE 0 END AS Stock_In_Hand_Merch_LFL_LY_MD_Qty
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value + f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_Merch_LFL_LY_Value
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_In_Hand_Merch_LFL_FP_LY_Value
   ,CASE WHEN merchLFL.Merch_LFL_LY = 1 THEN f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_In_Hand_Merch_LFL_MD_LY_Value
FROM dbo.Store_Item_Stock_Week_Fact f
LEFT JOIN dbo.Store_LFL_Week_Fact lfl
	ON lfl.Store_Dim_ID = f.Store_Dim_ID
	AND lfl.Sale_Week_Dim_ID = f.Calendar_Week_Dim_ID
JOIN Item_Dim i
	ON i.Item_Dim_ID = f.Item_Dim_ID
LEFT JOIN dbo.Merchandise_LFL_Week_Fact merchLFL
	ON merchLFL.Store_Dim_ID = f.Store_Dim_ID
	AND merchLFL.Calendar_Week_Dim_ID = f.Calendar_Week_Dim_ID
	AND merchLFL.Department_Dim_ID = i.Department_Dim_ID


GO
