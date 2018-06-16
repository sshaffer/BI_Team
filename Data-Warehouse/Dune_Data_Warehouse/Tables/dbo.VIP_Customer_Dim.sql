CREATE TABLE [dbo].[VIP_Customer_Dim]
(
[VIP_Customer_Dim_ID] [bigint] NOT NULL,
[VIP_Customer_Number] [char] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Title] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_First_Name] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Last_Name] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email_Address] [char] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Telephone_No] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Alternate_Telephone_No] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Shoe_Size] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_1] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_2] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_3] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_4] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Postal_Code] [char] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Registered_Store_Dim_ID] [int] NOT NULL,
[Optin_Dune] [bit] NOT NULL,
[Optin_3rdParty] [bit] NOT NULL,
[From_Date] [date] NOT NULL,
[To_Date] [date] NOT NULL CONSTRAINT [VIP_Customer_Dim_To_Date_DF] DEFAULT ('2025-01-01'),
[Current_VIP_Customer_Flag] [bit] NOT NULL,
[DateRegistered] [date] NOT NULL CONSTRAINT [VIP_Customer_Dim_DateRegistered_DF] DEFAULT ('1900-01-01')
) ON [PRIMARY]
ALTER TABLE [dbo].[VIP_Customer_Dim] ADD
CONSTRAINT [VIP_Customer_Dim_Store_Dim_FK] FOREIGN KEY ([Registered_Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])

GO
ALTER TABLE [dbo].[VIP_Customer_Dim] ADD CONSTRAINT [VIP_Customer_Dim_PK] PRIMARY KEY CLUSTERED  ([VIP_Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [VIP_Customer_Current_Dim_Customer_Number] ON [dbo].[VIP_Customer_Dim] ([VIP_Customer_Number]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [VIP_Customer_Dim_Customer_Number] ON [dbo].[VIP_Customer_Dim] ([VIP_Customer_Number]) ON [PRIMARY]
GO
