CREATE TABLE [dbo].[Class_Dim]
(
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Class_Dim_ID] [smallint] NOT NULL,
[Class_Code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Class_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Class_Dim] ADD CONSTRAINT [Class_Dim_PK] PRIMARY KEY CLUSTERED  ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Class_Dim_Class_IDX] ON [dbo].[Class_Dim] ([Class_Code], [Class_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Class_Dim_Dept_Subdept_Class_IDX] ON [dbo].[Class_Dim] ([Class_Code], [Class_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Class_Dim_Div_Dept_Subdept_Class_IDX] ON [dbo].[Class_Dim] ([Class_Code], [Class_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Class_Dim_Subdept_Class_IDX] ON [dbo].[Class_Dim] ([Class_Code], [Class_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Class_Dim_ClassName_IDX] ON [dbo].[Class_Dim] ([Class_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'A category grouping of items that sits in the merchandising hierarchy below divison/department/subdepartment e.g. Casual or Dressy under Dune Ladies Calf Boots.', 'SCHEMA', N'dbo', 'TABLE', N'Class_Dim', NULL, NULL
GO
