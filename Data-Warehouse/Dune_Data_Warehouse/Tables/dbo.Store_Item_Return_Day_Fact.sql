CREATE TABLE [dbo].[Store_Item_Return_Day_Fact]
(
[Return_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Return_Reason_Dim_ID] [tinyint] NOT NULL,
[Return_Qty] [decimal] (38, 3) NULL,
[Return_Value_Home] [money] NULL,
[Return_Value_Curr] [money] NULL,
[Return_Cost_Value_Home] [decimal] (38, 6) NULL,
[Return_Cost_Value_Curr] [decimal] (38, 6) NULL,
[VAT_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_VAT_Home_DF] DEFAULT ((0)),
[VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_VAT_Curr_DF] DEFAULT ((0)),
[FP_Return_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_Return_Home_DF] DEFAULT ((0)),
[FP_Return_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_Return_Curr_DF] DEFAULT ((0)),
[Promo_Return_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_Promo_Home_DF] DEFAULT ((0)),
[Promo_Return_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_Promo_Curr_DF] DEFAULT ((0)),
[MD_Return_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_Return_Home_DF] DEFAULT ((0)),
[MD_Return_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_Return_Curr_DF] DEFAULT ((0)),
[FP_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_Qty_DF] DEFAULT ((0)),
[Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_Gross_Profit_Home_DF] DEFAULT ((0)),
[Gross_Profit_value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_Gross_Profit_Curr_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Return_Day_Fact_MD_Gross_Profit_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [Store_Item_Return_Day_Fact_UIX] ON [dbo].[Store_Item_Return_Day_Fact] ([Return_Date_Dim_ID], [Item_Dim_ID], [Store_Dim_ID], [Channel_Dim_ID], [Currency_Dim_ID], [Return_Reason_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Item_Return_Day_Fact] ADD CONSTRAINT [Store_Item_Return_Day_Fact_Channel_Dim_FK] FOREIGN KEY ([Channel_Dim_ID]) REFERENCES [dbo].[Channel_Dim] ([Channel_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Item_Return_Day_Fact] ADD CONSTRAINT [Currency_Dim_Store_Item_Return_Day_Fact_FK] FOREIGN KEY ([Currency_Dim_ID]) REFERENCES [dbo].[Currency_Dim] ([Currency_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Item_Return_Day_Fact] ADD CONSTRAINT [Store_Item_Return_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Item_Return_Day_Fact] ADD CONSTRAINT [Calendar_Day_Dim_Store_Item_Return_Day_Fact_FK] FOREIGN KEY ([Return_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Store_Item_Return_Day_Fact] ADD CONSTRAINT [Return_Reason_Dim_Store_Item_Return_Day_Fact_FK] FOREIGN KEY ([Return_Reason_Dim_ID]) REFERENCES [dbo].[Return_Reason_Dim] ([Return_Reason_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Item_Return_Day_Fact] ADD CONSTRAINT [Store_Item_Return_Day_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
