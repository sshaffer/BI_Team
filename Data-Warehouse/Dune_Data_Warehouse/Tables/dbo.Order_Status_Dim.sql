CREATE TABLE [dbo].[Order_Status_Dim]
(
[Order_Status_Dim_ID] [tinyint] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Order_Status_Code] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order_Status_Description] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order_Status_Dim] ADD CONSTRAINT [Order_Status_Dim_PK] PRIMARY KEY CLUSTERED  ([Order_Status_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Order_Status_Dim_Order_Status_Code_UIX] ON [dbo].[Order_Status_Dim] ([Order_Status_Code]) ON [PRIMARY]
GO
