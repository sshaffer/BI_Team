CREATE TABLE [dbo].[International_Currency_Conversion_Rate_Fact]
(
[Currency_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[From_Date] [date] NOT NULL,
[To_Date] [date] NOT NULL,
[Rate] [decimal] (11, 3) NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [International_Currency_Conversion_Rate_Fact_CIX] ON [dbo].[International_Currency_Conversion_Rate_Fact] ([Currency_Code], [From_Date], [To_Date]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[International_Currency_Conversion_Rate_Fact] TO [DUNE\IISBISWEB]
GRANT INSERT ON  [dbo].[International_Currency_Conversion_Rate_Fact] TO [DUNE\IISBISWEB]
GRANT UPDATE ON  [dbo].[International_Currency_Conversion_Rate_Fact] TO [DUNE\IISBISWEB]
GO
