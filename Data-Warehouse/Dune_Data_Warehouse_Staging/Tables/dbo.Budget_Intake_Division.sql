CREATE TABLE [dbo].[Budget_Intake_Division]
(
[Division_Code] [tinyint] NOT NULL,
[Division_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Budget_Intake_Division_Name_DF] DEFAULT (''),
[Season] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Budget_Intake] [decimal] (7, 3) NOT NULL
) ON [PRIMARY]
GO
