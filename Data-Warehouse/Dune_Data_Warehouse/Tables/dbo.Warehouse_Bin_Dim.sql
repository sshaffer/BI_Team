CREATE TABLE [dbo].[Warehouse_Bin_Dim]
(
[Store_Dim_ID] [int] NOT NULL,
[Warehouse_Location_Dim_ID] [int] NOT NULL,
[Warehouse_Bin_Dim_ID] [int] NOT NULL,
[Store_Number] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Row] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Location_Section] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location_Level] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Bin_No] [char] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Bin_Status] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Warehouse_Bin_Dim] ADD CONSTRAINT [Warehouse_Bin_Dim_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Warehouse_Bin_Dim__Store_Location_Bin_IDX] ON [dbo].[Warehouse_Bin_Dim] ([Store_Number], [Location_Row], [Location_Section], [Location_Level], [Bin_No]) ON [PRIMARY]
GO
