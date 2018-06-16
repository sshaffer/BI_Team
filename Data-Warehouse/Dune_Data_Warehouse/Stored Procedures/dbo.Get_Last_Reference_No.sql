SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/************************************************************************************/
/*	Name:        dbo.Get_Last_Reference_No                                
	Author:      James Wolfisz														
	Created:     02/07/2013															
	Description: Gets last ID reference no from dbo.Last_Reference_ID.		
	
	Params: @Table_Name - Name of the table you want the ID for.
	
	Exec: EXEC dbo.Get_Last_Reference_No 'Customer_Dim';			
   																					
	Audit:       <user> <chage date> <reason>										*/
/************************************************************************************/
CREATE PROCEDURE [dbo].[Get_Last_Reference_No]
	@Table_Name VARCHAR(256)
AS

SELECT 
	Last_Reference_No
FROM Last_Reference_Id
WHERE Table_Name = @Table_Name;
GO
