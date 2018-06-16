CREATE TABLE [dbo].[Promotion_Dim]
(
[Promotion_Dim_ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Promotion_Event_Id] [char] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Promotion_Start_Date] [date] NOT NULL,
[Promotion_End_Date] [date] NOT NULL,
[Promotion Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Promotion_Dim] ADD CONSTRAINT [Promotion_PKv1] PRIMARY KEY CLUSTERED  ([Promotion_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Promotion_Dim_Promotion_Event_Id_UIX] ON [dbo].[Promotion_Dim] ([Promotion_Event_Id]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The description of the promotion', 'SCHEMA', N'dbo', 'TABLE', N'Promotion_Dim', 'COLUMN', N'Promotion Name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The end date of the promotion', 'SCHEMA', N'dbo', 'TABLE', N'Promotion_Dim', 'COLUMN', N'Promotion_End_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The code for the Promotion', 'SCHEMA', N'dbo', 'TABLE', N'Promotion_Dim', 'COLUMN', N'Promotion_Event_Id'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The start date for the promotion', 'SCHEMA', N'dbo', 'TABLE', N'Promotion_Dim', 'COLUMN', N'Promotion_Start_Date'
GO
