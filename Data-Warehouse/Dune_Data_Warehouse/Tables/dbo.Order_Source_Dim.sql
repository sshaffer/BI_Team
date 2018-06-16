CREATE TABLE [dbo].[Order_Source_Dim]
(
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Order_Source_Code] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_Source_Desc] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order_Source_Dim] ADD CONSTRAINT [Order_Source_Dim_PK] PRIMARY KEY CLUSTERED  ([Order_Source_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Order_Source_Dim_Order_Source_Code_UIX] ON [dbo].[Order_Source_Dim] ([Order_Source_Code]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Order_Source_Dim_Code_IDX] ON [dbo].[Order_Source_Dim] ([Order_Source_Code], [Order_Source_Desc]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Code and description to identify the source of the order e.g. AMA - Amazon, Dun - Dune Web Orders, ST00110 – Mobile order from store  Dune Thurrock.', 'SCHEMA', N'dbo', 'TABLE', N'Order_Source_Dim', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'e.g. AMA for Amazon Wholesale orders, RUS for Russia International, ST00243 for Store order (Mobile order)', 'SCHEMA', N'dbo', 'TABLE', N'Order_Source_Dim', 'COLUMN', N'Order_Source_Code'
GO
