CREATE TABLE [dbo].[Region_Dim]
(
[Territory_Dim_ID] [tinyint] NOT NULL,
[Region_Dim_ID] [tinyint] NOT NULL,
[Zone_Dim_ID] [tinyint] NOT NULL,
[Region_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Region_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Region_Dim] ADD CONSTRAINT [Region_Dim_PK] PRIMARY KEY CLUSTERED  ([Territory_Dim_ID], [Region_Dim_ID], [Zone_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Region_Dim_Region_Code_Name_IDX] ON [dbo].[Region_Dim] ([Region_Code], [Region_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Region_Dim_Terr_Region_IDX] ON [dbo].[Region_Dim] ([Region_Code], [Region_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Region_Dim_Region_Name_IDX] ON [dbo].[Region_Dim] ([Region_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The third level in the Facilities hierarchy e.g. 111 = John Lewis, 1 = Dune Solus.', 'SCHEMA', N'dbo', 'TABLE', N'Region_Dim', NULL, NULL
GO
