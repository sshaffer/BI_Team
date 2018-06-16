CREATE TABLE [dbo].[Product_Dim]
(
[Item_Dim_ID] [int] NOT NULL,
[Item_Code] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Style] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Description] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Short_Description] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Currency_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Description] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Current_Cost_Price] [money] NOT NULL,
[Commodity_Code] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SKU] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Vendor_Style] [char] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GTIN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Prepack_Type] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Prepack_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Prepack_Qty] [int] NOT NULL,
[Country_Dim_ID] [tinyint] NOT NULL,
[Country_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Name] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_of_Manufacture_Country_Dim_ID] [tinyint] NOT NULL,
[Country_of_Manufacture_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_of_Manufacture_Name] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_of_Origin_Country_Dim_ID] [tinyint] NOT NULL,
[Country_of_Origin_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_of_Origin_Name] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_Dim_ID] [int] NOT NULL,
[Supplier_Code] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Size_Code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Size_Name] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Class_Dim_ID] [smallint] NOT NULL,
[Class_Code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Class_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Division_Code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Division_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Department_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Department_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Subdepartment_Code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subdepartment_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subdepartment_Group_Name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subdepartmnet_Subgroup_Name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Colour_Dim_ID] [smallint] NOT NULL,
[Colour_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Colour_Name] [char] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Bag_Match] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Boot_Height] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Boot_Measurement_CM] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Colour_Group] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Comfort_Footbed] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Direct] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[External_Brands] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fastening] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Feature] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Heel_Height] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Heel_Measurement] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Heel_Shape] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Lining_Material] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Mark_Down] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Material] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Original_Season] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Pig_Skin] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Platform] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Risk] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sale_or_Return] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Season] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Selfidges] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sole_Material] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Theme] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Toe_Shape] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Web_Bertie] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Web_Chelsea_Cobbler] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Web_Pat] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Web_Shoe_Studio] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[X_Brightfilter_L1_PRD_RNG] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[X_Brightfilter_L2_PRD_GRP] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[X_Brightfilter_L3_PRD_SBGRP] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[X_Image] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[X_Style_Web] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[X_Web_Dune] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Z_Brand_Definition] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Season_Code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Season_Code_DF] DEFAULT (''),
[Subdepartment_Group_Dim_ID] [smallint] NOT NULL CONSTRAINT [Product_Dim_Subdepartment_Group_Dim_ID_DF] DEFAULT ((0)),
[ISBN] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_ISBN_DF] DEFAULT (''),
[UPC_GTIN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_UPC_GTIN_DF] DEFAULT (''),
[GTIN14] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_GTIN14_DF] DEFAULT (''),
[DP_EAN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_DP_EAN_DF] DEFAULT (''),
[TOPM_EAN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_TOPM_EAN_DF] DEFAULT (''),
[TOPS_EAN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_TOPS_EAN_DF] DEFAULT (''),
[Ext_Att_Insole] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Insole_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Lining] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Lining_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sole] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Sole_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Article] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Article_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Heel_Measurement] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Heel_Measurement_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_UAE_Store_Grading] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_UAE_Store_Grading_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sample_Sent_to_DC] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Sample_Sent_to_DC_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Last] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Last_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Upper_Material] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Upper_Material_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sock_Material] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Sock_Material_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_UK_Store_Grading] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_UK_Store_Grading_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sample_Confirmed] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Sample_Confirmed_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Retail_Press_Sample] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Retail_Press_Sample_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Heel_Name_Type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Heel_Name_Type_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sock_Lable] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Sock_Lable_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Russia_Store_Grading] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Russia_Store_Grading_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sample_Shop] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_Ext_Att_Sample_Shop_DF] DEFAULT ('UNKNOWN'),
[Original_Sale_Price] [money] NOT NULL CONSTRAINT [Product_Dim_Original_Sale_Price_DF] DEFAULT ((0)),
[US_Commodity_Code] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_US_Commod_Code_DF] DEFAULT (''),
[Item_Colour_Code] AS (substring([Item_Code],(1),(16))) PERSISTED,
[Retail_Price] [money] NOT NULL CONSTRAINT [Product_Dim_Retail_Price_DF] DEFAULT ((0)),
[Apparel_Markdown] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_ApparelMarkdown_DF] DEFAULT (''),
[Apparel_Original_Season] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_ApparelOriginalSeason_DF] DEFAULT (''),
[Apparel_Current_Season] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Product_Dim_ApparelCurrentSeason_DF] DEFAULT (''),
[Apparel_Item_Cost_1_AED] [numeric] (19, 7) NOT NULL CONSTRAINT [Product_Dim_ApparelItemCost1AED_DF] DEFAULT ((0.0)),
[Apparel_Ticket_Price_AED] [numeric] (19, 7) NOT NULL CONSTRAINT [Product_Dim_ApparelTicketPriceAED_DF] DEFAULT ((0.0)),
[Apparel_Original_Price_AED] [numeric] (19, 7) NOT NULL CONSTRAINT [Product_Dim_ApparelOriginalPriceAED_DF] DEFAULT ((0.0)),
[Apparel_Item_Cost_1_GBP] [numeric] (19, 7) NOT NULL CONSTRAINT [Product_Dim_ApparelItemCost1GBP_DF] DEFAULT ((0.0)),
[Apparel_Ticket_Price_GBP] [numeric] (19, 7) NOT NULL CONSTRAINT [Product_Dim_ApparelTicketPriceGBP_DF] DEFAULT ((0.0)),
[Apparel_Original_Price_GBP] [numeric] (19, 7) NOT NULL CONSTRAINT [Product_Dim_ApparelOriginalPriceGBP_DF] DEFAULT ((0.0))
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)



CREATE NONCLUSTERED INDEX [Product_Dim_Item_Colour_Code_IX] ON [dbo].[Product_Dim] ([Item_Colour_Code]) ON [PRIMARY]





GO
ALTER TABLE [dbo].[Product_Dim] ADD CONSTRAINT [Product_Dim_PK] PRIMARY KEY CLUSTERED  ([Item_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Cls_Ven_Sty_Clr_Siz_Item_Codes_IX] ON [dbo].[Product_Dim] ([Class_Code], [Supplier_Code], [Style], [Colour_Code], [Size_Code], [Item_Code]) INCLUDE ([Class_Name], [Colour_Name], [Size_Name], [SKU], [Supplier_Name]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Cls_Ven_Sty_Clr_Siz_Item_Ids_IX] ON [dbo].[Product_Dim] ([Class_Dim_ID], [Supplier_Dim_ID], [Style], [Colour_Dim_ID]) INCLUDE ([Size_Code], [Size_Name]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Cls_Ven_Sty_Clr_Siz_Item_Names_IX] ON [dbo].[Product_Dim] ([Class_Name], [Supplier_Name], [Style], [Colour_Name], [Size_Name], [Item_Code]) INCLUDE ([Class_Code], [Colour_Code], [Size_Code], [SKU], [Supplier_Code]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Country_IX] ON [dbo].[Product_Dim] ([Country_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Country_Manu_IX] ON [dbo].[Product_Dim] ([Country_of_Manufacture_Country_Dim_ID], [Country_of_Manufacture_Code]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Country_Origin_IX] ON [dbo].[Product_Dim] ([Country_of_Origin_Country_Dim_ID], [Country_of_Origin_Code]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Div_Dep_Sub_Codes_IX] ON [dbo].[Product_Dim] ([Division_Code], [Department_Code], [Subdepartment_Code]) INCLUDE ([Department_Name], [Division_Name], [Subdepartment_Name]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Div_Dep_Sub_IDs_IX] ON [dbo].[Product_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_Div_Dep_Sub_Names_IX] ON [dbo].[Product_Dim] ([Division_Name], [Department_Name], [Subdepartment_Name]) INCLUDE ([Department_Code], [Division_Code], [Subdepartment_Code]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_SKU_Item_ID_IX] ON [dbo].[Product_Dim] ([SKU]) INCLUDE ([Item_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Product_Dim_SubGrp_Sub_IX] ON [dbo].[Product_Dim] ([Subdepartment_Dim_ID], [Subdepartment_Name], [Subdepartmnet_Subgroup_Name]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
