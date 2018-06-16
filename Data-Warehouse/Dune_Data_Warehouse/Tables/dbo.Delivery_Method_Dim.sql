CREATE TABLE [dbo].[Delivery_Method_Dim]
(
[Delivery_Method_Dim_ID] [tinyint] NOT NULL,
[Delivery_Method_Code] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Carrier_Code] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Delivery_Method_Desc] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Additional_Charge_to_Customer] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Delivery_Method_Dim] ADD CONSTRAINT [Delivery_Method_Dim_PK] PRIMARY KEY CLUSTERED  ([Delivery_Method_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Delivery_Method_Dim_Carrier_Method_Desc_IDX] ON [dbo].[Delivery_Method_Dim] ([Carrier_Code], [Delivery_Method_Code], [Delivery_Method_Desc]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Delivery_Method_Dim_Del_Method_Code_IDX] ON [dbo].[Delivery_Method_Dim] ([Delivery_Method_Code], [Delivery_Method_Desc]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains the different ways the goods can be shipped to the customer, the carrier and if any additional costs are involved by code e.g. UKSTD – Standard delivery by GFS.', 'SCHEMA', N'dbo', 'TABLE', N'Delivery_Method_Dim', NULL, NULL
GO
