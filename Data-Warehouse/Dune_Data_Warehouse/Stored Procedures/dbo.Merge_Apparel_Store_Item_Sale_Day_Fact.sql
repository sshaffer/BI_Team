SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Merge_Apparel_Store_Item_Sale_Day_Fact]
AS

MERGE INTO dbo.Apparel_Store_Item_Sale_Day_Fact target
USING (
	SELECT
		Store_Dim_ID
	   ,Calendar_Dim_Id
	   ,Item_Dim_ID
	   ,SUM(Sales_Qty) AS Sales_Qty
	   ,SUM(FP_Qty) AS FP_Qty
	   ,SUM(MD_Qty) AS MD_Qty
	   ,SUM(Actual_Sales_Value_Curr) AS Actual_Sales_Value_Curr
	   ,SUM(Actual_Sales_Value_FP_Curr) AS Actual_Sales_Value_FP_Curr
	   ,SUM(Actual_Sales_Value_MD_Curr) AS Actual_Sales_Value_MD_Curr
	   ,SUM(Actual_Sales_Value_AED) AS Actual_Sales_Value_AED
	   ,SUM(Actual_Sales_Value_FP_AED) AS Actual_Sales_Value_FP_AED
	   ,SUM(Actual_Sales_Value_MD_AED) AS Actual_Sales_Value_MD_AED
	   ,SUM(Actual_Sales_Value_GBP) AS Actual_Sales_Value_GBP
	   ,SUM(Actual_Sales_Value_FP_GBP) AS Actual_Sales_Value_FP_GBP
	   ,SUM(Actual_Sales_Value_MD_GBP) AS Actual_Sales_Value_MD_GBP
	   ,SUM(Discount_Value_Curr) AS Discount_Value_Curr
	   ,SUM(Discount_Value_FP_Curr) AS Discount_Value_FP_Curr
	   ,SUM(Discount_Value_MD_Curr) AS Discount_Value_MD_Curr
	   ,SUM(Discount_Value_AED) AS Discount_Value_AED
	   ,SUM(Discount_Value_FP_AED) AS Discount_Value_FP_AED
	   ,SUM(Discount_Value_MD_AED) AS Discount_Value_MD_AED
	   ,SUM(Discount_Value_GBP) AS Discount_Value_GBP
	   ,SUM(Discount_Value_FP_GBP) AS Discount_Value_FP_GBP
	   ,SUM(Discount_Value_MD_GBP) AS Discount_Value_MD_GBP
	   ,SUM(Item_Cost_2_Curr) AS Item_Cost_2_Curr
	   ,SUM(Item_Cost_2_FP_Curr) AS Item_Cost_2_FP_Curr
	   ,SUM(Item_Cost_2_MD_Curr) AS Item_Cost_2_MD_Curr
	   ,SUM(Item_Cost_2_AED) AS Item_Cost_2_AED
	   ,SUM(Item_Cost_2_FP_AED) AS Item_Cost_2_FP_AED
	   ,SUM(Item_Cost_2_MD_AED) AS Item_Cost_2_MD_AED
	   ,SUM(Item_Cost_2_GBP) AS Item_Cost_2_GBP
	   ,SUM(Item_Cost_2_FP_GBP) AS Item_Cost_2_FP_GBP
	   ,SUM(Item_Cost_2_MD_GBP) AS Item_Cost_2_MD_GBP
	FROM
		dbo.Apparel_Store_Item_Sale_Trans_Fact
	GROUP BY
		Store_Dim_ID
	   ,Calendar_Dim_Id
	   ,Item_Dim_ID
) source
	ON source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Calendar_Dim_Id = target.Calendar_Dim_Id
	AND source.Item_Dim_ID = target.Item_Dim_ID
WHEN MATCHED THEN	
	UPDATE SET
		Sales_Qty                   = source.Sales_Qty
		,FP_Qty						= source.FP_Qty
		,MD_Qty						= source.MD_Qty
		,Actual_Sales_Value_Curr		= source.Actual_Sales_Value_Curr
		,Actual_Sales_Value_FP_Curr	= source.Actual_Sales_Value_FP_Curr
		,Actual_Sales_Value_MD_Curr	= source.Actual_Sales_Value_MD_Curr
		,Actual_Sales_Value_AED		= source.Actual_Sales_Value_AED
		,Actual_Sales_Value_FP_AED	= source.Actual_Sales_Value_FP_AED
		,Actual_Sales_Value_MD_AED	= source.Actual_Sales_Value_MD_AED
		,Actual_Sales_Value_GBP		= source.Actual_Sales_Value_GBP
		,Actual_Sales_Value_FP_GBP	= source.Actual_Sales_Value_FP_GBP
		,Actual_Sales_Value_MD_GBP	= source.Actual_Sales_Value_MD_GBP
		,Discount_Value_Curr			= source.Discount_Value_Curr
		,Discount_Value_FP_Curr		= source.Discount_Value_FP_Curr
		,Discount_Value_MD_Curr		= source.Discount_Value_MD_Curr
		,Discount_Value_AED			= source.Discount_Value_AED
		,Discount_Value_FP_AED		= source.Discount_Value_FP_AED
		,Discount_Value_MD_AED		= source.Discount_Value_MD_AED
		,Discount_Value_GBP			= source.Discount_Value_GBP
		,Discount_Value_FP_GBP		= source.Discount_Value_FP_GBP
		,Discount_Value_MD_GBP		= source.Discount_Value_MD_GBP
		,Item_Cost_2_Curr			= source.Item_Cost_2_Curr
		,Item_Cost_2_FP_Curr			= source.Item_Cost_2_FP_Curr
		,Item_Cost_2_MD_Curr			= source.Item_Cost_2_MD_Curr
		,Item_Cost_2_AED				= source.Item_Cost_2_AED
		,Item_Cost_2_FP_AED			= source.Item_Cost_2_FP_AED
		,Item_Cost_2_MD_AED			= source.Item_Cost_2_MD_AED
		,Item_Cost_2_GBP				= source.Item_Cost_2_GBP
		,Item_Cost_2_FP_GBP			= source.Item_Cost_2_FP_GBP
		,Item_Cost_2_MD_GBP			= source.Item_Cost_2_MD_GBP
WHEN NOT MATCHED THEN
INSERT
(
	Store_Dim_ID
	,Calendar_Dim_Id
	,Item_Dim_ID
	,Sales_Qty
	,FP_Qty
	,MD_Qty
	,Actual_Sales_Value_Curr
	,Actual_Sales_Value_FP_Curr
	,Actual_Sales_Value_MD_Curr
	,Actual_Sales_Value_AED
	,Actual_Sales_Value_FP_AED
	,Actual_Sales_Value_MD_AED
	,Actual_Sales_Value_GBP
	,Actual_Sales_Value_FP_GBP
	,Actual_Sales_Value_MD_GBP
	,Discount_Value_Curr
	,Discount_Value_FP_Curr
	,Discount_Value_MD_Curr
	,Discount_Value_AED
	,Discount_Value_FP_AED
	,Discount_Value_MD_AED
	,Discount_Value_GBP
	,Discount_Value_FP_GBP
	,Discount_Value_MD_GBP
	,Item_Cost_2_Curr
	,Item_Cost_2_FP_Curr
	,Item_Cost_2_MD_Curr
	,Item_Cost_2_AED
	,Item_Cost_2_FP_AED
	,Item_Cost_2_MD_AED
	,Item_Cost_2_GBP
	,Item_Cost_2_FP_GBP
	,Item_Cost_2_MD_GBP
)
VALUES 
(
	 source.Store_Dim_ID
	,source.Calendar_Dim_Id
	,source.Item_Dim_ID
	,source.Sales_Qty
	,source.FP_Qty
	,source.MD_Qty
	,source.Actual_Sales_Value_Curr
	,source.Actual_Sales_Value_FP_Curr
	,source.Actual_Sales_Value_MD_Curr
	,source.Actual_Sales_Value_AED
	,source.Actual_Sales_Value_FP_AED
	,source.Actual_Sales_Value_MD_AED
	,source.Actual_Sales_Value_GBP
	,source.Actual_Sales_Value_FP_GBP
	,source.Actual_Sales_Value_MD_GBP
	,source.Discount_Value_Curr
	,source.Discount_Value_FP_Curr
	,source.Discount_Value_MD_Curr
	,source.Discount_Value_AED
	,source.Discount_Value_FP_AED
	,source.Discount_Value_MD_AED
	,source.Discount_Value_GBP
	,source.Discount_Value_FP_GBP
	,source.Discount_Value_MD_GBP
	,source.Item_Cost_2_Curr
	,source.Item_Cost_2_FP_Curr
	,source.Item_Cost_2_MD_Curr
	,source.Item_Cost_2_AED
	,source.Item_Cost_2_FP_AED
	,source.Item_Cost_2_MD_AED
	,source.Item_Cost_2_GBP
	,source.Item_Cost_2_FP_GBP
	,source.Item_Cost_2_MD_GBP
);
GO
