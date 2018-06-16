SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[PO_Receipt_Week_Fact]
AS
SELECT
    w.Calendar_Week_Dim_ID
   ,f.Purchase_Order_No
   ,f.Purchase_Order_Sequence_No
   ,f.Item_Dim_ID
   ,SUM(f.PO_Receipt_Qty) AS PO_Receipt_Qty
   ,SUM(f.PO_Receipt_Component_Qty) AS PO_Receipt_Component_Qty
   ,SUM(f.PO_Receipt_Cost_Value) AS PO_Receipt_Cost_Value
   ,SUM(f.PO_Receipt_Selling_Value) AS PO_Receipt_Selling_Value
   ,f.Store_Dim_ID
FROM
    dbo.PO_Receipt_Fact f
JOIN dbo.Calendar_Dim cal
    ON cal.Calendar_Dim_Id = f.Calendar_Dim_ID
JOIN dbo.Calendar_Week_Dim w
    ON w.fiscal_year = cal.Fiscal_Year
       AND w.Fiscal_Week = cal.Fiscal_Week
GROUP BY
    w.Calendar_Week_Dim_ID
   ,f.Purchase_Order_No
   ,f.Purchase_Order_Sequence_No
   ,f.Item_Dim_ID
   ,f.Store_Dim_ID 
GO
