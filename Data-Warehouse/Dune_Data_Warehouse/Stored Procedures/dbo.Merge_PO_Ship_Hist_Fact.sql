SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Merge_PO_Ship_Hist_Fact
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
EXEC dbo.Log_Start @Source, 'Merge_PO_Ship_Hist_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

DECLARE @Calendar_Dim_ID SMALLINT = (SELECT Calendar_Dim_ID FROM Calendar_Dim WHERE Relative_Day = 0);

/* Tidy up */
DELETE FROM dbo.PO_Ship_Hist_Fact
WHERE Calendar_Date_Dim_ID = @Calendar_Dim_ID;

MERGE dbo.PO_Ship_Hist_Fact target
USING Dune_Data_Warehouse_Staging..PO_Ship_Hist_Fact source
	ON  source.Ship_Date_Dim_ID = target.Ship_Date_Dim_ID
	AND source.Purchase_Order_No = target.Purchase_Order_No
	AND source.Purchase_Order_Sequence_No = target.Purchase_Order_Sequence_No
	AND source.Item_Dim_ID = target.Item_Dim_ID
	AND source.Vessel_Name = target.Vessel_Name
	AND source.Booking_Reference = target.Booking_Reference
	AND source.Freight_Forwarder_Code = target.Freight_Forwarder_Code
WHEN NOT MATCHED THEN 
INSERT (
	Calendar_Date_Dim_ID
	,Ship_Date_Dim_ID
	,Purchase_Order_No
	,Purchase_Order_Sequence_No
	,Item_Dim_ID
	,Vessel_Name
	,Booking_Reference
	,Freight_Forwarder_Code
) VALUES (
	@Calendar_Dim_ID
	,source.Ship_Date_Dim_ID
	,source.Purchase_Order_No
	,source.Purchase_Order_Sequence_No
	,source.Item_Dim_ID
	,source.Vessel_Name
	,source.Booking_Reference
	,source.Freight_Forwarder_Code
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_PO_Ship_Hist_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
