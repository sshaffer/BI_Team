SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Merge_Item_Cost_Price_History_Fact
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
EXEC dbo.Log_Start @Source, 'Merge_Item_Cost_Price_History_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


/* Tidy up DW */
DECLARE @DW_Load_Date_ID SMALLINT;
SET @DW_Load_Date_ID = (SELECT DISTINCT
							DW_Load_Date_ID
						FROM Dune_Data_Warehouse_Staging.dbo.Item_Cost_Price_History_Fact);

DELETE FROM dbo.Item_Cost_Price_History_Fact
WHERE DW_Load_Date_ID = @DW_Load_Date_ID

/* Load data */
MERGE INTO dbo.Item_Cost_Price_History_Fact target
USING (	
	SELECT DW_Load_Date_ID
		,Calendar_Date_Dim_ID
		,Item_Dim_ID
		,Item_Landed_Cost_Price
	FROM (
		SELECT
			ROW_NUMBER() OVER (PARTITION BY Calendar_Date_Dim_ID,Item_Dim_ID ORDER BY RIGHT(Date_Key,2)) AS RowNum
			,DW_Load_Date_ID
			,Calendar_Date_Dim_ID
			,Item_Dim_ID
			,Item_Landed_Cost_Price
			,Date_Key
		FROM Dune_Data_Warehouse_Staging.dbo.Item_Cost_Price_History_Fact
	) a
	WHERE RowNum = 1
) source
ON source.Calendar_Date_Dim_ID = target.Calendar_Date_Dim_ID
AND source.Item_Dim_ID = target.Item_Dim_ID
WHEN NOT MATCHED THEN
INSERT (
	DW_Load_Date_ID
	,Calendar_Date_Dim_ID
	,Item_Dim_ID
	,Item_Landed_Cost_Price
) VALUES (
	source.DW_Load_Date_ID
	,source.Calendar_Date_Dim_ID
	,source.Item_Dim_ID
	,source.Item_Landed_Cost_Price
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Item_Cost_Price_History_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
