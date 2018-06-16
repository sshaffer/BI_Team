CREATE TABLE [dbo].[Forecast_Monitor_Fact]
(
[Fiscal_Year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Class_Dim_ID] [smallint] NOT NULL,
[Forecast_Sales_Quantity] [int] NOT NULL,
[Forecast_Sales_Cost_Value] [money] NOT NULL,
[Forecast_Sales_Selling_Value] [money] NOT NULL,
[Forecast_Stock_Quantity] [int] NOT NULL,
[Forecast_Stock_Cost_Value] [money] NOT NULL,
[Forecast_Stock_Selling_Value] [money] NOT NULL,
[Forecast_Intake_Quantity] [int] NOT NULL,
[Forecast_Intake_Cost_Value] [money] NOT NULL,
[Forecast_Intake_Selling_Value] [money] NOT NULL,
[Forecast_Gross_Profit_Value] [money] NOT NULL,
[Forecast_Flex_Commit_Quantity] [int] NOT NULL,
[Forecast_Flex_Commit_Cost_Value] [money] NOT NULL,
[Forecast_Flex_Commit_Selling_Value] [money] NOT NULL,
[Calendar_Period_Dim_Id] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Forecast_Monitor_Fact] ADD CONSTRAINT [Forecast_Monitor_PKv2] PRIMARY KEY CLUSTERED  ([Fiscal_Year], [Fiscal_Period], [Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Period_Forecast_MonitorX] ON [dbo].[Forecast_Monitor_Fact] ([Calendar_Period_Dim_Id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Forecast_Monitor_Class_Dim_FKX] ON [dbo].[Forecast_Monitor_Fact] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Forecast_Monitor_Fact] ADD CONSTRAINT [Calendar_Period_Forecast_Monitor] FOREIGN KEY ([Calendar_Period_Dim_Id]) REFERENCES [dbo].[Calendar_Period_Dim] ([Calendar_Period_Dim_Id])
GO
ALTER TABLE [dbo].[Forecast_Monitor_Fact] ADD CONSTRAINT [Forecast_Monitor_Class_Dim_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID]) REFERENCES [dbo].[Class_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID], [Class_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Flex Commitment cost value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Flex_Commit_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Flex Commitment Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Flex_Commit_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast  Flex Commitment selling value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Flex_Commit_Selling_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Gross Profit Value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Gross_Profit_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Intake cost value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Intake_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Intake Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Intake_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Intake selling value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Intake_Selling_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Sales cost value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Sales_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Sales Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Sales_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast  Sales selling value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Sales_Selling_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Stock cost value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Stock_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Stock Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Stock_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Forecast Sales selling value', 'SCHEMA', N'dbo', 'TABLE', N'Forecast_Monitor_Fact', 'COLUMN', N'Forecast_Stock_Selling_Value'
GO
