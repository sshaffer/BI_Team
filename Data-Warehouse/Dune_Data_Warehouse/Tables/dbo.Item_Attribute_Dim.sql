CREATE TABLE [dbo].[Item_Attribute_Dim]
(
[Item_Attribute_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Attribute_Category_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Category_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Value_ID] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Value_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [Item_Attribute_Dim_Cat_Name_Item_IX] ON [dbo].[Item_Attribute_Dim] ([Attribute_Category_Name], [Item_Dim_ID]) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Item_Attribute_Dim] ADD CONSTRAINT [Attribute_Value_Dim_PK] PRIMARY KEY CLUSTERED  ([Item_Attribute_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Attribute_Dim_Category_Value] ON [dbo].[Item_Attribute_Dim] ([Attribute_Category_Name], [Attribute_Value_Name]) INCLUDE ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Attribute_Dim_Item_Dim_FKX] ON [dbo].[Item_Attribute_Dim] ([Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Attribute_Dim] WITH NOCHECK ADD CONSTRAINT [Item_Attribute_Dim_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Generic attributes that the users can create and use for reporting and analysis. E.g. Colour Group, Season. Each attribute category (e.g. Colour Group) can have several values, one of which can be attributed to an item (e.g. Colour Group  value set to 2 is Blue)', 'SCHEMA', N'dbo', 'TABLE', N'Item_Attribute_Dim', NULL, NULL
GO
