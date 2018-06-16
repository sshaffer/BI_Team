SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Store_Click_and_Collect_Return_Trans_Week_Fact]
AS
SELECT
    w.Calendar_Week_Dim_Id
   ,f.Store_Dim_ID
   ,f.Item_Dim_ID
   ,f.Return_Reason_Dim_ID
   ,SUM(f.Return_Value) AS Return_Value
   ,SUM(f.Return_Qty) AS Return_Qty
FROM
    dbo.Store_Click_and_Collect_Return_Trans_Fact f
JOIN dbo.Calendar_Dim cal
    ON cal.Calendar_Dim_Id = f.Sale_Commission_Date_Dim_ID
JOIN dbo.Calendar_Week_Dim w
    ON w.Fiscal_Year = cal.Fiscal_Year
       AND w.Fiscal_Week = cal.Fiscal_Week
GROUP BY
    w.Calendar_Week_Dim_Id
   ,f.Store_Dim_ID
   ,f.Item_Dim_ID
   ,f.Return_Reason_Dim_ID
GO
