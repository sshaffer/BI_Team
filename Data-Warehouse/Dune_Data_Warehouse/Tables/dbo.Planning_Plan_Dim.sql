CREATE TABLE [dbo].[Planning_Plan_Dim]
(
[Planning_Plan_Dim_ID] [int] NOT NULL,
[Plan_Code] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Plan_Name] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Plan_Template_Code] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Plan_Template_Name] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Plan_Bottom_Level] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planning_Plan_Dim] ADD CONSTRAINT [Planning_Plan_PK] PRIMARY KEY CLUSTERED  ([Planning_Plan_Dim_ID]) ON [PRIMARY]
GO
