CREATE TABLE [hist].[Retail_Price_Change]
(
[Price_Date_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[FP_MD_Flag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Change_Retail_Price_Home] [numeric] (15, 4) NOT NULL,
[Change_Retail_Price_Curr] [numeric] (15, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [hist].[Retail_Price_Change] ADD CONSTRAINT [Retail_Price_Change_PK] PRIMARY KEY CLUSTERED  ([Price_Date_ID], [Store_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Retail_Price_Change_Store] ON [hist].[Retail_Price_Change] ([Store_Dim_ID]) INCLUDE ([Change_Retail_Price_Curr], [Change_Retail_Price_Home], [Currency_Dim_ID], [FP_MD_Flag], [Item_Dim_ID], [Price_Date_ID]) ON [PRIMARY]
GO
