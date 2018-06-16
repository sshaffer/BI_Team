CREATE TABLE [dbo].[Item_Cost_Price_History_Fact]
(
[DW_Load_Date_ID] [smallint] NOT NULL CONSTRAINT [Item_Cost_Price_History_Fact_DW_Load_Date_ID_DF] DEFAULT ((-32768)),
[Calendar_Date_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Item_Landed_Cost_Price] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Cost_Price_History_Fact] ADD CONSTRAINT [Item_Cost_Price_History_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Date_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Item_Cost_Price_Hist_Cost_Date_FKX] ON [dbo].[Item_Cost_Price_History_Fact] ([Calendar_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Cost_Price_History_Fact_Item_Dim_FKX] ON [dbo].[Item_Cost_Price_History_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Item_Cost_Price_History_Fact_Item_Cal_Cost_IX] ON [dbo].[Item_Cost_Price_History_Fact] ([Item_Dim_ID], [Calendar_Date_Dim_ID], [Item_Landed_Cost_Price]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Cost_Price_History_Fact] WITH NOCHECK ADD CONSTRAINT [Calendar_Day_Item_Cost_Price_Hist_Cost_Date_FK] FOREIGN KEY ([Calendar_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Item_Cost_Price_History_Fact] WITH NOCHECK ADD CONSTRAINT [Item_Cost_Price_History_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
