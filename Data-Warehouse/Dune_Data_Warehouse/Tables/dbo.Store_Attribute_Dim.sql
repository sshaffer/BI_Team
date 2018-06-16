CREATE TABLE [dbo].[Store_Attribute_Dim]
(
[Store_Attribute_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Attribute_Category_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Category_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Value_ID] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attribute_Value_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Attribute_Dim] ADD CONSTRAINT [Store_Attribute_Dim_PK] PRIMARY KEY CLUSTERED  ([Store_Attribute_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Attribute_Dim_Category_Value] ON [dbo].[Store_Attribute_Dim] ([Attribute_Category_Name], [Attribute_Value_Name]) INCLUDE ([Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Attribute_Dim_Store_Dim_FKX] ON [dbo].[Store_Attribute_Dim] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Attribute_Dim] ADD CONSTRAINT [Store_Attribute_Dim_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
