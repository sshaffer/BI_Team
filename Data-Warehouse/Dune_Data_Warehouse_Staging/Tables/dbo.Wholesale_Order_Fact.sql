CREATE TABLE [dbo].[Wholesale_Order_Fact]
(
[Wholesale_Order_Dim_ID] [bigint] NOT NULL,
[Sale_Order_Created_Date_Dim_ID] [smallint] NOT NULL,
[Sale_Order_Line_Created_Date_Dim_ID] [smallint] NOT NULL,
[Optional_Request_To_Ship_Date_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Sales_Order_Received_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Purchase_Order_Dim_ID] [bigint] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Delivery_Method_Dim_ID] [tinyint] NOT NULL,
[Sales_Order_Actual_Ship_Date_Dim_ID] [smallint] NOT NULL,
[Cancellation_Reason_Code_Dim_ID] [tinyint] NOT NULL,
[SALES_ORDER_QTY] [int] NOT NULL,
[SALES_ORDER_RESERVED_QTY] [int] NOT NULL,
[SALES_ORDER_ALLOCATED_QTY] [int] NOT NULL,
[SALES_ORDER_SHIPPED_QTY] [int] NOT NULL,
[SALES_ORDER_BACKORDER_QTY] [int] NOT NULL,
[SALES_ORDER_CANCELLED_QTY] [int] NOT NULL,
[ENTERED_UNIT_PRICE_HOME] [numeric] (7, 2) NOT NULL,
[ENTERED_UNIT_PRICE_CURR] [numeric] (7, 2) NOT NULL,
[VAT_UNIT_PRICE_HOME] [numeric] (7, 2) NOT NULL,
[VAT_UNIT_PRICE_CURR] [numeric] (7, 2) NOT NULL,
[ADDITIONAL_SHIPPING_CHARGE_HOME] [numeric] (7, 2) NOT NULL,
[ADDITIONAL_SHIPPING_CHARGE_CURR] [numeric] (7, 2) NOT NULL,
[TAX_AMOUNT_HOME] [numeric] (7, 2) NOT NULL,
[TAX_AMOUNT_CURR] [numeric] (7, 2) NOT NULL,
[OTHER_CHARGE_HOME] [numeric] (9, 2) NOT NULL,
[OTHER_CHARGE_CURR] [numeric] (9, 2) NOT NULL,
[OTHER_TAX_HOME] [numeric] (7, 2) NOT NULL,
[OTHER_TAX_CURR] [numeric] (7, 2) NOT NULL,
[LINE_MESSAGE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ORDER_STATUS] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[COUNTRY_CODE] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CARRAIGE_SEQUENCE] [int] NOT NULL,
[CARRAIGE_ROUTING_METHOD] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CARRAIGE_VALUE] [numeric] (13, 2) NOT NULL,
[INTERNATIONAL_CHARGE_SEQUENCE] [int] NOT NULL,
[INTERNATIONAL_CHARGE_ROUTING_METHOD] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[INTERNATIONAL_CHARGE_VALUE] [numeric] (13, 2) NOT NULL,
[LICENCE_FEE_SEQUENCE] [int] NOT NULL,
[LICENCE_FEE_ROUTING_METHOD] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LICENCE_FEE_VALUE] [numeric] (13, 2) NOT NULL,
[APPLY_LICENCE_FEE] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[INCLUDE_LICENCE_IN_COST] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RETAIL_MINUS_COST_PLUS] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RETAIL_FACTOR] [numeric] (13, 2) NOT NULL,
[LICENCE_FEE_PER_UNIT] [numeric] (19, 7) NOT NULL
) ON [PRIMARY]
GO