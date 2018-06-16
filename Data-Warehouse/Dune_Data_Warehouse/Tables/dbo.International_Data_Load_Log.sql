CREATE TABLE [dbo].[International_Data_Load_Log]
(
[International_Data_Load_Log_ID] [bigint] NOT NULL IDENTITY(-2147483648, 1),
[Processed_Date] [date] NOT NULL CONSTRAINT [International_Data_Load_Log_Proc_Date_DF] DEFAULT (getdate()),
[Partner_Name] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [International_Data_Load_Log_Partner_Name_DF] DEFAULT (''),
[Store_Code] [char] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [International_Data_Load_Log_Store_Code_DF] DEFAULT (''),
[File_Name] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Error_Message] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Processed_Today] [bit] NOT NULL CONSTRAINT [International_Data_Load_Log_Proc_Today_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[International_Data_Load_Log] TO [DUNE\IISBISWEB]
GO
