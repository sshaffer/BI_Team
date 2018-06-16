SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Customer_Current_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_Customer_Current_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


MERGE INTO dbo.Customer_Current_Dim target
USING (
	SELECT 
		hist.Customer_Dim_ID
		,curr.Customer_Number
		,curr.Customer_Title
		,curr.Customer_First_Name
		,curr.Customer_Last_Name
		,curr.Customer_Nickname
		,curr.Address_Line_1
		,curr.Address_Line_2
		,curr.City
		,curr.State
		,curr.Country_Dim_ID
		,curr.Postal_Code
		,curr.Customer_Type_Dim_ID
		,curr.Telephone_No
		,curr.Alternate_Telephone_No
		,curr.Email_Address
		,curr.Twitter_Name
		,curr.Gender
		,curr.Date_of_Birth
		,curr.Currency_Dim_ID
		,curr.Registration_Date
		,curr.Email_Marketing_Preference
		,curr.Shoe_Size
	FROM dbo.Customer_Dim curr
	JOIN dbo.Customer_Dim hist  ON
		hist.Customer_Number = curr.Customer_Number
	WHERE curr.Current_Customer_Flag = 'TRUE'
) source
ON source.Customer_Dim_ID = target.Customer_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Customer_Number = source.Customer_Number
	,Customer_Title = source.Customer_Title
	,Customer_First_Name = source.Customer_First_Name
	,Customer_Last_Name = source.Customer_Last_Name
	,Customer_Nickname = source.Customer_Nickname
	,Address_Line_1 = source.Address_Line_1
	,Address_Line_2 = source.Address_Line_2
	,City = source.City
	,State = source.State
	,Country_Dim_ID = source.Country_Dim_ID
	,Postal_Code = source.Postal_Code
	,Customer_Type_Dim_ID = source.Customer_Type_Dim_ID
	,Telephone_No = source.Telephone_No
	,Alternate_Telephone_No = source.Alternate_Telephone_No
	,Email_Address = source.Email_Address
	,Twitter_Name = source.Twitter_Name
	,Gender = source.Gender
	,Date_of_Birth = source.Date_of_Birth
	,Currency_Dim_ID = source.Currency_Dim_ID
	,Registration_Date = source.Registration_Date
	,Email_Marketing_Preference = source.Email_Marketing_Preference
	,Shoe_Size = source.Shoe_Size
WHEN NOT MATCHED THEN
INSERT (
	Customer_Dim_ID
	,Customer_Number
	,Customer_Title
	,Customer_First_Name
	,Customer_Last_Name
	,Customer_Nickname
	,Address_Line_1
	,Address_Line_2
	,City
	,State
	,Country_Dim_ID
	,Postal_Code
	,Customer_Type_Dim_ID
	,Telephone_No
	,Alternate_Telephone_No
	,Email_Address
	,Twitter_Name
	,Gender
	,Date_of_Birth
	,Currency_Dim_ID
	,Registration_Date
	,Email_Marketing_Preference
	,Shoe_Size
) VALUES (
	source.Customer_Dim_ID
	,source.Customer_Number
	,source.Customer_Title
	,source.Customer_First_Name
	,source.Customer_Last_Name
	,source.Customer_Nickname
	,source.Address_Line_1
	,source.Address_Line_2
	,source.City
	,source.State
	,source.Country_Dim_ID
	,source.Postal_Code
	,source.Customer_Type_Dim_ID
	,source.Telephone_No
	,source.Alternate_Telephone_No
	,source.Email_Address
	,source.Twitter_Name
	,source.Gender
	,source.Date_of_Birth
	,source.Currency_Dim_ID
	,source.Registration_Date
	,source.Email_Marketing_Preference
	,source.Shoe_Size
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Customer_Current_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
