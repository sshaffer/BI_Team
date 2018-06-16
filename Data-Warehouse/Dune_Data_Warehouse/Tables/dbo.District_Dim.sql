CREATE TABLE [dbo].[District_Dim]
(
[Region_Dim_ID] [tinyint] NOT NULL,
[District_Dim_ID] [tinyint] NOT NULL,
[Territory_Dim_ID] [tinyint] NOT NULL,
[Zone_Dim_ID] [tinyint] NOT NULL,
[District_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[District_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[District_Dim] ADD CONSTRAINT [District_Dim_PK] PRIMARY KEY CLUSTERED  ([Region_Dim_ID], [District_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [District_Dim_Dist_IDX] ON [dbo].[District_Dim] ([District_Code], [District_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [District_Dim_Region_Dist_IDX] ON [dbo].[District_Dim] ([District_Code], [District_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [District_Dim_DistName_IDX] ON [dbo].[District_Dim] ([District_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is part of the Facilities hierarchy and identifies a group of stores e.g. Dune Solus GB,  House of Fraser IE.', 'SCHEMA', N'dbo', 'TABLE', N'District_Dim', NULL, NULL
GO
