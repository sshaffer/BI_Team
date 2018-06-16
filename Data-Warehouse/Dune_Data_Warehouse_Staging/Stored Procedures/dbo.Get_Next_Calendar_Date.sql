SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/************************************************************************************/
/*	Name:        dbo.Get_Next_Calendar_Date                                
	Author:      James Wolfisz														
	Created:     02/07/2013															
	Description: Gets the next date (tomorrow) according to the calendar.		
	
	Params: 
	
	Exec: EXEC dbo.Get_Next_Calendar_Date;
   																					
	Audit:       <user> <chage date> <reason>										*/
/************************************************************************************/
CREATE PROCEDURE [dbo].[Get_Next_Calendar_Date]
AS

SELECT
	 c.Calendar_Date
FROM dbo.Calendar_Dim c
WHERE Relative_Day = 1;
GO
