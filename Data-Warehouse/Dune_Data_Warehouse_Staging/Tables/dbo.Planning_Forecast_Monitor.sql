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
