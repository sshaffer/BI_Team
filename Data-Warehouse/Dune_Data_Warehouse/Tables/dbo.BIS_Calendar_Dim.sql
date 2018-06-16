CREATE TABLE [dbo].[BIS_Calendar_Dim]
(
[Calendar_Dim_Id] [smallint] NOT NULL,
[Calendar_Week_Dim_Id] [smallint] NOT NULL,
[Calendar_Period_Dim_Id] [smallint] NOT NULL,
[Calendar_Date] [date] NOT NULL,
[Full_Date_Description] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[Holiday_Description] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Major_Event_Indicator] [bit] NOT NULL,
[Major_Event_Description] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Week_53_Indicator] [bit] NOT NULL,
[Current_Date_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Relative_Day] [int] NOT NULL,
[Current_Day] [smallint] NOT NULL,
[Current_Week] [smallint] NOT NULL,
[Current_Year] [smallint] NOT NULL,
[Current_Period] [smallint] NOT NULL,
[Current_Quarter] [smallint] NOT NULL,
[Current_Season] [smallint] NOT NULL,
[Week_Timeline] [int] NOT NULL,
[Year_Timeline] [int] NOT NULL,
[Standard_Period] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Calendar_Dim_Standard_Period_DF] DEFAULT (''),
[W53_Period] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Calendar_Dim_W53_Period_DF] DEFAULT (''),
[Period_Timeline] [int] NOT NULL CONSTRAINT [BIS_Calendar_Dim_Period_Timeline_DF] DEFAULT ((-1000))
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Date_IX] ON [dbo].[BIS_Calendar_Dim] ([Calendar_Date]) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [Combined_Calendar_Dim_UIX] ON [dbo].[BIS_Calendar_Dim] ([Calendar_Dim_Id], [Calendar_Week_Dim_Id], [Calendar_Period_Dim_Id]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Period_ID_Last_Day_in_Period_IX] ON [dbo].[BIS_Calendar_Dim] ([Calendar_Period_Dim_Id], [Fiscal_Last_Day_in_Period_Indicator]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Week_ID_Last_Day_in_Week_IX] ON [dbo].[BIS_Calendar_Dim] ([Calendar_Week_Dim_Id], [Fiscal_Last_Day_in_Week_Indicator]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Current_Year_Current_Week_Year_Week_Date_IX] ON [dbo].[BIS_Calendar_Dim] ([Current_Year], [Current_Week], [Fiscal_Year], [Fiscal_Week], [Calendar_Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Current_Year_Year_Week_Date_IX] ON [dbo].[BIS_Calendar_Dim] ([Current_Year], [Fiscal_Year], [Fiscal_Week], [Calendar_Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Year_Period_Week_Date_IX] ON [dbo].[BIS_Calendar_Dim] ([Fiscal_Year], [Fiscal_Period], [Fiscal_Week], [Calendar_Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Year_Week_Date_IX] ON [dbo].[BIS_Calendar_Dim] ([Fiscal_Year], [Fiscal_Week], [Calendar_Date]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BIS_Calendar_Dim_Period_Timeline_IX] ON [dbo].[BIS_Calendar_Dim] ([Period_Timeline]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BIS_Calendar_Week_Period_Timeline_IX] ON [dbo].[BIS_Calendar_Dim] ([Period_Timeline], [Week_Timeline]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Combined_Calendar_Dim_Relative_Day_IX] ON [dbo].[BIS_Calendar_Dim] ([Relative_Day]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BIS_Calendar_Dim_Week_Timeline_IX] ON [dbo].[BIS_Calendar_Dim] ([Week_Timeline]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BIS_Calendar_Dim_Year_Timeline_IX] ON [dbo].[BIS_Calendar_Dim] ([Year_Timeline]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [BIS_Calendar_Year_Week_Timeline_IX] ON [dbo].[BIS_Calendar_Dim] ([Year_Timeline], [Week_Timeline]) ON [PRIMARY]
GO
