CREATE TABLE [dbo].[Currency_Exchange_Rate_Fact]
(
[Calendar_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[From_Currency_Dim_ID] [tinyint] NOT NULL,
[To_Currency_Dim_ID] [tinyint] NOT NULL,
[Exchange_Rate] [decimal] (17, 10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Currency_Exchange_Rate_Fact] ADD CONSTRAINT [Currency_Exchange_Rate_PK] PRIMARY KEY CLUSTERED  ([From_Currency_Dim_ID], [To_Currency_Dim_ID], [Time_Dim_ID], [Calendar_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Currency_Exchange_Rate_Effective_Date_FKX] ON [dbo].[Currency_Exchange_Rate_Fact] ([Calendar_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_Currency_Exchange_Rate_From_Currency_Code_FKX] ON [dbo].[Currency_Exchange_Rate_Fact] ([From_Currency_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_Currency_Exchange_Rate_Effective_Time_FKX] ON [dbo].[Currency_Exchange_Rate_Fact] ([Time_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_Currency_Exchange_Rate_To_Currency_Code_FKX] ON [dbo].[Currency_Exchange_Rate_Fact] ([To_Currency_Dim_ID]) ON [PRIMARY]
GO
