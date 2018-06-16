CREATE TABLE [dbo].[Cancellation_Reason_Code_Dim]
(
[Cancellation_Reason_Code_Dim_ID] [tinyint] NOT NULL,
[Cancellation_Reason_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Cancellation_Reason_Desc] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cancellation_Reason_Code_Dim] ADD CONSTRAINT [Cancellation_Reason_Code_Dim_PK] PRIMARY KEY CLUSTERED  ([Cancellation_Reason_Code_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Cancellation_Reason_Code_Dim_Cancellation_Reason_Code_UIX] ON [dbo].[Cancellation_Reason_Code_Dim] ([Cancellation_Reason_Code]) ON [PRIMARY]
GO
