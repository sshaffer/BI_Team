CREATE TABLE [dbo].[Freight_Forwarder_Dim]
(
[Freight_Forwarder_Dim_ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Freight_Forwarder_Code] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Freight_Forwarder_Dim] ADD CONSTRAINT [Freight_Forwarder_Dim_PK] PRIMARY KEY CLUSTERED  ([Freight_Forwarder_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Freight_Forwarder_Dim_Freight_Forwarder_Code_UIX] ON [dbo].[Freight_Forwarder_Dim] ([Freight_Forwarder_Code]) ON [PRIMARY]
GO
