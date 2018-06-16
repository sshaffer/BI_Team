CREATE TABLE [dbo].[Planning_Measure_Dim]
(
[Planning_Measure_Dim_ID] [int] NOT NULL,
[Planning_Plan_Dim_ID] [int] NOT NULL,
[Measure_Code] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Measure_Name] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planning_Measure_Dim] ADD CONSTRAINT [Planning_Measure_Dim_PK] PRIMARY KEY CLUSTERED  ([Planning_Measure_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Planning_Measure_Dim_Plan_Measure_Code_UIX] ON [dbo].[Planning_Measure_Dim] ([Planning_Plan_Dim_ID], [Measure_Code]) ON [PRIMARY]
GO
