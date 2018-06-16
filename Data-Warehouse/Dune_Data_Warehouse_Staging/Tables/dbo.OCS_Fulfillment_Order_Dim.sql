CREATE TABLE [dbo].[OCS_Fulfillment_Order_Dim]
(
[OCS_Fulfillment_Order_Dim_Id] [int] NOT NULL,
[Order_Number] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Layby_Number] [int] NOT NULL,
[Layby_Line_Number] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCS_Fulfillment_Order_Dim] ADD CONSTRAINT [OCS_Fulfillment_Order_Dim_PK] PRIMARY KEY CLUSTERED  ([OCS_Fulfillment_Order_Dim_Id]) ON [PRIMARY]
GO
