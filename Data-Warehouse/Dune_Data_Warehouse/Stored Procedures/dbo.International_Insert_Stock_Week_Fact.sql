SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[International_Insert_Stock_Week_Fact]
	@Source VARCHAR(MAX),
	@Log_ID BIGINT,
	@Cache BIT,
	@Process BIT
	
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE (
	val BIGINT
)
INSERT INTO @return
EXEC dbo.Log_Start @Source, 'International_Insert_Stock_Week_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION

TRUNCATE TABLE dbo.International_Stock_Week_Fact;

INSERT INTO dbo.International_Stock_Week_Fact (
	Calendar_Week_Dim_ID
	,International_Partner_Dim_ID
	,Item_Dim_ID
	,Stock_Qty
)
SELECT
end_of_week.Calendar_Week_Dim_Id
,f.International_Partner_Dim_ID
,f.Item_Dim_ID
,f.Stock_Qty
FROM dbo.International_Stock_Day_Fact f
JOIN (
	SELECT
		cal.Calendar_Dim_Id Calendar_Day_Dim_ID,
		w.Calendar_Week_Dim_Id
	FROM Calendar_Dim cal
	JOIN Calendar_Week_Dim w
		ON w.Fiscal_Period_Beginning_Date = cal.Fiscal_Week_Beginning_Date
		AND w.Fiscal_Week_Ending_Date = cal.Fiscal_Week_Ending_Date
	WHERE cal.Fiscal_Last_Day_in_Week_Indicator = 1
) end_of_week
	ON end_of_week.Calendar_Day_Dim_ID = f.Calendar_Day_Dim_ID

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.International_Insert_Stock_Week_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
