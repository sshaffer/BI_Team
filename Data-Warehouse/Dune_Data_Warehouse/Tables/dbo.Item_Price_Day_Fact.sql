CREATE TABLE [dbo].[Item_Price_Day_Fact]
(
[Price_Date] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[FP_MD_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[User_Id] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Selling_Price_Sterling] [money] NOT NULL,
[Selling_Price_Euro] [money] NOT NULL,
[Selling_Price_Dollar] [money] NOT NULL,
[Selling_Price_DKK] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Price_Day_Fact] ADD CONSTRAINT [Item_Price_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Price_Date], [Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Store_Item_Price_Day_FKX] ON [dbo].[Item_Price_Day_Fact] ([Price_Date]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item_Price_Day_Fact] ADD CONSTRAINT [Calendar_Day_Item_Price_Day_FK] FOREIGN KEY ([Price_Date]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Full Price Markdown Flag', 'SCHEMA', N'dbo', 'TABLE', N'Item_Price_Day_Fact', 'COLUMN', N'FP_MD_Flag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Retail Selling Price of Item in Danish Krona', 'SCHEMA', N'dbo', 'TABLE', N'Item_Price_Day_Fact', 'COLUMN', N'Selling_Price_DKK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Retail Selling Price of Item in Dollars', 'SCHEMA', N'dbo', 'TABLE', N'Item_Price_Day_Fact', 'COLUMN', N'Selling_Price_Dollar'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Retail Selling Price of Item in Euros', 'SCHEMA', N'dbo', 'TABLE', N'Item_Price_Day_Fact', 'COLUMN', N'Selling_Price_Euro'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Retail Selling Price of Item in Sterling', 'SCHEMA', N'dbo', 'TABLE', N'Item_Price_Day_Fact', 'COLUMN', N'Selling_Price_Sterling'
GO
EXEC sp_addextendedproperty N'MS_Description', N'User who made the price change', 'SCHEMA', N'dbo', 'TABLE', N'Item_Price_Day_Fact', 'COLUMN', N'User_Id'
GO
