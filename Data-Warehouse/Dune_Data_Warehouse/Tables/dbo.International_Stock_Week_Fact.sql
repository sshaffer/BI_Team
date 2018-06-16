CREATE TABLE [dbo].[International_Stock_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[International_Partner_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Stock_Qty] [decimal] (11, 3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Stock_Week_Fact] ADD CONSTRAINT [International_Stock_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [International_Partner_Dim_ID], [Item_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Stock_Week_Fact] ADD CONSTRAINT [International_Stock_Week_Fact_Partner_FK] FOREIGN KEY ([International_Partner_Dim_ID]) REFERENCES [dbo].[International_Partner_Dim] ([International_Partner_Dim_ID])
GO
ALTER TABLE [dbo].[International_Stock_Week_Fact] ADD CONSTRAINT [International_Stock_Week_Fact_Item_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
