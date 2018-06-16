SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [dbo].[Merge_Merchandise_LFL_Week_Fact]
	@Source VARCHAR(MAX),
	@Log_ID BIGINT,
	@Cache BIT,
	@Process BIT
AS

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE (
	val BIGINT
)
INSERT INTO @return
EXEC dbo.Log_Start @Source, 'Merge_Merchandise_LFL_Week_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

;WITH sales
AS (
	SELECT f.Store_Dim_ID
		,cal.Calendar_Week_Dim_Id
		,cal.Week_Timeline
		,i.Department_Dim_ID
		,SUM(Actual_Sales_Value_Home) Sales_Value
	FROM (
		SELECT DISTINCT Calendar_Week_Dim_Id
			,Week_Timeline
		FROM dbo.BIS_Calendar_Dim_View
		) cal
	LEFT JOIN dbo.Sale_Week_Fact f 
		ON cal.Calendar_Week_Dim_Id = f.Sale_Week_Dim_ID
	LEFT JOIN dbo.Item_Dim i 
		ON i.Item_Dim_ID = f.Item_Dim_ID
	GROUP BY 
		f.Store_Dim_ID
		,cal.Calendar_Week_Dim_Id
		,cal.Week_Timeline
		,i.Department_Dim_ID
	)
MERGE INTO dbo.Merchandise_LFL_Week_Fact target
USING (
	SELECT COALESCE(thisYear.Store_Dim_ID, lastYear.Store_Dim_ID) Store_Dim_ID
		,COALESCE(thisYear.Calendar_Week_Dim_Id, lastYear.Calendar_Week_Dim_Id) Calendar_Week_Dim_ID
		,COALESCE(thisYear.Department_Dim_ID, lastYear.Department_Dim_ID) Department_Dim_ID
		,COALESCE(thisYear.LFL, 0) LFL
		,COALESCE(lastYear.LFL_LY, 0) LFL_LY
	FROM (
		SELECT ty.Store_Dim_ID
			,ty.Calendar_Week_Dim_Id
			,ty.Department_Dim_ID
			,LFL = CASE 
				WHEN (
						ty.Sales_Value IS NOT NULL
						AND ly.Sales_Value IS NOT NULL
						)
					THEN 1
				ELSE 0
				END
		FROM sales ty
		FULL OUTER JOIN sales ly 
			ON ly.Store_Dim_ID = ty.Store_Dim_ID
			AND ly.Department_Dim_ID = ty.Department_Dim_ID
			AND ly.Week_Timeline = ty.Week_Timeline - 52
		) thisYear
	JOIN (
		SELECT ly.Store_Dim_ID
			,ly.Calendar_Week_Dim_Id
			,ly.Department_Dim_ID
			,LFL_LY = CASE 
				WHEN (
						ty.Sales_Value IS NOT NULL
						AND ly.Sales_Value IS NOT NULL
						)
					THEN 1
				ELSE 0
				END
		FROM sales ty
		FULL OUTER JOIN sales ly 
			ON ly.Store_Dim_ID = ty.Store_Dim_ID
			AND ly.Department_Dim_ID = ty.Department_Dim_ID
			AND ly.Week_Timeline = ty.Week_Timeline - 52
		) lastYear 
			ON lastYear.Store_Dim_ID = thisYear.Store_Dim_ID
			AND lastYear.Calendar_Week_Dim_Id = thisYear.Calendar_Week_Dim_Id
			AND lastYear.Department_Dim_ID = thisYear.Department_Dim_ID
	) source
		ON source.Store_Dim_ID = target.Store_Dim_ID
		AND source.Calendar_Week_Dim_ID = target.Calendar_Week_Dim_ID
		AND source.Department_Dim_ID = target.Department_Dim_ID
WHEN MATCHED
	THEN
		UPDATE
		SET Merch_LFL = source.LFL
			,Merch_LFL_LY = source.LFL_LY
WHEN NOT MATCHED
	THEN
		INSERT (
			Calendar_Week_Dim_ID
			,Store_Dim_ID
			,Department_Dim_ID
			,Merch_LFL
			,Merch_LFL_LY
			)
		VALUES (
			source.Calendar_Week_Dim_ID
			,source.Store_Dim_ID
			,source.Department_Dim_ID
			,source.LFL
			,source.LFL_LY
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Merchandise_LFL_Week_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;





GO
