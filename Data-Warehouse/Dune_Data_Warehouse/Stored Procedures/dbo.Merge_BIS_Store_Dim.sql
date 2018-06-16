
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_BIS_Store_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_BIS_Store_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.BIS_Store_Dim target
USING (
	SELECT
		s.Store_Dim_ID
	   ,s.Store_Number
	   ,s.Store_Name
	   ,s.Store_Address_Line_1
	   ,s.Store_Address_Line_2
	   ,s.City
	   ,s.State
	   ,s.Post_Code
	   ,s.Country
	   ,s.Country_Name
	   ,s.Store_Manager
	   ,s.Telephone_No
	   ,s.Price_Group_ID
	   ,pg.Price_Group_Code
	   ,pg.Price_Group_Desc
	   ,s.Zone_Dim_ID
	   ,zon.Zone_Code
	   ,zon.Zone_Name
	   ,s.Territory_Dim_ID
	   ,ter.Territory_Code
	   ,ter.Territory_Name
	   ,s.Region_Dim_ID
	   ,reg.Region_Code
	   ,reg.Region_Name
	   ,s.District_Dim_ID
	   ,dis.District_Code
	   ,dis.District_Name
	   ,s.Open_Date
	   ,s.Open_Time_Sun
	   ,s.Close_Time_Sun
	   ,s.Open_Time_Mon
	   ,s.Close_Time_Mon
	   ,s.Open_Time_Tues
	   ,s.Close_Time_Tues
	   ,s.Open_Time_Wed
	   ,s.Close_Time_Wed
	   ,s.Open_Time_Thurs
	   ,s.Close_Time_Thurs
	   ,s.Open_Time_Fri
	   ,s.Close_Time_Fri
	   ,s.Open_Time_Sat
	   ,s.Close_Time_Sat
	   ,s.Warehouse_Flag
	   ,s.SSTX
	   ,s.Trading_Space
	   ,s.Non_Trading_Space
	   ,s.Total_Space
	   ,COALESCE(attAreaNumber.Attribute_Value_Name,'UNKNOWN') AS Area_Number
	   ,COALESCE(attClearance.Attribute_Value_Name,'UNKNOWN') AS Clearance
	   ,COALESCE(attCustomsWarehousing.Attribute_Value_Name,'UNKNOWN') AS Customs_Warehousing
	   ,COALESCE(attDeliveryRun.Attribute_Value_Name,'UNKNOWN') AS Delivery_Run
	   ,COALESCE(attHost.Attribute_Value_Name,'UNKNOWN') AS Host
	   ,COALESCE(attStandaloneType.Attribute_Value_Name,'UNKNOWN') AS Standalone_Type
	   ,COALESCE(attStockRoom1.Attribute_Value_Name,'UNKNOWN') AS Stock_Room_1
	   ,COALESCE(attStockRoom2.Attribute_Value_Name,'UNKNOWN') AS Stock_Room_2
	   ,COALESCE(attType.Attribute_Value_Name,'UNKNOWN') AS TYPE
       ,COALESCE(attHostStoreAndWeb.Attribute_Value_Name,'UNKNOWN') as HostStoreAndWeb
	   ,COALESCE(attBricksAndMortarInt.Attribute_Value_Name,'UNKNOWN') as BricksAndMortarInt
	   ,COALESCE(attAHrryInStore.Attribute_Value_Name,'UNKNOWN') AS HarryInStore
	   ,s.Store_Type
	   ,s.Currency
	   ,s.Apparel_Facia
	   ,s.Apparel_Exclude_From_Reports
	   ,s.Store_Email
	FROM dbo.Store_Dim s
	JOIN dbo.Price_Group_Dim pg
		ON pg.Price_Group_Dim_ID = s.Price_Group_ID
	JOIN dbo.Zone_Dim zon
		ON zon.Zone_Dim_ID =s.Zone_Dim_ID
	JOIN dbo.Territory_Dim ter
		ON ter.Territory_Dim_ID = s.Territory_Dim_ID
	JOIN dbo.Region_Dim reg
		ON reg.Region_Dim_ID = s.Region_Dim_ID
	JOIN dbo.District_Dim dis
		ON dis.District_Dim_ID = s.District_Dim_ID
	LEFT JOIN dbo.Store_Attribute_Dim attAreaNumber
		ON attAreaNumber.Store_Dim_ID = s.Store_Dim_ID
		AND attAreaNumber.Attribute_Category_Name = 'Area Number'
	LEFT JOIN dbo.Store_Attribute_Dim attClearance
		ON attClearance.Store_Dim_ID = s.Store_Dim_ID
		AND attClearance.Attribute_Category_Name = 'Clearance'
	LEFT JOIN dbo.Store_Attribute_Dim attCustomsWarehousing
		ON attCustomsWarehousing.Store_Dim_ID = s.Store_Dim_ID
		AND attCustomsWarehousing.Attribute_Category_Name = 'Customs Warehousing'
	LEFT JOIN dbo.Store_Attribute_Dim attDeliveryRun
		ON attDeliveryRun.Store_Dim_ID = s.Store_Dim_ID
		AND attDeliveryRun.Attribute_Category_Name = 'Delivery run'
	LEFT JOIN dbo.Store_Attribute_Dim attHost
		ON attHost.Store_Dim_ID = s.Store_Dim_ID
		AND attHost.Attribute_Category_Name = 'Host'
	LEFT JOIN dbo.Store_Attribute_Dim attStandaloneType
		ON attStandaloneType.Store_Dim_ID = s.Store_Dim_ID
		AND attStandaloneType.Attribute_Category_Name = 'Standalone Type'
	LEFT JOIN dbo.Store_Attribute_Dim attStockRoom1
		ON attStockRoom1.Store_Dim_ID = s.Store_Dim_ID
		AND attStockRoom1.Attribute_Category_Name = 'Stock Room 1'
	LEFT JOIN dbo.Store_Attribute_Dim attStockRoom2
		ON attStockRoom2.Store_Dim_ID = s.Store_Dim_ID
		AND attStockRoom2.Attribute_Category_Name = 'Stock Room 2'
	LEFT JOIN dbo.Store_Attribute_Dim attType
		ON attType.Store_Dim_ID = s.Store_Dim_ID
		AND attType.Attribute_Category_Name = 'Type'
	LEFT JOIN dbo.Store_Attribute_Dim attHostStoreAndWeb
		ON attHostStoreAndWeb.Store_Dim_ID = s.Store_Dim_ID
		AND attHostStoreAndWeb.Attribute_Category_Name = 'Host Store and Web'
	LEFT JOIN dbo.Store_Attribute_Dim attBricksAndMortarInt
		ON attBricksAndMortarInt.Store_Dim_ID = s.Store_Dim_ID
		AND attBricksAndMortarInt.Attribute_Category_Name = 'Bricks and Mortar - Int'
	LEFT JOIN dbo.Store_Attribute_Dim attAHrryInStore
		ON attAHrryInStore.Store_Dim_ID = s.Store_Dim_ID
		AND attAHrryInStore.Attribute_Category_Name = 'Harry In Store'	

) source 
	ON source.Store_Dim_ID = target.Store_Dim_ID
WHEN MATCHED THEN
UPDATE SET	
	Store_Number = source.Store_Number
	,Store_Name = source.Store_Name
	,Store_Address_Line_1 = source.Store_Address_Line_1
	,Store_Address_Line_2 = source.Store_Address_Line_2
	,City = source.City
	,State = source.State
	,Post_Code = source.Post_Code
	,Country = source.Country
	,Country_Name = source.Country_Name
	,Store_Manager = source.Store_Manager
	,Telephone_No = source.Telephone_No
	,Price_Group_ID = source.Price_Group_ID
	,Price_Group_Code = source.Price_Group_Code
	,Price_Group_Desc = source.Price_Group_Desc
	,Zone_Dim_ID = source.Zone_Dim_ID
	,Zone_Code = source.Zone_Code
	,Zone_Name = source.Zone_Name
	,Territory_Dim_ID = source.Territory_Dim_ID
	,Territory_Code = source.Territory_Code
	,Territory_Name = source.Territory_Name
	,Region_Dim_ID = source.Region_Dim_ID
	,Region_Code = source.Region_Code
	,Region_Name = source.Region_Name
	,District_Dim_ID = source.District_Dim_ID
	,District_Code = source.District_Code
	,District_Name = source.District_Name
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
	,Trading_Space = source.Trading_Space
	,Non_Trading_Space = source.Non_Trading_Space
	,Total_Space = source.Total_Space
	,Area_Number = source.Area_Number
	,Clearance = source.Clearance
	,Customs_Warehousing = source.Customs_Warehousing
	,Delivery_Run = source.Delivery_Run
	,Host = source.Host
	,Standalone_Type = source.Standalone_Type
	,Stock_Room_1 = source.Stock_Room_1
	,Stock_Room_2 = source.Stock_Room_2
	,Type = source.TYPE
    ,HostStoreAndWeb = source.HostStoreAndWeb
	,BricksAndMortarInt = source.BricksAndMortarInt
	,HarryInStore = source.HarryInStore
	,Store_Type = source.Store_Type
	,Currency = source.Currency
	,Apparel_Facia = source.Apparel_Facia
	,Apparel_Exclude_From_Reports = source.Apparel_Exclude_From_Reports
	,Store_Email = source.Store_Email
WHEN NOT MATCHED THEN 
INSERT (
	Store_Dim_ID
	,Store_Number
	,Store_Name
	,Store_Address_Line_1
	,Store_Address_Line_2
	,City
	,State
	,Post_Code
	,Country
	,Country_Name
	,Store_Manager
	,Telephone_No
	,Price_Group_ID
	,Price_Group_Code
	,Price_Group_Desc
	,Zone_Dim_ID
	,Zone_Code
	,Zone_Name
	,Territory_Dim_ID
	,Territory_Code
	,Territory_Name
	,Region_Dim_ID
	,Region_Code
	,Region_Name
	,District_Dim_ID
	,District_Code
	,District_Name
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
	,Trading_Space
	,Non_Trading_Space
	,Total_Space
	,Area_Number
	,Clearance
	,Customs_Warehousing
	,Delivery_Run
	,Host
	,Standalone_Type
	,Stock_Room_1
	,Stock_Room_2
	,Type
	,HostStoreAndWeb
	,BricksAndMortarInt
	,HarryInStore
	,Store_Type
	,Currency
	,Apparel_Facia
	,Apparel_Exclude_from_Reports
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
	,source.Country_Name
	,source.Store_Manager
	,source.Telephone_No
	,source.Price_Group_ID
	,source.Price_Group_Code
	,source.Price_Group_Desc
	,source.Zone_Dim_ID
	,source.Zone_Code
	,source.Zone_Name
	,source.Territory_Dim_ID
	,source.Territory_Code
	,source.Territory_Name
	,source.Region_Dim_ID
	,source.Region_Code
	,source.Region_Name
	,source.District_Dim_ID
	,source.District_Code
	,source.District_Name
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
	,source.Trading_Space
	,source.Non_Trading_Space
	,source.Total_Space
	,source.Area_Number
	,source.Clearance
	,source.Customs_Warehousing
	,source.Delivery_Run
	,source.Host
	,source.Standalone_Type
	,source.Stock_Room_1
	,source.Stock_Room_2
	,source.TYPE
    ,source.HostStoreAndWeb
	,source.BricksAndMortarInt
	,source.HarryInStore
	,source.Store_Type
	,source.Currency
	,source.Apparel_Facia
	,source.Apparel_Exclude_from_Reports
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_BIS_Store_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;


GO
