CREATE TABLE [dbo].[Wholesale_Invoice_Fact]
(
[Invoice_Number] [int] NOT NULL,
[Allocation_Date_Dim_ID] [smallint] NOT NULL,
[Wholesale_Order_Dim_ID] [bigint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Invoice_Qty] [int] NOT NULL,
[Invoice_Extended_Price_Home] [numeric] (9, 2) NOT NULL,
[Invoice_Extended_Price_Curr] [numeric] (9, 2) NOT NULL,
[Invoice_Tax_Value_Home] [numeric] (7, 2) NOT NULL,
[Invoice_Tax_Value_Curr] [numeric] (7, 2) NOT NULL,
[Invoice_Shipping_And_Handling_Home] [numeric] (9, 2) NOT NULL,
[Invoice_Shipping_And_Handling_Curr] [numeric] (9, 2) NOT NULL,
[Invoice_Discount_Amount_Home] [numeric] (9, 2) NOT NULL,
[Invoice_Discount_Amount_Curr] [numeric] (9, 2) NOT NULL,
[Invoice_Manifest_Note_1] [varchar] (78) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Invoice_Manifest_Note_2] [varchar] (78) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Invoice_Manifest_Note_3] [varchar] (78) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Invoice_Manifest_Note_4] [varchar] (78) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Dim_ID] [int] NOT NULL CONSTRAINT [Wholesale_Invoice_Fact_Customer_DF] DEFAULT ((-2147483648)),
[Purchase_Order_Dim_ID] [bigint] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Wholesale_Invoice_Fact] ADD 
CONSTRAINT [Wholesale_Invoice_Fact_PK] PRIMARY KEY CLUSTERED  ([Invoice_Number], [Wholesale_Order_Dim_ID]) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [Wholesale_Invoice_Fact_Cust_IX] ON [dbo].[Wholesale_Invoice_Fact] ([Customer_Dim_ID]) ON [PRIMARY]


GO
