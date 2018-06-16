CREATE TABLE [hist].[Retail_Price_Change_Failure]
(
[Retail_Prices_Failure_ID] [bigint] NOT NULL IDENTITY(-9223372036854775808, 1),
[Source] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Reason] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[KYR#] [numeric] (2, 0) NULL,
[KWK#] [numeric] (2, 0) NULL,
[KCLS] [numeric] (4, 0) NULL,
[KVEN] [numeric] (5, 0) NULL,
[KSTY] [numeric] (4, 0) NULL,
[KCLR] [numeric] (3, 0) NULL,
[KSIZ] [numeric] (4, 0) NULL,
[KSTR] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KSLR] [numeric] (11, 0) NULL,
[SCUR] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DCOEDT] [numeric] (8, 0) NULL,
[FSKSKU] [numeric] (10, 0) NULL,
[DCOCUR] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DOLUPR] [numeric] (7, 2) NULL,
[DOLUPRH] [numeric] (7, 2) NULL
) ON [PRIMARY]
GO
