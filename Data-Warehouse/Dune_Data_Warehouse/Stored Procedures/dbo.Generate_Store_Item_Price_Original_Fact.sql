SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Generate_Store_Item_Price_Original_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_Store_Item_Price_Original_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION Sales_Returns_Facts

DROP TABLE dbo.Store_Item_Price_Original_Fact;

SELECT
	item_dim_id,
	store_dim_id,
	retail_price_home,
	retail_price_curr
INTO dbo.Store_Item_Price_Original_Fact
FROM (
	SELECT
		f.Item_Dim_ID,
		f.Store_Dim_ID,
		Retail_Price_Home,
		Retail_Price_Curr
	FROM dbo.Store_Item_Price_Day_Fact f
	JOIN (
		SELECT 
			Item_Dim_ID,
			Store_Dim_ID,
			MIN(Calendar_Dim_ID) AS Calendar_Dim_ID
		FROM dbo.Store_Item_Price_Day_Fact
		GROUP BY 
			Item_Dim_ID,
			Store_Dim_ID
	) minprice
	ON minprice.Item_Dim_ID = f.Item_Dim_ID
	AND minprice.Store_Dim_ID = f.Store_Dim_ID
	AND minprice.Calendar_Dim_ID = f.Calendar_Dim_ID
) a;

CREATE UNIQUE CLUSTERED INDEX Store_Item_Price_Original_Fact_UIX 
ON dbo.Store_Item_Price_Original_Fact (Item_Dim_ID, Store_Dim_ID);

SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_Store_Item_Price_Original_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
