CREATE TABLE [dbo].[Last_Load_Id]
(
[Last_Load_Id] [bigint] NOT NULL,
[Load_Date] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Last_Load_Id] ADD CONSTRAINT [Last_Load_Id_PK] PRIMARY KEY CLUSTERED  ([Last_Load_Id]) ON [PRIMARY]
GO
