CREATE TABLE [dbo].[Country_Dim]
(
[Country_Dim_ID] [tinyint] NOT NULL,
[Country_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Name] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Country_Dim] ADD CONSTRAINT [Country_Dim_PK] PRIMARY KEY CLUSTERED  ([Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Country_Dim_Country_Code_IDX] ON [dbo].[Country_Dim] ([Country_Code]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains code and description for each relevant country.', 'SCHEMA', N'dbo', 'TABLE', N'Country_Dim', NULL, NULL
GO
