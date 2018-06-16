CREATE TABLE [dbo].[Time_Dim]
(
[Time_Dim_ID] [smallint] NOT NULL,
[Time] [time] (0) NOT NULL,
[Quarterly_Slot] [time] (0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Time_Dim] ADD CONSTRAINT [Time_Dim_PK] PRIMARY KEY CLUSTERED  ([Time_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Time_Dim_Time_UIX] ON [dbo].[Time_Dim] ([Time]) ON [PRIMARY]
GO
