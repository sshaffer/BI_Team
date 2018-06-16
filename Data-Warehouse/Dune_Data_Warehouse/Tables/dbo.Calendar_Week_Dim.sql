CREATE TABLE [dbo].[Calendar_Week_Dim]
(
[Calendar_Week_Dim_Id] [smallint] NOT NULL,
[Fiscal_Week] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Previous_Fiscal_Week] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Fiscal_Week] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period_Beginning_Date] [date] NOT NULL,
[Fiscal_Period_Ending_Date] [date] NOT NULL,
[Previous_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Week_in_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Previous_Week_in_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Week_in_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period_Name] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Previous_Fiscal_Year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Fiscal_Year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Quarter] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Previous_Fiscal_Quarter] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Fiscal_Quarter] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Half_Year] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Previous_Fiscal_Half_Year] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Fiscal_Half_Year] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Week_Beginning_Date] [date] NOT NULL,
[Fiscal_Week_Ending_Date] [date] NOT NULL,
[Week_53_Indicator] [bit] NOT NULL,
[Current_Week] [smallint] NOT NULL,
[Current_Year] [smallint] NOT NULL,
[Current_Period] [smallint] NOT NULL,
[Current_Quarter] [smallint] NOT NULL,
[Relative_Week] [smallint] NOT NULL
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Fiscal_Half_Year_CK] CHECK (([Fiscal_Half_Year]='2' OR [Fiscal_Half_Year]='1' OR [Fiscal_Half_Year]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Fiscal_Period_CK] CHECK (([Fiscal_Period]='12' OR [Fiscal_Period]='11' OR [Fiscal_Period]='10' OR [Fiscal_Period]='09' OR [Fiscal_Period]='08' OR [Fiscal_Period]='07' OR [Fiscal_Period]='06' OR [Fiscal_Period]='05' OR [Fiscal_Period]='04' OR [Fiscal_Period]='03' OR [Fiscal_Period]='02' OR [Fiscal_Period]='01' OR [Fiscal_Period]='00'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Fiscal_Quarter_CK] CHECK (([Fiscal_Quarter]='4' OR [Fiscal_Quarter]='3' OR [Fiscal_Quarter]='2' OR [Fiscal_Quarter]='1' OR [Fiscal_Quarter]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Fiscal_Week_CK] CHECK (([Fiscal_Week]>=(0) AND [Fiscal_Week]<=(53)))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Next_Fiscal_Half_Year_CK] CHECK (([Next_Fiscal_Half_Year]='2' OR [Next_Fiscal_Half_Year]='1' OR [Next_Fiscal_Half_Year]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Next_Fiscal_Period_CK] CHECK (([Next_Fiscal_Period]='12' OR [Next_Fiscal_Period]='11' OR [Next_Fiscal_Period]='10' OR [Next_Fiscal_Period]='09' OR [Next_Fiscal_Period]='08' OR [Next_Fiscal_Period]='07' OR [Next_Fiscal_Period]='06' OR [Next_Fiscal_Period]='05' OR [Next_Fiscal_Period]='04' OR [Next_Fiscal_Period]='03' OR [Next_Fiscal_Period]='02' OR [Next_Fiscal_Period]='01' OR [Next_Fiscal_Period]='00'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Next_Fiscal_Quarter_CK] CHECK (([Next_Fiscal_Quarter]='4' OR [Next_Fiscal_Quarter]='3' OR [Next_Fiscal_Quarter]='2' OR [Next_Fiscal_Quarter]='1' OR [Next_Fiscal_Quarter]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Next_Fiscal_Week_CK] CHECK (([Next_Fiscal_Week]>=(0) AND [Next_Fiscal_Week]<=(53)))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Next_Week_in_Fiscal_Period_CK] CHECK (([Next_Week_in_Fiscal_Period]='5' OR [Next_Week_in_Fiscal_Period]='4' OR [Next_Week_in_Fiscal_Period]='3' OR [Next_Week_in_Fiscal_Period]='2' OR [Next_Week_in_Fiscal_Period]='1' OR [Next_Week_in_Fiscal_Period]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Previous_Fiscal_Half_Year_CK] CHECK (([Previous_Fiscal_Half_Year]='2' OR [Previous_Fiscal_Half_Year]='1' OR [Previous_Fiscal_Half_Year]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Previous_Fiscal_Period_CK] CHECK (([Previous_Fiscal_Period]='12' OR [Previous_Fiscal_Period]='11' OR [Previous_Fiscal_Period]='10' OR [Previous_Fiscal_Period]='09' OR [Previous_Fiscal_Period]='08' OR [Previous_Fiscal_Period]='07' OR [Previous_Fiscal_Period]='06' OR [Previous_Fiscal_Period]='05' OR [Previous_Fiscal_Period]='04' OR [Previous_Fiscal_Period]='03' OR [Previous_Fiscal_Period]='02' OR [Previous_Fiscal_Period]='01' OR [Previous_Fiscal_Period]='00'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Previous_Fiscal_Quarter_CK] CHECK (([Previous_Fiscal_Quarter]='4' OR [Previous_Fiscal_Quarter]='3' OR [Previous_Fiscal_Quarter]='2' OR [Previous_Fiscal_Quarter]='1' OR [Previous_Fiscal_Quarter]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Previous_Fiscal_Week_CK] CHECK (([Previous_Fiscal_Week]>=(0) AND [Previous_Fiscal_Week]<=(53)))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Previous_Week_in_Fiscal_Period_CK] CHECK (([Previous_Week_in_Fiscal_Period]='5' OR [Previous_Week_in_Fiscal_Period]='4' OR [Previous_Week_in_Fiscal_Period]='3' OR [Previous_Week_in_Fiscal_Period]='2' OR [Previous_Week_in_Fiscal_Period]='1' OR [Previous_Week_in_Fiscal_Period]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Week_Dim_Week_in_Fiscal_Period_CK] CHECK (([Week_in_Fiscal_Period]='5' OR [Week_in_Fiscal_Period]='4' OR [Week_in_Fiscal_Period]='3' OR [Week_in_Fiscal_Period]='2' OR [Week_in_Fiscal_Period]='1' OR [Week_in_Fiscal_Period]='0'))
GO
ALTER TABLE [dbo].[Calendar_Week_Dim] ADD CONSTRAINT [Calendar_Week_Dim_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_Id]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Calendar_Week_Dim_Fiscal_Year_Fiscal_Week_UIX] ON [dbo].[Calendar_Week_Dim] ([Fiscal_Year], [Fiscal_Week]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Fiscal Half Year for the Calendar Date e.g. 1, 2.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Half_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Period number for the Calendar Date in the Fiscal Year e.g. 10.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Calendar Date at the bigging of the Fiscal Period', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Period_Beginning_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Calendar Date at the end of the fiscal period', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Period_Ending_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Period Name for the Fiscal Period e.g. January 13.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Period_Name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Fiscal Quarter that the Calendar Date is in e.g. 1, 2, 3, 4.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Quarter'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The week no for the Calendar Date in the Fiscal Year e.g. 15.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date the Fiscal Week begins.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Week_Beginning_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date the Fiscal Week ends.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Week_Ending_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Fiscal Year that the Calendar Date is in e.g. 2014.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Fiscal_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Half Year for the Calendar Date e.g. 1, 2.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Next_Fiscal_Half_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Period number for the Calendar Date in the Fiscal Year e.g. 11.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Next_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Quarter for the Calendar Date e.g. 1, 2, 3, 4.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Next_Fiscal_Quarter'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Week for the Calendar Date in the Fiscal Year e.g. 16.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Next_Fiscal_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Year that the Calendar Date is in e.g. 2015.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Next_Fiscal_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Next Week in Fiscal Period e.g. 1, 2, 3.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Next_Week_in_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Half Year for the Calendar Date e.g. 1, 2.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Previous_Fiscal_Half_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Period number for the Calendar Date in the Fiscal Year e.g. 9.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Previous_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Quarter for the Calendar Date e.g. 1, 2, 3, 4.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Previous_Fiscal_Quarter'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Week for the Calendar Date in the Fiscal Year e.g. 14.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Previous_Fiscal_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Year that the Calendar Date is in e.g. 2013.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Previous_Fiscal_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Previous Week in Fiscal Period e.g. 1, 2, 3.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Previous_Week_in_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this Calendar Date occurs in Fiscal Week 53.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Week_53_Indicator'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Week in Fiscal Period e.g. 1, 2, 3.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Week_Dim', 'COLUMN', N'Week_in_Fiscal_Period'
GO
