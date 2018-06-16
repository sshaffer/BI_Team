CREATE TABLE [dbo].[Warehouse_Reason_Dim]
(
[Store_Dim_ID] [int] NOT NULL,
[Warehouse_Reason_Dim_ID] [tinyint] NOT NULL,
[Store_Number] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Warehouse_Transfer_Reason_Code] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Reason_Desc] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Warehouse_Reason_Dim] ADD
CONSTRAINT [Warehouse_Reason_Dim_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])

GO
ALTER TABLE [dbo].[Warehouse_Reason_Dim] ADD CONSTRAINT [Warehouse_Reason_Dim_PK] PRIMARY KEY CLUSTERED  ([Warehouse_Reason_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Warehouse_Reason_Dim] ADD CONSTRAINT [Warehouse_Reason_Code] UNIQUE NONCLUSTERED  ([Store_Dim_ID], [Warehouse_Reason_Dim_ID]) ON [PRIMARY]
GO
