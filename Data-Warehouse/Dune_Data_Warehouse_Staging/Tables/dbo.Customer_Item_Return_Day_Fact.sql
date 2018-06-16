CREATE TABLE [dbo].[Customer_Item_Return_Day_Fact]
(
[Return_Date_Dim_ID] [smallint] NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Return_Status_Code] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Return_Reason_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Return_Qty] [decimal] (11, 3) NOT NULL,
[Return_Value_Home] [money] NOT NULL,
[Return_Value_Curr] [money] NOT NULL,
[Return_Cost_Value_Home] [money] NOT NULL,
[Return_Cost_Value_Curr] [money] NOT NULL,
[Return_VAT_Value_Home] [money] NOT NULL,
[Return_VAT_Value_Curr] [money] NOT NULL,
[Gross_Profit_Value_Home] [money] NOT NULL,
[Gross_Profit_Value_Curr] [money] NOT NULL,
[Delivery_Method_Dim_ID] [tinyint] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_Delivery_Method_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Return_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_Return_Curr_DF] DEFAULT ((0)),
[FP_Return_Qty] [int] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_Return_Qty_DF] DEFAULT ((0)),
[MD_Return_Qty] [int] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_Return_Qty_DF] DEFAULT ((0)),
[FP_Return_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_Return_Home_DF] DEFAULT ((0)),
[FP_Return_Value_Curr] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_FP_Return_Curr_DF] DEFAULT ((0)),
[MD_Return_Value_Home] [money] NOT NULL CONSTRAINT [Customer_Item_Return_Day_Fact_MD_Return_Home_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Return_Day_Fact_Channel_Dim_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_Dim_Customer_Item_Return_Day_Fact_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Currency_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Return_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Return_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Return_Day_Fact_Order_Source_Dim_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Order_Source_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Return_Day_Fact_Order_Type_Dim_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Dim_Customer_Item_Return_Day_Fact_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Return_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Return Reason Dim_Customer_Item_Return_Day_Fact_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Return_Reason_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Return_Day_Fact_Store_Dim_FKX] ON [dbo].[Customer_Item_Return_Day_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customer returns including sent in errors and refunds', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Return_Day_Fact', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Store where the original sale was made', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Return_Day_Fact', 'COLUMN', N'Store_Dim_ID'
GO
