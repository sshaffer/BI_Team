CREATE TABLE [dbo].[International_Partner_Dim]
(
[International_Partner_Dim_ID] [int] NOT NULL IDENTITY(-2147483648, 1),
[Partner_Store_Code] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Partner_Name] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Partner] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Currency_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Technical_Contact_Email] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [International_Partner_Dim_Tech_Email_DF] DEFAULT (''),
[Concession_Flag] [bit] NOT NULL CONSTRAINT [International_Partner_Dim_Con_Flag_DF] DEFAULT ((0)),
[Store_Footage] [int] NOT NULL CONSTRAINT [International_Partner_Dim_Store_Footage_DF] DEFAULT ((0)),
[Warehouse_Flag] [bit] NOT NULL CONSTRAINT [International_Partner_Dim_Warehouse_Flag_DF] DEFAULT ((0)),
[Exclude_From_Reports] [bit] NOT NULL CONSTRAINT [International_Partner_Dim_Exlude_DF] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[International_Partner_Dim] ADD CONSTRAINT [International_Partner_Dim_PK] PRIMARY KEY CLUSTERED  ([International_Partner_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [International_Partner_Dim_Code_Name_UIX] ON [dbo].[International_Partner_Dim] ([Partner_Store_Code], [Partner_Name]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[International_Partner_Dim] TO [DUNE\IISBISWEB]
GRANT INSERT ON  [dbo].[International_Partner_Dim] TO [DUNE\IISBISWEB]
GRANT DELETE ON  [dbo].[International_Partner_Dim] TO [DUNE\IISBISWEB]
GRANT UPDATE ON  [dbo].[International_Partner_Dim] TO [DUNE\IISBISWEB]
GO
