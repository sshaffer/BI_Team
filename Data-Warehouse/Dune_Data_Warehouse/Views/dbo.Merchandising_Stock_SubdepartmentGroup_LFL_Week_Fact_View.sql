SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[Merchandising_Stock_SubdepartmentGroup_LFL_Week_Fact_View]
AS

SELECT
	 f.Calendar_Week_Dim_ID
	,f.Store_Dim_ID
	,f.Item_Dim_ID
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Hand_Qty ELSE 0 END AS Stock_in_Hand_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Hand_Cost_Value ELSE 0 END AS Stock_in_Hand_Cost_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_in_Hand_Full_Price_Sales_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_in_Hand_Markdown_Sales_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Transit_Qty ELSE 0 END AS Stock_in_Transit_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Transit_Cost_Value ELSE 0 END AS Stock_in_Transit_Cost_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Transit_Full_Price_Sales_Value ELSE 0 END AS Stock_in_Transit_Full_Price_Sales_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Transit_Markdown_Sales_Value ELSE 0 END AS Stock_in_Transit_Markdown_Sales_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_Net_in_Hand_Qty ELSE 0 END AS Stock_Net_in_Hand_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_Net_in_Hand_Cost_Value ELSE 0 END AS Stock_Net_in_Hand_Cost_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_Net_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_Net_in_Hand_Full_Price_Sales_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_Net_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_Net_in_Hand_Markdown_Sales_Value_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Hand_FP_Qty ELSE 0 END AS Stock_in_Hand_FP_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Hand_MD_Qty ELSE 0 END AS Stock_in_Hand_MD_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Transit_FP_Qty ELSE 0 END AS Stock_in_Transit_FP_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_in_Transit_MD_Qty ELSE 0 END AS Stock_in_Transit_MD_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_Net_in_Hand_FP_Qty ELSE 0 END AS Stock_Net_in_Hand_FP_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Stock_Net_in_Hand_MD_Qty ELSE 0 END AS Stock_Net_in_Hand_MD_Qty_LFL
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Hand_Qty ELSE 0 END AS Stock_in_Hand_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Hand_Cost_Value ELSE 0 END AS Stock_in_Hand_Cost_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_in_Hand_Full_Price_Sales_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_in_Hand_Markdown_Sales_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Transit_Qty ELSE 0 END AS Stock_in_Transit_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Transit_Cost_Value ELSE 0 END AS Stock_in_Transit_Cost_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Transit_Full_Price_Sales_Value ELSE 0 END AS Stock_in_Transit_Full_Price_Sales_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Transit_Markdown_Sales_Value ELSE 0 END AS Stock_in_Transit_Markdown_Sales_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_Net_in_Hand_Qty ELSE 0 END AS Stock_Net_in_Hand_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_Net_in_Hand_Cost_Value ELSE 0 END AS Stock_Net_in_Hand_Cost_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_Net_in_Hand_Full_Price_Sales_Value ELSE 0 END AS Stock_Net_in_Hand_Full_Price_Sales_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_Net_in_Hand_Markdown_Sales_Value ELSE 0 END AS Stock_Net_in_Hand_Markdown_Sales_Value_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Hand_FP_Qty ELSE 0 END AS Stock_in_Hand_FP_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Hand_MD_Qty ELSE 0 END AS Stock_in_Hand_MD_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Transit_FP_Qty ELSE 0 END AS Stock_in_Transit_FP_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_in_Transit_MD_Qty ELSE 0 END AS Stock_in_Transit_MD_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_Net_in_Hand_FP_Qty ELSE 0 END AS Stock_Net_in_Hand_FP_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Stock_Net_in_Hand_MD_Qty ELSE 0 END AS Stock_Net_in_Hand_MD_Qty_LFL_LY
FROM
    dbo.Store_Item_Stock_Week_Fact f
JOIN dbo.Product_Dim i
    ON i.Item_Dim_ID = f.Item_Dim_ID
JOIN dbo.Merchandising_SubdepartmentGroup_LFL_Week_Fact lfl
    ON lfl.Store_Dim_ID = f.Store_Dim_ID
       AND lfl.Subdepartment_Group_Dim_ID = i.Subdepartment_Group_Dim_ID
       AND lfl.Calendar_Week_Dim_ID = f.Calendar_Week_Dim_ID



GO
