CREATE TABLE [dbo].[Customer_Dim]
(
[Customer_Dim_ID] [int] NOT NULL,
[Customer_Number] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Title] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_First_Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Last_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Nickname] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_2] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Dim_ID] [tinyint] NOT NULL,
[Postal_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Type_Dim_ID] [tinyint] NOT NULL,
[Telephone_No] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Alternate_Telephone_No] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email_Address] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Twitter_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Gender] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Date_of_Birth] [date] NOT NULL,
[Currency_Dim_ID] [tinyint] NOT NULL,
[Registration_Date] [date] NOT NULL,
[Email_Marketing_Preference] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Shoe_Size] [decimal] (3, 1) NOT NULL,
[From_Date] [date] NOT NULL,
[To_Date] [date] NOT NULL CONSTRAINT [Customer_Dim_To_Date_DF] DEFAULT ('2025-01-01'),
[Current_Customer_Flag] [bit] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Customer_Dim] ADD
CONSTRAINT [Customer_Dim_Country_Dim_FK] FOREIGN KEY ([Country_Dim_ID]) REFERENCES [dbo].[Country_Dim] ([Country_Dim_ID])
ALTER TABLE [dbo].[Customer_Dim] ADD
CONSTRAINT [Currency_Customer] FOREIGN KEY ([Currency_Dim_ID]) REFERENCES [dbo].[Currency_Dim] ([Currency_Dim_ID])
ALTER TABLE [dbo].[Customer_Dim] ADD
CONSTRAINT [Customer_Dim_Customer_Type_Dim_FK] FOREIGN KEY ([Customer_Type_Dim_ID]) REFERENCES [dbo].[Customer_Type_Dim] ([Customer_Type_Dim_ID])



GO
ALTER TABLE [dbo].[Customer_Dim] ADD CONSTRAINT [Customer_Dim_PK] PRIMARY KEY CLUSTERED  ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Current_Dim_Country_Dim_FKX] ON [dbo].[Customer_Dim] ([Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Dim_Country_Dim_FKX] ON [dbo].[Customer_Dim] ([Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_CustomerX] ON [dbo].[Customer_Dim] ([Currency_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Currency_CustomerX_Current] ON [dbo].[Customer_Dim] ([Currency_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Dim_Customer_Number_UIX] ON [dbo].[Customer_Dim] ([Customer_Number]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Current_Dim_Customer_Type_Dim_FKX] ON [dbo].[Customer_Dim] ([Customer_Type_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Dim_Customer_Type_Dim_FKX] ON [dbo].[Customer_Dim] ([Customer_Type_Dim_ID]) ON [PRIMARY]
GO

EXEC sp_addextendedproperty N'MS_Description', N'Customer title e.g. Mr, Mrs, Rev, Sir', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Dim', 'COLUMN', N'Customer_Title'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Opted In/Opted Out', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Dim', 'COLUMN', N'Email_Marketing_Preference'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Email Marketing Only', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Dim', 'COLUMN', N'Gender'
GO
