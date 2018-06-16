CREATE TABLE [dbo].[International_Partner_Target_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[International_Partner_Dim_ID] [int] NOT NULL,
[Target_Value_Home] [money] NOT NULL,
[Target_Value_Curr] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Partner_Target_Fact] ADD CONSTRAINT [International_Partner_Target_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [International_Partner_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Partner_Target_Fact] ADD CONSTRAINT [International_Partner_Target_Fact_Calendar_Week_Dim] FOREIGN KEY ([Calendar_Week_Dim_ID]) REFERENCES [dbo].[Calendar_Week_Dim] ([Calendar_Week_Dim_Id])
GO
ALTER TABLE [dbo].[International_Partner_Target_Fact] ADD CONSTRAINT [International_Partner_Target_Fact_Partner] FOREIGN KEY ([International_Partner_Dim_ID]) REFERENCES [dbo].[International_Partner_Dim] ([International_Partner_Dim_ID])
GO
