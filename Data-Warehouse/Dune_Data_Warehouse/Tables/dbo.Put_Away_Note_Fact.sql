CREATE TABLE [dbo].[Put_Away_Note_Fact]
(
[Putaway_Date_Dim_ID] [smallint] NOT NULL,
[Putaway_Start_Time_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Warehouse_Location_Dim_ID] [int] NOT NULL,
[Warehouse_Bin_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Put_Away_Sheet_No] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Put_Away_Id] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Put_Away_End_Time] [time] NOT NULL,
[Put_Away_Qty] [int] NOT NULL,
[Put_Away_Acknowledgement_Qty] [int] NOT NULL,
[Put_Away_Discrepancy_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Put_Away_Note_Fact] ADD CONSTRAINT [Put_Away_Note_Fact_PK] PRIMARY KEY CLUSTERED  ([Putaway_Date_Dim_ID], [Putaway_Start_Time_Dim_ID], [Item_Dim_ID], [Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Put_Away_Note_Fact_Item_Dim_FKX] ON [dbo].[Put_Away_Note_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Put_Away_Note_Fact_Calendar_Day_Dim_FKX] ON [dbo].[Put_Away_Note_Fact] ([Putaway_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Put_Away_Note_Fact_Time_Dim_FKX] ON [dbo].[Put_Away_Note_Fact] ([Putaway_Start_Time_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Put_Away_Note_Fact_Store_Dim_FKX] ON [dbo].[Put_Away_Note_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Put_Away_Note_Fact_Warehouse_Bin_Dim_FKX] ON [dbo].[Put_Away_Note_Fact] ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Put_Away_Note_Fact_Warehouse_Location_Dim_FKX] ON [dbo].[Put_Away_Note_Fact] ([Warehouse_Location_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Put_Away_Note_Fact] ADD CONSTRAINT [Put_Away_Note_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Put_Away_Note_Fact] ADD CONSTRAINT [Put_Away_Note_Fact_Calendar_Day_Dim_FK] FOREIGN KEY ([Putaway_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Put_Away_Note_Fact] ADD CONSTRAINT [Put_Away_Note_Fact_Time_Dim_FK] FOREIGN KEY ([Putaway_Start_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Put_Away_Note_Fact] ADD CONSTRAINT [Put_Away_Note_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Put_Away_Note_Fact] ADD CONSTRAINT [Put_Away_Note_Fact_Warehouse_Bin_Dim_FK] FOREIGN KEY ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID]) REFERENCES [dbo].[Warehouse_Bin_Dim] ([Store_Dim_ID], [Warehouse_Location_Dim_ID], [Warehouse_Bin_Dim_ID])
GO
ALTER TABLE [dbo].[Put_Away_Note_Fact] ADD CONSTRAINT [Put_Away_Note_Fact_Warehouse_Location_Dim_FK] FOREIGN KEY ([Warehouse_Location_Dim_ID], [Store_Dim_ID]) REFERENCES [dbo].[Warehouse_Location_Dim] ([Warehouse_Location_Dim_ID], [Store_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Actual picked Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Put_Away_Note_Fact', 'COLUMN', N'Put_Away_Acknowledgement_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Picked Quantity Difference', 'SCHEMA', N'dbo', 'TABLE', N'Put_Away_Note_Fact', 'COLUMN', N'Put_Away_Discrepancy_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Quantity being picked', 'SCHEMA', N'dbo', 'TABLE', N'Put_Away_Note_Fact', 'COLUMN', N'Put_Away_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number that is generated for each pick sheet', 'SCHEMA', N'dbo', 'TABLE', N'Put_Away_Note_Fact', 'COLUMN', N'Put_Away_Sheet_No'
GO
