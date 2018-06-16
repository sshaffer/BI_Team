CREATE TABLE [dbo].[Packing_Note_Fact]
(
[Packing_Date_Dim_ID] [smallint] NOT NULL,
[Packer_Start_Time_Dim_ID] [smallint] NOT NULL,
[Issuing_Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Packing_Slip_No] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Packer_Id] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Packer_End_Time] [time] NOT NULL,
[Pack_Qty] [int] NOT NULL,
[Acknowledgement_Qty] [int] NOT NULL,
[Discrepancy_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Packing_Note_Fact] ADD CONSTRAINT [Packing_Note_Fact_PK] PRIMARY KEY CLUSTERED  ([Packing_Date_Dim_ID], [Packer_Start_Time_Dim_ID], [Packing_Slip_No], [Issuing_Store_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Packing_Note_Fact_Store_Dim_FKX] ON [dbo].[Packing_Note_Fact] ([Issuing_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Packing_Note_Fact_Item_Dim_FKX] ON [dbo].[Packing_Note_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Packing_Note_Fact_Time_Dim_FKX] ON [dbo].[Packing_Note_Fact] ([Packer_Start_Time_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Packing_NoteX] ON [dbo].[Packing_Note_Fact] ([Packing_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Packing_Note_Fact_Store_Dim_FKv1X] ON [dbo].[Packing_Note_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Packing_Note_Fact] ADD CONSTRAINT [Packing_Note_Fact_Store_Dim_FK] FOREIGN KEY ([Issuing_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Packing_Note_Fact] ADD CONSTRAINT [Packing_Note_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Packing_Note_Fact] ADD CONSTRAINT [Packing_Note_Fact_Time_Dim_FK] FOREIGN KEY ([Packer_Start_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Packing_Note_Fact] ADD CONSTRAINT [Calendar_Day_Packing_Note] FOREIGN KEY ([Packing_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Packing_Note_Fact] ADD CONSTRAINT [Packing_Note_Fact_Store_Dim_FKv1] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Actual packed Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Packing_Note_Fact', 'COLUMN', N'Acknowledgement_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Packed Quantity Difference', 'SCHEMA', N'dbo', 'TABLE', N'Packing_Note_Fact', 'COLUMN', N'Discrepancy_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Quantity being packed', 'SCHEMA', N'dbo', 'TABLE', N'Packing_Note_Fact', 'COLUMN', N'Pack_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number that is generated for packing slip', 'SCHEMA', N'dbo', 'TABLE', N'Packing_Note_Fact', 'COLUMN', N'Packing_Slip_No'
GO
