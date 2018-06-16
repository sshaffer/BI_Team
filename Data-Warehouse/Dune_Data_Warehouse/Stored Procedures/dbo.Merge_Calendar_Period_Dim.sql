SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Merge_Calendar_Period_Dim
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
EXEC dbo.Log_Start @Source, 'Merge_Calendar_Period_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Calendar_Period_Dim target
USING Dune_Data_Warehouse_Staging..Calendar_Period_Dim source
	ON source.Calendar_Period_Dim_ID = target.Calendar_Period_Dim_ID
WHEN MATCHED THEN
UPDATE SET 
	Fiscal_Period = source.Fiscal_Period
	,Fiscal_Period_Beginning_Date = source.Fiscal_Period_Beginning_Date
	,Fiscal_Period_Ending_Date = source.Fiscal_Period_Ending_Date
	,Previous_Fiscal_Period = source.Previous_Fiscal_Period
	,Next_Fiscal_Period = source.Next_Fiscal_Period
	,Fiscal_Period_Name = source.Fiscal_Period_Name
	,Fiscal_Year = source.Fiscal_Year
	,Previous_Fiscal_Year = source.Previous_Fiscal_Year
	,Next_Fiscal_Year = source.Next_Fiscal_Year
	,Fiscal_Quarter = source.Fiscal_Quarter
	,Previous_Fiscal_Quarter = source.Previous_Fiscal_Quarter
	,Next_Fiscal_Quarter = source.Next_Fiscal_Quarter
	,Fiscal_Half_Year = source.Fiscal_Half_Year
	,Previous_Fiscal_Half_Year = source.Previous_Fiscal_Half_Year
	,Next_Fiscal_Half_Year = source.Next_Fiscal_Half_Year
	,Current_Period_Flag = source.Current_Period_Flag
	,Current_Period = source.Current_Period
	,Current_Year = source.Current_Year
	,Current_Quarter = source.Current_Quarter
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Period_Dim_Id
	,Fiscal_Period
	,Fiscal_Period_Beginning_Date
	,Fiscal_Period_Ending_Date
	,Previous_Fiscal_Period
	,Next_Fiscal_Period
	,Fiscal_Period_Name
	,Fiscal_Year
	,Previous_Fiscal_Year
	,Next_Fiscal_Year
	,Fiscal_Quarter
	,Previous_Fiscal_Quarter
	,Next_Fiscal_Quarter
	,Fiscal_Half_Year
	,Previous_Fiscal_Half_Year
	,Next_Fiscal_Half_Year
	,Current_Period_Flag
	,Current_Period
	,Current_Year
	,Current_Quarter
) VALUES (
	source.Calendar_Period_Dim_Id
	,source.Fiscal_Period
	,source.Fiscal_Period_Beginning_Date
	,source.Fiscal_Period_Ending_Date
	,source.Previous_Fiscal_Period
	,source.Next_Fiscal_Period
	,source.Fiscal_Period_Name
	,source.Fiscal_Year
	,source.Previous_Fiscal_Year
	,source.Next_Fiscal_Year
	,source.Fiscal_Quarter
	,source.Previous_Fiscal_Quarter
	,source.Next_Fiscal_Quarter
	,source.Fiscal_Half_Year
	,source.Previous_Fiscal_Half_Year
	,source.Next_Fiscal_Half_Year
	,source.Current_Period_Flag
	,source.Current_Period
	,source.Current_Year
	,source.Current_Quarter
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Calendar_Period_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
