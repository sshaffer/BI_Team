CREATE TABLE [dbo].[Subdepartment_Dim]
(
[Department_Dim_ID] [tinyint] NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Subdepartment_Code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subdepartment_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subdepartment_Group_Dim_ID] [smallint] NOT NULL CONSTRAINT [Subdepartment_Group_Dim_ID_DF] DEFAULT ((0))
) ON [PRIMARY]
ALTER TABLE [dbo].[Subdepartment_Dim] ADD
CONSTRAINT [Subdepartment_Group_Dim_FK] FOREIGN KEY ([Subdepartment_Group_Dim_ID]) REFERENCES [dbo].[Subdepartment_Group_Dim] ([Subdepartment_Group_Dim_ID])

GO
ALTER TABLE [dbo].[Subdepartment_Dim] ADD CONSTRAINT [Subdepartment_Dim_PK] PRIMARY KEY CLUSTERED  ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_Dept_SubDept_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Code], [Subdepartment_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_Div_Dept_Subdept_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Code], [Subdepartment_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_Subdept_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Code], [Subdepartment_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_SubdeptName_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Name]) ON [PRIMARY]
GO

GRANT SELECT ON  [dbo].[Subdepartment_Dim] TO [DUNE\IISBISWEB]
GRANT UPDATE ON  [dbo].[Subdepartment_Dim] TO [DUNE\IISBISWEB]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The third level in the Merchandising hierarchy e.g. DA - Hats', 'SCHEMA', N'dbo', 'TABLE', N'Subdepartment_Dim', NULL, NULL
GO
