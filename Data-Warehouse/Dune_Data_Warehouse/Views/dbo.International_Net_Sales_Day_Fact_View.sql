SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[International_Net_Sales_Day_Fact_View]
AS

SELECT 
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
	,FP_Sales_Value_AED = CONVERT(MONEY, Actual_FP_Sales_Value_Home / exchRate.Rate)
	,MD_Sales_Value_AED = CONVERT(MONEY,Actual_MD_Sales_Value_Home / exchRate.Rate)
	,Discount_Value_AED = CONVERT(MONEY,Discount_Value_Home / exchRate.Rate)
	,Original_Sales_Value_AED = CONVERT(MONEY,Original_Sales_Value_Home / exchRate.Rate)
	,Original_VAT_AED = CONVERT(MONEY,VAT_Value_Home / exchRate.Rate)
	,Gross_Sales_Value_AED = CONVERT(MONEY,Gross_Sales_Value_Home / exchRate.Rate)
	,Cost_of_Markdown_AED = CONVERT(MONEY,Cost_of_Markdown_Home / exchRate.Rate)
FROM dbo.International_Net_Sales_Day_Fact f
JOIN dbo.International_Partner_Dim p 
	ON p.International_Partner_Dim_ID = f.International_Partner_Dim_ID
JOIN dbo.Calendar_Dim cal 
	ON cal.Calendar_Dim_Id = f.Sale_Date_Dim_ID
LEFT JOIN (
	SELECT Currency_Code
		,From_Date
		,To_Date
		,Rate
	FROM dbo.International_Currency_Conversion_Rate_Fact_View
	WHERE Currency_Code = 'AED'
	) exchRate 
		ON cal.Calendar_Date BETWEEN exchRate.From_Date
		AND exchRate.To_Date




GO
