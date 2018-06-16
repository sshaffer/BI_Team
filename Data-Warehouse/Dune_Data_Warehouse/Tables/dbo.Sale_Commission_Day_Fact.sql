CREATE TABLE [dbo].[Sale_Commission_Day_Fact]
(
[Sale_Commission_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [bigint] NOT NULL,
[Transaction_No] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attributed_to_Sale] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Commission_Value] [money] NOT NULL,
[COMSTMP] [numeric] (14, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sale_Commission_Day_Fact] ADD CONSTRAINT [Sale_Commission_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Sale_Commission_Date_Dim_ID], [Time_Dim_ID], [Item_Dim_ID], [Store_Dim_ID], [Transaction_No]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Sale_Commission_Day_Fact_Item_Dim_FKX] ON [dbo].[Sale_Commission_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Sale_Commission_DayX] ON [dbo].[Sale_Commission_Day_Fact] ([Sale_Commission_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Time_Sale_Commission_DayX] ON [dbo].[Sale_Commission_Day_Fact] ([Time_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sale_Commission_Day_Fact] WITH NOCHECK ADD CONSTRAINT [Sale_Commission_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Sale_Commission_Day_Fact] WITH NOCHECK ADD CONSTRAINT [Calendar_Day_Sale_Commission_Day] FOREIGN KEY ([Sale_Commission_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Sale_Commission_Day_Fact] WITH NOCHECK ADD CONSTRAINT [Time_Sale_Commission_Day] FOREIGN KEY ([Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Employee number attributed to sale', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Commission_Day_Fact', 'COLUMN', N'Attributed_to_Sale'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Commission Value for the Sale', 'SCHEMA', N'dbo', 'TABLE', N'Sale_Commission_Day_Fact', 'COLUMN', N'Commission_Value'
GO
