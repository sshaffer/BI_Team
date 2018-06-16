CREATE TABLE [dbo].[International_Stock_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[International_Partner_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Stock_Qty] [decimal] (11, 3) NOT NULL
) ON [PRIMARY]
GO
