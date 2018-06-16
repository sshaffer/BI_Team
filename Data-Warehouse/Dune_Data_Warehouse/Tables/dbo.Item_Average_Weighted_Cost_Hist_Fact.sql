CREATE TABLE [dbo].[Item_Average_Weighted_Cost_Hist_Fact]
(
[Calendar_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Average_Weighted_Cost] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Average_Weighted_Cost_Hist_Fact] ADD CONSTRAINT [Item_Average_Weighted_Cost_Hist_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Date_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Item_Avg_Wght_Cost_Cost_Date_FKX] ON [dbo].[Item_Average_Weighted_Cost_Hist_Fact] ([Calendar_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Average_Weighted_Cost_Hist_Fact_Item_Dim_FKX] ON [dbo].[Item_Average_Weighted_Cost_Hist_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Average_Weighted_Cost_Hist_Fact] ADD CONSTRAINT [Calendar_Day_Item_Avg_Wght_Cost_Cost_Date_FK] FOREIGN KEY ([Calendar_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Item_Average_Weighted_Cost_Hist_Fact] ADD CONSTRAINT [Item_Average_Weighted_Cost_Hist_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
