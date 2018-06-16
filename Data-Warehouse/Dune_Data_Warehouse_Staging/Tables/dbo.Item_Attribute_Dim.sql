CREATE TABLE [dbo].[Item_Attribute_Dim]
(
[Item_Attribute_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Attribute_Category_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Category_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Value_ID] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Value_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Attribute_Dim] ADD CONSTRAINT [Attribute_Value_Dim_PK] PRIMARY KEY CLUSTERED  ([Item_Attribute_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Attribute_Dim_Category_Code_IDX] ON [dbo].[Item_Attribute_Dim] ([Attribute_Category_Code]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AItem_Attribute_Dim_Type_Category_Value_IDX] ON [dbo].[Item_Attribute_Dim] ([Attribute_Category_Code], [Attribute_Category_Name], [Attribute_Value_ID], [Attribute_Value_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Attribute_Dim_Value_ID_IDX] ON [dbo].[Item_Attribute_Dim] ([Attribute_Value_ID], [Attribute_Value_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Attribute_Dim_Item_Dim_FKX] ON [dbo].[Item_Attribute_Dim] ([Item_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Generic attributes that the users can create and use for reporting and analysis. E.g. Colour Group, Season. Each attribute category (e.g. Colour Group) can have several values, one of which can be attributed to an item (e.g. Colour Group  value set to 2 is Blue)', 'SCHEMA', N'dbo', 'TABLE', N'Item_Attribute_Dim', NULL, NULL
GO