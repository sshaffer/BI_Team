CREATE TABLE [dbo].[Processing_Status]
(
[Process_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Completed] [bit] NOT NULL CONSTRAINT [Processing_Status_Completed_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Processing_Status] ADD CONSTRAINT [Processing_Status_PK] PRIMARY KEY CLUSTERED  ([Process_Name]) ON [PRIMARY]
GO
