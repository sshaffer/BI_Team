CREATE TABLE [dbo].[YearWeekOffset]
(
[Week_Timeline] [int] NULL,
[Year_Timeline] [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [YearWeekOffset_UIX] ON [dbo].[YearWeekOffset] ([Week_Timeline]) ON [PRIMARY]
GO
