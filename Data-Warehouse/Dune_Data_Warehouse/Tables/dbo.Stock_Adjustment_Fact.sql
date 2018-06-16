CREATE TABLE [dbo].[Stock_Adjustment_Fact]
(
[Adjustment_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Warehouse_Location_Dim_ID] [int] NOT NULL,
[Warehouse_Bin_Dim_ID] [int] NOT NULL,
[Warehouse_Reason_Dim_ID] [tinyint] NOT NULL,
[User_Id] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Adjust_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Stock_Adjustment_Fact] ADD CONSTRAINT [Stock_Adjustment_Fact_PK] PRIMARY KEY CLUSTERED  ([Adjustment_Date_Dim_ID], [Item_Dim_ID], [Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Adjustment_Fact_Calendar_Day_Dim_FKX] ON [dbo].[Stock_Adjustment_Fact] ([Adjustment_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Adjustment_Fact_Item_Dim_FKX] ON [dbo].[Stock_Adjustment_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Adjustment_Fact_Store_Dim_FKX] ON [dbo].[Stock_Adjustment_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Adjustment_Fact_Warehouse_Bin_Dim_FKX] ON [dbo].[Stock_Adjustment_Fact] ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Adjustment_Fact_Time_Dim_FKX] ON [dbo].[Stock_Adjustment_Fact] ([Time_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Stock_Adjustment_Fact_Warehouse_Location_Dim_FKX] ON [dbo].[Stock_Adjustment_Fact] ([Warehouse_Location_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Warehouse_Reason_Stock_AdjustmentX] ON [dbo].[Stock_Adjustment_Fact] ([Warehouse_Reason_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Stock_Adjustment_Fact] ADD CONSTRAINT [Stock_Adjustment_Fact_Calendar_Day_Dim_FK] FOREIGN KEY ([Adjustment_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Stock_Adjustment_Fact] ADD CONSTRAINT [Stock_Adjustment_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Adjustment_Fact] ADD CONSTRAINT [Stock_Adjustment_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Adjustment_Fact] ADD CONSTRAINT [Stock_Adjustment_Fact_Warehouse_Bin_Dim_FK] FOREIGN KEY ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID]) REFERENCES [dbo].[Warehouse_Bin_Dim] ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Adjustment_Fact] ADD CONSTRAINT [Stock_Adjustment_Fact_Time_Dim_FK] FOREIGN KEY ([Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Stock_Adjustment_Fact] ADD CONSTRAINT [Warehouse_Reason_Stock_Adjustment] FOREIGN KEY ([Warehouse_Reason_Dim_ID]) REFERENCES [dbo].[Warehouse_Reason_Dim] ([Warehouse_Reason_Dim_ID])
GO
