CREATE TABLE [dbo].[Calendar_Dim]
(
[Calendar_Dim_Id] [smallint] NOT NULL,
[Calendar_Date] [date] NOT NULL,
[Full_Date_Description] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Calendar_Dim_Desc_DF] DEFAULT (''),
[Fiscal_Day] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Week] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Previous_Fiscal_Week] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Fiscal_Week] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period_Beginning_Date] [date] NOT NULL,
[Fiscal_Period_Ending_Date] [date] NOT NULL,
[Fiscal_Last_Day_in_Period_Indicator] [bit] NOT NULL,
[Fiscal_First_Day_in_Period_Indicator] [bit] NOT NULL,
[Previous_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Day_in_Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
[Fiscal_Last_Day_in_Week_Indicator] [bit] NOT NULL,
[Fiscal_First_Day_in_Week_Indicator] [bit] NOT NULL,
[Merchandise_Season] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Previous_Merchandise_Season] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Next_Merchandise_Season] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Day_of_Week_Number] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Short_Day_of_Week] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Day_of_Week] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Day_of_Year] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Month_Number] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Month_Short_Name] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Month_Name] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Calendar_Last_Day_in_Week_Indicator] [bit] NOT NULL,
[Calendar_Last_Day_in_Month_Indicator] [bit] NOT NULL,
[Weekday_Indicator] [bit] NOT NULL,
[Holiday_Indicator] [bit] NOT NULL,
[Holiday_Description] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Calednar_Dim_Hol_Desc_DF] DEFAULT (''),
[Major_Event_Indicator] [bit] NOT NULL,
[Major_Event_Description] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Calendar_Dim_Maj_Evt_DF] DEFAULT (''),
[Week_53_Indicator] [bit] NOT NULL,
[Current_Date_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Calendar_Dim_Current_Date_Flag_DF] DEFAULT ('F'),
[Relative_Day] [int] NOT NULL CONSTRAINT [Calendar_Dim_Relative_Day_DF] DEFAULT ((0)),
[Current_Day] [smallint] NOT NULL CONSTRAINT [Calendar_Dim_Current_Day_DF] DEFAULT ((0)),
[Current_Week] [smallint] NOT NULL CONSTRAINT [Calendar_Dim_Current_Week_DF] DEFAULT ((0)),
[Current_Year] [smallint] NOT NULL CONSTRAINT [Calendar_Dim_Current_Year_DF] DEFAULT ((0)),
[Current_Period] [smallint] NOT NULL CONSTRAINT [Calendar_Dim_Current_Period_DF] DEFAULT ((0)),
[Current_Quarter] [smallint] NOT NULL CONSTRAINT [Calendar_Dim_Current_Quarter_DF] DEFAULT ((0)),
[Current_Season] [smallint] NOT NULL CONSTRAINT [Calendar_Dim_Current_Season_DF] DEFAULT ((0))
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Calendar_Day_of_Week_Number_CK] CHECK (([Calendar_Day_of_Week_Number]>=(0) AND [Calendar_Day_of_Week_Number]<=(7)))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Calendar_Day_of_Year_CK] CHECK (([Calendar_Day_of_Year]>=(0) AND [Calendar_Day_of_Year]<=(366)))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Calendar_Month_Name_CK] CHECK (([Calendar_Month_Name]='Unknown' OR [Calendar_Month_Name]='December' OR [Calendar_Month_Name]='November' OR [Calendar_Month_Name]='October' OR [Calendar_Month_Name]='September' OR [Calendar_Month_Name]='August' OR [Calendar_Month_Name]='July' OR [Calendar_Month_Name]='June' OR [Calendar_Month_Name]='May' OR [Calendar_Month_Name]='April' OR [Calendar_Month_Name]='March' OR [Calendar_Month_Name]='February' OR [Calendar_Month_Name]='January'))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Calendar_Month_Number_CK] CHECK (([Calendar_Month_Number]='0' OR [Calendar_Month_Number]='12' OR [Calendar_Month_Number]='11' OR [Calendar_Month_Number]='10' OR [Calendar_Month_Number]='9' OR [Calendar_Month_Number]='8' OR [Calendar_Month_Number]='7' OR [Calendar_Month_Number]='6' OR [Calendar_Month_Number]='5' OR [Calendar_Month_Number]='4' OR [Calendar_Month_Number]='3' OR [Calendar_Month_Number]='2' OR [Calendar_Month_Number]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Calendar_Month_Short_Name_CK] CHECK (([Calendar_Month_Short_Name]='NA' OR [Calendar_Month_Short_Name]='Dec' OR [Calendar_Month_Short_Name]='Nov' OR [Calendar_Month_Short_Name]='Oct' OR [Calendar_Month_Short_Name]='Sep' OR [Calendar_Month_Short_Name]='Aug' OR [Calendar_Month_Short_Name]='Jul' OR [Calendar_Month_Short_Name]='Jun' OR [Calendar_Month_Short_Name]='May' OR [Calendar_Month_Short_Name]='Apr' OR [Calendar_Month_Short_Name]='Mar' OR [Calendar_Month_Short_Name]='Feb' OR [Calendar_Month_Short_Name]='Jan'))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Calendar_Short_Day_of_Week_CK] CHECK (([Calendar_Short_Day_of_Week]='NA' OR [Calendar_Short_Day_of_Week]='Sun' OR [Calendar_Short_Day_of_Week]='Sat' OR [Calendar_Short_Day_of_Week]='Fri' OR [Calendar_Short_Day_of_Week]='Thu' OR [Calendar_Short_Day_of_Week]='Wed' OR [Calendar_Short_Day_of_Week]='Tue' OR [Calendar_Short_Day_of_Week]='Mon'))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Current_Date_Flag_CK] CHECK (([Current_Date_Flag]='H' OR [Current_Date_Flag]='F' OR [Current_Date_Flag]='C'))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Day_in_Fiscal_Period_CK] CHECK (([Day_in_Fiscal_Period]>=(0) AND [Day_in_Fiscal_Period]<=(35)))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Day_of_Week_CK] CHECK (([Calendar_Day_of_Week]='Unknown' OR [Calendar_Day_of_Week]='Sunday' OR [Calendar_Day_of_Week]='Saturday' OR [Calendar_Day_of_Week]='Friday' OR [Calendar_Day_of_Week]='Thursday' OR [Calendar_Day_of_Week]='Wednesday' OR [Calendar_Day_of_Week]='Tuesday' OR [Calendar_Day_of_Week]='Monday'))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Fiscal_Day_CK] CHECK (([Fiscal_Day]>=(0) AND [Fiscal_Day]<=(371)))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_Fiscal_Half_Year_CK] CHECK (([Fiscal_Half_Year]='0' OR [Fiscal_Half_Year]='2' OR [Fiscal_Half_Year]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Fiscal_Period_CK] CHECK (([Fiscal_Period]='00' OR [Fiscal_Period]='12' OR [Fiscal_Period]='11' OR [Fiscal_Period]='10' OR [Fiscal_Period]='09' OR [Fiscal_Period]='08' OR [Fiscal_Period]='07' OR [Fiscal_Period]='06' OR [Fiscal_Period]='05' OR [Fiscal_Period]='04' OR [Fiscal_Period]='03' OR [Fiscal_Period]='02' OR [Fiscal_Period]='01'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Fiscal_Quarter_CK] CHECK (([Fiscal_Quarter]='0' OR [Fiscal_Quarter]='4' OR [Fiscal_Quarter]='3' OR [Fiscal_Quarter]='2' OR [Fiscal_Quarter]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Fiscal_Week_CK] CHECK (([Fiscal_Week]>=(0) AND [Fiscal_Week]<=(53)))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Next_Fiscal_Half_Year_CK] CHECK (([Next_Fiscal_Half_Year]='0' OR [Next_Fiscal_Half_Year]='2' OR [Next_Fiscal_Half_Year]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Next_Fiscal_Period_CK] CHECK (([Next_Fiscal_Period]='00' OR [Next_Fiscal_Period]='12' OR [Next_Fiscal_Period]='11' OR [Next_Fiscal_Period]='10' OR [Next_Fiscal_Period]='09' OR [Next_Fiscal_Period]='08' OR [Next_Fiscal_Period]='07' OR [Next_Fiscal_Period]='06' OR [Next_Fiscal_Period]='05' OR [Next_Fiscal_Period]='04' OR [Next_Fiscal_Period]='03' OR [Next_Fiscal_Period]='02' OR [Next_Fiscal_Period]='01'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Next_Fiscal_Quarter_CK] CHECK (([Next_Fiscal_Quarter]='0' OR [Next_Fiscal_Quarter]='4' OR [Next_Fiscal_Quarter]='3' OR [Next_Fiscal_Quarter]='2' OR [Next_Fiscal_Quarter]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Next_Fiscal_Week_CK] CHECK (([Next_Fiscal_Week]>=(0) AND [Next_Fiscal_Week]<=(53)))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Next_Week_in_Fiscal_Period_CK] CHECK (([Next_Week_in_Fiscal_Period]='0' OR [Next_Week_in_Fiscal_Period]='5' OR [Next_Week_in_Fiscal_Period]='4' OR [Next_Week_in_Fiscal_Period]='3' OR [Next_Week_in_Fiscal_Period]='2' OR [Next_Week_in_Fiscal_Period]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Previous_Fiscal_Half_Year_CK] CHECK (([Previous_Fiscal_Half_Year]='0' OR [Previous_Fiscal_Half_Year]='2' OR [Previous_Fiscal_Half_Year]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Previous_Fiscal_Period_CK] CHECK (([Previous_Fiscal_Period]='00' OR [Previous_Fiscal_Period]='12' OR [Previous_Fiscal_Period]='11' OR [Previous_Fiscal_Period]='10' OR [Previous_Fiscal_Period]='09' OR [Previous_Fiscal_Period]='08' OR [Previous_Fiscal_Period]='07' OR [Previous_Fiscal_Period]='06' OR [Previous_Fiscal_Period]='05' OR [Previous_Fiscal_Period]='04' OR [Previous_Fiscal_Period]='03' OR [Previous_Fiscal_Period]='02' OR [Previous_Fiscal_Period]='01'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Previous_Fiscal_Quarter_CK] CHECK (([Previous_Fiscal_Quarter]='0' OR [Previous_Fiscal_Quarter]='4' OR [Previous_Fiscal_Quarter]='3' OR [Previous_Fiscal_Quarter]='2' OR [Previous_Fiscal_Quarter]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Previous_Fiscal_Week_CK] CHECK (([Previous_Fiscal_Week]>=(0) AND [Previous_Fiscal_Week]<=(53)))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Previous_Week_in_Fiscal_Period_CK] CHECK (([Previous_Week_in_Fiscal_Period]='0' OR [Previous_Week_in_Fiscal_Period]='5' OR [Previous_Week_in_Fiscal_Period]='4' OR [Previous_Week_in_Fiscal_Period]='3' OR [Previous_Week_in_Fiscal_Period]='2' OR [Previous_Week_in_Fiscal_Period]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] WITH NOCHECK ADD CONSTRAINT [Calendar_Dim_Week_in_Fiscal_Period_CK] CHECK (([Week_in_Fiscal_Period]='0' OR [Week_in_Fiscal_Period]='5' OR [Week_in_Fiscal_Period]='4' OR [Week_in_Fiscal_Period]='3' OR [Week_in_Fiscal_Period]='2' OR [Week_in_Fiscal_Period]='1'))
GO
ALTER TABLE [dbo].[Calendar_Dim] ADD CONSTRAINT [Calendar_Dim_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_Id]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Calendar_Dim_Calendar_Date_UIX] ON [dbo].[Calendar_Dim] ([Calendar_Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Dim_Relative_Day] ON [dbo].[Calendar_Dim] ([Relative_Day]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date in the calendar.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Long name for the Day of Week e.g. Sunday, Monday.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Day_of_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of the Day of Week where Sun = 1.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Day_of_Week_Number'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The day number of the Calendar Date in the Calendar Year e.g. 365.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Day_of_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this is the Last Day in Month.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Last_Day_in_Month_Indicator'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this is the Last Day in Week.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Last_Day_in_Week_Indicator'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the Calendar Month e.g. January.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Month_Name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of Calendar Month e.g. 3', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Month_Number'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Short name of Calendar Month e.g. Jan.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Month_Short_Name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Short name for the Day of Week e.g. Sun, Mon.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Calendar_Short_Day_of_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this Calendar Date is in the Current Date in the Data Warehouse (the last date the data warehouse was refreshed for), Historic or Future e.g. C = Current, H = Historic, F = Future.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Current_Date_Flag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of the day in the Fiscal Period', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Day_in_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Day no of the Calendar Date in the Fiscal Year e.g. 361.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Day'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Fiscal Half Year for the Calendar Date e.g. 1, 2.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Half_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Period number for the Calendar Date in the Fiscal Year e.g. 10.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Calendar Date at the bigging of the Fiscal Period', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Period_Beginning_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Calendar Date at the end of the fiscal period', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Period_Ending_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Period Name for the Fiscal Period e.g. January 13.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Period_Name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Fiscal Quarter that the Calendar Date is in e.g. 1, 2, 3, 4.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Quarter'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The week no for the Calendar Date in the Fiscal Year e.g. 15.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date the Fiscal Week begins.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Week_Beginning_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date the Fiscal Week ends.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Week_Ending_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Fiscal Year that the Calendar Date is in e.g. 2014.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Fiscal_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Full description of the date.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Full_Date_Description'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Description of the public holiday.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Holiday_Description'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this is a public holiday.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Holiday_Indicator'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Description of the major event.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Major_Event_Description'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this is a major event.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Major_Event_Indicator'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Merchandising Season for the Calendar Date e.g. SS14.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Merchandise_Season'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Half Year for the Calendar Date e.g. 1, 2.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Next_Fiscal_Half_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Period number for the Calendar Date in the Fiscal Year e.g. 11.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Next_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Quarter for the Calendar Date e.g. 1, 2, 3, 4.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Next_Fiscal_Quarter'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Week for the Calendar Date in the Fiscal Year e.g. 16.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Next_Fiscal_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Fiscal Year that the Calendar Date is in e.g. 2015.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Next_Fiscal_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The next Merchandising Season for the Calendar Date e.g. AW14.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Next_Merchandise_Season'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Next Week in Fiscal Period e.g. 1, 2, 3.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Next_Week_in_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Half Year for the Calendar Date e.g. 1, 2.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Previous_Fiscal_Half_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Period number for the Calendar Date in the Fiscal Year e.g. 9.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Previous_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Quarter for the Calendar Date e.g. 1, 2, 3, 4.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Previous_Fiscal_Quarter'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Week for the Calendar Date in the Fiscal Year e.g. 14.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Previous_Fiscal_Week'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Fiscal Year that the Calendar Date is in e.g. 2013.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Previous_Fiscal_Year'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The previous Merchandising Season for the Calendar Date e.g. AW13.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Previous_Merchandise_Season'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Previous Week in Fiscal Period e.g. 1, 2, 3.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Previous_Week_in_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this Calendar Date occurs in Fiscal Week 53.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Week_53_Indicator'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Week in Fiscal Period e.g. 1, 2, 3.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Week_in_Fiscal_Period'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this is a weekday.', 'SCHEMA', N'dbo', 'TABLE', N'Calendar_Dim', 'COLUMN', N'Weekday_Indicator'
GO
