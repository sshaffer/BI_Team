SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/************************************************************************************/
/*	Name:        dbo.Get_Current_Calendar_Date                                
	Author:      James Wolfisz														
	Created:     02/07/2013															
	Description: Get the current date according to the calednar.		
	
	Params: 
	
	Exec: EXEC dbo.Get_Current_Calendar_Date;
   																					
	Audit:       <user> <chage date> <reason>										*/
/************************************************************************************/
CREATE PROCEDURE [dbo].[Get_Current_Calendar_Date]
AS

SELECT 
	Calendar_Date 
FROM  dbo.Calendar_Dim 
WHERE Relative_Day = 0;
GO
