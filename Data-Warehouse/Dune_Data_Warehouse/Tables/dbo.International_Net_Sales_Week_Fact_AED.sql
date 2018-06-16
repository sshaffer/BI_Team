CREATE TABLE [dbo].[International_Net_Sales_Week_Fact_AED]
(
[Calendar_Week_Dim_Id] [smallint] NOT NULL,
[International_Partner_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Sale_Qty] [decimal] (38, 3) NULL,
[Actual_FP_Sales_Value_Home] [decimal] (38, 4) NULL,
[Actual_FP_Sales_Value_Curr] [decimal] (38, 4) NULL,
[Actual_MD_Sales_Value_Home] [decimal] (38, 4) NULL,
[Actual_MD_Sales_Value_Curr] [decimal] (38, 4) NULL,
[Discount_Value_Home] [decimal] (38, 4) NULL,
[Discount_Value_Curr] [decimal] (38, 4) NULL,
[Original_Sales_Value_Home] [decimal] (38, 4) NULL,
[Original_Sales_Value_Curr] [decimal] (38, 4) NULL,
[VAT_Value_Home] [decimal] (38, 4) NULL,
[VAT_Value_Curr] [decimal] (38, 4) NULL,
[Gross_Sales_Value_Home] [decimal] (38, 4) NULL,
[Gross_Sales_Value_Curr] [decimal] (38, 4) NULL,
[Cost_of_Markdown_Home] [decimal] (38, 4) NULL,
[Cost_of_Markdown_Curr] [decimal] (38, 4) NULL,
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
ALTER TABLE [dbo].[International_Net_Sales_Week_Fact_AED] ADD CONSTRAINT [International_Net_Sales_Week_Fact_AED_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_Id], [International_Partner_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [International_Net_Sales_Week_Fact_AED_Partner_IX] ON [dbo].[International_Net_Sales_Week_Fact_AED] ([International_Partner_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [International_Net_Sales_Week_Fact_AED_Item_IX] ON [dbo].[International_Net_Sales_Week_Fact_AED] ([Item_Dim_ID]) ON [PRIMARY]
GO
