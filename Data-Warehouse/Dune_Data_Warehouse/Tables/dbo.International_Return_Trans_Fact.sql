CREATE TABLE [dbo].[International_Return_Trans_Fact]
(
[Return_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[International_Partner_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Return_Qty] [decimal] (11, 3) NOT NULL,
[Actual_FP_Return_Value_Home] [decimal] (19, 4) NOT NULL,
[Actual_FP_Return_Value_Curr] [decimal] (19, 4) NOT NULL,
[Actual_MD_Return_Value_Home] [decimal] (19, 4) NOT NULL,
[Actual_MD_Return_Value_Curr] [decimal] (19, 4) NOT NULL,
[Discount_Value_Home] [decimal] (19, 4) NOT NULL,
[Discount_Value_Curr] [decimal] (19, 4) NOT NULL,
[Original_Sales_Value_Home] [decimal] (19, 4) NOT NULL,
[Original_Sales_Value_Curr] [decimal] (19, 4) NOT NULL,
[VAT_Value_Home] [decimal] (19, 4) NOT NULL,
[VAT_Value_Curr] [decimal] (19, 4) NOT NULL,
[Gross_Return_Value_Home] [decimal] (19, 4) NOT NULL,
[Gross_Return_Value_Curr] [decimal] (19, 4) NOT NULL,
[Cost_of_Markdown_Home] [decimal] (19, 4) NOT NULL,
[Cost_of_Markdown_Curr] [decimal] (19, 4) NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [International_Return_Trans_Fact_CIX] ON [dbo].[International_Return_Trans_Fact] ([Return_Date_Dim_ID], [Time_Dim_ID], [International_Partner_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Return_Trans_Fact] ADD CONSTRAINT [International_Return_Trans_Fact_Parter_FK] FOREIGN KEY ([International_Partner_Dim_ID]) REFERENCES [dbo].[International_Partner_Dim] ([International_Partner_Dim_ID])
GO
ALTER TABLE [dbo].[International_Return_Trans_Fact] ADD CONSTRAINT [International_Return_Trans_Fact_Item_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[International_Return_Trans_Fact] ADD CONSTRAINT [International_Return_Trans_Fact_Date_FK] FOREIGN KEY ([Return_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[International_Return_Trans_Fact] ADD CONSTRAINT [International_Return_Trans_Fact_Time_FK] FOREIGN KEY ([Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
