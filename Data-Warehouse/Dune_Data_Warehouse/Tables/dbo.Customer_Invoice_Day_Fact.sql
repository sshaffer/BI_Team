CREATE TABLE [dbo].[Customer_Invoice_Day_Fact]
(
[Invoice_Date_Dim_ID] [smallint] NOT NULL,
[Invoice_No] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[AR_Customer_Dim_ID] [int] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Unit_Cost_Price] [money] NOT NULL,
[Invoice_Qty] [int] NOT NULL,
[VAT_Value] [money] NOT NULL,
[Discount_Value] [money] NOT NULL,
[Delivery_Charge_Value] [money] NOT NULL,
[Net_Value] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Invoice_Day_Fact] ADD CONSTRAINT [Customer_Invoice_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Invoice_Date_Dim_ID], [Invoice_No], [Order_No], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Invoice_Day_Fact_AR_Customer_Dim_FKX] ON [dbo].[Customer_Invoice_Day_Fact] ([AR_Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Invoice_Day_Fact_Channel_Dim_FKX] ON [dbo].[Customer_Invoice_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Invoice_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Invoice_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Dim_Cust_Invoice_Day_Fact_FKX] ON [dbo].[Customer_Invoice_Day_Fact] ([Invoice_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Invoice_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Invoice_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Invoice_Day_Fact] ADD CONSTRAINT [Customer_Invoice_Day_Fact_AR_Customer_Dim_FK] FOREIGN KEY ([AR_Customer_Dim_ID]) REFERENCES [dbo].[AR_Customer_Dim] ([AR_Customer_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Invoice_Day_Fact] ADD CONSTRAINT [Customer_Invoice_Day_Fact_Channel_Dim_FK] FOREIGN KEY ([Channel_Dim_ID]) REFERENCES [dbo].[Channel_Dim] ([Channel_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Invoice_Day_Fact] ADD CONSTRAINT [Customer_Invoice_Day_Fact_Customer_Dim_FK] FOREIGN KEY ([Customer_Dim_ID]) REFERENCES [dbo].[Customer_Dim] ([Customer_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Invoice_Day_Fact] ADD CONSTRAINT [Calendar_Day_Dim_Cust_Invoice_Day_Fact_FK] FOREIGN KEY ([Invoice_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Customer_Invoice_Day_Fact] ADD CONSTRAINT [Customer_Invoice_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'AR Invoices', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Invoice_Day_Fact', NULL, NULL
GO
