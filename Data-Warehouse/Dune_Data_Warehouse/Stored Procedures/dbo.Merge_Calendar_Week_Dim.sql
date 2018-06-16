SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Merge_Calendar_Week_Dim
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
EXEC dbo.Log_Start @Source, 'Merge_Calendar_Week_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


MERGE INTO dbo.Calendar_Week_Dim target
USING Dune_Data_Warehouse_Staging.dbo.Calendar_Week_Dim source
ON source.Calendar_Week_Dim_ID = target.Calendar_Week_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Fiscal_Week = source.Fiscal_Week
	,Previous_Fiscal_Week = source.Previous_Fiscal_Week
	,Next_Fiscal_Week = source.Next_Fiscal_Week
	,Fiscal_Period = source.Fiscal_Period
	,Fiscal_Period_Beginning_Date = source.Fiscal_Period_Beginning_Date
	,Fiscal_Period_Ending_Date = source.Fiscal_Period_Ending_Date
	,Previous_Fiscal_Period = source.Previous_Fiscal_Period
	,Next_Fiscal_Period = source.Next_Fiscal_Period
	,Week_in_Fiscal_Period = source.Week_in_Fiscal_Period
	,Previous_Week_in_Fiscal_Period = source.Previous_Week_in_Fiscal_Period
	,Next_Week_in_Fiscal_Period = source.Next_Week_in_Fiscal_Period
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
	,Fiscal_Week_Beginning_Date = source.Fiscal_Week_Beginning_Date
	,Fiscal_Week_Ending_Date = source.Fiscal_Week_Ending_Date
	,Week_53_Indicator = source.Week_53_Indicator
	,Current_Week = source.Current_Week
	,Current_Year = source.Current_Year
	,Current_Period = source.Current_Period
	,Current_Quarter = source.Current_Quarter
	,Relative_Week = source.Relative_Week
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Week_Dim_Id
	,Fiscal_Week
	,Previous_Fiscal_Week
	,Next_Fiscal_Week
	,Fiscal_Period
	,Fiscal_Period_Beginning_Date
	,Fiscal_Period_Ending_Date
	,Previous_Fiscal_Period
	,Next_Fiscal_Period
	,Week_in_Fiscal_Period
	,Previous_Week_in_Fiscal_Period
	,Next_Week_in_Fiscal_Period
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
	,Fiscal_Week_Beginning_Date
	,Fiscal_Week_Ending_Date
	,Week_53_Indicator
	,Current_Week
	,Current_Year
	,Current_Period
	,Current_Quarter
	,Relative_Week
) VALUES (
	 source.Calendar_Week_Dim_Id
	,source.Fiscal_Week
	,source.Previous_Fiscal_Week
	,source.Next_Fiscal_Week
	,source.Fiscal_Period
	,source.Fiscal_Period_Beginning_Date
	,source.Fiscal_Period_Ending_Date
	,source.Previous_Fiscal_Period
	,source.Next_Fiscal_Period
	,source.Week_in_Fiscal_Period
	,source.Previous_Week_in_Fiscal_Period
	,source.Next_Week_in_Fiscal_Period
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
	,source.Fiscal_Week_Beginning_Date
	,source.Fiscal_Week_Ending_Date
	,source.Week_53_Indicator
	,source.Current_Week
	,source.Current_Year
	,source.Current_Period
	,source.Current_Quarter
	,source.Relative_Week
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Calendar_Week_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
