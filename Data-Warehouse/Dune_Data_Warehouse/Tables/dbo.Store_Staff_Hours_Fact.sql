CREATE TABLE [dbo].[Store_Staff_Hours_Fact]
(
[Staff_Hours_Date_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[No_of_Hours] [int] NOT NULL,
[Cost_Value] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Staff_Hours_Fact] ADD CONSTRAINT [Store_Staff_Hours_Fact_PK] PRIMARY KEY CLUSTERED  ([Staff_Hours_Date_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Store_Staff_Hours_Fact_FKX] ON [dbo].[Store_Staff_Hours_Fact] ([Staff_Hours_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_Staff_Hours_Fact_Store_Dim_FKX] ON [dbo].[Store_Staff_Hours_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Staff_Hours_Fact] ADD CONSTRAINT [Calendar_Day_Store_Staff_Hours_Fact_FK] FOREIGN KEY ([Staff_Hours_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Store_Staff_Hours_Fact] ADD CONSTRAINT [Store_Staff_Hours_Fact_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'The cost to the company (including Employers NI)', 'SCHEMA', N'dbo', 'TABLE', N'Store_Staff_Hours_Fact', 'COLUMN', N'Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'No of hours worked in store', 'SCHEMA', N'dbo', 'TABLE', N'Store_Staff_Hours_Fact', 'COLUMN', N'No_of_Hours'
GO
