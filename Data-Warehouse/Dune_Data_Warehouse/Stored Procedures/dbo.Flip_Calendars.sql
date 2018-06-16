
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Flip_Calendars]
 @Date_To_Flip DATETIME,
 @Source VARCHAR(100),
 @Cache BIT = 0,
 @Process BIT = 1
AS

TRUNCATE TABLE Dune_Data_Warehouse_Staging.dbo.Calendar_Dim;
INSERT INTO Dune_Data_Warehouse_Staging.dbo.Calendar_Dim (
	Calendar_Dim_Id
	,Calendar_Date
	,Full_Date_Description
	,Fiscal_Day
	,Fiscal_Week
	,Previous_Fiscal_Week
	,Next_Fiscal_Week
	,Fiscal_Period
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
	,Current_Season
)
SELECT 
	Calendar_Dim_Id
	,Calendar_Date
	,Full_Date_Description
	,Fiscal_Day
	,Fiscal_Week
	,Previous_Fiscal_Week
	,Next_Fiscal_Week
	,Fiscal_Period
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
	,Current_Season
FROM dbo.Calendar_Dim;


EXEC Dune_Data_Warehouse_Staging.dbo.Flip_Calendar @Date_To_Flip;
EXEC Dune_Data_Warehouse_Staging.dbo.Generate_Calendar_Week_Dim;
EXEC Dune_Data_Warehouse_Staging.dbo.Generate_Calendar_Period_Dim;
EXEC dbo.Update_Calendar_Dim @Source, 0, @Cache, @Process;
EXEC dbo.Merge_Calendar_Week_Dim @Source, 0, @Cache, @Process;
EXEC dbo.Merge_Calendar_Period_Dim @Source,0, @Cache, @Process;
EXEC dbo.Merge_BIS_Calendar_Dim @source,0,@Cache,@Process;
--EXEC dbo.Update_BIS_Calendar_Dim_Period_Timeline @source,0,@Cache,@Process;
GO
