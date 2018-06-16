CREATE TABLE [dbo].[Store_Item_Price_Day_Fact]
(
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[FP_MD_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Retail_Price_Home] [money] NOT NULL,
[Retail_Price_Curr] [money] NOT NULL,
[Calendar_Dim_ID] [smallint] NOT NULL,
[Promotion_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Store_Item_Price_Day_Fact_Promotion_Flag] DEFAULT ('N'),
[Cost_Price_Home] [money] NOT NULL CONSTRAINT [Store_Item_Price_Day_Fact_Cost_Home_DF] DEFAULT ((0)),
[Cost_Price_Curr] [money] NOT NULL CONSTRAINT [Store_Item_Price_Day_Fact_Cost_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)
GO
CREATE UNIQUE CLUSTERED INDEX [Store_Item_Price_Day_Fact_CIX] ON [dbo].[Store_Item_Price_Day_Fact] ([Calendar_Dim_ID], [Item_Dim_ID], [Store_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
