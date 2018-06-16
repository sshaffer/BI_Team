SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Harry_Payment_Trans_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Harry_Payment_Trans_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Harry_Payment_Trans_Fact target
USING Dune_Data_Warehouse_Staging..Harry_Payment_Trans_Fact source
	ON source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Transaction_Date_Dim_ID = target.Transaction_Date_Dim_ID
	AND source.Transaction_Time_Dim_ID = target.Transaction_Time_Dim_ID
	AND source.Docket = target.Docket
	AND source.Line_Number = target.Line_Number
	AND source.Register = target.Register
WHEN MATCHED THEN
UPDATE SET
	Operator_Number = source.Operator_Number
	,Payment_Value_Home = source.Payment_Value_Home
WHEN NOT MATCHED THEN
INSERT (
	Store_Dim_ID
	,Transaction_Date_Dim_ID
	,Transaction_Time_Dim_ID
	,Register
	,Docket
	,Line_Number
	,Operator_Number
	,Payment_Value_Home
) VALUES (
	source.Store_Dim_ID
	,source.Transaction_Date_Dim_ID
	,source.Transaction_Time_Dim_ID
	,source.Register
	,source.Docket
	,source.Line_Number
	,source.Operator_Number
	,source.Payment_Value_Home
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Harry_Payment_Trans_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
