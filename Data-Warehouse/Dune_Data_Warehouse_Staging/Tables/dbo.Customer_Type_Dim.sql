CREATE TABLE [dbo].[Customer_Type_Dim]
(
[Customer_Type_Dim_ID] [tinyint] NOT NULL,
[Customer_Type_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Type_Desc] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Type_Dim] ADD CONSTRAINT [Customer_Type_Dim_PK] PRIMARY KEY CLUSTERED  ([Customer_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Customer_Type_Dim_Customer_Type_Code_UIX] ON [dbo].[Customer_Type_Dim] ([Customer_Type_Code]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies the origin of the customer e.g. International, Wholesale, Web or Mobile', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Type_Dim', NULL, NULL
GO
