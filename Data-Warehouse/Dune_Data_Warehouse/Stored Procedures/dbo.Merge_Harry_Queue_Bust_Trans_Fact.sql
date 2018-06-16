
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Harry_Queue_Bust_Trans_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Harry_Queue_Bust_Trans_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Harry_Queue_Bust_Trans_Fact target
USING Dune_Data_Warehouse_Staging..Harry_Queue_Bust_Trans_Fact source
	ON source.Store_Dim_ID = target.Store_Dim_ID
	AND source.Despatch_Date_Dim_ID = target.Despatch_Date_Dim_ID
	AND source.Despatch_Time_Dim_ID = target.Despatch_Time_Dim_ID
	AND source.Register = target.Register
	AND source.Docket = target.Docket
	AND source.Line_Number = target.Line_Number
WHEN MATCHED THEN
UPDATE SET
	Despatch_Qty = source.Despatch_Qty
	,Despatch_Sale_Value_Home = source.Despatch_Sale_Value_Home
	,Despatch_Net_Value_Home = source.Despatch_Net_Value_Home
	,Despatch_Tax_Value_Home = source.Despatch_Tax_Value_Home
	,Despatch_Cost_Value_Home = source.Despatch_Cost_Value_Home
	,Despatch_Margin_Value_Home = source.Despatch_Margin_Value_Home
WHEN NOT MATCHED THEN
INSERT (
	Store_Dim_ID
	,Despatch_Date_Dim_ID
	,Despatch_Time_Dim_ID
	,Item_Dim_ID
	,Register
	,Docket
	,Line_Number
	,Despatch_Qty
	,Despatch_Sale_Value_Home
	,Despatch_Net_Value_Home
	,Despatch_Tax_Value_Home
	,Despatch_Cost_Value_Home
	,Despatch_Margin_Value_Home
) VALUES (
	source.Store_Dim_ID
	,source.Despatch_Date_Dim_ID
	,source.Despatch_Time_Dim_ID
	,source.Item_Dim_ID
	,source.Register
	,source.Docket
	,source.Line_Number
	,source.Despatch_Qty
	,source.Despatch_Sale_Value_Home
	,source.Despatch_Net_Value_Home
	,source.Despatch_Tax_Value_Home
	,source.Despatch_Cost_Value_Home
	,source.Despatch_Margin_Value_Home
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Harry_Queue_Bust_Trans_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
