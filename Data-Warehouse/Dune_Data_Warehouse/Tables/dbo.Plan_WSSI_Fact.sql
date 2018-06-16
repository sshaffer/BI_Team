CREATE TABLE [dbo].[Plan_WSSI_Fact]
(
[Fiscal_Year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Week] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Plan_WSSI_Sales_Quantity] [int] NOT NULL,
[Plan_WSSI_Sales_Cost_Value] [money] NOT NULL,
[Plan_WSSI_Sales_Selling_Value] [money] NOT NULL,
[Plan_WSSI_Stock_Quantity] [int] NOT NULL,
[Plan_WSSI_Stock_Cost_Value] [money] NOT NULL,
[Plan_WSSI_Stock_Selling_Value] [money] NOT NULL,
[Plan_WSSI_Intake_Quantity] [int] NOT NULL,
[Plan_WSSI_Intake_Cost_Value] [money] NOT NULL,
[Plan_WSSI_Intake_Selling_Value] [money] NOT NULL,
[Plan_WSSI_Gross_Profit_Value] [money] NOT NULL,
[Plan_WSSI_Flex_Commit_Quantity] [int] NOT NULL,
[Plan_WSSI_Flex_Commit_Cost_Value] [money] NOT NULL,
[Plan_WSSI_Flex_Commit_Selling_Value] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Plan_WSSI_Fact] ADD CONSTRAINT [Plan_WSSI_PKv1] PRIMARY KEY CLUSTERED  ([Fiscal_Year], [Fiscal_Week], [Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Plan_WSSI_Subdepartment_Dim_FKX] ON [dbo].[Plan_WSSI_Fact] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Week_Plan_WssiX] ON [dbo].[Plan_WSSI_Fact] ([Fiscal_Year], [Fiscal_Week]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Plan_WSSI_Fact] ADD CONSTRAINT [Plan_WSSI_Subdepartment_Dim_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID]) REFERENCES [dbo].[Subdepartment_Dim] ([Division_Dim_ID], [Department_Dim_ID], [Subdepartment_Dim_ID])
GO
ALTER TABLE [dbo].[Plan_WSSI_Fact] ADD CONSTRAINT [Calendar_Week_Plan_Wssi] FOREIGN KEY ([Fiscal_Year], [Fiscal_Week]) REFERENCES [dbo].[Calendar_Week_Dim] ([Fiscal_Year], [Fiscal_Week])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Flex Commitment cost value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Flex_Commit_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Flex Commitment Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Flex_Commit_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI  Flex Commitment selling value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Flex_Commit_Selling_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Gross Profit Value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Gross_Profit_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Intake cost value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Intake_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Intake Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Intake_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Intake selling value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Intake_Selling_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Sales cost value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Sales_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Sales Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Sales_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI  Sales selling value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Sales_Selling_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Stock cost value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Stock_Cost_Value'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned WSSI Stock Quantity', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Stock_Quantity'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Planned Sales selling value', 'SCHEMA', N'dbo', 'TABLE', N'Plan_WSSI_Fact', 'COLUMN', N'Plan_WSSI_Stock_Selling_Value'
GO
