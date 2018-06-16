SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[StartStoreSalesReRun]
AS

DECLARE @EndTime DATETIME;
DECLARE @Success BIT;

/* Get details for last run */
SELECT TOP 1
		@EndTime = End_Time,
		@Success = Success 
FROM Load_Log
WHERE Table_Name IN ( 'Store Item Trans', 'Sales Facts')
ORDER BY Start_Time DESC

IF (@EndTime IS NULL OR @Success <> 1) 
BEGIN
	SELECT -1 AS ReturnCode, 'Previous job failed or still running.' AS ReturnDescription;
END
ELSE 
BEGIN
	EXEC msdb..sp_start_job  'BIS - Store Sales ReRun';
	SELECT 0 AS ReturnCode, 'OK' AS ReturnDescription; 
END
GO
GRANT EXECUTE ON  [dbo].[StartStoreSalesReRun] TO [DUNE\IISBISWEB]
GO
