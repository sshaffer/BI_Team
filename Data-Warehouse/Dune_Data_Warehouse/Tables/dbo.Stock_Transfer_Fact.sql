CREATE TABLE [dbo].[Stock_Transfer_Fact]
(
[Transfer_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[From_Store_Dim_ID] [int] NOT NULL,
[From_Warehouse_Location_Dim_ID] [int] NOT NULL,
[From_Warehouse_Bin_Dim_ID] [int] NOT NULL,
[To_Store_Dim_ID] [int] NOT NULL,
[To_Warehouse_Location_Dim_ID] [int] NOT NULL,
[To_Warehouse_Bin_Dim_ID] [int] NOT NULL,
[User_Id] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Warehouse_Reason_Dim_ID] [tinyint] NOT NULL,
[Transfer_Qty] [int] NOT NULL,
[Acknowledged_Transferred_Qty] [int] NOT NULL,
[Discrepancy_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_PK] PRIMARY KEY CLUSTERED  ([Transfer_Date_Dim_ID], [Time_Dim_ID], [Item_Dim_ID], [To_Store_Dim_ID], [To_Warehouse_Location_Dim_ID], [To_Warehouse_Bin_Dim_ID], [From_Store_Dim_ID], [From_Warehouse_Location_Dim_ID], [From_Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_From_Store_Dim_FKX] ON [dbo].[Stock_Transfer_Fact] ([From_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_From_Warehouse_Bin_Dim_FKX] ON [dbo].[Stock_Transfer_Fact] ([From_Store_Dim_ID], [From_Warehouse_Location_Dim_ID], [From_Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_Warehouse_Location_Dim_FKX] ON [dbo].[Stock_Transfer_Fact] ([From_Warehouse_Location_Dim_ID], [From_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_Item_Dim_FKX] ON [dbo].[Stock_Transfer_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_Time_Dim_FKX] ON [dbo].[Stock_Transfer_Fact] ([Time_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_To_Store_Dim_FKX] ON [dbo].[Stock_Transfer_Fact] ([To_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_To_Warehouse_Bin_Dim_FKv1X] ON [dbo].[Stock_Transfer_Fact] ([To_Store_Dim_ID], [To_Warehouse_Location_Dim_ID], [To_Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_Warehouse_Location_Dim_FKv1X] ON [dbo].[Stock_Transfer_Fact] ([To_Warehouse_Location_Dim_ID], [To_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Transfer_Fact_Calendar_Day_Dim_FKX] ON [dbo].[Stock_Transfer_Fact] ([Transfer_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Warehouse_Reason_Stock_TransferX] ON [dbo].[Stock_Transfer_Fact] ([Warehouse_Reason_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_From_Store_Dim_FK] FOREIGN KEY ([From_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_From_Warehouse_Bin_Dim_FK] FOREIGN KEY ([From_Store_Dim_ID], [From_Warehouse_Location_Dim_ID], [From_Warehouse_Bin_Dim_ID]) REFERENCES [dbo].[Warehouse_Bin_Dim] ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_From_Warehouse_Location_Dim_FK] FOREIGN KEY ([From_Warehouse_Location_Dim_ID], [From_Store_Dim_ID]) REFERENCES [dbo].[Warehouse_Location_Dim] ([Warehouse_Location_Dim_ID], [Store_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_Time_Dim_FK] FOREIGN KEY ([Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_To_Store_Dim_FK] FOREIGN KEY ([To_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_To_Warehouse_Bin_Dim_FK] FOREIGN KEY ([To_Store_Dim_ID], [To_Warehouse_Location_Dim_ID], [To_Warehouse_Bin_Dim_ID]) REFERENCES [dbo].[Warehouse_Bin_Dim] ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_To_Warehouse_Location_Dim_FK] FOREIGN KEY ([To_Warehouse_Location_Dim_ID], [To_Store_Dim_ID]) REFERENCES [dbo].[Warehouse_Location_Dim] ([Warehouse_Location_Dim_ID], [Store_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Stock_Transfer_Fact_Calendar_Day_Dim_FK] FOREIGN KEY ([Transfer_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Stock_Transfer_Fact] ADD CONSTRAINT [Warehouse_Reason_Stock_Transfer] FOREIGN KEY ([Warehouse_Reason_Dim_ID]) REFERENCES [dbo].[Warehouse_Reason_Dim] ([Warehouse_Reason_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Actual transferred quantity', 'SCHEMA', N'dbo', 'TABLE', N'Stock_Transfer_Fact', 'COLUMN', N'Acknowledged_Transferred_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Difference in expected to actual Transferred quantity', 'SCHEMA', N'dbo', 'TABLE', N'Stock_Transfer_Fact', 'COLUMN', N'Discrepancy_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Expected transfer quantity', 'SCHEMA', N'dbo', 'TABLE', N'Stock_Transfer_Fact', 'COLUMN', N'Transfer_Qty'
GO
