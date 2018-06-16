CREATE TABLE [dbo].[Yahoo_Weather]
(
[Location] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Condition] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Temperature] [int] NOT NULL
) ON [PRIMARY]
GO
