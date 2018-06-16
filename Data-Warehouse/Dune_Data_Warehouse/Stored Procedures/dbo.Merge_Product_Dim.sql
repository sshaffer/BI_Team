
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Product_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_Product_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.Product_Dim target
USING
    ( SELECT
        i.Item_Dim_ID
       ,i.Item_Code
       ,i.Style
       ,i.Item_Description
       ,i.Item_Short_Description
       ,i.Currency_Dim_ID
       ,cur.Currency_Code
       ,cur.Currency_Description
       ,i.Current_Cost_Price
       ,i.Commodity_Code
       ,i.SKU
       ,i.Vendor_Style
       ,i.GTIN
       ,i.Prepack_Type
       ,i.Prepack_Flag
       ,i.Prepack_Qty
       ,i.Country_Dim_ID
       ,cnt.Country_Code
       ,cnt.Country_Name
       ,i.Country_of_Manufacture_Country_Dim_ID
       ,Country_of_Manufacture_Code = cntManufacture.Country_Code
       ,Country_of_Manufacture_Name = cntManufacture.Country_Name
       ,i.Country_of_Origin_Country_Dim_ID
       ,Country_of_Origin_Code = cntOrigin.Country_Code
       ,Country_of_Origin_Name = cntOrigin.Country_Name
       ,i.Supplier_Dim_ID
       ,sup.Supplier_Code
       ,sup.Supplier_Name
       ,i.Size_Code
       ,i.Size_Name
       ,i.Class_Dim_ID
       ,cls.Class_Code
       ,cls.Class_Name
       ,i.Division_Dim_ID
       ,div.Division_Code
       ,div.Division_Name
       ,i.Department_Dim_ID
       ,dep.Department_Code
       ,dep.Department_Name
       ,i.Subdepartment_Dim_ID
       ,sub.Subdepartment_Code
       ,sub.Subdepartment_Name
       ,Subdepartment_Group_Name = subgrp.Group_Name
       ,Subdepartmnet_Subgroup_Name = subGrp.Subgroup_Name
       ,i.Colour_Dim_ID
       ,clr.Colour_Code
       ,clr.Colour_Name
       ,Bag_Match = COALESCE(attBagMatch.Attribute_Value_Name, 'UNKNOWN')
       ,Boot_Height = COALESCE(attBootHeight.Attribute_Value_Name, 'UNKNOWN')
       ,Boot_Measurement_CM = COALESCE(attBootMeasurementCM.Attribute_Value_Name,'UNKNOWN')
       ,Colour_Group = COALESCE(attColourGrp.Attribute_Value_Name, 'UNKNOWN')
       ,Comfort_Footbed = COALESCE(attComfortFootbed.Attribute_Value_Name,'UNKNOWN')
       ,Direct = COALESCE(attDirect.Attribute_Value_Name, 'UNKNOWN')
       ,External_Brands = COALESCE(attExternalBrands.Attribute_Value_Name,'UNKNOWN')
       ,Fastening = COALESCE(attFastening.Attribute_Value_Name, 'UNKNOWN')
       ,Feature = COALESCE(attFeature.Attribute_Value_Name, 'UNKNOWN')
       ,Heel_Height = COALESCE(attHeelHeight.Attribute_Value_Name, 'UNKNOWN')
       ,Heel_Measurement = COALESCE(attHeelMeasurement.Attribute_Value_Name,'UNKNOWN')
       ,Heel_Shape = COALESCE(attHeelShape.Attribute_Value_Name, 'UNKNOWN')
       ,Lining_Material = COALESCE(attLiningMaterial.Attribute_Value_Name,'UNKNOWN')
       ,Mark_Down = COALESCE(attMarkDown.Attribute_Value_Name, 'UNKNOWN')
       ,Material = COALESCE(attMaterial.Attribute_Value_Name, 'UNKNOWN')
       ,Original_Season = COALESCE(attOriginalSeason.Attribute_Value_Name,'UNKNOWN')
       ,Pig_Skin = COALESCE(attPigSkin.Attribute_Value_Name, 'UNKNOWN')
       ,Platform = COALESCE(attPlatform.Attribute_Value_Name, 'UNKNOWN')
       ,Risk = COALESCE(attRisk.Attribute_Value_Name, 'UNKNOWN')
       ,Sale_or_Return = COALESCE(attSoR.Attribute_Value_Name, 'UNKNOWN')
       ,Season = COALESCE(attSeason.Attribute_Value_Name, 'UNKNOWN')
       ,Selfidges = COALESCE(attSelfridges.Attribute_Value_Name, 'UNKNOWN')
       ,Sole_Material = COALESCE(attSoleMaterial.Attribute_Value_Name,'UNKNOWN')
       ,Theme = COALESCE(attTheme.Attribute_Value_Name, 'UNKNOWN')
       ,Toe_Shape = COALESCE(attToeShape.Attribute_Value_Name, 'UNKNOWN')
       ,Web_Bertie = COALESCE(attWebBertie.Attribute_Value_Name, 'UNKNOWN')
       ,Web_Chelsea_Cobbler = COALESCE(attWebChelseaCobbler.Attribute_Value_Name,'UNKNOWN')
       ,Web_Pat = COALESCE(attWebPat.Attribute_Value_Name, 'UNKNOWN')
       ,Web_Shoe_Studio = COALESCE(attWebShoeStudio.Attribute_Value_Name,'UNKNOWN')
       ,X_Brightfilter_L1_PRD_RNG = COALESCE(attXBrightFilterL1PrdRng.Attribute_Value_Name,'UNKNOWN')
       ,X_Brightfilter_L2_PRD_GRP = COALESCE(attXBrightFilterL2PrdGrp.Attribute_Value_Name,'UNKNOWN')
       ,X_Brightfilter_L3_PRD_SBGRP = COALESCE(attXBrightFilterL3PrdSbgrp.Attribute_Value_Name,'UNKNOWN')
       ,X_Image = COALESCE(attXImage.Attribute_Value_Name, 'UNKNOWN')
       ,X_Style_Web = COALESCE(attXStyleWeb.Attribute_Value_Name, 'UNKNOWN')
       ,X_Web_Dune = COALESCE(attXWebDune.Attribute_Value_Name, 'UNKNOWN')
       ,Z_Brand_Definition = COALESCE(attZBrandDefinition.Attribute_Value_Name,'UNKNOWN')
	   ,Season_Code = CASE WHEN COALESCE(attSeason.Attribute_Value_Name,'') = 'UNKNOWN' THEN '' ELSE LEFT(COALESCE(attSeason.Attribute_Value_Name,''),2) END
	   ,sub.Subdepartment_Group_Dim_ID
	   ,i.ISBN
	   ,i.UPC_GTIN
	   ,i.GTIN14
	   ,i.DP_EAN
	   ,i.TOPM_EAN
	   ,i.TOPS_EAN
	   ,i.Ext_Att_Insole
	   ,i.Ext_Att_Lining
	   ,i.Ext_Att_Sole
	   ,i.Ext_Att_Article
	   ,i.Ext_Att_Heel_Measurement
	   ,i.Ext_Att_UAE_Store_Grading
	   ,i.Ext_Att_Sample_Sent_to_DC
	   ,i.Ext_Att_Last
	   ,i.Ext_Att_Upper_Material
	   ,i.Ext_Att_Sock_Material
	   ,i.Ext_Att_UK_Store_Grading
	   ,i.Ext_Att_Sample_Confirmed
	   ,i.Ext_Att_Retail_Press_Sample
	   ,i.Ext_Att_Heel_Name_Type
	   ,i.Ext_Att_Sock_Lable
	   ,i.Ext_Att_Russia_Store_Grading
	   ,i.Ext_Att_Sample_Shop
	   ,i.Original_Sale_Price
	   ,i.US_Commodity_Code
	   ,i.Retail_Price
	   ,i.Apparel_Markdown
	   ,i.Apparel_Original_Season
	   ,i.Apparel_Current_Season
	   ,i.Apparel_Item_Cost_1_AED
	   ,i.Apparel_Ticket_Price_AED
	   ,i.Apparel_Original_Price_AED
	   ,i.Apparel_Item_Cost_1_GBP
	   ,i.Apparel_Ticket_Price_GBP
	   ,i.Apparel_Original_Price_GBP
      FROM dbo.Item_Dim i
      JOIN dbo.Currency_Dim cur
        ON cur.Currency_Dim_ID = i.Currency_Dim_ID
      JOIN dbo.Country_Dim cnt
        ON cnt.Country_Dim_ID = i.Country_Dim_ID
      JOIN dbo.Country_Dim cntManufacture
        ON cntManufacture.Country_Dim_ID = i.Country_of_Manufacture_Country_Dim_ID
      JOIN dbo.Country_Dim cntOrigin
        ON cntOrigin.Country_Dim_ID = i.Country_of_Origin_Country_Dim_ID
      JOIN dbo.Supplier_Dim sup
        ON sup.Supplier_Dim_ID = i.Supplier_Dim_ID
      JOIN dbo.Class_Dim cls
        ON cls.Class_Dim_ID = i.Class_Dim_ID
      JOIN dbo.Division_Dim div
        ON div.Division_Dim_ID = i.Division_Dim_ID
      JOIN dbo.Department_Dim dep
        ON dep.Department_Dim_ID = i.Department_Dim_ID
      JOIN dbo.Subdepartment_Dim sub
        ON sub.Subdepartment_Dim_ID = i.Subdepartment_Dim_ID
      JOIN dbo.Colour_Dim clr
        ON clr.Colour_Dim_ID = i.Colour_Dim_ID
      JOIN dbo.Subdepartment_Group_Dim subGrp
        ON subGrp.Subdepartment_Group_Dim_ID = sub.Subdepartment_Group_Dim_ID
      LEFT JOIN dbo.Item_Attribute_Dim attBagMatch
        ON attBagMatch.Item_Dim_ID = i.Item_Dim_ID
           AND attBagMatch.Attribute_Category_Name = 'BAG MATCH'
      LEFT JOIN dbo.Item_Attribute_Dim attBootHeight
        ON attBootHeight.Item_Dim_ID = i.Item_Dim_ID
           AND attBootHeight.Attribute_Category_Name = 'BOOT HEIGHT'
      LEFT JOIN dbo.Item_Attribute_Dim attBootMeasurementCM
        ON attBootMeasurementCM.Item_Dim_ID = i.Item_Dim_ID
           AND attBootMeasurementCM.Attribute_Category_Name = 'BOOT MEASUREMENT (CM)'
      LEFT JOIN dbo.Item_Attribute_Dim attColourGrp
        ON attColourGrp.Item_Dim_ID = i.Item_Dim_ID
           AND attColourGrp.Attribute_Category_Name = 'COLOUR GRP'
      LEFT JOIN dbo.Item_Attribute_Dim attComfortFootbed
        ON attComfortFootbed.Item_Dim_ID = i.Item_Dim_ID
           AND attComfortFootbed.Attribute_Category_Name = 'COMFORT FOOTBED'
      LEFT JOIN dbo.Item_Attribute_Dim attDirect
        ON attDirect.Item_Dim_ID = i.Item_Dim_ID
           AND attDirect.Attribute_Category_Name = 'DIRECT'
      LEFT JOIN dbo.Item_Attribute_Dim attExternalBrands
        ON attExternalBrands.Item_Dim_ID = i.Item_Dim_ID
           AND attExternalBrands.Attribute_Category_Name = 'EXTERNAL BRANDS'
      LEFT JOIN dbo.Item_Attribute_Dim attFastening
        ON attFastening.Item_Dim_ID = i.Item_Dim_ID
           AND attFastening.Attribute_Category_Name = 'FASTENING'
      LEFT JOIN dbo.Item_Attribute_Dim attFeature
        ON attFeature.Item_Dim_ID = i.Item_Dim_ID
           AND attFeature.Attribute_Category_Name = 'FEATURE'
      LEFT JOIN dbo.Item_Attribute_Dim attHeelHeight
        ON attHeelHeight.Item_Dim_ID = i.Item_Dim_ID
           AND attHeelHeight.Attribute_Category_Name = 'HEEL HEIGHT'
      LEFT JOIN dbo.Item_Attribute_Dim attHeelMeasurement
        ON attHeelMeasurement.Item_Dim_ID = i.Item_Dim_ID
           AND attHeelMeasurement.Attribute_Category_Name = 'HEEL MEASUREMENT'
      LEFT JOIN dbo.Item_Attribute_Dim attHeelShape
        ON attHeelShape.Item_Dim_ID = i.Item_Dim_ID
           AND attHeelShape.Attribute_Category_Name = 'HEEL SHAPE'
      LEFT JOIN dbo.Item_Attribute_Dim attLiningMaterial
        ON attLiningMaterial.Item_Dim_ID = i.Item_Dim_ID
           AND attLiningMaterial.Attribute_Category_Name = 'LINING MATERIAL'
      LEFT JOIN dbo.Item_Attribute_Dim attMarkDown
        ON attMarkDown.Item_Dim_ID = i.Item_Dim_ID
           AND attMarkDown.Attribute_Category_Name = 'MARK DOWN'
      LEFT JOIN dbo.Item_Attribute_Dim attMaterial
        ON attMaterial.Item_Dim_ID = i.Item_Dim_ID
           AND attMaterial.Attribute_Category_Name = 'MATERIAL'
      LEFT JOIN dbo.Item_Attribute_Dim attOriginalSeason
        ON attOriginalSeason.Item_Dim_ID = i.Item_Dim_ID
           AND attOriginalSeason.Attribute_Category_Name = 'ORIGINAL SEASON'
      LEFT JOIN dbo.Item_Attribute_Dim attPigSkin
        ON attPigSkin.Item_Dim_ID = i.Item_Dim_ID
           AND attPigSkin.Attribute_Category_Name = 'PIG SKIN'
      LEFT JOIN dbo.Item_Attribute_Dim attPlatform
        ON attPlatform.Item_Dim_ID = i.Item_Dim_ID
           AND attPlatform.Attribute_Category_Name = 'PLATFORM'
      LEFT JOIN dbo.Item_Attribute_Dim attRisk
        ON attRisk.Item_Dim_ID = i.Item_Dim_ID
           AND attRisk.Attribute_Category_Name = 'RISK'
      LEFT JOIN dbo.Item_Attribute_Dim attSoR
        ON attSoR.Item_Dim_ID = i.Item_Dim_ID
           AND attSoR.Attribute_Category_Name = 'SALE OR RETURN - SOR'
      LEFT JOIN dbo.Item_Attribute_Dim attSeason
        ON attSeason.Item_Dim_ID = i.Item_Dim_ID
           AND attSeason.Attribute_Category_Name = 'SEASON'
      LEFT JOIN dbo.Item_Attribute_Dim attSelfridges
        ON attSelfridges.Item_Dim_ID = i.Item_Dim_ID
           AND attSelfridges.Attribute_Category_Name = 'Selfridges'
      LEFT JOIN dbo.Item_Attribute_Dim attSoleMaterial
        ON attSoleMaterial.Item_Dim_ID = i.Item_Dim_ID
           AND attSoleMaterial.Attribute_Category_Name = 'SOLE MATERIAL'
      LEFT JOIN dbo.Item_Attribute_Dim attTheme
        ON attTheme.Item_Dim_ID = i.Item_Dim_ID
           AND attTheme.Attribute_Category_Name = 'THEME'
      LEFT JOIN dbo.Item_Attribute_Dim attToeShape
        ON attToeShape.Item_Dim_ID = i.Item_Dim_ID
           AND attToeShape.Attribute_Category_Name = 'TOE SHAPE'
      LEFT JOIN dbo.Item_Attribute_Dim attWebBertie
        ON attWebBertie.Item_Dim_ID = i.Item_Dim_ID
           AND attWebBertie.Attribute_Category_Name = 'WEB BERTIE'
      LEFT JOIN dbo.Item_Attribute_Dim attWebChelseaCobbler
        ON attWebChelseaCobbler.Item_Dim_ID = i.Item_Dim_ID
           AND attWebChelseaCobbler.Attribute_Category_Name = 'WEB CHELSEA COBBLER'
      LEFT JOIN dbo.Item_Attribute_Dim attWebPat
        ON attWebPat.Item_Dim_ID = i.Item_Dim_ID
           AND attWebPat.Attribute_Category_Name = 'WEB PAT'
      LEFT JOIN dbo.Item_Attribute_Dim attWebShoeStudio
        ON attWebPat.Item_Dim_ID = i.Item_Dim_ID
           AND attWebPat.Attribute_Category_Name = 'WEB SHOE STUDIO'
      LEFT JOIN dbo.Item_Attribute_Dim attXBrightFilterL1PrdRng
        ON attXBrightFilterL1PrdRng.Item_Dim_ID = i.Item_Dim_ID
           AND attXBrightFilterL1PrdRng.Attribute_Category_Name = 'X BRIGHTFILTER(L1)PRD RNG'
      LEFT JOIN dbo.Item_Attribute_Dim attXBrightFilterL2PrdGrp
        ON attXBrightFilterL2PrdGrp.Item_Dim_ID = i.Item_Dim_ID
           AND attXBrightFilterL2PrdGrp.Attribute_Category_Name = 'X BRIGHTFILTER(L2)PRD GRP'
      LEFT JOIN dbo.Item_Attribute_Dim attXBrightFilterL3PrdSbgrp
        ON attXBrightFilterL3PrdSbgrp.Item_Dim_ID = i.Item_Dim_ID
           AND attXBrightFilterL3PrdSbgrp.Attribute_Category_Name = 'X BRIGHTFLTR(L3)PRD SBGRP'
      LEFT JOIN dbo.Item_Attribute_Dim attXImage
        ON attXImage.Item_Dim_ID = i.Item_Dim_ID
           AND attXImage.Attribute_Category_Name = 'X IMAGE'
      LEFT JOIN dbo.Item_Attribute_Dim attXStyleWeb
        ON attXStyleWeb.Item_Dim_ID = i.Item_Dim_ID
           AND attXStyleWeb.Attribute_Category_Name = 'X STYLE (WEB)'
      LEFT JOIN dbo.Item_Attribute_Dim attXWebDune
        ON attXWebDune.Item_Dim_ID = i.Item_Dim_ID
           AND attXWebDune.Attribute_Category_Name = 'X WEB DUNE'
      LEFT JOIN dbo.Item_Attribute_Dim attZBrandDefinition
        ON attZBrandDefinition.Item_Dim_ID = i.Item_Dim_ID
           AND attZBrandDefinition.Attribute_Category_Name = 'Z BRAND DEFINITION'
	  WHERE EXISTS (
		SELECT 
			1
		FROM Dune_Data_Warehouse_Staging..Item_Dim
		WHERE Item_Dim_ID = i.Item_Dim_ID
	  )	
    ) source
ON source.Item_Dim_ID = target.Item_Dim_ID
WHEN MATCHED THEN
    UPDATE SET
               Item_Code = source.Item_Code
              ,Style = source.Style
              ,Item_Description = source.Item_Description
              ,Item_Short_Description = source.Item_Short_Description
              ,Currency_Dim_ID = source.Currency_Dim_ID
              ,Currency_Code = source.Currency_Code
              ,Currency_Description = source.Currency_Description
              ,Current_Cost_Price = source.Current_Cost_Price
              ,Commodity_Code = source.Commodity_Code
              ,SKU = source.SKU
              ,Vendor_Style = source.Vendor_Style
              ,GTIN = source.GTIN
              ,Prepack_Type = source.Prepack_Type
              ,Prepack_Flag = source.Prepack_Flag
              ,Prepack_Qty = source.Prepack_Qty
              ,Country_Dim_ID = source.Country_Dim_ID
              ,Country_Code = source.Country_Code
              ,Country_Name = source.Country_Name
              ,Country_of_Manufacture_Country_Dim_ID = source.Country_of_Manufacture_Country_Dim_ID
              ,Country_of_Manufacture_Code = source.Country_of_Manufacture_Code
              ,Country_of_Manufacture_Name = source.Country_of_Manufacture_Name
              ,Country_of_Origin_Country_Dim_ID = source.Country_of_Origin_Country_Dim_ID
              ,Country_of_Origin_Code = source.Country_of_Origin_Code
              ,Country_of_Origin_Name = source.Country_of_Origin_Name
              ,Supplier_Dim_ID = source.Supplier_Dim_ID
              ,Supplier_Code = source.Supplier_Code
              ,Supplier_Name = source.Supplier_Name
              ,Size_Code = source.Size_Code
              ,Size_Name = source.Size_Name
              ,Class_Dim_ID = source.Class_Dim_ID
              ,Class_Code = source.Class_Code
              ,Class_Name = source.Class_Name
              ,Division_Dim_ID = source.Division_Dim_ID
              ,Division_Code = source.Division_Code
              ,Division_Name = source.Division_Name
              ,Department_Dim_ID = source.Department_Dim_ID
              ,Department_Code = source.Department_Code
              ,Department_Name = source.Department_Name
              ,Subdepartment_Dim_ID = source.Subdepartment_Dim_ID
              ,Subdepartment_Code = source.Subdepartment_Code
              ,Subdepartment_Name = source.Subdepartment_Name
              ,Subdepartment_Group_Name = source.Subdepartment_Group_Name
              ,Subdepartmnet_Subgroup_Name = source.Subdepartmnet_Subgroup_Name
              ,Colour_Dim_ID = source.Colour_Dim_ID
              ,Colour_Code = source.Colour_Code
              ,Colour_Name = source.Colour_Name
              ,Bag_Match = source.Bag_Match
              ,Boot_Height = source.Boot_Height
              ,Boot_Measurement_CM = source.Boot_Measurement_CM
              ,Colour_Group = source.Colour_Group
              ,Comfort_Footbed = source.Comfort_Footbed
              ,Direct = source.Direct
              ,External_Brands = source.External_Brands
              ,Fastening = source.Fastening
              ,Feature = source.Feature
              ,Heel_Height = source.Heel_Height
              ,Heel_Measurement = source.Heel_Measurement
              ,Heel_Shape = source.Heel_Shape
              ,Lining_Material = source.Lining_Material
              ,Mark_Down = source.Mark_Down
              ,Material = source.Material
              ,Original_Season = source.Original_Season
              ,Pig_Skin = source.Pig_Skin
              ,Platform = source.Platform
              ,Risk = source.Risk
              ,Sale_or_Return = source.Sale_or_Return
              ,Season = source.Season
              ,Selfidges = source.Selfidges
              ,Sole_Material = source.Sole_Material
              ,Theme = source.Theme
              ,Toe_Shape = source.Toe_Shape
              ,Web_Bertie = source.Web_Bertie
              ,Web_Chelsea_Cobbler = source.Web_Chelsea_Cobbler
              ,Web_Pat = source.Web_Pat
              ,Web_Shoe_Studio = source.Web_Shoe_Studio
              ,X_Brightfilter_L1_PRD_RNG = source.X_Brightfilter_L1_PRD_RNG
              ,X_Brightfilter_L2_PRD_GRP = source.X_Brightfilter_L2_PRD_GRP
              ,X_Brightfilter_L3_PRD_SBGRP = source.X_Brightfilter_L3_PRD_SBGRP
              ,X_Image = source.X_Image
              ,X_Style_Web = source.X_Style_Web
              ,X_Web_Dune = source.X_Web_Dune
              ,Z_Brand_Definition = source.Z_Brand_Definition
			  ,Season_Code = source.Season_Code
			  ,Subdepartment_Group_Dim_ID = source.Subdepartment_Group_Dim_ID
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
			  ,Apparel_Markdown = source.Apparel_Markdown
			  ,Apparel_Original_Season = source.Apparel_Original_Season
			  ,Apparel_Current_Season = source.Apparel_Current_Season
			  ,Apparel_Item_Cost_1_AED = source.Apparel_Item_Cost_1_AED
			  ,Apparel_Ticket_Price_AED = source.Apparel_Ticket_Price_AED
			  ,Apparel_Original_Price_AED = source.Apparel_Original_Price_AED
			  ,Apparel_Item_Cost_1_GBP = source.Apparel_Item_Cost_1_GBP
			  ,Apparel_Ticket_Price_GBP = source.Apparel_Ticket_Price_GBP
			  ,Apparel_Original_Price_GBP = source.Apparel_Original_Price_GBP
WHEN NOT MATCHED THEN 
INSERT (
	Item_Dim_ID
	,Item_Code                               
	,Style									
	,Item_Description						
	,Item_Short_Description					
	,Currency_Dim_ID							
	,Currency_Code							
	,Currency_Description					
	,Current_Cost_Price						
	,Commodity_Code							
	,SKU										
	,Vendor_Style							
	,GTIN									
	,Prepack_Type							
	,Prepack_Flag							
	,Prepack_Qty								
	,Country_Dim_ID							
	,Country_Code							
	,Country_Name							
	,Country_of_Manufacture_Country_Dim_ID	
	,Country_of_Manufacture_Code				
	,Country_of_Manufacture_Name				
	,Country_of_Origin_Country_Dim_ID		
	,Country_of_Origin_Code					
	,Country_of_Origin_Name					
	,Supplier_Dim_ID							
	,Supplier_Code							
	,Supplier_Name							
	,Size_Code								
	,Size_Name								
	,Class_Dim_ID							
	,Class_Code								
	,Class_Name								
	,Division_Dim_ID							
	,Division_Code							
	,Division_Name							
	,Department_Dim_ID						
	,Department_Code							
	,Department_Name							
	,Subdepartment_Dim_ID					
	,Subdepartment_Code						
	,Subdepartment_Name						
	,Subdepartment_Group_Name				
	,Subdepartmnet_Subgroup_Name				
	,Colour_Dim_ID							
	,Colour_Code								
	,Colour_Name								
	,Bag_Match								
	,Boot_Height								
	,Boot_Measurement_CM						
	,Colour_Group							
	,Comfort_Footbed							
	,Direct									
	,External_Brands							
	,Fastening								
	,Feature									
	,Heel_Height								
	,Heel_Measurement						
	,Heel_Shape								
	,Lining_Material							
	,Mark_Down								
	,Material								
	,Original_Season							
	,Pig_Skin								
	,Platform								
	,Risk									
	,Sale_or_Return							
	,Season									
	,Selfidges								
	,Sole_Material							
	,Theme									
	,Toe_Shape								
	,Web_Bertie								
	,Web_Chelsea_Cobbler						
	,Web_Pat									
	,Web_Shoe_Studio							
	,X_Brightfilter_L1_PRD_RNG				
	,X_Brightfilter_L2_PRD_GRP				
	,X_Brightfilter_L3_PRD_SBGRP				
	,X_Image									
	,X_Style_Web								
	,X_Web_Dune								
	,Z_Brand_Definition						
	,Season_Code
	,Subdepartment_Group_Dim_ID
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
	,Apparel_Markdown
	,Apparel_Original_Season
	,Apparel_Current_Season
	,Apparel_Item_Cost_1_AED
	,Apparel_Ticket_Price_AED
	,Apparel_Original_Price_AED
	,Apparel_Item_Cost_1_GBP
	,Apparel_Ticket_Price_GBP
	,Apparel_Original_Price_GBP
) VALUES (
	source.Item_Dim_ID
	,source.Item_Code                               
	,source.Style									
	,source.Item_Description						
	,source.Item_Short_Description					
	,source.Currency_Dim_ID							
	,source.Currency_Code							
	,source.Currency_Description					
	,source.Current_Cost_Price						
	,source.Commodity_Code							
	,source.SKU										
	,source.Vendor_Style							
	,source.GTIN									
	,source.Prepack_Type							
	,source.Prepack_Flag							
	,source.Prepack_Qty								
	,source.Country_Dim_ID							
	,source.Country_Code							
	,source.Country_Name							
	,source.Country_of_Manufacture_Country_Dim_ID	
	,source.Country_of_Manufacture_Code				
	,source.Country_of_Manufacture_Name				
	,source.Country_of_Origin_Country_Dim_ID		
	,source.Country_of_Origin_Code					
	,source.Country_of_Origin_Name					
	,source.Supplier_Dim_ID							
	,source.Supplier_Code							
	,source.Supplier_Name							
	,source.Size_Code								
	,source.Size_Name								
	,source.Class_Dim_ID							
	,source.Class_Code								
	,source.Class_Name								
	,source.Division_Dim_ID							
	,source.Division_Code							
	,source.Division_Name							
	,source.Department_Dim_ID						
	,source.Department_Code							
	,source.Department_Name							
	,source.Subdepartment_Dim_ID					
	,source.Subdepartment_Code						
	,source.Subdepartment_Name						
	,source.Subdepartment_Group_Name				
	,source.Subdepartmnet_Subgroup_Name				
	,source.Colour_Dim_ID							
	,source.Colour_Code								
	,source.Colour_Name								
	,source.Bag_Match								
	,source.Boot_Height								
	,source.Boot_Measurement_CM						
	,source.Colour_Group							
	,source.Comfort_Footbed							
	,source.Direct									
	,source.External_Brands							
	,source.Fastening								
	,source.Feature									
	,source.Heel_Height								
	,source.Heel_Measurement						
	,source.Heel_Shape								
	,source.Lining_Material							
	,source.Mark_Down								
	,source.Material								
	,source.Original_Season							
	,source.Pig_Skin								
	,source.Platform								
	,source.Risk									
	,source.Sale_or_Return							
	,source.Season									
	,source.Selfidges								
	,source.Sole_Material							
	,source.Theme									
	,source.Toe_Shape								
	,source.Web_Bertie								
	,source.Web_Chelsea_Cobbler						
	,source.Web_Pat									
	,source.Web_Shoe_Studio							
	,source.X_Brightfilter_L1_PRD_RNG				
	,source.X_Brightfilter_L2_PRD_GRP				
	,source.X_Brightfilter_L3_PRD_SBGRP				
	,source.X_Image									
	,source.X_Style_Web								
	,source.X_Web_Dune								
	,source.Z_Brand_Definition	
	,source.Season_Code
	,source.Subdepartment_Group_Dim_ID		
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
	,source.Apparel_Markdown
	,source.Apparel_Original_Season
	,source.Apparel_Current_Season
	,source.Apparel_Item_Cost_1_AED
	,source.Apparel_Ticket_Price_AED
	,source.Apparel_Original_Price_AED
	,source.Apparel_Item_Cost_1_GBP
	,source.Apparel_Ticket_Price_GBP
	,source.Apparel_Original_Price_GBP
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

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Product_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
