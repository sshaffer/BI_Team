CREATE TABLE [dbo].[Division_Dim]
(
[Division_Dim_ID] [tinyint] NOT NULL,
[Division_Code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Division_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Division_Dim] ADD CONSTRAINT [Division_Dim_PK] PRIMARY KEY CLUSTERED  ([Division_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Division_Dim__IDX] ON [dbo].[Division_Dim] ([Division_Code], [Division_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Division_Dim_DivName_IDX] ON [dbo].[Division_Dim] ([Division_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Part of the merchandising hierarchy e.g. Ladies', 'SCHEMA', N'dbo', 'TABLE', N'Division_Dim', NULL, NULL
GO
