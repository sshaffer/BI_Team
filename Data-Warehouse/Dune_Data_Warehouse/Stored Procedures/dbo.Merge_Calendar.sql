SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Merge_Calendar
	@Source VARCHAR(MAX),
	@Log_ID BIGINT,
	@Cache BIT,
	@Process BIT
AS

SET NOCOUNT ON;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE (
	val BIGINT
)
INSERT INTO @return
EXEC dbo.Log_Start @Source, 'Merge_Calendar', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Calendar_Dim target
USING Dune_Data_Warehouse_Staging..Calendar_Dim source
ON source.Calendar_Dim_Id = target.Calendar_Dim_Id
WHEN MATCHED THEN
UPDATE SET 
	Calendar_Date = source.Calendar_Date
	,Full_Date_Description = source.Full_Date_Description
	,Fiscal_Day = source.Fiscal_Day
	,Fiscal_Week = source.Fiscal_Week
	,Previous_Fiscal_Week = source.Previous_Fiscal_Week
	,Next_Fiscal_Week = source.Next_Fiscal_Week
	,Fiscal_Period = source.Fiscal_Period
	,Fiscal_Period_Beginning_Date = source.Fiscal_Period_Beginning_Date
	,Fiscal_Period_Ending_Date = source.Fiscal_Period_Ending_Date
	,Fiscal_Last_Day_in_Period_Indicator = source.Fiscal_Last_Day_in_Period_Indicator
	,Fiscal_First_Day_in_Period_Indicator = source.Fiscal_First_Day_in_Period_Indicator
	,Previous_Fiscal_Period = source.Previous_Fiscal_Period
	,Next_Fiscal_Period = source.Next_Fiscal_Period
	,Day_in_Fiscal_Period = source.Day_in_Fiscal_Period
	,Week_in_Fiscal_Period = source.Week_in_Fiscal_Period
	,Previous_Week_in_Fiscal_Period = source.Previous_Week_in_Fiscal_Period
	,Next_Week_in_Fiscal_Period = source.Next_Week_in_Fiscal_Period
	,Fiscal_Period_Name = source.Fiscal_Period_Name
	,Fiscal_Year = source.Fiscal_Year
	,Previous_Fiscal_Year = source.Previous_Fiscal_Year
	,Next_Fiscal_Year = source.Next_Fiscal_Year
	,Fiscal_Quarter = source.Fiscal_Quarter
	,Previous_Fiscal_Quarter = source.Previous_Fiscal_Quarter
	,Next_Fiscal_Quarter = source.Next_Fiscal_Quarter
	,Fiscal_Half_Year = source.Fiscal_Half_Year
	,Previous_Fiscal_Half_Year = source.Previous_Fiscal_Half_Year
	,Next_Fiscal_Half_Year = source.Next_Fiscal_Half_Year
	,Fiscal_Week_Beginning_Date = source.Fiscal_Week_Beginning_Date
	,Fiscal_Week_Ending_Date = source.Fiscal_Week_Ending_Date
	,Fiscal_Last_Day_in_Week_Indicator = source.Fiscal_Last_Day_in_Week_Indicator
	,Fiscal_First_Day_in_Week_Indicator = source.Fiscal_First_Day_in_Week_Indicator
	,Merchandise_Season = source.Merchandise_Season
	,Previous_Merchandise_Season = source.Previous_Merchandise_Season
	,Next_Merchandise_Season = source.Next_Merchandise_Season
	,Calendar_Day_of_Week_Number = source.Calendar_Day_of_Week_Number
	,Calendar_Short_Day_of_Week = source.Calendar_Short_Day_of_Week
	,Calendar_Day_of_Week = source.Calendar_Day_of_Week
	,Calendar_Day_of_Year = source.Calendar_Day_of_Year
	,Calendar_Month_Number = source.Calendar_Month_Number
	,Calendar_Month_Short_Name = source.Calendar_Month_Short_Name
	,Calendar_Month_Name = source.Calendar_Month_Name
	,Calendar_Last_Day_in_Week_Indicator = source.Calendar_Last_Day_in_Week_Indicator
	,Calendar_Last_Day_in_Month_Indicator = source.Calendar_Last_Day_in_Month_Indicator
	,Weekday_Indicator = source.Weekday_Indicator
	,Holiday_Indicator = source.Holiday_Indicator
	,Holiday_Description = source.Holiday_Description
	,Major_Event_Indicator = source.Major_Event_Indicator
	,Major_Event_Description = source.Major_Event_Description
	,Week_53_Indicator = source.Week_53_Indicator
	,Current_Date_Flag = source.Current_Date_Flag
	,Relative_Day = source.Relative_Day
	,Current_Day = source.Current_Day
	,Current_Week = source.Current_Week
	,Current_Year = source.Current_Year
	,Current_Period = source.Current_Period
	,Current_Quarter = source.Current_Quarter
	,Current_Season = source.Current_Season
WHEN  NOT MATCHED THEN
INSERT (Calendar_Dim_Id
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
) VALUES (
	source.Calendar_Dim_Id
	,source.Calendar_Date
	,source.Full_Date_Description
	,source.Fiscal_Day
	,source.Fiscal_Week
	,source.Previous_Fiscal_Week
	,source.Next_Fiscal_Week
	,source.Fiscal_Period
	,source.Fiscal_Period_Beginning_Date
	,source.Fiscal_Period_Ending_Date
	,source.Fiscal_Last_Day_in_Period_Indicator
	,source.Fiscal_First_Day_in_Period_Indicator
	,source.Previous_Fiscal_Period
	,source.Next_Fiscal_Period
	,source.Day_in_Fiscal_Period
	,source.Week_in_Fiscal_Period
	,source.Previous_Week_in_Fiscal_Period
	,source.Next_Week_in_Fiscal_Period
	,source.Fiscal_Period_Name
	,source.Fiscal_Year
	,source.Previous_Fiscal_Year
	,source.Next_Fiscal_Year
	,source.Fiscal_Quarter
	,source.Previous_Fiscal_Quarter
	,source.Next_Fiscal_Quarter
	,source.Fiscal_Half_Year
	,source.Previous_Fiscal_Half_Year
	,source.Next_Fiscal_Half_Year
	,source.Fiscal_Week_Beginning_Date
	,source.Fiscal_Week_Ending_Date
	,source.Fiscal_Last_Day_in_Week_Indicator
	,source.Fiscal_First_Day_in_Week_Indicator
	,source.Merchandise_Season
	,source.Previous_Merchandise_Season
	,source.Next_Merchandise_Season
	,source.Calendar_Day_of_Week_Number
	,source.Calendar_Short_Day_of_Week
	,source.Calendar_Day_of_Week
	,source.Calendar_Day_of_Year
	,source.Calendar_Month_Number
	,source.Calendar_Month_Short_Name
	,source.Calendar_Month_Name
	,source.Calendar_Last_Day_in_Week_Indicator
	,source.Calendar_Last_Day_in_Month_Indicator
	,source.Weekday_Indicator
	,source.Holiday_Indicator
	,source.Holiday_Description
	,source.Major_Event_Indicator
	,source.Major_Event_Description
	,source.Week_53_Indicator
	,source.Current_Date_Flag
	,source.Relative_Day
	,source.Current_Day
	,source.Current_Week
	,source.Current_Year
	,source.Current_Period
	,source.Current_Quarter
	,source.Current_Season
); 

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Calendar: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
