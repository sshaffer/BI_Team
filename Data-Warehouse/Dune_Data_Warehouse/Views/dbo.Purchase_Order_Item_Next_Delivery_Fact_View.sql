SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Purchase_Order_Item_Next_Delivery_Fact_View]
AS

SELECT 
f.Item_Dim_ID,
f.Item_Anticipated_Delivery_Date_Dim_ID,
f.Order_Qty,
f.Order_Component_Qty,
f.Landed_Cost,
f.Vendor_Cost,
f.Retail_Cost
FROM dbo.Purchase_Order_Curr_Fact_View f
JOIN (
	SELECT
		Item_Dim_ID,
		MIN(Item_Anticipated_Delivery_Date_Dim_ID) NextDeliveryDateID
	FROM Purchase_Order_Curr_Fact_View
	WHERE Closed_Flag <> 'Y'
	GROUP BY Item_Dim_ID
) delivery
ON delivery.Item_Dim_ID = f.Item_Dim_ID
AND delivery.NextDeliveryDateID = f.Item_Anticipated_Delivery_Date_Dim_ID
WHERE Closed_Flag <> 'Y'
GO
