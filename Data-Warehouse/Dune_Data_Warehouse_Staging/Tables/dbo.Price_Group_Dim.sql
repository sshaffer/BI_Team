CREATE TABLE [dbo].[Price_Group_Dim]
(
[Price_Group_Dim_ID] [tinyint] NOT NULL,
[Price_Group_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Price_Group_Desc] [char] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Price_Group_Dim] ADD CONSTRAINT [Price_Group_PK] PRIMARY KEY CLUSTERED  ([Price_Group_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_Price_GroupX] ON [dbo].[Price_Group_Dim] ([Currency_Dim_ID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Codes and descriptions for Price Groups denoting Currency for the Group, used for stores.', 'SCHEMA', N'dbo', 'TABLE', N'Price_Group_Dim', NULL, NULL
GO
