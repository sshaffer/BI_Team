SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Merge_Apparel_Intake_Week_Fact]
AS

MERGE INTO dbo.Apparel_Intake_Week_Fact target
USING (
	SELECT
		cal.Calendar_Week_Dim_Id
		,f.Store_Dim_Id
		,f.Item_Dim_Id
		,SUM(f.Qty) AS Qty
		,SUM(f.Item_Cost_1_AED) AS Item_Cost_1_AED
		,SUM(f.Item_Cost_1_GBP) AS Item_Cost_1_GBP
	FROM dbo.Apparel_Intake_Day_Fact f
	JOIN dbo.BIS_Calendar_Dim_View cal
		ON cal.Calendar_Dim_Id = f.Calendar_Dim_Id
	GROUP BY 
		cal.Calendar_Week_Dim_Id
		,f.Store_Dim_Id
		,f.Item_Dim_Id
) source
	ON source.Calendar_Week_Dim_Id = target.Calendar_Week_Dim_ID
	AND source.Store_Dim_Id = target.Store_Dim_ID
	AND source.Item_Dim_Id = target.Item_Dim_ID
WHEN MATCHED THEN
	UPDATE SET
		Qty = source.Qty
		,Item_Cost_1_AED = source.Item_Cost_1_AED
		,Item_Cost_1_GBP = source.Item_Cost_1_GBP
WHEN NOT MATCHED THEN
	INSERT 
	(
		Calendar_Week_Dim_ID
		,Store_Dim_ID
		,Item_Dim_ID
		,Qty
		,Item_Cost_1_AED
		,Item_Cost_1_GBP
	)
	VALUES
	(
		source.Calendar_Week_Dim_Id
		,source.Store_Dim_Id
		,source.Item_Dim_Id
		,source.Qty
		,source.Item_Cost_1_AED
		,source.Item_Cost_1_GBP
	)
;
	
GO
