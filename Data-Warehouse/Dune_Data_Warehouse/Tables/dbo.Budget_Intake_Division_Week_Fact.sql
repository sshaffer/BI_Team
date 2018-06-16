CREATE TABLE [dbo].[Budget_Intake_Division_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Budget_Intake] [decimal] (7, 3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Budget_Intake_Division_Week_Fact] ADD CONSTRAINT [Budget_Intake_Division_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Division_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Budget_Intake_Division_Week_Fact] ADD CONSTRAINT [Budget_Intake_Division_Week_Fact_Week_FK] FOREIGN KEY ([Calendar_Week_Dim_ID]) REFERENCES [dbo].[Calendar_Week_Dim] ([Calendar_Week_Dim_Id])
GO
ALTER TABLE [dbo].[Budget_Intake_Division_Week_Fact] ADD CONSTRAINT [Budget_Intake_Division_Week_Fact_Division_FK] FOREIGN KEY ([Division_Dim_ID]) REFERENCES [dbo].[Division_Dim] ([Division_Dim_ID])
GO
