CREATE TABLE [dbo].[Master_Customer_Dim]
(
[CustomerSource] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Dim_ID] [bigint] NOT NULL,
[Customer_Number] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Title] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_First_Name] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Last_Name] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Nickname] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address_Line_2] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Name] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Postal_Code] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Type_Code] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Telephone_No] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Alternate_Telephone_No] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email_Address] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Twitter_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Date_of_Birth] [date] NULL,
[Currency_Code] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Registration_Date] [date] NOT NULL,
[Email_Marketing_Preference] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Shoe_Size] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Registered_Store] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Optin_3rdParty] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Master_Customer_Dim] ADD CONSTRAINT [Master_Customer_Dim_PK] PRIMARY KEY CLUSTERED  ([CustomerSource], [Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Master_Customer_Dim_CustomerNumber_IX] ON [dbo].[Master_Customer_Dim] ([Customer_Number]) ON [PRIMARY]
GO
