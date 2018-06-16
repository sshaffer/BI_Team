
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[BIS_Calendar_Dim_View]
AS

SELECT
    Calendar_Dim_Id
   ,Calendar_Week_Dim_Id
   ,Calendar_Period_Dim_Id
   ,Calendar_Date
   ,Full_Date_Description
   ,Fiscal_Day
   ,Fiscal_Week
   ,Previous_Fiscal_Week
   ,Next_Fiscal_Week  
   ,CASE WHEN dbo.YearAfterWeek53() = 1 THEN RIGHT(W53_Period,2) ELSE RIGHT(Standard_Period,2) END AS Fiscal_Period
   ,Fiscal_Period_Beginning_Date
   ,Fiscal_Period_Ending_Date
   ,Fiscal_Last_Day_in_Period_Indicator
   ,Fiscal_First_Day_in_Period_Indicator
   ,Previous_Fiscal_Period
   ,Next_Fiscal_Period
   ,Day_in_Fiscal_Period
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
   ,Fiscal_Last_Day_in_Week_Indicator
   ,Fiscal_First_Day_in_Week_Indicator
   ,Merchandise_Season
   ,Previous_Merchandise_Season
   ,Next_Merchandise_Season
   ,Calendar_Day_of_Week_Number
   ,Calendar_Short_Day_of_Week
   ,Calendar_Day_of_Week
   ,Calendar_Day_of_Year
   ,Calendar_Month_Number
   ,Calendar_Month_Short_Name
   ,Calendar_Month_Name
   ,Calendar_Last_Day_in_Week_Indicator
   ,Calendar_Last_Day_in_Month_Indicator
   ,Weekday_Indicator
   ,Holiday_Indicator
   ,Holiday_Description
   ,Major_Event_Indicator
   ,Major_Event_Description
   ,Week_53_Indicator
   ,Current_Date_Flag
   ,Relative_Day
   ,Current_Day
   ,Current_Week
   ,Current_Year
   ,Current_Period
   ,Current_Quarter
   , Current_Season = CASE 
							WHEN Today.TheYear < '2015' AND Today.TheWeek IN ('02','28') THEN Current_Season  + 1
							WHEN Today.TheYear >= '2015' AND Today.TheWeek IN ('01','27') THEN Current_Season  + 1
							ELSE Current_Season
						END 
   ,Week_Timeline
   ,Year_Timeline
   ,Standard_Period
   ,W53_Period
   ,CASE WHEN dbo.FirstWeekInPeriod() = 1 THEN Period_Timeline + 1 ELSE Period_Timeline END AS Period_Timeline
   ,CASE WHEN dbo.YearAfterWeek53() = 1 THEN LEFT(W53_Period,4) ELSE LEFT(Standard_Period,4) END AS Fiscal_Period_Year
FROM dbo.BIS_Calendar_Dim
CROSS APPLY (
	SELECT
		TheYear = Fiscal_Year,
		TheWeek = Fiscal_Week
	FROM dbo.BIS_Calendar_Dim
	WHERE Relative_Day = 0
) Today
WHERE Standard_Period <> ''



GO
