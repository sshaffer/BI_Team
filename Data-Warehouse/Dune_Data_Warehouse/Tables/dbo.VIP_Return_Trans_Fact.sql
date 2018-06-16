CREATE TABLE [dbo].[VIP_Return_Trans_Fact]
(
[VIP_Customer_Dim_ID] [bigint] NOT NULL,
[Calendar_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Return_Price] [money] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Discount_Value] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Discount_DF] DEFAULT ((0)),
[VAT_Value] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_VAT_DF] DEFAULT ((0)),
[ID_STR_RT] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_ID_STR_RT_DF] DEFAULT (''),
[ID_WS] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_ID_WS_DF] DEFAULT (''),
[AI_TRN] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_AI_TRN_DF] DEFAULT (''),
[DC_DY_BSN] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_DC_DY_BSN_DF] DEFAULT (''),
[Return_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Return_Price_Curr_DF] DEFAULT ((0)),
[FP_Return_Price] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_Return_Price_DF] DEFAULT ((0)),
[FP_Return_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_Return_Price_Curr_DF] DEFAULT ((0)),
[MD_Return_Price] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_Return_Price_DF] DEFAULT ((0)),
[MD_Return_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_Return_Price_Curr_DF] DEFAULT ((0)),
[Discount_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Discount_Home_DF] DEFAULT ((0)),
[Discount_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Discount_Curr_DF] DEFAULT ((0)),
[Cost_Price_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Cost_Home_DF] DEFAULT ((0)),
[Cost_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Cost_Curr_DF] DEFAULT ((0)),
[FP_Qty] [int] NOT NULL CONSTRAINT [VIP_Return_Trasn_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_Qty_DF] DEFAULT ((0)),
[Qty] [int] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Qty_DF] DEFAULT ((0)),
[VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_VAT_Home_DF] DEFAULT ((0)),
[VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_VAT_Curr_DF] DEFAULT ((0)),
[Gross_Return_Price_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Gross_Home_DF] DEFAULT ((0)),
[Gross_Return_Price_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_Gross_Curr_DF] DEFAULT ((0)),
[FP_VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_VAT_Home_DF] DEFAULT ((0)),
[FP_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_VAT_Curr_DF] DEFAULT ((0)),
[MD_VAT_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_VAT_Home_DF] DEFAULT ((0)),
[MD_VAT_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_VAT_Curr_DF] DEFAULT ((0)),
[FP_Cost_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_Cost_Home_DF] DEFAULT ((0)),
[FP_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_Cost_Curr_DF] DEFAULT ((0)),
[MD_Cost_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_Cost_Home_DF] DEFAULT ((0)),
[MD_Cost_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_Cost_Curr_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_Gross_Profit_Home_DF] DEFAULT ((0)),
[FP_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_FP_Gross_Profit_Curr_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Home] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_Gross_Profit_Home_DF] DEFAULT ((0)),
[MD_Gross_Profit_Value_Curr] [money] NOT NULL CONSTRAINT [VIP_Return_Trans_Fact_MD_Gross_Profot_Curr_DF] DEFAULT ((0)),
[AI_LN_ITM] [smallint] NOT NULL,
[AI_SEQ] [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[VIP_Return_Trans_Fact] ADD 
CONSTRAINT [VIP_Return_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([ID_STR_RT], [ID_WS], [AI_TRN], [DC_DY_BSN], [AI_LN_ITM], [AI_SEQ]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[VIP_Return_Trans_Fact] ADD CONSTRAINT [VIP_Return_Trans_Fact_Calendar_Dim_FK] FOREIGN KEY ([Calendar_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO

ALTER TABLE [dbo].[VIP_Return_Trans_Fact] ADD CONSTRAINT [VIP_Return_Trans_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[VIP_Return_Trans_Fact] ADD CONSTRAINT [VIP_Return_Trans_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[VIP_Return_Trans_Fact] ADD CONSTRAINT [VIP_Return_Trans_Fact_Time_Dim_FK] FOREIGN KEY ([Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
ALTER TABLE [dbo].[VIP_Return_Trans_Fact] ADD CONSTRAINT [VIP_Return_Trans_Fact_VIP_Customer_Dim_FK] FOREIGN KEY ([VIP_Customer_Dim_ID]) REFERENCES [dbo].[VIP_Customer_Dim] ([VIP_Customer_Dim_ID])
GO
