SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Update_BIS_Calendar_Dim_Period_Timeline]
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
EXEC dbo.Log_Start @Source, 'Update_BIS_Calendar_Dim_Period_Timeline', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

DECLARE @CurrentYear CHAR(4) = (SELECT Fiscal_Year FROM dbo.Calendar_Dim WHERE Relative_Day = 0);
DECLARE @PeriodOffset INT;

IF @CurrentYear IN ('2015') 
BEGIN
	SET @PeriodOffset = (SELECT COUNT(DISTINCT W53_Period) FROM dbo.Calendar_Dim WHERE Relative_Day < 0);
END ELSE BEGIN
	SET @PeriodOffset = (SELECT COUNT(DISTINCT Standard_Period) FROM dbo.Calendar_Dim WHERE Relative_Day < 0);
END;

WITH timeline AS (
SELECT
	Calendar_Dim_Id,
	Period_Timeline,
	New_Period_Timeline = DENSE_RANK() OVER (ORDER BY CASE WHEN @CurrentYear = '2015' THEN W53_Period ELSE Standard_Period END) - @PeriodOffset
FROM dbo.BIS_Calendar_Dim
)
UPDATE timeline
SET Period_Timeline = New_Period_Timeline



SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Update_BIS_Calendar_Dim_Period_Timeline: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
