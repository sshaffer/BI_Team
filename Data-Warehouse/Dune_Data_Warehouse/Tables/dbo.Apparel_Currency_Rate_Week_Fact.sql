CREATE TABLE [dbo].[Apparel_Currency_Rate_Week_Fact]
(
[Calendar_Week_Dim_Id] [smallint] NOT NULL,
[Currency_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GBP_to_Local_Rate] [numeric] (19, 7) NOT NULL,
[Local_to_AED_Rate] [numeric] (19, 7) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Apparel_Currency_Rate_Week_Fact] ADD CONSTRAINT [Apparel_Currency_Rate_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_Id], [Currency_Code]) ON [PRIMARY]
GO
