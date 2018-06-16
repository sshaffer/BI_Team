
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Merge_Store_Budget_Week_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Store_Budget_Week_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRAN;

/* This now works from the live WSSI data so no need to do any fancy stuff to work out what needs updating. Can just update the lot every time. */

/* SALES BUDGET */
;WITH WeeklyBudget AS (
	SELECT
		week.Fiscal_Year,
		week.Fiscal_Week,
		budget.Store_Dim_ID,
		Weekly_Budget = budget.Budget
						* 
						CASE 
						WHEN period.Forecast = 0 THEN  0
						ELSE week.Forecast / period.Forecast
						END
	FROM (
		SELECT
			Fiscal_Year,
			Fiscal_Week,
			Fiscal_Period,
			SUM(Measure_Value_Home) AS Forecast
		FROM dbo.Planning_WSSI wssi
		JOIN dbo.Planning_Measure_Dim m
			ON m.Planning_Measure_Dim_ID = wssi.Planning_Measure_Dim_ID
			AND m.Planning_Plan_Dim_ID = wssi.Planning_Plan_Dim_ID
		JOIN dbo.Calendar_Week_Dim cw
			ON cw.Calendar_Week_Dim_Id = wssi.Calendar_Week_Dim_ID
		WHERE m.Measure_Code = 'Sls_Rtl_Appr'
		GROUP BY
			Fiscal_Year,
			Fiscal_Week,
			Fiscal_Period
	) week
	JOIN (
		SELECT
			Fiscal_Year,
			Fiscal_Period,
			SUM(Measure_Value_Home) AS Forecast
		FROM dbo.Planning_WSSI wssi
		JOIN dbo.Planning_Measure_Dim m
			ON m.Planning_Measure_Dim_ID = wssi.Planning_Measure_Dim_ID
			AND m.Planning_Plan_Dim_ID = wssi.Planning_Plan_Dim_ID
		JOIN dbo.Calendar_Week_Dim cw
			ON cw.Calendar_Week_Dim_Id = wssi.Calendar_Week_Dim_ID
		WHERE m.Measure_Code = 'Sls_Rtl_Appr'
		GROUP BY 
			Fiscal_Year,
			Fiscal_Period
	) period
		ON period.Fiscal_Year = week.Fiscal_Year
		AND period.Fiscal_Period = week.Fiscal_Period
	JOIN (
		SELECT
			cp.Fiscal_Year,
			cp.Fiscal_Period,
			pb.Store_Dim_ID,
			pb.Budget
		FROM dbo.Store_Budget_Period_Fact pb
		JOIN dbo.Calendar_Period_Dim cp
			ON cp.Calendar_Period_Dim_Id = pb.Calendar_Period_Dim_ID
	) budget
		ON budget.Fiscal_Year = period.Fiscal_Year
		AND budget.Fiscal_Period = period.Fiscal_Period
)

MERGE INTO dbo.Store_Budget_Week_Fact target
USING (
	SELECT 
		wk.Calendar_Week_Dim_Id
	   ,WeeklyBudget.Store_Dim_ID
	   ,WeeklyBudget.Weekly_Budget
	FROM WeeklyBudget
	JOIN dbo.Calendar_Week_Dim wk
		ON wk.Fiscal_Year = WeeklyBudget.Fiscal_Year
		AND wk.Fiscal_Week = WeeklyBudget.Fiscal_Week
) source
	ON source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Calendar_Week_Dim_Id = target.Calendar_Week_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Budget = source.Weekly_Budget
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Week_Dim_Id,
	Store_Dim_ID,
	Budget
) VALUES (
	source.Calendar_Week_Dim_Id,
	source.Store_Dim_ID,
	source.Weekly_Budget
);


/* PROFIT BUDGET */
;WITH WeeklyMarginBudget AS (
	SELECT
		week.Fiscal_Year,
		week.Fiscal_Week,
		budget.Store_Dim_ID,
		Weekly_Budget = budget.Budget
						* 
						CASE 
						WHEN period.Forecast = 0 THEN  0
						ELSE week.Forecast / period.Forecast
						END
	FROM (
		SELECT
			Fiscal_Year,
			Fiscal_Week,
			Fiscal_Period,
			SUM(Measure_Value_Home) AS Forecast
		FROM dbo.Planning_WSSI wssi
		JOIN dbo.Planning_Measure_Dim m
			ON m.Planning_Measure_Dim_ID = wssi.Planning_Measure_Dim_ID
			AND m.Planning_Plan_Dim_ID = wssi.Planning_Plan_Dim_ID
		JOIN dbo.Calendar_Week_Dim cw
			ON cw.Calendar_Week_Dim_Id = wssi.Calendar_Week_Dim_ID
		WHERE m.Measure_Code = 'Profit_Appr'
		GROUP BY 
			Fiscal_Year,
			Fiscal_Week,
			Fiscal_Period
	) week
	JOIN (
		SELECT
			Fiscal_Year,
			Fiscal_Period,
			SUM(Measure_Value_Home) AS Forecast
		FROM dbo.Planning_WSSI wssi
		JOIN dbo.Planning_Measure_Dim m
			ON m.Planning_Measure_Dim_ID = wssi.Planning_Measure_Dim_ID
			AND m.Planning_Plan_Dim_ID = wssi.Planning_Plan_Dim_ID
		JOIN dbo.Calendar_Week_Dim cw
			ON cw.Calendar_Week_Dim_Id = wssi.Calendar_Week_Dim_ID
		WHERE m.Measure_Code = 'Profit_Appr'
		GROUP BY 
			Fiscal_Year,
			Fiscal_Period
	) period
		ON period.Fiscal_Year = week.Fiscal_Year
		AND period.Fiscal_Period = week.Fiscal_Period
	JOIN (
		SELECT
			cp.Fiscal_Year,
			cp.Fiscal_Period,
			pb.Store_Dim_ID,
			pb.Budget
		FROM dbo.Store_Margin_Budget_Period_Fact pb
		JOIN dbo.Calendar_Period_Dim cp
			ON cp.Calendar_Period_Dim_Id = pb.Calendar_Period_Dim_ID
	) budget
		ON budget.Fiscal_Year = week.Fiscal_Year
		AND budget.Fiscal_Period = week.Fiscal_Period
)

MERGE INTO dbo.Store_Budget_Week_Fact target
USING (
	SELECT 
		wk.Calendar_Week_Dim_Id
	   ,WeeklyMarginBudget.Store_Dim_ID
	   ,WeeklyMarginBudget.Weekly_Budget
	FROM WeeklyMarginBudget
	JOIN dbo.Calendar_Week_Dim wk
		ON wk.Fiscal_Year = WeeklyMarginBudget.Fiscal_Year
		AND wk.Fiscal_Week = WeeklyMarginBudget.Fiscal_Week
) source
	ON source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Calendar_Week_Dim_Id = target.Calendar_Week_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Margin_Budget  = source.Weekly_Budget
;

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Store_Budget_Week_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;


GO
