SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Till_Payment_Week_Fact]
AS
SELECT
    f.Store_Dim_ID
   ,w.Calendar_Week_Dim_Id
   ,f.Register
   ,f.Docket
   ,SUM(f.Payment_Value_Home) AS Payment_Value_Home
   ,SUM(f.Payment_Qty) AS Payment_Qty
FROM
    dbo.Till_Payment_Fact f
JOIN dbo.Calendar_Dim cal
    ON cal.Calendar_Dim_Id = f.Transaction_Date_Dim_ID
JOIN dbo.Calendar_Week_Dim w
    ON w.Fiscal_Year = cal.Fiscal_Year
       AND w.Fiscal_Week = cal.Fiscal_Week
GROUP BY
    f.Store_Dim_ID
   ,w.Calendar_Week_Dim_Id
   ,f.Register
   ,f.Docket
GO
