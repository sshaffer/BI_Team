CREATE TABLE [dbo].[Last_Reference_Id]
(
[Table_Name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Last_Reference_No] [bigint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Last_Reference_Id] ADD CONSTRAINT [Last_Reference_Id_PK] PRIMARY KEY CLUSTERED  ([Table_Name]) ON [PRIMARY]
GO
