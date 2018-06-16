CREATE TABLE [dbo].[Item_Cost_Price_History_Fact]
(
[DW_Load_Date_ID] [smallint] NOT NULL CONSTRAINT [Item_Cost_Price_History_Fact_DW_Load_Date_ID_DF] DEFAULT ('-32768'),
[Calendar_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Item_Landed_Cost_Price] [money] NOT NULL,
[Date_Key] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
