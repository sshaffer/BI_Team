CREATE TABLE [dbo].[Store_Weather_Day_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Condition] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Store_Weather_Day_Fact_Condition_DF] DEFAULT (''),
[Temperature] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Weather_Day_Fact] ADD CONSTRAINT [Store_Weather_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Weather_Day_Fact] ADD CONSTRAINT [Store_Weather_Day_Fact_Calendar_Dim_ID_FK] FOREIGN KEY ([Calendar_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Store_Weather_Day_Fact] ADD CONSTRAINT [Store_Weather_Day_Fact_Store_Dim_ID_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
