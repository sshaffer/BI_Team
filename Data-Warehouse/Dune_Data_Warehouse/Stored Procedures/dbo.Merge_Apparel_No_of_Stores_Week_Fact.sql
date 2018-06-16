SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[Merge_Apparel_No_of_Stores_Week_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Apparel_No_of_Stores_Week_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

;
WITH stock AS (
	SELECT 
		f.Calendar_Week_Dim_ID,
		f.Store_Dim_ID,
		prod.Item_Colour_Code,
		MIN(boundary.value) AS boundary,
		SUM(f.OnHand_Qty) AS Qty
	FROM dbo.Apparel_Store_Item_Stock_Week_Fact f
	JOIN dbo.Product_Dim prod
		ON prod.Item_Dim_ID = f.Item_Dim_ID
	JOIN dbo.Store_Dim s
		ON s.Store_Dim_ID = f.Store_Dim_ID
	CROSS APPLY (
		SELECT
			CASE 
				WHEN Division_Name IN ('LADIES','MENS') THEN 3
				WHEN Division_Name IN ('ACCESSORIES') THEN 1
				ELSE NULL
			END AS value
		FROM dbo.Product_Dim
		WHERE Item_Dim_ID = f.Item_Dim_ID
	) boundary
	WHERE s.Warehouse_Flag <> 'Y'
	AND s.Store_Type = 'Apparel'
	GROUP BY
		f.Calendar_Week_Dim_ID,
		f.Store_Dim_ID,
		prod.Item_Colour_Code
)

MERGE INTO dbo.Apparel_No_of_Stores_Week_Fact target
USING (
	SELECT
		stock.Calendar_Week_Dim_ID,
		stock.Item_Colour_Code,
		COUNT(stock.Store_Dim_ID) AS No_of_Stores
	FROM stock
	WHERE stock.Qty >= stock.boundary
	GROUP BY
		stock.Calendar_Week_Dim_ID,
		stock.Item_Colour_Code
) source
	ON source.Calendar_Week_Dim_ID = target.Calendar_Week_Dim_ID
	AND source.Item_Colour_Code = target.Item_Colour_Code
WHEN MATCHED THEN
	UPDATE SET
		No_of_Stores = source.No_of_Stores
WHEN NOT MATCHED THEN
INSERT
(
	Calendar_Week_Dim_ID
	,Item_Colour_Code
	,No_of_Stores
) 
VALUES (
	source.Calendar_Week_Dim_ID
	,source.Item_Colour_Code
	,source.No_of_Stores
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Apparel_No_of_Stores_Week_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
