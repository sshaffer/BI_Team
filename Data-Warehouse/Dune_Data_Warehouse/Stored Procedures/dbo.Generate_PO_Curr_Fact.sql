SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Generate_PO_Curr_Fact]
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
EXEC dbo.Log_Start @Source, 'Generate_PO_Curr_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY
BEGIN TRANSACTION

/* Truncate Table */
TRUNCATE TABLE dbo.PO_Curr_Fact

/* Insert dbo.PO_Curr_Fact */
INSERT INTO dbo.PO_Curr_Fact (
	Purchase_Order_No
	,Purchase_Order_Sequence_No
	,Item_Dim_ID
	,Purchase_Order_Date_Dim_ID
	,Store_Dim_ID
	,Buyer_ID
	,Ship_Via
	,Agent_Name
	,Terms_Description
	,Currency_Dim_ID
	,Closed_Order
	,Closed_Item
	,Handling_Type
	,Unit_Cost_Price
	,Retail_Price
	,Purchase_Order_Quantity
	,Frieght_Cost_Per_Unit
	,Duty_Value
	,Agent_Fees
	,Carriage_Cost_per_Unit
	,Landed_Cost
	,Margin_Calc_Value
	,Purchase_Order_Component_Qty
	,User_Id
)
SELECT
	f.Purchase_Order_No
	,f.Purchase_Order_Sequence_No
	,f.Item_Dim_ID
	,f.Purchase_Order_Date_Dim_ID
	,f.Store_Dim_ID
	,f.Buyer_ID
	,f.Ship_Via
	,f.Agent_Name
	,f.Terms_Description
	,f.Currency_Dim_ID
	,f.Closed_Order
	,f.Closed_Item
	,f.Handling_Type
	,f.Unit_Cost_Price
	,f.Retail_Price
	,f.Purchase_Order_Quantity
	,f.Frieght_Cost_Per_Unit
	,f.Duty_Value
	,f.Agent_Fees
	,f.Carriage_Cost_per_Unit
	,f.Landed_Cost
	,f.Margin_Calc_Value
	,f.Purchase_Order_Component_Qty
	,f.User_ID
FROM dbo.PO_History_Fact f
JOIN (
	SELECT 
	Purchase_Order_No,
	Purchase_Order_Sequence_No,
	MAX(Calendar_Dim_ID) Max_Date_ID
	FROM dbo.PO_History_Fact
	GROUP BY Purchase_Order_No,
			 Purchase_Order_Sequence_No
) last_po
	ON last_po.Purchase_Order_No = f.Purchase_Order_No
	AND last_po.Purchase_Order_Sequence_No = f.Purchase_Order_Sequence_No
	AND last_po.Max_Date_ID = f.Calendar_Dim_ID

SET @Row_Count = @@ROWCOUNT;

COMMIT TRANSACTION;

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Generate_PO_Curr_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;

RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
