
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_Calendar_Period_Dim]
AS

/* Clear the table before loading the data */
TRUNCATE TABLE dbo.Calendar_Period_Dim

/* Get calendar date to flip the period calendar to */
DECLARE @Date_To_Flip DATE = (SELECT Calendar_Date FROM Calendar_Dim WHERE Relative_Day = 0);

/* Need the smallest smallint number to start off the IDs */
DECLARE @Starting_ID SMALLINT = -32768;

WITH cal AS (
	SELECT DISTINCT
			Calendar_Dim.Fiscal_Period
			,Calendar_Dim.Fiscal_Period_Beginning_Date
			,Calendar_Dim.Fiscal_Period_Ending_Date
			,Calendar_Dim.Previous_Fiscal_Period
			,Calendar_Dim.Next_Fiscal_Period
			,Calendar_Dim.Fiscal_Period_Name
			,Calendar_Dim.Fiscal_Year
			,Calendar_Dim.Previous_Fiscal_Year
			,Calendar_Dim.Next_Fiscal_Year
			,Calendar_Dim.Fiscal_Quarter
			,Calendar_Dim.Previous_Fiscal_Quarter
			,Calendar_Dim.Next_Fiscal_Quarter
			,Calendar_Dim.Fiscal_Half_Year
			,Calendar_Dim.Previous_Fiscal_Half_Year
			,Calendar_Dim.Next_Fiscal_Half_Year
			,Calendar_Dim.Current_Period
			--,Calendar_Dim.Current_Year
			,CAST(Calendar_Dim.Fiscal_Year AS INT) - Current_Day.Fiscal_Year AS Current_Year
			,Calendar_Dim.Current_Quarter
	FROM Calendar_Dim
	CROSS APPLY (
		SELECT
			CAST(Fiscal_Week AS INT) AS Fiscal_Week,
			CAST(Fiscal_Year AS INT) AS Fiscal_Year,
			CAST(Fiscal_Quarter AS INT) AS Fiscal_Quarter,
			CAST(Fiscal_Period AS INT) AS Fiscal_Period,
			CAST(Calendar_Day_of_Year AS INT) Calendar_Day_of_Year
		FROM Calendar_Dim
		WHERE DATEDIFF(DAY,@Date_To_Flip,Calendar_Date) = 0
	) AS Current_Day
)
INSERT INTO dbo.Calendar_Period_Dim (
	Calendar_Period_Dim_Id
	,Fiscal_Period
	,Fiscal_Period_Beginning_Date
	,Fiscal_Period_Ending_Date
	,Previous_Fiscal_Period
	,Next_Fiscal_Period
	,Fiscal_Period_Name
	,Fiscal_Year
	,Previous_Fiscal_Year
	,Next_Fiscal_Year
	,Fiscal_Quarter
	,Previous_Fiscal_Quarter
	,Next_Fiscal_Quarter
	,Fiscal_Half_Year
	,Previous_Fiscal_Half_Year
	,Next_Fiscal_Half_Year
	,Current_Period
	,Current_Year
	,Current_Quarter
)
SELECT
	ROW_NUMBER() OVER (ORDER BY Fiscal_Period_Beginning_Date) + @Starting_ID AS Calendar_Period_Dim_ID,
	*
FROM cal
GO
