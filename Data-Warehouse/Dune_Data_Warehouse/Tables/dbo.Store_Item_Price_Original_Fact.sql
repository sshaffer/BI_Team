CREATE TABLE [dbo].[Store_Item_Price_Original_Fact]
(
[item_dim_id] [int] NOT NULL,
[store_dim_id] [int] NOT NULL,
[retail_price_home] [money] NOT NULL,
[retail_price_curr] [money] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [Store_Item_Price_Original_Fact_UIX] ON [dbo].[Store_Item_Price_Original_Fact] ([item_dim_id], [store_dim_id]) ON [PRIMARY]
GO
