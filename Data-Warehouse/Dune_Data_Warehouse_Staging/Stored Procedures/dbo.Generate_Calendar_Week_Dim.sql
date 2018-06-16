
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Generate_Calendar_Week_Dim]
AS

/* Clear the table before loading the data */
TRUNCATE TABLE dbo.Calendar_Week_Dim;

/* Get calendar date to flip the week calendar to */
DECLARE @Date_To_Flip DATE = (SELECT Calendar_Date FROM Calendar_Dim WHERE Relative_Day = 0);

/* Need the smallest smallint number to start off the IDs */
DECLARE @Starting_ID SMALLINT = -32768;

WITH cal AS (
	SELECT DISTINCT
		 Calendar_Dim.Fiscal_Week
		,Calendar_Dim.Previous_Fiscal_Week
		,Calendar_Dim.Next_Fiscal_Week
		,Calendar_Dim.Fiscal_Period
		,Calendar_Dim.Fiscal_Period_Beginning_Date
		,Calendar_Dim.Fiscal_Period_Ending_Date
		,Calendar_Dim.Previous_Fiscal_Period
		,Calendar_Dim.Next_Fiscal_Period
		,Calendar_Dim.Week_in_Fiscal_Period
		,Calendar_Dim.Previous_Week_in_Fiscal_Period
		,Calendar_Dim.Next_Week_in_Fiscal_Period
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
		,Calendar_Dim.Fiscal_Week_Beginning_Date
		,Calendar_Dim.Fiscal_Week_Ending_Date
		,Calendar_Dim.Week_53_Indicator
		,DATEDIFF(WEEK,@Date_To_Flip,Calendar_Dim.Calendar_Date) AS Relative_Week 
		,Calendar_Dim.Current_Week
		,Calendar_Dim.Current_Period
		,Calendar_Dim.Current_Year
		,Calendar_Dim.Current_Quarter
	FROM Calendar_Dim
)
INSERT INTO dbo.Calendar_Week_Dim (
	Calendar_Week_Dim_ID
	,Fiscal_Week
	,Previous_Fiscal_Week
	,Next_Fiscal_Week
	,Fiscal_Period
	,Fiscal_Period_Beginning_Date
	,Fiscal_Period_Ending_Date
	,Previous_Fiscal_Period
	,Next_Fiscal_Period
	,Week_in_Fiscal_Period
	,Previous_Week_in_Fiscal_Period
	,Next_Week_in_Fiscal_Period
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
	,Fiscal_Week_Beginning_Date
	,Fiscal_Week_Ending_Date
	,Week_53_Indicator
	,Relative_Week
	,Current_Week
	,Current_Period
	,Current_Year
	,Current_Quarter
)
SELECT
	ROW_NUMBER() OVER (ORDER BY Fiscal_Week_Beginning_Date) + @Starting_ID AS Calendar_Week_Dim_ID,
	*
FROM cal
GO
