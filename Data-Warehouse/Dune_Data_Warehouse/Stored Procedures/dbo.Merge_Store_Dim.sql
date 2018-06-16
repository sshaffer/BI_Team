
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Store_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_Store_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Store_Dim target
USING Dune_Data_Warehouse_Staging..Store_Dim source
ON source.Store_Dim_ID = target.Store_Dim_ID
WHEN MATCHED THEN
UPDATE SET 
	Store_Name = source.Store_Name
	,Store_Address_Line_1 = source.Store_Address_Line_1
	,Store_Address_Line_2 = source.Store_Address_Line_2
	,City = source.City
	,State = source.State
	,Post_Code = source.Post_Code
	,Country = source.Country
	,Store_Manager = source.Store_Manager
	,Telephone_No = source.Telephone_No
	,Price_Group_ID = source.Price_Group_ID
	,Zone_Dim_ID = source.Zone_Dim_ID
	,Territory_Dim_ID = source.Territory_Dim_ID
	,Region_Dim_ID = source.Region_Dim_ID
	,District_Dim_ID = source.District_Dim_ID
	,Open_Date = source.Open_Date
	,Open_Time_Sun = source.Open_Time_Sun
	,Close_Time_Sun = source.Close_Time_Sun
	,Open_Time_Mon = source.Open_Time_Mon
	,Close_Time_Mon = source.Close_Time_Mon
	,Open_Time_Tues = source.Open_Time_Tues
	,Close_Time_Tues = source.Close_Time_Tues
	,Open_Time_Wed = source.Open_Time_Wed
	,Close_Time_Wed = source.Close_Time_Wed
	,Open_Time_Thurs = source.Open_Time_Thurs
	,Close_Time_Thurs = source.Close_Time_Thurs
	,Open_Time_Fri = source.Open_Time_Fri
	,Close_Time_Fri = source.Close_Time_Fri
	,Open_Time_Sat = source.Open_Time_Sat
	,Close_Time_Sat = source.Close_Time_Sat
	,Warehouse_Flag = source.Warehouse_Flag
	,SSTX = source.SSTX
	,Country_Name = source.Country_Name
	,Trading_Space = source.Trading_Space 
	,Non_Trading_Space = source.Non_Trading_Space
	,Total_Space = source.Total_Space
	,Store_Email = source.Store_Email
WHEN NOT MATCHED THEN
INSERT(
	Store_Dim_ID
	,Store_Number
	,Store_Name
	,Store_Address_Line_1
	,Store_Address_Line_2
	,City
	,State
	,Post_Code
	,Country
	,Store_Manager
	,Telephone_No
	,Price_Group_ID
	,Zone_Dim_ID
	,Territory_Dim_ID
	,Region_Dim_ID
	,District_Dim_ID
	,Open_Date
	,Open_Time_Sun
	,Close_Time_Sun
	,Open_Time_Mon
	,Close_Time_Mon
	,Open_Time_Tues
	,Close_Time_Tues
	,Open_Time_Wed
	,Close_Time_Wed
	,Open_Time_Thurs
	,Close_Time_Thurs
	,Open_Time_Fri
	,Close_Time_Fri
	,Open_Time_Sat
	,Close_Time_Sat
	,Warehouse_Flag
	,SSTX
	,Country_Name
	,Trading_Space
	,Non_Trading_Space
	,Total_Space
	,Store_Email
) VALUES (
	source.Store_Dim_ID
	,source.Store_Number
	,source.Store_Name
	,source.Store_Address_Line_1
	,source.Store_Address_Line_2
	,source.City
	,source.State
	,source.Post_Code
	,source.Country
	,source.Store_Manager
	,source.Telephone_No
	,source.Price_Group_ID
	,source.Zone_Dim_ID
	,source.Territory_Dim_ID
	,source.Region_Dim_ID
	,source.District_Dim_ID
	,source.Open_Date
	,source.Open_Time_Sun
	,source.Close_Time_Sun
	,source.Open_Time_Mon
	,source.Close_Time_Mon
	,source.Open_Time_Tues
	,source.Close_Time_Tues
	,source.Open_Time_Wed
	,source.Close_Time_Wed
	,source.Open_Time_Thurs
	,source.Close_Time_Thurs
	,source.Open_Time_Fri
	,source.Close_Time_Fri
	,source.Open_Time_Sat
	,source.Close_Time_Sat
	,source.Warehouse_Flag
	,source.SSTX
	,source.Country_Name
	,source.Trading_Space
	,source.Non_Trading_Space
	,source.Total_Space
	,source.Store_Email
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Store_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
