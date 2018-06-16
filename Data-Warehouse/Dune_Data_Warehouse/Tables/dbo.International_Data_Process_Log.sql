CREATE TABLE [dbo].[International_Data_Process_Log]
(
[International_Data_Process_Log_ID] [bigint] NOT NULL IDENTITY(-9223372036854775808, 1),
[Processed_Date] [datetime2] (0) NOT NULL CONSTRAINT [International_Data_Process_Log_Proc_Date_DF] DEFAULT (getdate()),
[File_Name] [varchar] (8000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Status] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [International_Data_Process_Log_Status_DF] DEFAULT ('Processing')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Data_Process_Log] ADD CONSTRAINT [International_Data_Process_Log_Status_Values] CHECK (([Status]='Success' OR [Status]='Failed' OR [Status]='Processing'))
GO
GRANT SELECT ON  [dbo].[International_Data_Process_Log] TO [DUNE\IISBISWEB]
GO
