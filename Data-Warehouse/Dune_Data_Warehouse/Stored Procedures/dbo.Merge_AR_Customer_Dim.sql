SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC dbo.Merge_AR_Customer_Dim 
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
EXEC dbo.Log_Start @Source, 'Merge_AR_Customer_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION Sales_Returns_Facts

MERGE INTO dbo.AR_Customer_Dim target
USING Dune_Data_Warehouse_Staging..AR_Customer_Dim source
ON source.AR_Customer_Dim_ID = target.AR_Customer_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Company_Name = source.Company_Name
	,Address_Line_1 = source.Address_Line_1
	,Address_Line_2 = source.Address_Line_2
	,City = source.City
	,State = source.State
	,Post_Code = source.Post_Code
	,Discount_Percentage = source.Discount_Percentage
	,Credit_Limit = source.Credit_Limit
	,Uninvoiced_Credit_Used = source.Uninvoiced_Credit_Used
	,Invoiced_Credit_Used = source.Invoiced_Credit_Used
	,Accumulated_Days_to_Pay = source.Accumulated_Days_to_Pay
	,Longest_No_of_Days_to_Pay = source.Longest_No_of_Days_to_Pay
WHEN NOT MATCHED THEN
INSERT (
	AR_Customer_Dim_ID
	,AR_Customer_No
	,Company_Name
	,Address_Line_1
	,Address_Line_2
	,City
	,State
	,Post_Code
	,Discount_Percentage
	,Credit_Limit
	,Uninvoiced_Credit_Used
	,Invoiced_Credit_Used
	,Accumulated_Days_to_Pay
	,Longest_No_of_Days_to_Pay
) VALUES (
	 source.AR_Customer_Dim_ID
	,source.AR_Customer_No
	,source.Company_Name
	,source.Address_Line_1
	,source.Address_Line_2
	,source.City
	,source.State
	,source.Post_Code
	,source.Discount_Percentage
	,source.Credit_Limit
	,source.Uninvoiced_Credit_Used
	,source.Invoiced_Credit_Used
	,source.Accumulated_Days_to_Pay
	,source.Longest_No_of_Days_to_Pay

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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_AR_Customer_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
