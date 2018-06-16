SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Store_Targets_Week_Fact]
	@Source VARCHAR(100),
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
EXEC dbo.Log_Start @Source, 'Merge_Store_Targets_Week_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;



BEGIN TRY
BEGIN TRANSACTION

/* Truncate Table */
MERGE INTO dbo.Store_Targets_Week_Fact target
USING Dune_Data_Warehouse_Staging..Store_Targets_Week_Fact source
	ON source.Calendar_Week_Dim_ID = target.Calendar_Week_Dim_ID
	AND source.Store_Dim_ID = target.Store_Dim_ID
WHEN MATCHED THEN
UPDATE SET 
	Target_Value_Curr = source.Target_Value_Curr,
	Target_Value_Home = source.Target_Value_Home
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Week_Dim_ID,
	Store_Dim_ID,
	Target_Value_Curr,
	Target_Value_Home
) VALUES (
	source.Calendar_Week_Dim_ID,
	source.Store_Dim_ID,
	source.Target_Value_Curr,
	source.Target_Value_Home
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Store_Targets_Week_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
