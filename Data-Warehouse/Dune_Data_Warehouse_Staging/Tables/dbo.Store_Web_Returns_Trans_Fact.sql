CREATE TABLE [dbo].[Store_Web_Returns_Trans_Fact]
(
[Sale_Commission_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Return_Reason_Dim_ID] [tinyint] NOT NULL,
[Return_Value] [money] NOT NULL,
[Return_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
