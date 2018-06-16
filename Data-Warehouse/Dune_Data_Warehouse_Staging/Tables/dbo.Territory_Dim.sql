CREATE TABLE [dbo].[Territory_Dim]
(
[Zone_Dim_ID] [tinyint] NOT NULL,
[Territory_Dim_ID] [int] NOT NULL,
[Territory_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Territory_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Territory_Dim] ADD CONSTRAINT [Territory_Dim_PK] PRIMARY KEY CLUSTERED  ([Territory_Dim_ID], [Zone_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Territory_Dim_Terr_IDX] ON [dbo].[Territory_Dim] ([Territory_Code], [Territory_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Territory_Dim_Zone_Terr_IDX] ON [dbo].[Territory_Dim] ([Territory_Code], [Territory_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Territory_Dim_TerrName_IDX] ON [dbo].[Territory_Dim] ([Territory_Name]) ON [PRIMARY]
GO
