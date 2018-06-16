CREATE TABLE [dbo].[Zone_Dim]
(
[Zone_Dim_ID] [tinyint] NOT NULL,
[Zone_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Zone_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Zone_Dim] ADD CONSTRAINT [Zone_Dim_PK] PRIMARY KEY CLUSTERED  ([Zone_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Zone_Dim_Zone_Name_IDX] ON [dbo].[Zone_Dim] ([Zone_Code], [Zone_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Zone_Dim_Name_IDX] ON [dbo].[Zone_Dim] ([Zone_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The top level of the Facilites hierarchy', 'SCHEMA', N'dbo', 'TABLE', N'Zone_Dim', NULL, NULL
GO
