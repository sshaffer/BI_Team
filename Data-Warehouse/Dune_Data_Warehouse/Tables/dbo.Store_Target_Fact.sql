CREATE TABLE [dbo].[Store_Target_Fact]
(
[Target_Week_Dim_Id] [smallint] NOT NULL,
[Store_Dim_Id] [int] NOT NULL,
[Target_Value] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Target_Fact] ADD CONSTRAINT [Store_Target_Fact_PK] PRIMARY KEY CLUSTERED  ([Target_Week_Dim_Id], [Store_Dim_Id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Target_Fact_Store_Dim_FKX] ON [dbo].[Store_Target_Fact] ([Store_Dim_Id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Week_Store_TargetX] ON [dbo].[Store_Target_Fact] ([Target_Week_Dim_Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Target_Fact] ADD CONSTRAINT [Store_Target_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_Id]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Target_Fact] ADD CONSTRAINT [Calendar_Week_Store_Target_FK] FOREIGN KEY ([Target_Week_Dim_Id]) REFERENCES [dbo].[Calendar_Week_Dim] ([Calendar_Week_Dim_Id])
GO
