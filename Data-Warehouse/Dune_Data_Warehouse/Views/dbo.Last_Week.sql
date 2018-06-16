SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Last_Week]
AS 

SELECT
  Calendar_Date,  
  Fiscal_Year,
  Fiscal_Week
FROM Calendar_Dim
WHERE Calendar_Date < (
						SELECT
							Fiscal_Week_Beginning_Date
						FROM Calendar_Dim
						WHERE Relative_Day = 0
						)						
AND Calendar_Date >= DATEADD(DAY,
							-7, 
							(SELECT
								Fiscal_Week_Beginning_Date
							 FROM Calendar_Dim
							 WHERE Relative_Day = 0)
							)

GO
