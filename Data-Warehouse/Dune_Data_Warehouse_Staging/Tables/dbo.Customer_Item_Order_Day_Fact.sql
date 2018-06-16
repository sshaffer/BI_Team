CREATE TABLE [dbo].[Customer_Item_Order_Day_Fact]
(
[Order_Date_Dim_ID] [smallint] NOT NULL,
[Order_Time_Dim_ID] [smallint] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Delivery_Method_Dim_ID] [tinyint] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Collection_Store_Dim_ID] [int] NOT NULL,
[Time_Store_Acknowledged_Dim_ID] [smallint] NOT NULL,
[Time_Store_Contacted_Dim_ID] [smallint] NOT NULL,
[Time_Waiting_Dim_ID] [smallint] NOT NULL,
[Discount_Reason_Dim_ID] [tinyint] NOT NULL,
[Order_Status_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_Qty] [int] NOT NULL,
[Gross_Order_Value_Home] [money] NOT NULL,
[Gross_Order_Value_Curr] [money] NOT NULL,
[Reserved_Qty] [int] NOT NULL,
[Pending_Qty] [int] NOT NULL,
[Discount_Value_Home] [money] NOT NULL,
[Discount_Value_Curr] [money] NOT NULL,
[Gift_Charge_Value_Home] [money] NOT NULL,
[Gift_Charge_Value_Curr] [money] NOT NULL,
[Shipping_Charge_Value_Home] [money] NOT NULL,
[Shipping_Charge_Value_Curr] [money] NOT NULL,
[VAT_Value_Home] [money] NOT NULL,
[VAT_Value_Curr] [money] NOT NULL,
[Goodwill_Value_Home] [money] NOT NULL,
[Goodwill_Value_Curr] [money] NOT NULL,
[Goodwill_Discount_Value_Home] [money] NOT NULL,
[Goodwill_Discount_Value_Curr] [money] NOT NULL,
[Net_Value_Home] [money] NOT NULL,
[Net_Value_Curr] [money] NOT NULL,
[Date_Received_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Order_Day_Fact_Channel_Dim_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Order_Day_Fact_Store_Dim_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Collection_Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Order_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Order_Day_Fact_Delivery_Method_Dim_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Delivery_Method_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Discount_Reason_Customer_Item_Order_Day_Fact_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Discount_Reason_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Order_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Dim_Customer_Item_Order_Day_Fact_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Order_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [Customer_Item_Order_Day_Fact_CIX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Order_Date_Dim_ID], [Order_Time_Dim_ID], [Customer_Dim_ID], [Order_No], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Order_Day_Fact_Order_Source_Dim_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Order_Source_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Time_Customer_Item_Order_Day_Fact_Order_Time_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Order_Time_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Order_Day_Fact_Order_Type_Dim_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Time_Customer_Item_Order_Day_Time_Store_Acknow_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Time_Store_Acknowledged_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Time_Customer_Item_Order_Day_Time_Store_Contacted_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Time_Store_Contacted_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Time_Customer_Item_Order_Day_Time_Waiting_FKX] ON [dbo].[Customer_Item_Order_Day_Fact] ([Time_Waiting_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Collection store for a Reserve and Collect order', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Order_Day_Fact', 'COLUMN', N'Collection_Store_Dim_ID'
GO
