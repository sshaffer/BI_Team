CREATE TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact]
(
[Sale_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Sales_Qty] [decimal] (11, 3) NOT NULL,
[Cost_Value_Home] [money] NOT NULL,
[Cost_Value_Curr] [money] NOT NULL,
[Actual_Sales_Value_Home] [money] NOT NULL,
[Actual_Sales_Value_Curr] [money] NOT NULL,
[Gross_Sales_Value_Home] [money] NOT NULL,
[Gross_Sales_Value_Curr] [money] NOT NULL,
[VAT_Value_Home] [money] NOT NULL,
[VAT_Value_Curr] [money] NOT NULL,
[Actual_FP_Sales_Value_Home] [money] NOT NULL,
[Actual_FP_Sales_Value_Curr] [money] NOT NULL,
[Actual_MD_Sales_Value_Home] [money] NOT NULL,
[Actual_MD_Sales_Value_Curr] [money] NOT NULL,
[Cost_of_Markdown_Value_Home] [money] NOT NULL,
[Cost_of_Markdown_Value_Curr] [money] NOT NULL,
[FP_Qty] [int] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_MD_Qty_DF] DEFAULT ((0)),
[Gross_Profit_Value_Home] [money] NOT NULL,
[Gross_Profit_Value_Curr] [money] NOT NULL,
[Delivery_Method_Dim_ID] [tinyint] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Delivery_Method_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_MD_Gross_Profit_Curr_DF] DEFAULT ((0)),
[Discount_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Discount_Home_DF] DEFAULT ((0)),
[Discount_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Discount_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Sale_Date_Dim_ID], [Item_Dim_ID], [Customer_Dim_ID], [Order_No], [Store_Dim_ID], [Channel_Dim_ID], [Currency_Dim_ID], [Order_Source_Dim_ID], [Order_Type_Dim_ID], [Delivery_Method_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Net_Sale_Day_Fact_Channel_Dim_FKX] ON [dbo].[Customer_Item_Net_Sale_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Net_Sale_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Item_Net_Sale_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Net_Sale_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Item_Net_Sale_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Net_Sale_Day_Fact__IDX] ON [dbo].[Customer_Item_Net_Sale_Day_Fact] ([Order_Source_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Net_Sale_Day_Fact_Order_Type_Dim_FKX] ON [dbo].[Customer_Item_Net_Sale_Day_Fact] ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calender_Day_Customer_Item_Net_Sale_Day_FKX] ON [dbo].[Customer_Item_Net_Sale_Day_Fact] ([Sale_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Customer_Item_Net_Sale_Day_FKX] ON [dbo].[Customer_Item_Net_Sale_Day_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Channel_Dim_FK] FOREIGN KEY ([Channel_Dim_ID]) REFERENCES [dbo].[Channel_Dim] ([Channel_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Currency_Cust_Item_Net_Sale_Day_FK] FOREIGN KEY ([Currency_Dim_ID]) REFERENCES [dbo].[Currency_Dim] ([Currency_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Customer_Dim_FK] FOREIGN KEY ([Customer_Dim_ID]) REFERENCES [dbo].[Customer_Dim] ([Customer_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customre_Item_Net_Sale_Day_Fact_Delivery_Method_FK] FOREIGN KEY ([Delivery_Method_Dim_ID]) REFERENCES [dbo].[Delivery_Method_Dim] ([Delivery_Method_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Order_Source_Dim_FK] FOREIGN KEY ([Order_Source_Dim_ID]) REFERENCES [dbo].[Order_Source_Dim] ([Order_Source_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customer_Item_Net_Sale_Day_Fact_Order_Type_Dim_FK] FOREIGN KEY ([Order_Type_Dim_ID]) REFERENCES [dbo].[Order_Type_Dim] ([Order_Type_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Calender_Day_Customer_Item_Net_Sale_Day_FK] FOREIGN KEY ([Sale_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Customer_Item_Net_Sale_Day_Fact] ADD CONSTRAINT [Customer_Item_Net_Sale_Day_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
