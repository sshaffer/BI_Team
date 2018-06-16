SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_VIP_Customer_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_VIP_Customer_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.VIP_Customer_Dim target
USING (
	SELECT
		VIP_Customer_Dim_ID
		,VIP_Customer_Number 
		,Customer_Title
		,Customer_First_Name 
		,Customer_Last_Name
		,Email_Address 
		,Telephone_No 
		,Alternate_Telephone_No 
		,Shoe_Size 
		,Address_Line_1 
		,Address_Line_2 
		,Address_Line_3 
		,Address_Line_4 
		,Postal_Code 
		,Country 
		,Registered_Store_Dim_ID 
		,Optin_Dune 
		,Optin_3rdParty 
		,From_Date 
		,To_Date 
		,Current_VIP_Customer_Flag  
		,DateRegistered
	FROM Dune_Data_Warehouse_Staging..VIP_Customer_Dim
	WHERE NewOrChangedCustomer = 'TRUE'
) source
ON source.VIP_Customer_Dim_ID = target.VIP_Customer_Dim_ID
WHEN MATCHED THEN 
UPDATE SET
		Customer_Title = source.Customer_Title
		,Customer_First_Name = source.Customer_First_Name
		,Customer_Last_Name = source.Customer_Last_Name
		,Email_Address = source.Email_Address
		,Telephone_No = source.Telephone_No
		,Alternate_Telephone_No = source.Alternate_Telephone_No
		,Shoe_Size = source.Shoe_Size
		,Address_Line_1 = source.Address_Line_1
		,Address_Line_2 = source.Address_Line_2
		,Address_Line_3 = source.Address_Line_3
		,Address_Line_4 = source.Address_Line_4
		,Postal_Code = source.Postal_Code
		,Country = source.Country
		,Registered_Store_Dim_ID = source.Registered_Store_Dim_ID
		,Optin_Dune = source.Optin_Dune
		,Optin_3rdParty = source.Optin_3rdParty
		,From_Date = source.From_Date
		,To_Date = source.To_Date
		,Current_VIP_Customer_Flag = source.Current_VIP_Customer_Flag
		,DateRegistered = source.DateRegistered
WHEN NOT MATCHED THEN 
INSERT (
	VIP_Customer_Dim_ID
	,VIP_Customer_Number 
	,Customer_Title
	,Customer_First_Name 
	,Customer_Last_Name
	,Email_Address 
	,Telephone_No 
	,Alternate_Telephone_No 
	,Shoe_Size 
	,Address_Line_1 
	,Address_Line_2 
	,Address_Line_3 
	,Address_Line_4 
	,Postal_Code 
	,Country 
	,Registered_Store_Dim_ID 
	,Optin_Dune 
	,Optin_3rdParty 
	,From_Date 
	,To_Date 
	,Current_VIP_Customer_Flag
	,DateRegistered
) VALUES (
		source.VIP_Customer_Dim_ID
		,source.VIP_Customer_Number 
		,source.Customer_Title
		,source.Customer_First_Name 
		,source.Customer_Last_Name
		,source.Email_Address 
		,source.Telephone_No 
		,source.Alternate_Telephone_No 
		,source.Shoe_Size 
		,source.Address_Line_1 
		,source.Address_Line_2 
		,source.Address_Line_3 
		,source.Address_Line_4 
		,source.Postal_Code 
		,source.Country 
		,source.Registered_Store_Dim_ID 
		,source.Optin_Dune 
		,source.Optin_3rdParty 
		,source.From_Date 
		,source.To_Date 
		,source.Current_VIP_Customer_Flag
		,source.DateRegistered
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_VIP_Customer_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;



EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
