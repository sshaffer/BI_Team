CREATE TABLE [dbo].[Delivery_Manifest_Day_Fact]
(
[Delivery_Manifest_Date_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Distribution_Control_No] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Distribution_Sequence_No] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Carton_No] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Acknowledgement_Date_Dim_ID] [int] NOT NULL,
[Delivery_Qty] [int] NOT NULL,
[Acknowledgement_Qty] [int] NOT NULL,
[Discrepancy_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Delivery_Manifest_Day_Fact] ADD CONSTRAINT [Delivery_Manifest_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Delivery_Manifest_Date_Dim_ID], [Store_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Delivery_Manifest_Day_FKX] ON [dbo].[Delivery_Manifest_Day_Fact] ([Delivery_Manifest_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Delivery_Manifest_Day_Fact_Item_Dim_FKX] ON [dbo].[Delivery_Manifest_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Delivery_Manifest_Day_Fact_Store_Dim_FKX] ON [dbo].[Delivery_Manifest_Day_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Delivery_Manifest_Day_Fact] ADD CONSTRAINT [Calendar_Day_Delivery_Manifest_Day_FK] FOREIGN KEY ([Delivery_Manifest_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Delivery_Manifest_Day_Fact] ADD CONSTRAINT [Delivery_Manifest_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Delivery_Manifest_Day_Fact] ADD CONSTRAINT [Delivery_Manifest_Day_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
