CREATE TABLE [dbo].[Store_Weather_Day_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Condition] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Store_Wea__Condi__3864608B] DEFAULT (''),
[Temperature] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Weather_Day_Fact] ADD CONSTRAINT [Store_Weather_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
