CREATE TABLE [dbo].[Planning_Forecast_Monitor]
(
[Calendar_Period_Dim_ID] [smallint] NOT NULL,
[Planning_Plan_Dim_ID] [int] NOT NULL,
[Planning_Measure_Dim_ID] [int] NOT NULL,
[Class_Dim_ID] [smallint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Territory_Dim_ID] [tinyint] NOT NULL,
[Zone_Dim_ID] [tinyint] NOT NULL,
[Measure_Value_Home] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forcast_Monitor_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Period_Dim_ID], [Planning_Plan_Dim_ID], [Planning_Measure_Dim_ID], [Class_Dim_ID], [Subdepartment_Dim_ID], [Department_Dim_ID], [Division_Dim_ID], [Territory_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Cal_FK] FOREIGN KEY ([Calendar_Period_Dim_ID]) REFERENCES [dbo].[Calendar_Period_Dim] ([Calendar_Period_Dim_Id])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Division_FK] FOREIGN KEY ([Division_Dim_ID]) REFERENCES [dbo].[Division_Dim] ([Division_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Department_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID]) REFERENCES [dbo].[Department_Dim] ([Division_Dim_ID], [Department_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Subdepartment_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) REFERENCES [dbo].[Subdepartment_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Class_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) REFERENCES [dbo].[Class_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Measure_FK] FOREIGN KEY ([Planning_Measure_Dim_ID]) REFERENCES [dbo].[Planning_Measure_Dim] ([Planning_Measure_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Plan_FK] FOREIGN KEY ([Planning_Plan_Dim_ID]) REFERENCES [dbo].[Planning_Plan_Dim] ([Planning_Plan_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Territory_FK] FOREIGN KEY ([Territory_Dim_ID], [Zone_Dim_ID]) REFERENCES [dbo].[Territory_Dim] ([Territory_Dim_ID], [Zone_Dim_ID])
GO
ALTER TABLE [dbo].[Planning_Forecast_Monitor] ADD CONSTRAINT [Planning_Forecast_Monitor_Zone_FK] FOREIGN KEY ([Zone_Dim_ID]) REFERENCES [dbo].[Zone_Dim] ([Zone_Dim_ID])
GO
