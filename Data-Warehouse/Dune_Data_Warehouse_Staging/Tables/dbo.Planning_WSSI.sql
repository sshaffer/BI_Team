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
[Measure_Value_Home] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planning_WSSI] ADD CONSTRAINT [Planning_WSSI_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Planning_Plan_Dim_ID], [Planning_Measure_Dim_ID], [Subdepartment_Dim_ID], [Territory_Dim_ID]) ON [PRIMARY]
GO
