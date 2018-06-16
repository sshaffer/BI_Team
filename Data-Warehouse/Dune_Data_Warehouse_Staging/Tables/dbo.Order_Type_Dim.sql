CREATE TABLE [dbo].[Order_Type_Dim]
(
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Order_Type_Code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_Type_Description] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order_Type_Dim] ADD CONSTRAINT [Order_Type_Dim_PK] PRIMARY KEY CLUSTERED  ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Order_Type_Dim_Order_Type_Code_UIX] ON [dbo].[Order_Type_Dim] ([Order_Type_Code]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Order_Type_Dim_Code_Desc_IDX] ON [dbo].[Order_Type_Dim] ([Order_Type_Code], [Order_Type_Description]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Order_Type_Dim_Desc_IDX] ON [dbo].[Order_Type_Dim] ([Order_Type_Description]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Code and descriptions that identifies whether the order is phone, web or mobile.', 'SCHEMA', N'dbo', 'TABLE', N'Order_Type_Dim', NULL, NULL
GO
