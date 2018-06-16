
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Wholesale_Invoice_Fact]
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
EXEC dbo.Log_Start @Source, 'Merge_Wholesale_Invoice_Fact', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Wholesale_Invoice_Fact target
USING Dune_Data_Warehouse_Staging.dbo.Wholesale_Invoice_Fact source
	ON source.Invoice_Number = target.Invoice_Number
	AND source.Wholesale_Order_Dim_ID = target.Wholesale_Order_Dim_ID
WHEN MATCHED THEN
    UPDATE SET
               Allocation_Date_Dim_ID = source.Allocation_Date_Dim_ID
              ,Item_Dim_ID = source.Item_Dim_ID
              ,Invoice_Qty = source.Invoice_Qty
              ,Invoice_Extended_Price_Home = source.Invoice_Extended_Price_Home
              ,Invoice_Extended_Price_Curr = source.Invoice_Extended_Price_Curr
              ,Invoice_Tax_Value_Home = source.Invoice_Tax_Value_Home
              ,Invoice_Tax_Value_Curr = source.Invoice_Tax_Value_Curr
              ,Invoice_Shipping_And_Handling_Home = source.Invoice_Shipping_And_Handling_Home
              ,Invoice_Shipping_And_Handling_Curr = source.Invoice_Shipping_And_Handling_Curr
              ,Invoice_Discount_Amount_Home = source.Invoice_Discount_Amount_Home
              ,Invoice_Discount_Amount_Curr = source.Invoice_Discount_Amount_Curr
              ,Invoice_Manifest_Note_1 = source.Invoice_Manifest_Note_1
              ,Invoice_Manifest_Note_2 = source.Invoice_Manifest_Note_2
              ,Invoice_Manifest_Note_3 = source.Invoice_Manifest_Note_3
              ,Invoice_Manifest_Note_4 = source.Invoice_Manifest_Note_4
			  ,Customer_Dim_ID = source.Customer_Dim_ID
			  ,Purchase_Order_Dim_ID = source.Purchase_Order_Dim_ID
WHEN NOT MATCHED THEN
    INSERT
           (Allocation_Date_Dim_ID
           ,Wholesale_Order_Dim_ID
           ,Item_Dim_ID
           ,Invoice_Qty
           ,Invoice_Extended_Price_Home
           ,Invoice_Extended_Price_Curr
           ,Invoice_Tax_Value_Home
           ,Invoice_Tax_Value_Curr
           ,Invoice_Shipping_And_Handling_Home
           ,Invoice_Shipping_And_Handling_Curr
           ,Invoice_Discount_Amount_Home
           ,Invoice_Discount_Amount_Curr
           ,Invoice_Manifest_Note_1
           ,Invoice_Manifest_Note_2
           ,Invoice_Manifest_Note_3
           ,Invoice_Manifest_Note_4
		   ,Customer_Dim_ID
		   ,Invoice_Number
		   ,Purchase_Order_Dim_ID
	       )
    VALUES (
           source.Allocation_Date_Dim_ID
           ,source.Wholesale_Order_Dim_ID
           ,source.Item_Dim_ID
           ,source.Invoice_Qty
           ,source.Invoice_Extended_Price_Home
           ,source.Invoice_Extended_Price_Curr
           ,source.Invoice_Tax_Value_Home
           ,source.Invoice_Tax_Value_Curr
           ,source.Invoice_Shipping_And_Handling_Home
           ,source.Invoice_Shipping_And_Handling_Curr
           ,source.Invoice_Discount_Amount_Home
           ,source.Invoice_Discount_Amount_Curr
           ,source.Invoice_Manifest_Note_1
           ,source.Invoice_Manifest_Note_2
           ,source.Invoice_Manifest_Note_3
           ,source.Invoice_Manifest_Note_4
		   ,source.Customer_Dim_ID
		   ,source.Invoice_Number
		   ,source.Purchase_Order_Dim_ID
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Wholesale_Invoice_Fact: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
