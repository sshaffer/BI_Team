CREATE TABLE [dbo].[Wholesale_Order_Dim]
(
[Wholesale_Order_Dim_ID] [bigint] NOT NULL,
[Sales_Order_Number] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sales_Order_Line_Number] [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Wholesale_Order_Dim] ADD 
CONSTRAINT [Wholesale_Order_Dim_PK] PRIMARY KEY CLUSTERED  ([Wholesale_Order_Dim_ID], [Sales_Order_Number], [Sales_Order_Line_Number]) ON [PRIMARY]
GO
