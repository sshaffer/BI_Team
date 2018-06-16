
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[Currency_Exchange_Rate_Fact_View]
AS

WITH exch AS (
SELECT
cal.Calendar_Date,
toC.Currency_Code as To_Currency_Code,
fromC.Currency_Code as From_Currency_Code,
f.Exchange_Rate,
ROW_NUMBER() OVER (PARTITION BY toC.Currency_Dim_ID, fromC.Currency_Dim_ID ORDER BY cal.Calendar_Date) RowuNum
FROM dbo.Currency_Exchange_Rate_Fact f
JOIN dbo.Currency_Dim toC
	ON toC.Currency_Dim_ID = f.To_Currency_Dim_ID
JOIN dbo.Currency_Dim fromC
	ON fromC.Currency_Dim_ID = f.From_Currency_Dim_ID
JOIN dbo.Calendar_Dim cal
	ON cal.Calendar_Dim_Id = f.Calendar_Date_Dim_ID
)

SELECT
	CASE WHEN past.Calendar_Date IS NULL THEN '2000-01-01' ELSE exch.Calendar_Date END AS From_Effective_Date,
	CASE WHEN future.Calendar_Date IS NULL THEN '2025-01-01' ELSE DATEADD(DAY,-1,future.Calendar_Date) END AS To_Effective_Date,
	exch.From_Currency_Code,
	exch.To_Currency_Code,
	exch.Exchange_Rate
FROM exch 
LEFT JOIN exch future	
	ON future.RowuNum = exch.RowuNum + 1
	AND future.To_Currency_Code = exch.To_Currency_Code
	AND future.From_Currency_Code = exch.From_Currency_Code
LEFT JOIN exch past
	ON past.RowuNum = exch.RowuNum - 1
	AND past.To_Currency_Code = exch.To_Currency_Code
	AND past.From_Currency_Code = exch.From_Currency_Code


GO
