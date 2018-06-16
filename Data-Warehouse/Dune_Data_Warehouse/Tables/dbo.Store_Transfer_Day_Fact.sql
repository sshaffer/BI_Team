CREATE TABLE [dbo].[Store_Transfer_Day_Fact]
(
[Transfer_Date_Dim_ID] [smallint] NOT NULL,
[From_Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[To_Store_Dim_ID] [int] NOT NULL,
[Store_Acknowledgement_Date_Dim_ID] [int] NOT NULL,
[Delivery_Status] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Transfer_Qty] [int] NOT NULL,
[Transfer_Cost_Value] [money] NOT NULL,
[Transfer_Retail_Value] [money] NOT NULL,
[Acknowledgement_Qty] [int] NOT NULL,
[Acknowledgement_Cost_Value] [money] NOT NULL,
[Acknowledgement_Retail_Value] [money] NOT NULL,
[Discrepancy_Qty] [int] NOT NULL,
[Discrepancy_Cost_Value] [money] NOT NULL,
[Discrepancy_Retail_Value] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Transfer_Day_Fact] ADD CONSTRAINT [Store_Transfer_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Item_Dim_ID], [Transfer_Date_Dim_ID], [From_Store_Dim_ID], [To_Store_Dim_ID], [Store_Acknowledgement_Date_Dim_ID], [Delivery_Status]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Transfer_Day_Fact_From_Store_Dim_FKX] ON [dbo].[Store_Transfer_Day_Fact] ([From_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Transfer_Day_Fact_Item_Dim_FKX] ON [dbo].[Store_Transfer_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Transfer_Day_Fact_To_Store_Dim_FKX] ON [dbo].[Store_Transfer_Day_Fact] ([To_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_ay_DStore_Transfer_Day_FKX] ON [dbo].[Store_Transfer_Day_Fact] ([Transfer_Date_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Transfer_Day_Fact] ADD CONSTRAINT [Store_Transfer_Day_Fact_From_Store_Dim_FK] FOREIGN KEY ([From_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Transfer_Day_Fact] ADD CONSTRAINT [Store_Transfer_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Transfer_Day_Fact] ADD CONSTRAINT [Store_Transfer_Day_Fact_To_Store_Dim_FK] FOREIGN KEY ([To_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Transfer_Day_Fact] ADD CONSTRAINT [Calendar_ay_DStore_Transfer_Day_FK] FOREIGN KEY ([Transfer_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost Value of the actual transferred quantity', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Acknowledgement_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Actual transferred Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Acknowledgement_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Retail Value of the actual transferred items', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Acknowledgement_Retail_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost Value of the transferred quantity difference', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Discrepancy_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Quantity transferred difference', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Discrepancy_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Retail Value of the transferred quantity difference', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Discrepancy_Retail_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost Value of the items being transferred', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Transfer_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Quantity being transferred', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Transfer_Qty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Retail Value of the items being transferred', 'SCHEMA', N'dbo', 'TABLE', N'Store_Transfer_Day_Fact', 'COLUMN', N'Transfer_Retail_Value'
GO
