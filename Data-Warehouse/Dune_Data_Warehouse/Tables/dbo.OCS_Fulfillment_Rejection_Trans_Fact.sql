CREATE TABLE [dbo].[OCS_Fulfillment_Rejection_Trans_Fact]
(
[OCS_Fulfillment_Order_Dim_Id] [int] NOT NULL,
[Sending_Store_Dim_Id] [int] NOT NULL,
[Item_Dim_Id] [int] NOT NULL,
[Sending_Store_Rejected_Date_Dim_ID] [smallint] NOT NULL,
[Sending_Store_Rejected_Time_Dim_ID] [smallint] NOT NULL,
[TransferNumber] [int] NOT NULL,
[TransferLine] [int] NOT NULL,
[SendingStoreRejUser] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Layby_Store_Dim_ID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Rejection_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Rejection_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([OCS_Fulfillment_Order_Dim_Id], [Layby_Store_Dim_ID], [Sending_Store_Dim_Id], [Item_Dim_Id], [Sending_Store_Rejected_Date_Dim_ID], [Sending_Store_Rejected_Time_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Rejection_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Rejection_Trans_Fact_Item_FK] FOREIGN KEY ([Item_Dim_Id]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Rejection_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Rejection_Trans_Fact_LaybyStore_FK] FOREIGN KEY ([Layby_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Rejection_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Rejection_Trans_Fact_SendingStore_FK] FOREIGN KEY ([Sending_Store_Dim_Id]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Rejection_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Rejection_Trans_Fact_SendingStoreDate_FK] FOREIGN KEY ([Sending_Store_Rejected_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Rejection_Trans_Fact] ADD CONSTRAINT [OCS_Fulfillment_Rejection_Trans_Fact_SendingStoreTime_FK] FOREIGN KEY ([Sending_Store_Rejected_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
