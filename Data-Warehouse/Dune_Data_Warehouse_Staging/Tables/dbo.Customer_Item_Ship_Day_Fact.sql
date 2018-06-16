CREATE TABLE [dbo].[Customer_Item_Ship_Day_Fact]
(
[Ship_Date_Dim_ID] [smallint] NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Delivery_Method_Dim_ID] [tinyint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Ship_Qty] [decimal] (11, 3) NOT NULL,
[Cost_Value_Home] [money] NOT NULL,
[Cost_Value_Curr] [money] NOT NULL,
[Shipping_Charge_Home] [money] NOT NULL,
[Shipping_Charge_Curr] [money] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Ship_Day_Fact_Channel_Dim_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_Dim_Customer_Item_Ship_Day_Fact_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Currency_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Ship_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Ship_Day_Fact_Delivery_Method_Dim_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Delivery_Method_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Ship_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Ship_Day_Fact_Order_Source_Dim_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Order_Source_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Ship_Day_Fact_Order_Type_Dim_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Dim_Cust_Item_Ship_Day_Fact_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Ship_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Ship_Day_Fact_Store_Dim_FKX] ON [dbo].[Customer_Item_Ship_Day_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
