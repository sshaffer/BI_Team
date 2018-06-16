CREATE TABLE [dbo].[Department_Dim]
(
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Department_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Department_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Department_Dim] ADD CONSTRAINT [Department_Dim_PK] PRIMARY KEY CLUSTERED  ([Department_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Department_Dim_Department_IDX] ON [dbo].[Department_Dim] ([Department_Code], [Department_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Department_Dim_Division_Department_IDX] ON [dbo].[Department_Dim] ([Department_Code], [Department_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Department_Dim_DeptName_IDX] ON [dbo].[Department_Dim] ([Department_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second level of the merchandising hierarchy e.g. Dune Ladies.', 'SCHEMA', N'dbo', 'TABLE', N'Department_Dim', NULL, NULL
GO
