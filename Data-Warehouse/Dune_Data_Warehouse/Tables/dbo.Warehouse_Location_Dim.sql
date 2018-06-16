CREATE TABLE [dbo].[Warehouse_Location_Dim]
(
[Store_Dim_ID] [int] NOT NULL,
[Warehouse_Location_Dim_ID] [int] NOT NULL,
[Store_Number] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Row] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Section] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Level] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Stock_Zone] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Pick_Zone] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Description] [char] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Status] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Warehouse_Location_Dim] ADD
CONSTRAINT [Warehouse_Location_Dim_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])

GO
ALTER TABLE [dbo].[Warehouse_Location_Dim] ADD CONSTRAINT [Warehouse_Location_Dim_PK] PRIMARY KEY CLUSTERED  ([Warehouse_Location_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Warehouse_Location_Dim_Store_Dim_FKX] ON [dbo].[Warehouse_Location_Dim] ([Store_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Warehouse_Location_Dim__Store_Location_IDX] ON [dbo].[Warehouse_Location_Dim] ([Store_Number], [Location_Row], [Location_Section], [Location_Level]) ON [PRIMARY]
GO
