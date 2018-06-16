CREATE TABLE [dbo].[AR_Customer_Xref_Dim]
(
[Customer_Dim_ID] [int] NOT NULL,
[AR_Customer_Dim_ID] [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[AR_Customer_Xref_Dim] ADD
CONSTRAINT [AR_Customer_Xref_Dim_AR_Customer_Dim_FX] FOREIGN KEY ([AR_Customer_Dim_ID]) REFERENCES [dbo].[AR_Customer_Dim] ([AR_Customer_Dim_ID])
ALTER TABLE [dbo].[AR_Customer_Xref_Dim] ADD
CONSTRAINT [AR_Customer_Xref_Dim_Customer_Dim_FK] FOREIGN KEY ([Customer_Dim_ID]) REFERENCES [dbo].[Customer_Dim] ([Customer_Dim_ID])


GO
ALTER TABLE [dbo].[AR_Customer_Xref_Dim] ADD CONSTRAINT [AR_Customer_Xref_Dim_PK] PRIMARY KEY CLUSTERED  ([AR_Customer_Dim_ID], [Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AR_Customer_Xref_Dim_AR_Cust_IDX] ON [dbo].[AR_Customer_Xref_Dim] ([AR_Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [AR_Customer_Xref_Dim_Cust_IDX] ON [dbo].[AR_Customer_Xref_Dim] ([Customer_Dim_ID]) ON [PRIMARY]
GO

EXEC sp_addextendedproperty N'MS_Description', N'Cross reference between the Accounts Receivable Customer number and the IP Direct Customer number.', 'SCHEMA', N'dbo', 'TABLE', N'AR_Customer_Xref_Dim', NULL, NULL
GO
