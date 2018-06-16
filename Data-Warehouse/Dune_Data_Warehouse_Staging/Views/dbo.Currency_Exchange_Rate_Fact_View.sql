SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Currency_Exchange_Rate_Fact_View]
AS

WITH d1 AS (
SELECT
	ROW_NUMBER() OVER (PARTITION BY f.From_Currency_Dim_ID, f.To_Currency_Dim_ID ORDER BY f.Calendar_Date_Dim_ID) AS Row_Num,
	cal.Calendar_Date AS Effective_Date,
	f.Exchange_Rate,
	COALESCE(fc.Currency_Code, '') AS From_Currency_Code,
	COALESCE(tc.Currency_Code, '') AS To_Currency_Code
FROM dbo.Currency_Exchange_Rate_Fact f
LEFT JOIN dbo.Currency_Dim fc 
ON fc.Currency_Dim_ID = f.From_Currency_Dim_ID
LEFT JOIN dbo.Currency_Dim tc 
ON tc.Currency_Dim_ID = f.To_Currency_Dim_ID
JOIN dbo.Calendar_Dim cal
ON cal.Calendar_Dim_Id = f.Calendar_Date_Dim_ID
),
d2 AS (
SELECT
	ROW_NUMBER() OVER (PARTITION BY f.From_Currency_Dim_ID, f.To_Currency_Dim_ID ORDER BY f.Calendar_Date_Dim_ID) AS Row_Num,
	cal.Calendar_Date AS Effective_Date,
	f.Exchange_Rate,
	COALESCE(fc.Currency_Code, '') AS From_Currency_Code,
	COALESCE(tc.Currency_Code, '') AS To_Currency_Code
FROM dbo.Currency_Exchange_Rate_Fact f
LEFT JOIN dbo.Currency_Dim fc 
ON fc.Currency_Dim_ID = f.From_Currency_Dim_ID
LEFT JOIN dbo.Currency_Dim tc 
ON tc.Currency_Dim_ID = f.To_Currency_Dim_ID
JOIN dbo.Calendar_Dim cal
ON cal.Calendar_Dim_Id = f.Calendar_Date_Dim_ID
)
SELECT 
  d1.Effective_Date AS From_Effective_Date,
  COALESCE(DATEADD(DAY,-1,d2.Effective_Date), '2025-01-01') AS To_Effective_Date, /* Arbitrary future date as we cannot put one in the calendar just in case we reach it */
  d1.From_Currency_Code,
  d1.To_Currency_Code,
  d1.Exchange_Rate
FROM d1
LEFT JOIN d2
ON d2.Row_Num = d1.Row_Num + 1 
AND d1.From_Currency_Code = d2.From_Currency_Code 
AND d1.To_Currency_Code = d2.To_Currency_Code
GO
