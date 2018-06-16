CREATE TABLE [dbo].[Channel_Dim]
(
[Channel_Dim_ID] [tinyint] NOT NULL,
[Channel_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Channel_Name] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Dim_ID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Channel_Dim] ADD CONSTRAINT [Channel_Dim_PK] PRIMARY KEY CLUSTERED  ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Channel_Dim_Channel_Code_UIX] ON [dbo].[Channel_Dim] ([Channel_Code]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Channel_Dim_Code_Name_IDX] ON [dbo].[Channel_Dim] ([Channel_Code], [Channel_Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Channel_Dim_Name_IDX] ON [dbo].[Channel_Dim] ([Channel_Name]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies where the sale and/or order was made e.g. Wholesale, Web.', 'SCHEMA', N'dbo', 'TABLE', N'Channel_Dim', NULL, NULL
GO
