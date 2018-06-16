CREATE TABLE [dbo].[International_Net_Sales_Day_Fact]
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
[FP_Qty] [int] NULL CONSTRAINT [International_Net_Sales_Day_Fact_FP_Qty_DF] DEFAULT ((0)),
[MD_Qty] [int] NULL CONSTRAINT [International_Net_Sales_Day_Fact_MD_Qty_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Net_Sales_Day_Fact] ADD CONSTRAINT [International_Net_Sales_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Sale_Date_Dim_ID], [International_Partner_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Net_Sales_Day_Fact] ADD CONSTRAINT [International_Net_Sales_Day_Fact_Partner_FK] FOREIGN KEY ([International_Partner_Dim_ID]) REFERENCES [dbo].[International_Partner_Dim] ([International_Partner_Dim_ID])
GO
ALTER TABLE [dbo].[International_Net_Sales_Day_Fact] ADD CONSTRAINT [International_Net_Sales_Day_Fact_Item_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[International_Net_Sales_Day_Fact] ADD CONSTRAINT [International_Net_Sales_Day_Fact_Date_FK] FOREIGN KEY ([Sale_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
