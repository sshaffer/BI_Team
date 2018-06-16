CREATE TABLE [dbo].[Customer_Ship_Address_Dim]
(
[Customer_Ship_Address_Dim_ID] [int] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Ship_Address_Sequence_No] [numeric] (3, 0) NOT NULL,
[Ship_Address_Line_1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Ship_Address_Line_2] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Ship_City] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Ship_State] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Ship_Postal_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Ship_Telephone_No] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Dim_ID] [tinyint] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Customer_Ship_Address_Dim] ADD
CONSTRAINT [Customer_Ship_Address_Dim_Country_Dim_FK] FOREIGN KEY ([Country_Dim_ID]) REFERENCES [dbo].[Country_Dim] ([Country_Dim_ID])
ALTER TABLE [dbo].[Customer_Ship_Address_Dim] ADD
CONSTRAINT [Customer_Ship_Address_Dim_Customer_Dim_FK] FOREIGN KEY ([Customer_Dim_ID]) REFERENCES [dbo].[Customer_Dim] ([Customer_Dim_ID])


GO
ALTER TABLE [dbo].[Customer_Ship_Address_Dim] ADD CONSTRAINT [Customer_Ship_Address_Dim_PK] PRIMARY KEY CLUSTERED  ([Customer_Ship_Address_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Ship_Address_Dim_Country_Dim_FKX] ON [dbo].[Customer_Ship_Address_Dim] ([Country_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Ship_Address_Dim_Customer_Dim_FKX] ON [dbo].[Customer_Ship_Address_Dim] ([Customer_Dim_ID]) ON [PRIMARY]
GO
