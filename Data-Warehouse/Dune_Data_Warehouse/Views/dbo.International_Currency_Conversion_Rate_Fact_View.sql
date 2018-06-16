SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[International_Currency_Conversion_Rate_Fact_View]
AS 

WITH exch AS (
SELECT
    Currency_Code
   ,From_Date
   ,To_Date
   ,Rate
   ,ROW_NUMBER() OVER (PARTITION BY Currency_Code ORDER BY From_Date, To_Date) RowNum
FROM dbo.International_Currency_Conversion_Rate_Fact
)

SELECT
	CASE WHEN past.From_Date IS NULL THEN '2000-01-01' ELSE exch.From_Date END AS From_Date
	,CASE WHEN future.To_Date IS NULL THEN '2025-01-01' ELSE DATEADD(DAY,-1,future.To_Date) END AS To_Date
	,exch.Currency_Code
	,exch.Rate
FROM exch
LEFT JOIN exch future
	ON future.RowNum = exch.RowNum + 1
	AND future.Currency_Code = exch.Currency_Code
LEFT JOIN exch past
	ON past.RowNum = exch.RowNum - 1
	AND past.Currency_Code = exch.Currency_Code
GO
