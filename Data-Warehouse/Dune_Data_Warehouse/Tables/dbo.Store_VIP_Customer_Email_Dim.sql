CREATE TABLE [dbo].[Store_VIP_Customer_Email_Dim]
(
[Store_VIP_Customer_Email_Dim_ID] [bigint] NOT NULL,
[VIP_Customer_Email_Dim_ID] [bigint] NULL,
[VIP_Customer_Title] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[VIP_Customer_First_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[VIP_Customer_Surname] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[VIP_Customer_Email] [char] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Dim_ID] [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Store_VIP_Customer_Email_Dim] ADD
CONSTRAINT [Store_VIP_Customer_Email_Dim_To_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])

GO
ALTER TABLE [dbo].[Store_VIP_Customer_Email_Dim] ADD CONSTRAINT [Store_VIP_Customer_Email_Dim_PK] PRIMARY KEY CLUSTERED  ([Store_VIP_Customer_Email_Dim_ID]) ON [PRIMARY]
GO
