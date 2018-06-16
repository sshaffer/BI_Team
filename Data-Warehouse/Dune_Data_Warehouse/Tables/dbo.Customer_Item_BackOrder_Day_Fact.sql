CREATE TABLE [dbo].[Customer_Item_BackOrder_Day_Fact]
(
[Backorder_Date_Dim_ID] [smallint] NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Backorder_Qty] [int] NOT NULL,
[Backorder_Value_Home] [money] NOT NULL,
[Backorder_Value_Curr] [money] NOT NULL,
[Backorder_Cost_Value_Home] [money] NOT NULL,
[Backorder_Cost_Value_Curr] [money] NOT NULL,
[Backorder_VAT_Value_Home] [money] NOT NULL,
[Backorder_VAT_Value_Curr] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Item_BackOrder_Day_Fact] ADD CONSTRAINT [Customer_Item_BackOrder_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Backorder_Date_Dim_ID], [Customer_Dim_ID], [Order_No], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Dim_Cust_Item_Backorder_Day_Fact_FKX] ON [dbo].[Customer_Item_BackOrder_Day_Fact] ([Backorder_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_BackOrder_Day_Fact_Channel_Dim_IDX] ON [dbo].[Customer_Item_BackOrder_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_BackOrder_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Item_BackOrder_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_BackOrder_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Item_BackOrder_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_BackOrder_Day_Fact_Order_Source_IDX] ON [dbo].[Customer_Item_BackOrder_Day_Fact] ([Order_Source_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_BackOrder_Day_Fact_Order_Type_Dim_FKX] ON [dbo].[Customer_Item_BackOrder_Day_Fact] ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Item_BackOrder_Day_Fact] ADD CONSTRAINT [Calendar_Day_Dim_Cust_Item_Backorder_Day_Fact_FK] FOREIGN KEY ([Backorder_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Customer_Item_BackOrder_Day_Fact] ADD CONSTRAINT [Customer_Item_BackOrder_Day_Fact_Channel_Dim_FK] FOREIGN KEY ([Channel_Dim_ID]) REFERENCES [dbo].[Channel_Dim] ([Channel_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_BackOrder_Day_Fact] ADD CONSTRAINT [Customer_Item_BackOrder_Day_Fact_Customer_Dim_FK] FOREIGN KEY ([Customer_Dim_ID]) REFERENCES [dbo].[Customer_Dim] ([Customer_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_BackOrder_Day_Fact] ADD CONSTRAINT [Customer_Item_BackOrder_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_BackOrder_Day_Fact] ADD CONSTRAINT [Customer_Item_BackOrder_Day_Fact_Order_Source_Dim_FK] FOREIGN KEY ([Order_Source_Dim_ID]) REFERENCES [dbo].[Order_Source_Dim] ([Order_Source_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_BackOrder_Day_Fact] ADD CONSTRAINT [Customer_Item_BackOrder_Day_Fact_Order_Type_Dim_FK] FOREIGN KEY ([Order_Type_Dim_ID]) REFERENCES [dbo].[Order_Type_Dim] ([Order_Type_Dim_ID])
GO
