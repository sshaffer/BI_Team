SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* This is a different type of load compared to the rest of the DW.
It is loaded on the day the data is required e.g. if the actual date is 07/11/2013
the data will be for that day not for the calendar day.
This ETL will run on its own schedule to populate the weather table with the most up 
to date weather info */

CREATE PROCEDURE [dbo].[Insert_Store_Weather_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Insert_Store_Weather_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION

/* Tidy up */
DECLARE @Calendar_Dim_ID SMALLINT;
SET @Calendar_Dim_ID = (SELECT 
							Calendar_Dim_ID
						FROM Calendar_Dim 
						WHERE Calendar_Date = CAST(GETDATE() AS DATE)
						)

DELETE FROM Store_Weather_Day_Fact
WHERE Calendar_Dim_ID = @Calendar_Dim_ID

/* Insert facts */
INSERT INTO Store_Weather_Day_Fact (
	Calendar_Dim_ID,
	Store_Dim_ID,
	Condition,
	Temperature
)
SELECT 
	cal.Calendar_Dim_Id,
	s.Store_Dim_ID,
	w.Condition,
	w.Temperature
FROM Dune_Data_Warehouse_Staging.dbo.Yahoo_Weather w
JOIN dbo.Store_Dim s
	ON s.Yahoo_WOEID = w.Location
JOIN Calendar_Dim cal
	ON cal.Calendar_Date = CAST(GETDATE() AS DATE)

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Insert_Store_Weather_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
