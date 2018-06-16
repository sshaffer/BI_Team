CREATE TABLE [dbo].[Store_Targets_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Target_Value_Home] [money] NOT NULL CONSTRAINT [Target_Value_Home_DF] DEFAULT ((0)),
[Target_Value_Curr] [money] NOT NULL CONSTRAINT [Target_Value_Curr_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Targets_Week_Fact] ADD CONSTRAINT [Store_Targets_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
