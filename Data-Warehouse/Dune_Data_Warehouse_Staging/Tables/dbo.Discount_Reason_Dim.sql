CREATE TABLE [dbo].[Discount_Reason_Dim]
(
[Discount_Reason_Dim_ID] [tinyint] NOT NULL,
[Discount_Reason_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Discount_Reason_Desc] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Discount_Reason_Dim] ADD CONSTRAINT [Discount_Reason_Dim_PK] PRIMARY KEY CLUSTERED  ([Discount_Reason_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Discount_Reason_Dim_Discount_Reason_Code_UIX] ON [dbo].[Discount_Reason_Dim] ([Discount_Reason_Code]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Codes and descriptions that denote the reason why a discount was given to the customer on the selling price of the goods e.g. Gesture of Goodwill, Poor Service (Store)', 'SCHEMA', N'dbo', 'TABLE', N'Discount_Reason_Dim', NULL, NULL
GO
