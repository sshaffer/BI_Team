CREATE TABLE [dbo].[International_Sales_Trans_Fact]
(
[Sale_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[International_Partner_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Sale_Qty] [decimal] (11, 3) NOT NULL,
[Actual_FP_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Actual_FP_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[Actual_MD_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Actual_MD_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[Discount_Value_Home] [decimal] (19, 4) NOT NULL,
[Discount_Value_Curr] [decimal] (19, 4) NOT NULL,
[Original_Sales_Value_Home] [decimal] (19, 4) NOT NULL CONSTRAINT [International_Sales_Trans_Fact_Original_Sales_Val_Home_DF] DEFAULT ((0)),
[Original_Sales_Value_Curr] [decimal] (19, 4) NOT NULL CONSTRAINT [International_Sales_Trans_Fact_Origianl_Sales_Val_Home_DF] DEFAULT ((0)),
[VAT_Value_Home] [decimal] (19, 4) NOT NULL,
[VAT_Value_Curr] [decimal] (19, 4) NOT NULL,
[Gross_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Gross_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[Cost_of_Markdown_Home] [decimal] (19, 4) NOT NULL,
[Cost_of_Markdown_Curr] [decimal] (19, 4) NOT NULL
) ON [PRIMARY]
GO
