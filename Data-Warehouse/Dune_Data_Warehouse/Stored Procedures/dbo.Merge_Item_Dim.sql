
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Merge_Item_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_Item_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 


MERGE INTO dbo.Item_Dim target
USING Dune_Data_Warehouse_Staging..Item_Dim source
ON source.Item_Dim_ID = target.Item_Dim_ID
WHEN MATCHED THEN
UPDATE SET
	Item_Code = source.Item_Code
	,Style = source.Style
	,Item_Description = source.Item_Description
	,Item_Short_Description = source.Item_Short_Description
	,Currency_Dim_ID = source.Currency_Dim_ID
	,Current_Cost_Price = source.Current_Cost_Price
	,Commodity_Code = source.Commodity_Code
	,Vendor_Style = source.Vendor_Style
	,GTIN = source.GTIN
	,Prepack_Type = source.Prepack_Type
	,Prepack_Flag = source.Prepack_Flag
	,Prepack_Qty = source.Prepack_Qty
	,Colour_Code = source.Colour_Code
	,Colour_Name = source.Colour_Name
	,Country_Dim_ID = source.Country_Dim_ID
	,Country_of_Manufacture_Country_Dim_ID = source.Country_of_Manufacture_Country_Dim_ID
	,Country_of_Origin_Country_Dim_ID = source.Country_of_Origin_Country_Dim_ID
	,Supplier_Dim_ID = source.Supplier_Dim_ID
	,Size_Code = source.Size_Code
	,Size_Name = source.Size_Name
	,Class_Dim_ID = source.Class_Dim_ID
	,Division_Dim_ID = source.Division_Dim_ID
	,Department_Dim_ID = source.Department_Dim_ID
	,Subdepartment_Dim_ID = source.Subdepartment_Dim_ID
	,Colour_Dim_ID = source.Colour_Dim_ID
	,ISBN = source.ISBN
	,UPC_GTIN = source.UPC_GTIN
	,GTIN14 = source.GTIN14
	,DP_EAN = source.DP_EAN
	,TOPM_EAN = source.TOPM_EAN
	,TOPS_EAN = source.TOPS_EAN
	,Ext_Att_Insole = source.Ext_Att_Insole
	,Ext_Att_Lining = source.Ext_Att_Lining
	,Ext_Att_Sole = source.Ext_Att_Sole
	,Ext_Att_Article = source.Ext_Att_Article
	,Ext_Att_Heel_Measurement = source.Ext_Att_Heel_Measurement
	,Ext_Att_UAE_Store_Grading = source.Ext_Att_UAE_Store_Grading
	,Ext_Att_Sample_Sent_to_DC = source.Ext_Att_Sample_Sent_to_DC
	,Ext_Att_Last = source.Ext_Att_Last
	,Ext_Att_Upper_Material = source.Ext_Att_Upper_Material
	,Ext_Att_Sock_Material = source.Ext_Att_Sock_Material
	,Ext_Att_UK_Store_Grading = source.Ext_Att_UK_Store_Grading
	,Ext_Att_Sample_Confirmed = source.Ext_Att_Sample_Confirmed
	,Ext_Att_Retail_Press_Sample = source.Ext_Att_Retail_Press_Sample
	,Ext_Att_Heel_Name_Type = source.Ext_Att_Heel_Name_Type
	,Ext_Att_Sock_Lable = source.Ext_Att_Sock_Lable
	,Ext_Att_Russia_Store_Grading = source.Ext_Att_Russia_Store_Grading
	,Ext_Att_Sample_Shop = source.Ext_Att_Sample_Shop
	,Original_Sale_Price = source.Original_Sale_Price
	,US_Commodity_Code = source.US_Commodity_Code
	,Retail_Price = source.Retail_Price
WHEN NOT MATCHED THEN
INSERT (
	Item_Dim_ID
	,Item_Code
	,Style
	,Item_Description
	,Item_Short_Description
	,Currency_Dim_ID
	,Current_Cost_Price
	,Commodity_Code
	,SKU
	,Vendor_Style
	,GTIN
	,Prepack_Type
	,Prepack_Flag
	,Prepack_Qty
	,Colour_Code
	,Colour_Name
	,Country_Dim_ID
	,Country_of_Manufacture_Country_Dim_ID
	,Country_of_Origin_Country_Dim_ID
	,Supplier_Dim_ID
	,Size_Code
	,Size_Name
	,Class_Dim_ID
	,Division_Dim_ID
	,Department_Dim_ID
	,Subdepartment_Dim_ID
	,ISBN
	,UPC_GTIN
	,GTIN14
	,DP_EAN
	,TOPM_EAN
	,TOPS_EAN
	,Ext_Att_Insole
	,Ext_Att_Lining
	,Ext_Att_Sole
	,Ext_Att_Article
	,Ext_Att_Heel_Measurement
	,Ext_Att_UAE_Store_Grading
	,Ext_Att_Sample_Sent_to_DC
	,Ext_Att_Last
	,Ext_Att_Upper_Material
	,Ext_Att_Sock_Material
	,Ext_Att_UK_Store_Grading
	,Ext_Att_Sample_Confirmed
	,Ext_Att_Retail_Press_Sample
	,Ext_Att_Heel_Name_Type
	,Ext_Att_Sock_Lable
	,Ext_Att_Russia_Store_Grading
	,Ext_Att_Sample_Shop
	,Original_Sale_Price
	,US_Commodity_Code
	,Retail_Price
) VALUES (
	source.Item_Dim_ID
	,source.Item_Code
	,source.Style
	,source.Item_Description
	,source.Item_Short_Description
	,source.Currency_Dim_ID
	,source.Current_Cost_Price
	,source.Commodity_Code
	,source.SKU
	,source.Vendor_Style
	,source.GTIN
	,source.Prepack_Type
	,source.Prepack_Flag
	,source.Prepack_Qty
	,source.Colour_Code
	,source.Colour_Name
	,source.Country_Dim_ID
	,source.Country_of_Manufacture_Country_Dim_ID
	,source.Country_of_Origin_Country_Dim_ID
	,source.Supplier_Dim_ID
	,source.Size_Code
	,source.Size_Name
	,source.Class_Dim_ID
	,source.Division_Dim_ID
	,source.Department_Dim_ID
	,source.Subdepartment_Dim_ID
	,source.ISBN
	,source.UPC_GTIN
	,source.GTIN14
	,source.DP_EAN
	,source.TOPM_EAN
	,source.TOPS_EAN
	,source.Ext_Att_Insole
	,source.Ext_Att_Lining
	,source.Ext_Att_Sole
	,source.Ext_Att_Article
	,source.Ext_Att_Heel_Measurement
	,source.Ext_Att_UAE_Store_Grading
	,source.Ext_Att_Sample_Sent_to_DC
	,source.Ext_Att_Last
	,source.Ext_Att_Upper_Material
	,source.Ext_Att_Sock_Material
	,source.Ext_Att_UK_Store_Grading
	,source.Ext_Att_Sample_Confirmed
	,source.Ext_Att_Retail_Press_Sample
	,source.Ext_Att_Heel_Name_Type
	,source.Ext_Att_Sock_Lable
	,source.Ext_Att_Russia_Store_Grading
	,source.Ext_Att_Sample_Shop
	,source.Original_Sale_Price
	,source.US_Commodity_Code
	,source.Retail_Price
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Item_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;



EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;
GO
