CREATE TABLE [dbo].[AR_Customer_Dim]
(
[AR_Customer_Dim_ID] [int] NOT NULL,
[AR_Customer_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Company_Name] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_1] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_2] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Post_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Discount_Percentage] [decimal] (5, 2) NOT NULL,
[Credit_Limit] [numeric] (7, 0) NOT NULL,
[Uninvoiced_Credit_Used] [money] NOT NULL,
[Invoiced_Credit_Used] [money] NOT NULL,
[Accumulated_Days_to_Pay] [int] NOT NULL,
[Longest_No_of_Days_to_Pay] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AR_Customer_Dim] ADD CONSTRAINT [AR_Customer_Dim_PK] PRIMARY KEY CLUSTERED  ([AR_Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AR_Customer_Dim_Cust_No_IDX] ON [dbo].[AR_Customer_Dim] ([AR_Customer_No]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Dune International Wholesale Customer information. Finance AR produces invoices for these customers.', 'SCHEMA', N'dbo', 'TABLE', N'AR_Customer_Dim', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Finance Accounts Receivable customers for International and Wholesale/Franchise e.g. Amazon', 'SCHEMA', N'dbo', 'TABLE', N'AR_Customer_Dim', 'COLUMN', N'AR_Customer_No'
GO
