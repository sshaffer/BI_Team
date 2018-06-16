SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].Generate_PO_Ship_Curr_Fact
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
EXEC dbo.Log_Start @Source, 'Generate_PO_Ship_Curr_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY
BEGIN TRANSACTION

/* Truncate table */
TRUNCATE TABLE dbo.PO_Ship_Curr_Fact

/* Insert data */
INSERT INTO dbo.PO_Ship_Curr_Fact (
	Ship_Date_Dim_ID
	,Purchase_Order_No
	,Purchase_Order_Sequence_No
	,Item_Dim_ID
	,Vessel_Name
	,Booking_Reference
	,Freight_Forwarder_Code
)
SELECT
	f.Ship_Date_Dim_ID
	,f.Purchase_Order_No
	,f.Purchase_Order_Sequence_No
	,f.Item_Dim_ID
	,f.Vessel_Name
	,f.Booking_Reference
	,f.Freight_Forwarder_Code
FROM dbo.PO_Ship_Hist_Fact f
JOIN (
	SELECT
		MAX(Calendar_Date_Dim_ID) MAX_Date_ID
		,Purchase_Order_No
		,Purchase_Order_Sequence_No
	FROM dbo.PO_Ship_Hist_Fact
	GROUP BY Purchase_Order_No
			 ,Purchase_Order_Sequence_No
) Curr
	ON Curr.Purchase_Order_No = f.Purchase_Order_No
	AND Curr.Purchase_Order_Sequence_No = f.Purchase_Order_Sequence_No
	AND Curr.MAX_Date_ID = f.Calendar_Date_Dim_ID

SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_PO_Ship_Curr_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
