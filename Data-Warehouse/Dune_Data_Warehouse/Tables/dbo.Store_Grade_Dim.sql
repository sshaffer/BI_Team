CREATE TABLE [dbo].[Store_Grade_Dim]
(
[Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Item_Attribute_Dim_ID] [int] NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Store_Grade_ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Grade_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Store_Grade_Dim] ADD
CONSTRAINT [Store_Grade_Subdepartment_Dim_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) REFERENCES [dbo].[Subdepartment_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID])
ALTER TABLE [dbo].[Store_Grade_Dim] ADD
CONSTRAINT [Store_Grade_Item_Attribute_Dim_FK] FOREIGN KEY ([Item_Attribute_Dim_ID], [Item_Dim_ID]) REFERENCES [dbo].[Item_Attribute_Dim] ([Item_Attribute_Dim_ID], [Item_Dim_ID])
ALTER TABLE [dbo].[Store_Grade_Dim] ADD
CONSTRAINT [Store_Grade_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])



GO
ALTER TABLE [dbo].[Store_Grade_Dim] ADD CONSTRAINT [Store_Grade_Dim_PK] PRIMARY KEY CLUSTERED  ([Store_Grade_ID], [Store_Dim_ID], [Item_Attribute_Dim_ID], [Item_Dim_ID], [Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Grade_Subdepartment_Dim_FKX] ON [dbo].[Store_Grade_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Grade_Item_Attribute_Dim_FKX] ON [dbo].[Store_Grade_Dim] ([Item_Attribute_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Grade_Store_Dim_FKX] ON [dbo].[Store_Grade_Dim] ([Store_Dim_ID]) ON [PRIMARY]
GO
