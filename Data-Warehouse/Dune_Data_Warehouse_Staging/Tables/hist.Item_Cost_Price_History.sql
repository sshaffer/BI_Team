CREATE TABLE [hist].[Item_Cost_Price_History]
(
[Price_Change] [money] NULL,
[Date_Key] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Calendar_Dim_ID] [smallint] NULL,
[Item_Dim_ID] [int] NULL
) ON [PRIMARY]
GO
