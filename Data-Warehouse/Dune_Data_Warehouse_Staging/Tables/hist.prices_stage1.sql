CREATE TABLE [hist].[prices_stage1]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Change_Retail_Price_Home] [money] NULL,
[Change_Retail_Price_Curr] [money] NULL,
[SKU] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
