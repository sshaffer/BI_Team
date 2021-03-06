CREATE TABLE [dbo].[Wholesale_Order_Fact]
(
[Wholesale_Order_Dim_ID] [bigint] NOT NULL,
[From_Date] [date] NOT NULL,
[To_Date] [date] NOT NULL,
[Current_Flag] [bit] NOT NULL,
[Sale_Order_Created_Date_Dim_ID] [smallint] NOT NULL,
[Sale_Order_Line_Created_Date_Dim_ID] [smallint] NOT NULL,
[Optional_Request_to_Ship_Date_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Sales_Order_Received_Date_Dim_ID] [smallint] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Delivery_Method_Dim_ID] [tinyint] NOT NULL,
[Sales_Order_Actual_Ship_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Sales_Order_Qty] [int] NOT NULL,
[Sales_Order_Reserved_Qty] [int] NOT NULL,
[Sales_Order_Allocated_Qty] [int] NOT NULL,
[Sales_Order_Shipped_Qty] [int] NOT NULL,
[Sales_Order_Backorder_Qty] [int] NOT NULL,
[Sales_Order_Cancelled_Qty] [int] NOT NULL,
[Entered_Unit_Price_Home] [decimal] (7, 2) NOT NULL,
[Entered_Unit_Price_Curr] [decimal] (7, 2) NOT NULL,
[VAT_Unit_Price_Home] [decimal] (7, 2) NOT NULL,
[VAT_Unit_Price_Curr] [decimal] (7, 2) NOT NULL,
[Additional_Shipping_Charge_Home] [decimal] (7, 2) NOT NULL,
[Additional_Shipping_Charge_Curr] [decimal] (7, 2) NOT NULL,
[Tax_Amount_Home] [decimal] (7, 2) NOT NULL,
[Tax_Amount_Curr] [decimal] (7, 2) NOT NULL,
[Cancellation_Reason_Code_Dim_ID] [tinyint] NOT NULL,
[Other_Charge_Home] [decimal] (7, 2) NOT NULL,
[Other_Charge_Curr] [decimal] (7, 2) NOT NULL,
[Other_Tax_Home] [decimal] (7, 2) NOT NULL,
[Other_Tax_Curr] [decimal] (7, 2) NOT NULL,
[Line_Message] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Dim_ID] [bigint] NOT NULL,
[Order_Status] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Carraige_Sequence] [int] NOT NULL,
[Carraige_Routing_Method] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Carraige_Value] [numeric] (13, 2) NOT NULL,
[International_Charge_Sequence] [int] NOT NULL,
[International_Charge_Routing_Method] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[International_Charge_Value] [numeric] (13, 2) NOT NULL,
[Licence_Fee_Sequence] [int] NOT NULL,
[Licence_Fee_Routing_Method] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Licence_Fee_Value] [numeric] (13, 2) NOT NULL,
[Apply_Licence_Fee] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Include_Licence_Fee_In_Cost] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Retail_Minus_Cost_Plus] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Retail_Factor] [numeric] (13, 2) NOT NULL,
[Licence_Fee_Per_Unit] [numeric] (19, 7) NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Wholesale_Order_Fact] ADD 
CONSTRAINT [Wholesale_Order_Fact_PK] PRIMARY KEY CLUSTERED  ([Wholesale_Order_Dim_ID], [Sale_Order_Created_Date_Dim_ID], [From_Date], [To_Date], [Current_Flag]) ON [PRIMARY]


GO
