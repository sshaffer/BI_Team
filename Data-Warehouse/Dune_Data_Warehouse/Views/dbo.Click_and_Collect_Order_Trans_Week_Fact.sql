SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Click_and_Collect_Order_Trans_Week_Fact]	
AS
SELECT
    w.Calendar_Week_Dim_Id
   ,f.Order_Number
   ,f.Layby_Number
   ,f.Line_Number
   ,f.Transfer_Status
   ,f.Tracking_Number
   ,f.Delivery_Method
   ,f.Ultimate_Store_Dim_ID
   ,f.Issuing_Store_Dim_ID
   ,SUM(f.Order_Value) AS Order_Value
   ,SUM(f.Order_Qty) AS Order_Qty
   ,SUM(f.Value_Collected) AS Value_Collected
   ,SUM(f.Qty_Collected) AS Qty_Collected
   ,SUM(f.Qty_Await_Fullfilment) AS Qty_Await_Fullfilment
   ,SUM(f.Qty_Awaiting_Acknowledgement) AS Qty_Awaiting_Acknowledgement
   ,SUM(f.Qty_Awaiting_Collection) AS Qty_Awaiting_Collection
   ,SUM(f.Qty_Late) AS Qty_Late
   ,SUM(f.Qty_Overdue) AS Qty_Overdue
   ,SUM(f.Qty_Uncollected) AS Qty_Uncollected
FROM
    dbo.Click_and_Collect_Order_Trans_Fact f
JOIN dbo.Calendar_Dim cal
    ON cal.Calendar_Dim_Id = f.Order_Created_Date_Dim_ID
JOIN dbo.Calendar_Week_Dim w
    ON w.Fiscal_Year = cal.Fiscal_Year
       AND w.Fiscal_Week = cal.Fiscal_Week
GROUP BY
    w.Calendar_Week_Dim_Id
   ,f.Order_Number
   ,f.Layby_Number
   ,f.Line_Number
   ,f.Transfer_Status
   ,f.Tracking_Number
   ,f.Delivery_Method
   ,f.Ultimate_Store_Dim_ID
   ,f.Issuing_Store_Dim_ID
GO
