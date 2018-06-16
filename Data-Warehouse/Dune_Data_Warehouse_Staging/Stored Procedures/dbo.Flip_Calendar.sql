
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



/************************************************************************************/
/*	Name:        dbo.Flip_Calendar                                
	Author:      James Wolfisz														
	Created:     02/07/2013															
	Description: Changes current and relative date numbers in the calendar to match 
				 the given date.		
	
	Params: @Date_To_Flip - Date to change the calendar to.
	
	Exec: EXEC dbo.Flip_Calendar '2013-07-02';
   																					
	Audit:       <user> <chage date> <reason>										*/
/************************************************************************************/
CREATE PROCEDURE [dbo].[Flip_Calendar]
	@Date_To_Flip DATETIME
AS

IF (@Date_To_Flip IS NULL) BEGIN
	RAISERROR('Must supply a date to flip the calendar to (@Date_To_Flip DATETIME).', 16,1);
	RETURN;
END

DECLARE @Offset INT = -12;
DECLARE @SeasonOffset INT = (SELECT COUNT(DISTINCT Merchandise_Season) FROM Calendar_Dim WHERE Calendar_Date <= @Date_To_Flip) * -1;


UPDATE Calendar_Dim
SET Relative_Day = curr.Relative_Day,
	Current_Day = curr.Current_Day,
	Current_Week = curr.Current_Week,
	Current_Year = curr.Current_Year,
	Current_Period = curr.Current_Period,
	Current_Quarter = curr.Current_Quarter,
	Current_Season = curr.Current_Season
FROM Calendar_Dim
INNER JOIN (
	SELECT 
		Calendar_Dim_Id,
		DATEDIFF(DAY,@Date_To_Flip,c.Calendar_Date) AS Relative_Day,
		CAST(c.Calendar_Day_of_Year AS INT) - Current_Day.Calendar_Day_of_Year AS Current_Day,
		CASE 			
			WHEN Current_Day.Fiscal_Week = 53 AND (Current_Day.Fiscal_Year >= CAST(c.Fiscal_Year AS INT)) AND c.Fiscal_Week = '01' THEN 0
			WHEN Current_Day.Fiscal_Week = 53 AND (CAST(c.Fiscal_Year AS INT) > Current_Day.Fiscal_Year) AND c.Fiscal_Week = '02' THEN 0
			WHEN (Current_Day.Fiscal_Year = 2015 AND Current_Day.Fiscal_Week = '01') AND c.Fiscal_Week = '53' THEN -1 
			WHEN Current_Day.Fiscal_Year = 2015 AND (c.Fiscal_Year = '2014' AND c.Fiscal_Week = '01') THEN CAST(c.Fiscal_Week AS INT) - Current_Day.Fiscal_Week
			WHEN Current_Day.Fiscal_Year = 2015 AND c.Fiscal_Year = '2014' THEN (CAST(c.Fiscal_Week AS INT) - Current_Day.Fiscal_Week) - 1
			ELSE CAST(c.Fiscal_Week AS INT) - Current_Day.Fiscal_Week
 		END AS Current_Week,
		--CAST(c.Fiscal_Week AS INT) - Current_Day.Fiscal_Week AS Current_Week,
		/*********** OLD Fiscal Period */
		CAST(c.Fiscal_Period AS INT) - Current_Day.Fiscal_Period AS Current_Period,
		/***************************/
		/********* Fiscal Period WK53 Hack 2014-06-12 ***************/
		--CASE
		--WHEN Current_Day.Fiscal_Year = 2015 AND c.Fiscal_Year = '2014' AND c.Day_in_Fiscal_Period IN ('01','02','03','04','05','06','07') THEN ( CAST(c.Fiscal_Period AS INT) - Current_Day.Fiscal_Period) - 1
		--ELSE CAST(c.Fiscal_Period AS INT) - Current_Day.Fiscal_Period
		--END AS Current_Period,
		/********* END Fiscal Period WK53 Hack 2014-06-12 ***************/
		/************* OLD Current_Year. Was not shifting Week 01 to correct year with week 53 logic. 2014-06-24 
		--CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year AS Current_Year,
		CASE 
			WHEN Current_Day.Fiscal_Year = 2015 AND c.Fiscal_Year < '2014' THEN CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year -1
			WHEN Current_Day.Fiscal_Year = 2015 AND (c.Fiscal_Year = '2014' AND c.Fiscal_Week = '01') THEN CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year -1
			WHEN (Current_Day.Fiscal_Year = 2015 AND Current_Day.Fiscal_Week = '01') AND c.Fiscal_Week = '53' THEN 0
			ELSE CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year 
		END AS Current_Year,
		******************************** END OLD Current_Year 2014-06-24 ************************/
		CASE 
			WHEN current_Day.Fiscal_Year = 2015 AND c.Fiscal_Year < '2014' AND c.Fiscal_Week = '01' THEN CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year - 1
			WHEN Current_Day.Fiscal_Year = 2015 AND c.Fiscal_Year < '2014' THEN CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year -- 1
			WHEN Current_Day.Fiscal_Year = 2015 AND (c.Fiscal_Year = '2014' AND c.Fiscal_Week = '01') THEN CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year - 1
			WHEN (Current_Day.Fiscal_Year = 2015 AND Current_Day.Fiscal_Week = '01') AND c.Fiscal_Week = '53' THEN 0
			ELSE CAST(c.Fiscal_Year AS INT) - Current_Day.Fiscal_Year 
		END AS Current_Year,
		CAST(c.Fiscal_Quarter AS INT) - Current_Day.Fiscal_Quarter AS Current_Quarter,
		@SeasonOffset + DENSE_RANK() OVER (ORDER BY CAST(CONCAT(RIGHT(c.Merchandise_Season,2), CASE LEFT(c.Merchandise_Season,2) WHEN 'SS' THEN '1' ELSE '2' END) AS INT) )  AS Current_Season
	FROM Calendar_Dim c
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
) curr ON
	curr.Calendar_Dim_Id = Calendar_Dim.Calendar_Dim_Id
GO
