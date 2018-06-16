CREATE TABLE [dbo].[Pick_Note_Fact]
(
[Pick_Date_Dim_ID] [smallint] NOT NULL,
[Pick_Start_Time_Dim_ID] [smallint] NOT NULL,
[Issuing_Store_Dim_ID] [int] NOT NULL,
[Pick_Sheet_No] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Picker_Id] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Pick_End_Time] [time] NOT NULL,
[Pick_Qty] [int] NOT NULL,
[Acknowledgement_Qty] [int] NOT NULL,
[Discrepancy_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pick_Note_Fact] ADD CONSTRAINT [Pick_Note_Fact_PK] PRIMARY KEY CLUSTERED  ([Pick_Date_Dim_ID], [Pick_Start_Time_Dim_ID], [Pick_Sheet_No], [Item_Dim_ID], [Issuing_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Pick_Note_Fact_Store_Dim_FKX] ON [dbo].[Pick_Note_Fact] ([Issuing_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Pick_Note_Fact_Item_Dim_FKX] ON [dbo].[Pick_Note_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Pick_Note_FKX] ON [dbo].[Pick_Note_Fact] ([Pick_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Pick_Note_Fact_Pick_Sheet_No_UIX] ON [dbo].[Pick_Note_Fact] ([Pick_Sheet_No]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Pick_Note_Fact_Time_Dim_FKX] ON [dbo].[Pick_Note_Fact] ([Pick_Start_Time_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Pick_Note_Fact_Store_Dim_FKv1X] ON [dbo].[Pick_Note_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pick_Note_Fact] ADD CONSTRAINT [Pick_Note_Fact_Store_Dim_FK] FOREIGN KEY ([Issuing_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Pick_Note_Fact] ADD CONSTRAINT [Pick_Note_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Pick_Note_Fact] ADD CONSTRAINT [Calendar_Day_Pick_Note_FK] FOREIGN KEY ([Pick_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Pick_Note_Fact] ADD CONSTRAINT [Pick_Note_Fact_Time_Dim_FK] FOREIGN KEY ([Pick_Start_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[Pick_Note_Fact] ADD CONSTRAINT [Pick_Note_Fact_Store_Dim_FKv1] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Actual picked Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Pick_Note_Fact', 'COLUMN', N'Acknowledgement_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Picked Quantity Difference', 'SCHEMA', N'dbo', 'TABLE', N'Pick_Note_Fact', 'COLUMN', N'Discrepancy_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Quantity being picked', 'SCHEMA', N'dbo', 'TABLE', N'Pick_Note_Fact', 'COLUMN', N'Pick_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number that is generated for each pick sheet', 'SCHEMA', N'dbo', 'TABLE', N'Pick_Note_Fact', 'COLUMN', N'Pick_Sheet_No'
GO
