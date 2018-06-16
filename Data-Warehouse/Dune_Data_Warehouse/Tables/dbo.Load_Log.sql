CREATE TABLE [dbo].[Load_Log]
(
[Load_Log_Id] [bigint] NOT NULL IDENTITY(-9223372036854775808, 1),
[Source] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Load_Log_Source_DF] DEFAULT ('Unknown'),
[Table_Name] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Start_Time] [datetime] NOT NULL,
[End_Time] [datetime] NULL,
[Row_Count] [int] NOT NULL CONSTRAINT [Load_Log_Row_Count_DF] DEFAULT ((0)),
[Load_Id] [bigint] NOT NULL CONSTRAINT [Load_Log_Load_Id_DF] DEFAULT ((0)),
[Success] [bit] NOT NULL CONSTRAINT [Load_Log_Sucess_DF] DEFAULT ((0)),
[Cache] [bit] NOT NULL CONSTRAINT [Load_Log_Cache_DF] DEFAULT ((0)),
[Process] [bit] NOT NULL CONSTRAINT [Load_Log_Process_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Load_Log] ADD CONSTRAINT [Load_Log_PK] PRIMARY KEY CLUSTERED  ([Load_Log_Id]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Load_Log] TO [DUNE\IISBISWEB]
GO
