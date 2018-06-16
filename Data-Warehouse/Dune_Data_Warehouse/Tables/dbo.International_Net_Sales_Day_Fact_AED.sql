CREATE TABLE [dbo].[International_Net_Sales_Day_Fact_AED]
(
[Sale_Date_Dim_ID] [smallint] NOT NULL,
[International_Partner_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Sale_Qty] [decimal] (11, 3) NOT NULL,
[Actual_FP_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Actual_FP_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[Actual_MD_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Actual_MD_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[Discount_Value_Home] [decimal] (19, 4) NOT NULL,
[Discount_Value_Curr] [decimal] (19, 4) NOT NULL,
[Original_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Original_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[VAT_Value_Home] [decimal] (19, 4) NOT NULL,
[VAT_Value_Curr] [decimal] (19, 4) NOT NULL,
[Gross_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Gross_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[Cost_of_Markdown_Home] [decimal] (19, 4) NOT NULL,
[Cost_of_Markdown_Curr] [decimal] (19, 4) NOT NULL,
[FP_Qty] [int] NULL,
[MD_Qty] [int] NULL,
[FP_Sales_Value_AED] [money] NULL,
[MD_Sales_Value_AED] [money] NULL,
[Discount_Value_AED] [money] NULL,
[Original_Sales_Value_AED] [money] NULL,
[Original_VAT_AED] [money] NULL,
[Gross_Sales_Value_AED] [money] NULL,
[Cost_of_Markdown_AED] [money] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Net_Sales_Day_Fact_AED] ADD CONSTRAINT [International_Net_Sales_Day_Fact_AED_PK] PRIMARY KEY CLUSTERED  ([Sale_Date_Dim_ID], [International_Partner_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [International_Net_Sales_Day_Fact_AED_Partner_IX] ON [dbo].[International_Net_Sales_Day_Fact_AED] ([International_Partner_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [International_Net_Sales_Day_Fact_AED_Item_IX] ON [dbo].[International_Net_Sales_Day_Fact_AED] ([Item_Dim_ID]) ON [PRIMARY]
GO
