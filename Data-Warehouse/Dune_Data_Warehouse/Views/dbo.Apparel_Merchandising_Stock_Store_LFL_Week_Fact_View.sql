
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[Apparel_Merchandising_Stock_Store_LFL_Week_Fact_View]
AS

SELECT
	 f.Item_Dim_ID
	,f.Calendar_Week_Dim_Id
	,f.Store_Dim_ID
	,CASE WHEN lfl.LFL = 1 THEN f.Intransit_FP_Qty ELSE 0 END AS Intransit_FP_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Intransit_MD_Qty ELSE 0 END AS Intransit_MD_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Intransit_Qty ELSE 0 END AS Intransit_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.OnHand_FP_Qty ELSE 0 END AS OnHand_FP_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.OnHand_MD_Qty ELSE 0 END AS OnHand_MD_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.OnHand_Qty ELSE 0 END AS OnHand_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.FP_Item_Cost_2_Curr ELSE 0 END AS FP_Item_Cost_2_Curr_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.MD_Item_Cost_2_Curr ELSE 0 END AS MD_Item_Cost_2_Curr_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_Curr ELSE 0 END AS Item_Cost_2_Curr_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.FP_Retail_Price_Curr ELSE 0 END AS FP_Retail_Price_Curr_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.MD_Retail_Price_Curr ELSE 0 END AS MD_Retail_Price_Curr_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Retail_Price_Curr ELSE 0 END AS Retail_Price_Curr_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.FP_Item_Cost_2_AED ELSE 0 END AS FP_Item_Cost_2_AED_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.MD_Item_Cost_2_AED ELSE 0 END AS MD_Item_Cost_2_AED_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_AED ELSE 0 END AS Item_Cost_2_AED_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.FP_Retail_Price_AED ELSE 0 END AS FP_Retail_Price_AED_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.MD_Retail_Price_AED ELSE 0 END AS MD_Retail_Price_AED_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Retail_Price_AED ELSE 0 END AS Retail_Price_AED_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.FP_Item_Cost_2_GBP ELSE 0 END AS FP_Item_Cost_2_GBP_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.MD_Item_Cost_2_GBP ELSE 0 END AS MD_Item_Cost_2_GBP_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Item_Cost_2_GBP ELSE 0 END AS Item_Cost_2_GBP_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.FP_Retail_Price_GBP ELSE 0 END AS FP_Retail_Price_GBP_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.MD_Retail_Price_GBP ELSE 0 END AS MD_Retail_Price_GBP_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Retail_Price_GBP ELSE 0 END AS Retail_Price_GBP_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Net_OnHand_Qty ELSE 0 END AS Net_OnHand_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Net_OnHand_FP_Qty ELSE 0 END AS Net_OnHand_FP_Qty_LFL
	,CASE WHEN lfl.LFL = 1 THEN f.Net_OnHand_MD_Qty ELSE 0 END AS Net_OnHand_MD_Qty_LFL

	,CASE WHEN lfl.LFL_LY = 1 THEN f.Intransit_FP_Qty ELSE 0 END AS Intransit_FP_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Intransit_MD_Qty ELSE 0 END AS Intransit_MD_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Intransit_Qty ELSE 0 END AS Intransit_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.OnHand_FP_Qty ELSE 0 END AS OnHand_FP_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.OnHand_MD_Qty ELSE 0 END AS OnHand_MD_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.OnHand_Qty ELSE 0 END AS OnHand_Qty_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Item_Cost_2_Curr ELSE 0 END AS FP_Item_Cost_2_Curr_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Item_Cost_2_Curr ELSE 0 END AS MD_Item_Cost_2_Curr_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_Curr ELSE 0 END AS Item_Cost_2_Curr_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Retail_Price_Curr ELSE 0 END AS FP_Retail_Price_Curr_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Retail_Price_Curr ELSE 0 END AS MD_Retail_Price_Curr_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Retail_Price_Curr ELSE 0 END AS Retail_Price_Curr_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Item_Cost_2_AED ELSE 0 END AS FP_Item_Cost_2_AED_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Item_Cost_2_AED ELSE 0 END AS MD_Item_Cost_2_AED_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_AED ELSE 0 END AS Item_Cost_2_AED_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Retail_Price_AED ELSE 0 END AS FP_Retail_Price_AED_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Retail_Price_AED ELSE 0 END AS MD_Retail_Price_AED_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Retail_Price_AED ELSE 0 END AS Retail_Price_AED_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Item_Cost_2_GBP ELSE 0 END AS FP_Item_Cost_2_GBP_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Item_Cost_2_GBP ELSE 0 END AS MD_Item_Cost_2_GBP_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Item_Cost_2_GBP ELSE 0 END AS Item_Cost_2_GBP_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.FP_Retail_Price_GBP ELSE 0 END AS FP_Retail_Price_GBP_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.MD_Retail_Price_GBP ELSE 0 END AS MD_Retail_Price_GBP_LFL_LY
	,CASE WHEN lfl.LFL_LY = 1 THEN f.Retail_Price_GBP ELSE 0 END AS Retail_Price_GBP_LFL_LY
	,CASE WHEN lfl.LFL = 1 THEN f.Net_OnHand_Qty ELSE 0 END AS Net_OnHand_Qty_LFL_LY
	,CASE WHEN lfl.LFL = 1 THEN f.Net_OnHand_FP_Qty ELSE 0 END AS Net_OnHand_FP_Qty_LFL_LY
	,CASE WHEN lfl.LFL = 1 THEN f.Net_OnHand_MD_Qty ELSE 0 END AS Net_OnHand_MD_Qty_LFL_LY
FROM
    dbo.Apparel_Store_Item_Stock_Week_Fact f
JOIN dbo.Apparel_Merchandising_Store_LFL_Week_Fact lfl
    ON lfl.Store_Dim_ID = f.Store_Dim_ID
       AND lfl.Calendar_Week_Dim_ID = f.Calendar_Week_Dim_Id





GO
