CREATE TABLE [dbo].[Transfer_Reason_Dim]
(
[Transfer_Reason_Dim_ID] [tinyint] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Transfer_Reason_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Transfer_Reason_Desc] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Transfer_Reason_Dim] ADD CONSTRAINT [Transfer_Reason_Dim_PK] PRIMARY KEY CLUSTERED  ([Transfer_Reason_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Transfer_Reason_Dim_Transfer_Reason_Code_UIX] ON [dbo].[Transfer_Reason_Dim] ([Transfer_Reason_Code]) ON [PRIMARY]
GO
