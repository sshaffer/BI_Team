CREATE TABLE [dbo].[Merge_Retail_Price_Change]
(
[Change_Retail_Price_Home] [numeric] (15, 4) NULL,
[Price_Date_ID] [smallint] NULL,
[Item_Dim_ID] [int] NULL,
[Store_Dim_ID] [int] NULL,
[FP_MD_Flag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Currency_Dim_ID] [tinyint] NULL,
[Change_Retail_Price_Curr] [numeric] (15, 4) NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Merge_Retail_Price_Change_Item_Store] ON [dbo].[Merge_Retail_Price_Change] ([Item_Dim_ID], [Store_Dim_ID]) INCLUDE ([Change_Retail_Price_Curr], [Change_Retail_Price_Home], [Price_Date_ID]) ON [PRIMARY]
GO
