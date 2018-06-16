SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_PO_History_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_PO_History_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


/* Declare Variables */
DECLARE @Purchase_Order_No VARCHAR(10),
		@Purchase_Order_Sequence_No INT,
		@Item_Dim_ID INT,
		@Purchase_Order_Date_Dim_ID SMALLINT,
		@Store_Dim_ID INT,
		@Buyer_ID CHAR(3),
		@Ship_Via VARCHAR(20),
		@Agent_Name VARCHAR(25),
		@Terms_Description VARCHAR(20),
		@Currency_Dim_ID TINYINT,
		@Closed_Order CHAR(1),
		@Closed_Item CHAR(1),
		@Handling_Type CHAR(8),
		@Unit_Cost_Price MONEY,
		@Retail_Price MONEY,
		@Purchase_Order_Qty INT,
		@Purchase_Order_Component_Qty INT,
		@Frieght_Cost_Per_Unit MONEY,
		@Duty_Value MONEY,
		@Agent_Fees MONEY,
		@Carriage_Cost_per_Unit MONEY,
		@Landed_Cost MONEY,
		@Margin_Calc_Value MONEY,
		@SEQUENCE_KEY CHAR(6),
		@SEQUENCE INT,
		@TOTAL MONEY,
		@VALUE DECIMAL(7,3),
		@FreightDutyValue DECIMAL(7,3),
		@FreightDutyType CHAR(1),
		@PRVPO VARCHAR(10),
		@PRVSEQ INT,
		@User_ID CHAR(4)
;

/* Results Staging Table */
DECLARE @Results TABLE (
	Purchase_Order_No VARCHAR(10),
	Purchase_Order_Sequence_No INT,
	Item_Dim_ID INT,
	Purchase_Order_Date_Dim_ID SMALLINT,
	Store_Dim_ID INT,
	Buyer_ID CHAR(3),
	Ship_Via VARCHAR(20),
	Agent_Name VARCHAR(25),
	Terms_Description VARCHAR(20),
	Currency_Dim_ID TINYINT,
	Closed_Order CHAR(1),
	Closed_Item CHAR(1),
	Handling_Type CHAR(8),
	Unit_Cost_Price MONEY,
	Retail_Price MONEY,
	Purchase_Order_Quantity INT,
	Frieght_Cost_Per_Unit MONEY,
	Duty_Value MONEY,
	Agent_Fees MONEY,
	Carriage_Cost_per_Unit MONEY,
	Landed_Cost MONEY,
	Margin_Calc_Value MONEY,
	SEQUENCE INT,
	Purchase_Order_Component_Qty INT,
	User_ID CHAR(4)
)

DECLARE C CURSOR FAST_FORWARD FOR 
SELECT 
	SEQUENCE_KEY
	,SEQUENCE
	,HONO
	,HBYR
	,HVIA
	,HANM
	,HTRM
	,HCLO
	,ISEQ
	,IERR
	,IHOM
	,IRET
	,IQTY
	,ILNC
	,IHND
	,Item_Dim_ID
	,Purchase_Order_Date_Dim_ID
	,Store_Dim_ID
	,Currency_Dim_ID
	,FreightDutyValue
	,FreightDutyType
	,Purchase_Order_Component_Qty
	,HUSR
FROM Dune_Data_Warehouse_Staging..PO_Hist_Fact
ORDER BY HONO, ISEQ, SEQUENCE;

OPEN C;

FETCH NEXT FROM C INTO
	 @SEQUENCE_KEY
	,@SEQUENCE
	,@Purchase_Order_No
	,@Buyer_ID
	,@Ship_Via
	,@Agent_Name
	,@Terms_Description
	,@Closed_Order
	,@Purchase_Order_Sequence_No
	,@Closed_Item
	,@Unit_Cost_Price
	,@Retail_Price
	,@Purchase_Order_Qty
	,@Landed_Cost
	,@Handling_Type
	,@Item_Dim_ID
	,@Purchase_Order_Date_Dim_ID
	,@Store_Dim_ID
	,@Currency_Dim_ID
	,@FreightDutyValue
	,@FreightDutyType
	,@Purchase_Order_Component_Qty
	,@User_ID
;

SELECT @PRVPO = @Purchase_Order_No,
	   @PRVSEQ = @Purchase_Order_Sequence_No,
	   @Frieght_Cost_Per_Unit = 0,
	   @Duty_Value = 0,
	   @Agent_Fees = 0,
	   @Carriage_Cost_per_Unit = 0,
	   @TOTAL = 0
;

WHILE @@FETCH_STATUS = 0
BEGIN

IF (@Purchase_Order_No <> @PRVPO OR @Purchase_Order_Sequence_No <> @PRVSEQ)
BEGIN
	SELECT @PRVPO = @Purchase_Order_No,
		   @PRVSEQ = @Purchase_Order_Sequence_No,
		   @Frieght_Cost_Per_Unit = 0,
		   @Duty_Value = 0,
		   @Agent_Fees = 0,
		   @Carriage_Cost_per_Unit = 0,
		   @TOTAL = 0
	;
END

IF @SEQUENCE_KEY IN ('IFDQ01' /* Air */,'IFDQ02' /* Sea */, 'IFDQ06' /* Road */) 
BEGIN
	IF @FreightDutyType = 'U' /* Unit */ AND @FreightDutyValue <> 0
	BEGIN
		SELECT @TOTAL = @TOTAL + @FreightDutyValue
		SELECT @Frieght_Cost_Per_Unit = @Frieght_Cost_Per_Unit + @FreightDutyValue;
	END
END
ELSE IF @SEQUENCE_KEY = 'IFDQ03' /* Duty */ AND @FreightDutyType = 'N' AND @FreightDutyValue <> 0
BEGIN
	SELECT @Duty_Value = @TOTAL * @FreightDutyValue;
	SELECT @TOTAL = @TOTAL - @Duty_Value;
END
ELSE IF @SEQUENCE_KEY = 'IFDQ04' /* Agent */
BEGIN 
	IF @FreightDutyType = 'N' AND @FreightDutyValue <> 0
	BEGIN
		SELECT @Agent_Fees = @TOTAL * @FreightDutyValue;
	END 
	ELSE IF @FreightDutyType = 'U' AND @FreightDutyValue <> 0
	BEGIN
		SELECT @Agent_Fees = @FreightDutyValue;
	END
	SELECT @TOTAL = @TOTAL - @Agent_Fees;
END	
ELSE IF @SEQUENCE_KEY = 'IFDQ05' /* Carriage */ AND @FreightDutyValue <> 0
BEGIN
	SELECT @Carriage_Cost_per_Unit = @FreightDutyValue;
END;

SELECT @Margin_Calc_Value = @Retail_Price - @Landed_Cost;

INSERT INTO @Results (
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
	,SEQUENCE
	,Purchase_Order_Component_Qty
	,User_ID
) VALUES (
	@Purchase_Order_No
	,@Purchase_Order_Sequence_No
	,@Item_Dim_ID
	,@Purchase_Order_Date_Dim_ID
	,@Store_Dim_ID
	,@Buyer_ID
	,@Ship_Via
	,@Agent_Name
	,@Terms_Description
	,@Currency_Dim_ID
	,@Closed_Order
	,@Closed_Item
	,@Handling_Type
	,@Unit_Cost_Price 
	,@Retail_Price
	,@Purchase_Order_Qty
	,@Frieght_Cost_Per_Unit
	,@Duty_Value
	,@Agent_Fees
	,@Carriage_Cost_per_Unit
	,@Landed_Cost
	,@Margin_Calc_Value
	,@SEQUENCE
	,@Purchase_Order_Component_Qty
	,@User_ID
);

FETCH NEXT FROM C INTO
	 @SEQUENCE_KEY
	,@SEQUENCE
	,@Purchase_Order_No
	,@Buyer_ID
	,@Ship_Via
	,@Agent_Name
	,@Terms_Description
	,@Closed_Order
	,@Purchase_Order_Sequence_No
	,@Closed_Item
	,@Unit_Cost_Price
	,@Retail_Price
	,@Purchase_Order_Qty
	,@Landed_Cost
	,@Handling_Type
	,@Item_Dim_ID
	,@Purchase_Order_Date_Dim_ID
	,@Store_Dim_ID
	,@Currency_Dim_ID
	,@FreightDutyValue
	,@FreightDutyType
	,@Purchase_Order_Component_Qty
	,@User_ID
;

END;

CLOSE C;
DEALLOCATE C;

/* Get the DW calendar date id */
DECLARE @DW_Date_ID SMALLINT = (SELECT Calendar_Dim_ID FROM dbo.Calendar_Dim WHERE Relative_Day = 0);

/* Tidy up */
DELETE FROM dbo.PO_History_Fact
WHERE Calendar_Dim_ID = @DW_Date_ID;

WITH Final AS (
	SELECT
		ROW_NUMBER() OVER (PARTITION BY Purchase_Order_No, Purchase_Order_Sequence_No ORDER BY SEQUENCE DESC) RowNum, 
		*
	FROM @Results
), 
Facts AS (
	SELECT
		Purchase_Order_No,
		Purchase_Order_Sequence_No,
		Item_Dim_ID,
		Purchase_Order_Date_Dim_ID,
		Store_Dim_ID,
		Buyer_ID,
		Ship_Via,
		Agent_Name,
		Terms_Description,
		Currency_Dim_ID,
		Closed_Order,
		Closed_Item,
		Handling_Type,
		Unit_Cost_Price,
		Retail_Price,
		Purchase_Order_Quantity,
		Purchase_Order_Component_Qty,
		Frieght_Cost_Per_Unit,
		Duty_Value,
		Agent_Fees,
		Carriage_Cost_per_Unit,
		Landed_Cost,
		Margin_Calc_Value,
		User_ID		
	FROM Final 
	WHERE RowNum = 1 /* Last row as it has the totals */
	--ORDER BY Purchase_Order_No, Purchase_Order_Sequence_No, SEQUENCE
)
MERGE INTO dbo.PO_History_Fact target
USING Facts source
ON source.Purchase_Order_No = target.Purchase_Order_No                           
   AND source.Purchase_Order_Sequence_No = target.Purchase_Order_Sequence_No
   AND source.Item_Dim_ID = target.Item_Dim_ID  
   AND source.Purchase_Order_Date_Dim_ID = target.Purchase_Order_Date_Dim_ID  
   AND source.Store_Dim_ID = target.Store_Dim_ID  
   AND source.Buyer_ID = target.Buyer_ID  
   AND source.Ship_Via = target.Ship_Via  
   AND source.Agent_Name = target.Agent_Name  
   AND source.Terms_Description = target.Terms_Description  
   AND source.Currency_Dim_ID = target.Currency_Dim_ID  
   AND source.Closed_Order = target.Closed_Order  
   AND source.Closed_Item = target.Closed_Item  
   AND source.Handling_Type = target.Handling_Type  
   AND source.Unit_Cost_Price = target.Unit_Cost_Price  
   AND source.Retail_Price = target.Retail_Price  
   AND source.Purchase_Order_Quantity = target.Purchase_Order_Quantity  
   AND source.Purchase_Order_Component_Qty = target.Purchase_Order_Component_Qty
   AND source.Frieght_Cost_Per_Unit = target.Frieght_Cost_Per_Unit  
   AND source.Duty_Value = target.Duty_Value  
   AND source.Agent_Fees = target.Agent_Fees  
   AND source.Carriage_Cost_per_Unit = target.Carriage_Cost_per_Unit  
   AND source.Landed_Cost = target.Landed_Cost  
   AND source.Margin_Calc_Value = target.Margin_Calc_Value 
   AND source.User_ID = TARGET.USER_ID
WHEN NOT MATCHED THEN
INSERT (
	Calendar_Dim_ID
	,Purchase_Order_No
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
	,Purchase_Order_Component_Qty
	,Frieght_Cost_Per_Unit
	,Duty_Value
	,Agent_Fees
	,Carriage_Cost_per_Unit
	,Landed_Cost
	,Margin_Calc_Value
    ,USER_ID
) VALUES (
	@DW_Date_ID
	,source.Purchase_Order_No
	,source.Purchase_Order_Sequence_No
	,source.Item_Dim_ID
	,source.Purchase_Order_Date_Dim_ID
	,source.Store_Dim_ID
	,source.Buyer_ID
	,source.Ship_Via
	,source.Agent_Name
	,source.Terms_Description
	,source.Currency_Dim_ID
	,source.Closed_Order
	,source.Closed_Item
	,source.Handling_Type
	,source.Unit_Cost_Price
	,source.Retail_Price
	,source.Purchase_Order_Quantity
	,source.Purchase_Order_Component_Qty
	,source.Frieght_Cost_Per_Unit
	,source.Duty_Value
	,source.Agent_Fees
	,source.Carriage_Cost_per_Unit
	,source.Landed_Cost
	,source.Margin_Calc_Value
    ,source.User_Id
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Class_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
