CREATE TABLE [dbo].[Item_Dim]
(
[Item_Dim_ID] [int] NOT NULL,
[Item_Code] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Style] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Description] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Short_Description] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Current_Cost_Price] [money] NOT NULL,
[Commodity_Code] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SKU] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Vendor_Style] [char] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GTIN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Prepack_Type] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Prepack_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Prepack_Qty] [int] NOT NULL,
[Colour_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Colour_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Dim_ID] [tinyint] NOT NULL,
[Country_of_Manufacture_Country_Dim_ID] [tinyint] NOT NULL,
[Country_of_Origin_Country_Dim_ID] [tinyint] NOT NULL,
[Supplier_Dim_ID] [int] NOT NULL,
[Size_Code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Size_Name] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Class_Dim_ID] [smallint] NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Colour_Dim_ID] [smallint] NOT NULL CONSTRAINT [Item_Dim_Colour_DF] DEFAULT ((-32768)),
[ISBN] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_ISBN_DF] DEFAULT (''),
[UPC_GTIN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_UPC_GTIN_DF] DEFAULT (''),
[GTIN14] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_GTIN14_DF] DEFAULT (''),
[DP_EAN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_DP_EAN_DF] DEFAULT (''),
[TOPM_EAN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_TOPM_EAN_DF] DEFAULT (''),
[TOPS_EAN] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_TOPS_EAN_DF] DEFAULT (''),
[Ext_Att_Insole] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Insole_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Lining] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Lining_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sole] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Sole_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Article] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Article_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Heel_Measurement] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Heel_Measurement_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Last] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Last_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Upper_Material] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Upper_Material_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sock_Material] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Sock_Material_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_UK_Store_Grading] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_UK_Store_Grading_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sample_Confirmed] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Sample_Confirmed_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Heel_Name_Type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Heel_Name_Type_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sock_Lable] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Sock_Lable_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Russia_Store_Grading] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Russia_Store_Grading_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sample_Shop] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Sample_Shop_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Retail_Press_Sample] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Retail_Press_Sample_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_Sample_Sent_to_DC] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_Sample_Sent_to_DC_DF] DEFAULT ('UNKNOWN'),
[Ext_Att_UAE_Store_Grading] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_Ext_Att_UAE_Store_Grading_DF] DEFAULT ('UNKNOWN'),
[Original_Sale_Price] [money] NOT NULL CONSTRAINT [Item_Dim_Original_Sale_Price_DF] DEFAULT ((0)),
[US_Commodity_Code] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Item_Dim_US_Commod_Code_DF] DEFAULT (''),
[Retail_Price] [money] NOT NULL CONSTRAINT [Item_Dim_Retail_Price_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Dim] ADD CONSTRAINT [Item_Dim_PK] PRIMARY KEY CLUSTERED  ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Colour_Code_IDX] ON [dbo].[Item_Dim] ([Colour_Code], [Colour_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Country_Dim_Country_Code_FKX] ON [dbo].[Item_Dim] ([Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Country_Dim_Country_of_Manufacture_FKX] ON [dbo].[Item_Dim] ([Country_of_Manufacture_Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Country_Dim_Country_of_Origin_FKX] ON [dbo].[Item_Dim] ([Country_of_Origin_Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_ItemX] ON [dbo].[Item_Dim] ([Currency_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Division_Dim_FKX] ON [dbo].[Item_Dim] ([Division_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Department_Dim_FKX] ON [dbo].[Item_Dim] ([Division_Dim_ID], [Department_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Subdepartment_Dim_FKX] ON [dbo].[Item_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Class_Dim_FKX] ON [dbo].[Item_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Size_Code_IDX] ON [dbo].[Item_Dim] ([Size_Code], [Size_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Dim_Supplier_Dim_IDX] ON [dbo].[Item_Dim] ([Supplier_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The smallest unit of goods available for sale. The code is made up of class, supplier, style, colour and size.', 'SCHEMA', N'dbo', 'TABLE', N'Item_Dim', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Country of Delivery', 'SCHEMA', N'dbo', 'TABLE', N'Item_Dim', 'COLUMN', N'Country_Dim_ID'
GO
