CREATE TABLE [dbo].[Store_PLU_Dim]
(
[Store_PLU_Dim_ID] [bigint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Retail_Price_Book] [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Store_PLU_Dim] ADD
CONSTRAINT [Store_PLU_Dim_Store_Dim_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])

GO
ALTER TABLE [dbo].[Store_PLU_Dim] ADD CONSTRAINT [Store_Item_Price_Dim_PK] PRIMARY KEY CLUSTERED  ([Store_PLU_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Store_PLU_Dim_Store_Dim_FKX] ON [dbo].[Store_PLU_Dim] ([Store_Dim_ID]) ON [PRIMARY]
GO
