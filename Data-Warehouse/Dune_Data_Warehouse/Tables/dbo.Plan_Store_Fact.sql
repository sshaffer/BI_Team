CREATE TABLE [dbo].[Plan_Store_Fact]
(
[Fiscal_Year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Class_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Plan_Store_Sales_Qty] [int] NOT NULL,
[Plan_Store_Sales_Cost_Value] [money] NOT NULL,
[Plan_Store_Sales_Retail_Value] [money] NOT NULL,
[Plan_Store_Sales_Profit_Value] [money] NOT NULL,
[Calendar_Period_Dim_ID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Plan_Store_Fact] ADD CONSTRAINT [Plan_Store_PKv1] PRIMARY KEY CLUSTERED  ([Fiscal_Year], [Fiscal_Period], [Store_Dim_ID], [Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Period_Plan_StoreX] ON [dbo].[Plan_Store_Fact] ([Calendar_Period_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Plan_Store_Class_Dim_FKX] ON [dbo].[Plan_Store_Fact] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Plan_Store_Store_Dim_FKX] ON [dbo].[Plan_Store_Fact] ([Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Plan_Store_Fact] ADD CONSTRAINT [Calendar_Period_Plan_Store] FOREIGN KEY ([Calendar_Period_Dim_ID]) REFERENCES [dbo].[Calendar_Period_Dim] ([Calendar_Period_Dim_Id])
GO
ALTER TABLE [dbo].[Plan_Store_Fact] ADD CONSTRAINT [Plan_Store_Class_Dim_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) REFERENCES [dbo].[Class_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID])
GO
ALTER TABLE [dbo].[Plan_Store_Fact] ADD CONSTRAINT [Plan_Store_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
