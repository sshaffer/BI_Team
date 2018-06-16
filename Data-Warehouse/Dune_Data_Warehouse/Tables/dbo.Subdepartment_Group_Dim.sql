CREATE TABLE [dbo].[Subdepartment_Group_Dim]
(
[Subdepartment_Group_Dim_ID] [smallint] NOT NULL IDENTITY(0, 1),
[Group_Name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subgroup_Name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Subdepartment_Group_Dim] ADD CONSTRAINT [Subdepartment_Group_Dim_PK] PRIMARY KEY CLUSTERED  ([Subdepartment_Group_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Subdepartment_Group_Dim] ADD CONSTRAINT [Subdepartment_Group_Dim_Group_Subgroup] UNIQUE NONCLUSTERED  ([Group_Name], [Subgroup_Name]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Subdepartment_Group_Dim] ADD CONSTRAINT [Subdepartment_Group_Dim_Subgroup_Name] UNIQUE NONCLUSTERED  ([Subgroup_Name]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Subdepartment_Group_Dim] TO [DUNE\IISBISWEB]
GRANT INSERT ON  [dbo].[Subdepartment_Group_Dim] TO [DUNE\IISBISWEB]
GRANT DELETE ON  [dbo].[Subdepartment_Group_Dim] TO [DUNE\IISBISWEB]
GRANT UPDATE ON  [dbo].[Subdepartment_Group_Dim] TO [DUNE\IISBISWEB]
GO
