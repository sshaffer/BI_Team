CREATE TABLE [dbo].[Planning_WSSI]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Planning_Plan_Dim_ID] [int] NOT NULL,
[Planning_Measure_Dim_ID] [int] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Territory_Dim_ID] [tinyint] NOT NULL,
[Zone_Dim_ID] [tinyint] NOT NULL,
[Measure_Value_Home] [numeric] (19, 7) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Planning_Plan_Dim_ID], [Planning_Measure_Dim_ID], [Subdepartment_Dim_ID], [Territory_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_Week_FK] FOREIGN KEY ([Calendar_Week_Dim_ID]) REFERENCES [dbo].[Calendar_Week_Dim] ([Calendar_Week_Dim_Id])
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_Division_FK] FOREIGN KEY ([Division_Dim_ID]) REFERENCES [dbo].[Division_Dim] ([Division_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_Department_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID]) REFERENCES [dbo].[Department_Dim] ([Division_Dim_ID], [Department_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_Subdepartment_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) REFERENCES [dbo].[Subdepartment_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_Measure_FK] FOREIGN KEY ([Planning_Measure_Dim_ID]) REFERENCES [dbo].[Planning_Measure_Dim] ([Planning_Measure_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_Plan_FK] FOREIGN KEY ([Planning_Plan_Dim_ID]) REFERENCES [dbo].[Planning_Plan_Dim] ([Planning_Plan_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_Territory_FK] FOREIGN KEY ([Territory_Dim_ID], [Zone_Dim_ID]) REFERENCES [dbo].[Territory_Dim] ([Territory_Dim_ID], [Zone_Dim_ID])
GO
