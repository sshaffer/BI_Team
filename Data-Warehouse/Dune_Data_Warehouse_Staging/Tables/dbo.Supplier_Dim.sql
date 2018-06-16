CREATE TABLE [dbo].[Supplier_Dim]
(
[Supplier_Dim_ID] [int] NOT NULL,
[Supplier_Code] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_Contact_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_Address_Line_1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_Address_Line_2] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_City] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_State] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Supplier_Post_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Dim_ID] [tinyint] NOT NULL,
[Contact_Telephone_No] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Default_Terms_Description] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Default_Terms_Code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Expected_Lead_Time] [decimal] (3, 0) NOT NULL,
[Factory_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Factory_Address_Line_1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Factory_Address_Line_2] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Factory_City] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Factory_State] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Factory_Post_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Factory_Country_Name] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FOB_Point] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FOB_Terms_Description] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FOB_Terms_Code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Supplier_Dim] ADD CONSTRAINT [Supplier_Dim_PK] PRIMARY KEY CLUSTERED  ([Supplier_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Supplier_Dim_Country_Dim_Country_Code_FKX] ON [dbo].[Supplier_Dim] ([Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Supplier_Dim_Country_Dim_Supplier_Country_FKX] ON [dbo].[Supplier_Dim] ([Factory_Country_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Code and attributes for provider of products.', 'SCHEMA', N'dbo', 'TABLE', N'Supplier_Dim', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Country ID for the Supplier''s country code', 'SCHEMA', N'dbo', 'TABLE', N'Supplier_Dim', 'COLUMN', N'Country_Dim_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default terms code', 'SCHEMA', N'dbo', 'TABLE', N'Supplier_Dim', 'COLUMN', N'Default_Terms_Code'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default terms description', 'SCHEMA', N'dbo', 'TABLE', N'Supplier_Dim', 'COLUMN', N'Default_Terms_Description'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Country ID for the Supplier''s Factory country code.', 'SCHEMA', N'dbo', 'TABLE', N'Supplier_Dim', 'COLUMN', N'Factory_Country_Name'
GO
