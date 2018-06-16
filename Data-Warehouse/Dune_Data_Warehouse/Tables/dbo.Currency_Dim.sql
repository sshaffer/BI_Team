CREATE TABLE [dbo].[Currency_Dim]
(
[Currency_Dim_ID] [tinyint] NOT NULL,
[Currency_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Description] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Currency_Dim] ADD CONSTRAINT [Currency_Dim_PK] PRIMARY KEY CLUSTERED  ([Currency_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains code and description for each currency used within the business.', 'SCHEMA', N'dbo', 'TABLE', N'Currency_Dim', NULL, NULL
GO
