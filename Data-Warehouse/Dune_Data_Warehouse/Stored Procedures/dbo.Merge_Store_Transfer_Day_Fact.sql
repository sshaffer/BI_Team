SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Store_Transfer_Day_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Store_Transfer_Day_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Store_Transfer_Day_Fact target
USING (
	SELECT
		[Transfer_Date_Dim_ID]
		,[From_Store_Dim_ID]
		,[Item_Dim_ID]
		,[To_Store_Dim_ID]
		,[Store_Acknowledgement_Date_Dim_ID]
		,[Delivery_Status]
		,SUM([Transfer_Qty]) AS Transfer_Qty
		,SUM([Transfer_Cost_Value]) AS Transfer_Cost_Value
		,SUM([Transfer_Retail_Value]) AS Transfer_Retail_Value
		,SUM([Acknowledgement_Qty]) AS [Acknowledgement_Qty]
		,SUM([Acknowledgement_Cost_Value]) AS [Acknowledgement_Cost_Value] 
		,SUM([Acknowledgement_Retail_Value]) AS [Acknowledgement_Retail_Value]
		,SUM([Discrepancy_Qty]) AS [Discrepancy_Qty]
		,SUM([Discrepancy_Cost_Value]) AS [Discrepancy_Cost_Value]
		,SUM([Discrepancy_Retail_Value]) AS [Discrepancy_Retail_Value]
	FROM Dune_Data_Warehouse_Staging..Store_Transfer_Day_Fact
	GROUP BY
		[Transfer_Date_Dim_ID]
		,[From_Store_Dim_ID]
		,[Item_Dim_ID]
		,[To_Store_Dim_ID]
		,[Store_Acknowledgement_Date_Dim_ID]
		,[Delivery_Status]
) source
	ON source.Transfer_Date_Dim_ID = target.Transfer_Date_Dim_ID
	AND source.From_Store_Dim_ID = target.From_Store_Dim_ID
	AND source.To_Store_Dim_ID = target.To_Store_Dim_ID
	AND source.Item_Dim_ID = target.Item_Dim_ID
WHEN MATCHED THEN 
UPDATE SET
	Store_Acknowledgement_Date_Dim_ID = source.Store_Acknowledgement_Date_Dim_ID
	--,Transfer_Reason_Dim_ID = source.Transfer_Reason_Dim_ID
	,Delivery_Status = source.Delivery_Status
	,Transfer_Qty = source.Transfer_Qty
	,Transfer_Cost_Value = source.Transfer_Cost_Value
	,Transfer_Retail_Value = source.Transfer_Retail_Value
	,Acknowledgement_Qty = source.Acknowledgement_Qty
	,Acknowledgement_Cost_Value = source.Acknowledgement_Cost_Value
	,Acknowledgement_Retail_Value = source.Acknowledgement_Retail_Value
	,Discrepancy_Qty = source.Discrepancy_Qty
	,Discrepancy_Cost_Value = source.Discrepancy_Cost_Value
	,Discrepancy_Retail_Value = source.Discrepancy_Retail_Value
WHEN NOT MATCHED THEN 
INSERT (
	Transfer_Date_Dim_ID
	,From_Store_Dim_ID
	,Item_Dim_ID
	,To_Store_Dim_ID
	,Store_Acknowledgement_Date_Dim_ID
	,Delivery_Status
	,Transfer_Qty
	,Transfer_Cost_Value
	,Transfer_Retail_Value
	,Acknowledgement_Qty
	,Acknowledgement_Cost_Value
	,Acknowledgement_Retail_Value
	,Discrepancy_Qty
	,Discrepancy_Cost_Value
	,Discrepancy_Retail_Value
) VALUES (
	source.Transfer_Date_Dim_ID
	,source.From_Store_Dim_ID
	,source.Item_Dim_ID
	,source.To_Store_Dim_ID
	,source.Store_Acknowledgement_Date_Dim_ID
	,source.Delivery_Status
	,source.Transfer_Qty
	,source.Transfer_Cost_Value
	,source.Transfer_Retail_Value
	,source.Acknowledgement_Qty
	,source.Acknowledgement_Cost_Value
	,source.Acknowledgement_Retail_Value
	,source.Discrepancy_Qty
	,source.Discrepancy_Cost_Value
	,source.Discrepancy_Retail_Value
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Store_Transfer_Day_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
