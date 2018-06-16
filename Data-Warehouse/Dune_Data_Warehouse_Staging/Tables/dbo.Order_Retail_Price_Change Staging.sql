CREATE TABLE [dbo].[Order_Retail_Price_Change Staging]
(
[Change_Retail_Price_Curr] [numeric] (7, 2) NULL,
[Change_Retail_Price_Home] [numeric] (7, 2) NULL,
[Item_Dim_ID] [int] NULL,
[Store_Dim_ID] [int] NULL,
[Calendar_Dim_Id] [smallint] NULL,
[FP_MD_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Currency_Dim_ID] [tinyint] NULL
) ON [PRIMARY]
GO
