CREATE TABLE [dbo].[Store_Item_Pre_Allocation_Fact]
(
[Pre_Allocation_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Item_Pre_Allocation_Fact] ADD CONSTRAINT [Store_Item_Pre-Allocation_Fact_PK] PRIMARY KEY CLUSTERED  ([Item_Dim_ID], [Pre_Allocation_Date_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Item_Pre_Allocation_Fact_Item_Dim_FKX] ON [dbo].[Store_Item_Pre_Allocation_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Store_Item_Pre_Allocation_FKX] ON [dbo].[Store_Item_Pre_Allocation_Fact] ([Pre_Allocation_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Item_Pre_Allocation_Fact_Store_Dim_FKX] ON [dbo].[Store_Item_Pre_Allocation_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Item_Pre_Allocation_Fact] ADD CONSTRAINT [Store_Item_Pre_Allocation_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Item_Pre_Allocation_Fact] ADD CONSTRAINT [Calendar_Day_Store_Item_Pre_Allocation_FK] FOREIGN KEY ([Pre_Allocation_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Store_Item_Pre_Allocation_Fact] ADD CONSTRAINT [Store_Item_Pre_Allocation_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
