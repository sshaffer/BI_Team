CREATE TABLE [dbo].[Original_Retail_Price]
(
[Calendar_Date_ID] [smallint] NULL,
[FP_MD_Flag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Original_Retail_Price_Curr] [numeric] (13, 2) NULL,
[Original_Retail_Price_Home] [numeric] (13, 2) NULL,
[Item_Dim_ID] [int] NULL,
[Store_Dim_ID] [int] NULL,
[Currency_Dim_ID] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Original_Retail_Price_IDX] ON [dbo].[Original_Retail_Price] ([Store_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
