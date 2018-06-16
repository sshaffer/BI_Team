SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[International_Net_Sales_Week_Fact_View]
AS

SELECT
   wk.Calendar_Week_Dim_Id
   ,f.International_Partner_Dim_ID
   ,f.Item_Dim_ID
   ,SUM(f.Sale_Qty					   ) AS Sale_Qty
   ,SUM(f.Actual_FP_Sales_Value_Home   ) AS Actual_FP_Sales_Value_Home
   ,SUM(f.Actual_FP_Sales_Value_Curr   ) AS Actual_FP_Sales_Value_Curr
   ,SUM(f.Actual_MD_Sales_Value_Home   ) AS Actual_MD_Sales_Value_Home
   ,SUM(f.Actual_MD_Sales_Value_Curr   ) AS Actual_MD_Sales_Value_Curr
   ,SUM(f.Discount_Value_Home		   ) AS Discount_Value_Home
   ,SUM(f.Discount_Value_Curr		   ) AS Discount_Value_Curr
   ,SUM(f.Original_Sales_Value_Home	   ) AS Original_Sales_Value_Home
   ,SUM(f.Original_Sales_Value_Curr	   ) AS Original_Sales_Value_Curr
   ,SUM(f.VAT_Value_Home			   ) AS VAT_Value_Home
   ,SUM(f.VAT_Value_Curr			   ) AS VAT_Value_Curr
   ,SUM(f.Gross_Sales_Value_Home	   ) AS Gross_Sales_Value_Home
   ,SUM(f.Gross_Sales_Value_Curr	   ) AS Gross_Sales_Value_Curr
   ,SUM(f.Cost_of_Markdown_Home		   ) AS Cost_of_Markdown_Home
   ,SUM(f.Cost_of_Markdown_Curr		   ) AS Cost_of_Markdown_Curr
   ,SUM(f.FP_Qty					   ) AS FP_Qty
   ,SUM(f.MD_Qty					   ) AS MD_Qty
   ,SUM(f.FP_Sales_Value_AED		   ) AS FP_Sales_Value_AED
   ,SUM(f.MD_Sales_Value_AED		   ) AS MD_Sales_Value_AED
   ,SUM(f.Discount_Value_AED		   ) AS Discount_Value_AED
   ,SUM(f.Original_Sales_Value_AED	   ) AS Original_Sales_Value_AED
   ,SUM(f.Original_VAT_AED			   ) AS Original_VAT_AED
   ,SUM(f.Gross_Sales_Value_AED		   ) AS Gross_Sales_Value_AED
   ,SUM(f.Cost_of_Markdown_AED		   ) AS Cost_of_Markdown_AED
FROM dbo.International_Net_Sales_Day_Fact_View f
JOIN  dbo.Calendar_Dim cal
	ON cal.Calendar_Dim_Id = f.Sale_Date_Dim_ID
JOIN dbo.Calendar_Week_Dim wk
	ON wk.Fiscal_Year = cal.Fiscal_Year
	AND wk.Fiscal_Week = cal.Fiscal_Week
GROUP BY 
	wk.Calendar_Week_Dim_Id
   ,f.International_Partner_Dim_ID
   ,f.Item_Dim_ID
	




GO
