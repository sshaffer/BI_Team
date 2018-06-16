SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Reserve_and_Collect_Order_Trans_Week_Fact]
AS
SELECT
    w.Calendar_Week_Dim_Id
   ,f.Store_Dim_ID
   ,f.Order_Number
   ,f.Layby_Number
   ,f.Line_Number
   ,f.Order_Status
   ,f.Response_Time_Sec
   ,f.Reason_Code
   ,f.Reason_Description
   ,f.Reason_Type
   ,f.SLA_Exceeded
   ,SUM(f.Order_Qty) AS Order_Qty
   ,SUM(f.Order_Value) AS Order_Value
   ,SUM(f.Rejected_Qty) AS Rejected_Qty
   ,SUM(f.Rejected_Value) AS Rejected_Value
   ,SUM(f.Cancelled_Cust_Serv_Qty) AS Cancelled_Cust_Serv_Qty
   ,SUM(f.No_Show_Qty) AS No_Show_Qty
   ,SUM(f.Fit_Qty) AS Fit_Qty
   ,SUM(f.Colour_Qty) AS Colour_Qty
   ,SUM(f.Changed_Mind_Qty) AS Changed_Mind_Qty
   ,SUM(f.Alternative_Qty) AS Alternative_Qty
   ,SUM(f.Collected_Qty) AS Collected_Qty
   ,SUM(f.Collected_Value) AS Collected_Value
   ,SUM(f.Awaiting_Collection_Qty) AS Awaiting_Collection_Qty
   ,SUM(f.Awaiting_Collection_Value) AS Awaiting_Collection_Value
   ,SUM(f.Expired_Qty) AS Expired_Qty
   ,SUM(f.Unacknowledged_Qty) AS Unacknowledged_Qty
   ,SUM(f.Unacknowledged_Value) AS Unacknowledged_Value
FROM
    dbo.Reserve_and_Collect_Order_Trans_Fact f
JOIN dbo.Calendar_Dim cal
    ON cal.Calendar_Dim_Id = f.Order_Created_Date_Dim_ID
JOIN dbo.Calendar_Week_Dim w
    ON w.Fiscal_Year = cal.Fiscal_Year
       AND w.Fiscal_Week = cal.Fiscal_Week
GROUP BY
    w.Calendar_Week_Dim_Id
   ,f.Store_Dim_ID
   ,f.Order_Number
   ,f.Layby_Number
   ,f.Line_Number
   ,f.Order_Status
   ,f.Response_Time_Sec
   ,f.Reason_Code
   ,f.Reason_Description
   ,f.Reason_Type
   ,f.SLA_Exceeded
GO
