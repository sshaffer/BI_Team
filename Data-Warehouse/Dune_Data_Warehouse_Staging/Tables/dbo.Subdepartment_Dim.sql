CREATE TABLE [dbo].[Subdepartment_Dim]
(
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Subdepartment_Code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subdepartment_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Subdepartment_Dim] ADD CONSTRAINT [Subdepartment_Dim_PK] PRIMARY KEY CLUSTERED  ([Subdepartment_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_Dept_SubDept_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Code], [Subdepartment_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_Div_Dept_Subdept_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Code], [Subdepartment_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_Subdept_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Code], [Subdepartment_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Subdepartment_Dim_SubdeptName_IDX] ON [dbo].[Subdepartment_Dim] ([Subdepartment_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The third level in the Merchandising hierarchy e.g. DA - Hats', 'SCHEMA', N'dbo', 'TABLE', N'Subdepartment_Dim', NULL, NULL
GO
