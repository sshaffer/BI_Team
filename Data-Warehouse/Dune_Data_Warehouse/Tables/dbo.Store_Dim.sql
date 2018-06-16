CREATE TABLE [dbo].[Store_Dim]
(
[Store_Dim_ID] [int] NOT NULL,
[Store_Number] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Name] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Store_Address_Line_1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Address_Line_2] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Post_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Manager] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Telephone_No] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Price_Group_ID] [tinyint] NOT NULL,
[Zone_Dim_ID] [tinyint] NOT NULL,
[Territory_Dim_ID] [tinyint] NOT NULL,
[Region_Dim_ID] [tinyint] NOT NULL,
[District_Dim_ID] [tinyint] NOT NULL,
[Open_Date] [date] NOT NULL,
[Open_Time_Sun] [time] NOT NULL,
[Close_Time_Sun] [time] NOT NULL,
[Open_Time_Mon] [time] NOT NULL,
[Close_Time_Mon] [time] NOT NULL,
[Open_Time_Tues] [time] NOT NULL,
[Close_Time_Tues] [time] NOT NULL,
[Open_Time_Wed] [time] NOT NULL,
[Close_Time_Wed] [time] NOT NULL,
[Open_Time_Thurs] [time] NOT NULL,
[Close_Time_Thurs] [time] NOT NULL,
[Open_Time_Fri] [time] NOT NULL,
[Close_Time_Fri] [time] NOT NULL,
[Open_Time_Sat] [time] NOT NULL,
[Close_Time_Sat] [time] NOT NULL,
[Warehouse_Flag] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SSTX] [numeric] (5, 0) NOT NULL CONSTRAINT [Store_Dim_SSTX_DF] DEFAULT ((0)),
[Yahoo_WOEID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Store_Dim_YahooWOEID_DF] DEFAULT (''),
[Trading_Space] [smallint] NOT NULL CONSTRAINT [Store_Dim_Trading_Space_DF] DEFAULT ((0)),
[Non_Trading_Space] [smallint] NOT NULL CONSTRAINT [Store_Dim_Non_Trading_Space_DF] DEFAULT ((0)),
[Total_Space] [smallint] NOT NULL CONSTRAINT [Store_Dim_Total_Space_DF] DEFAULT ((0)),
[Store_Type] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Store_Dim_Store_Type_DF] DEFAULT ('Dune'),
[Currency] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Store_Dim_Currency_DF] DEFAULT (''),
[Apparel_Facia] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Store_Dim_Apparel_Facia_DF] DEFAULT (''),
[Apparel_Exclude_From_Reports] [bit] NOT NULL CONSTRAINT [Store_Dim_Apparel_Exlude_DF] DEFAULT ((0)),
[Country_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Store_Dim_Country_Name_DF] DEFAULT (''),
[Store_Email] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [Store_Dim_StoreEmail_DF] DEFAULT ('')
) ON [PRIMARY]
ALTER TABLE [dbo].[Store_Dim] ADD 
CONSTRAINT [Store_Dim_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID]) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [Store_Store_Number_IX] ON [dbo].[Store_Dim] ([Store_Number]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [Store_Dim_StoreTypeStoreNumber_IX] ON [dbo].[Store_Dim] ([Store_Type], [Store_Number]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [Store_Dim_Price_Group_FKX] ON [dbo].[Store_Dim] ([Price_Group_ID]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [Store_Dim_Territory_Dim_FKX] ON [dbo].[Store_Dim] ([Territory_Dim_ID], [Zone_Dim_ID]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [Store_Dim_Zone_Dim_FKX] ON [dbo].[Store_Dim] ([Zone_Dim_ID]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [Store_Dim_Region_Dim_FKX] ON [dbo].[Store_Dim] ([Territory_Dim_ID], [Region_Dim_ID]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [Store_Dim_District_Dim_FKX] ON [dbo].[Store_Dim] ([Region_Dim_ID], [District_Dim_ID]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [Store_Dim_StoreType_IX] ON [dbo].[Store_Dim] ([Store_Type]) ON [PRIMARY]

GO
EXEC sp_addextendedproperty N'MS_Description', N'Denotes whether the store is a warehouse or a store Y or N', 'SCHEMA', N'dbo', 'TABLE', N'Store_Dim', 'COLUMN', N'Warehouse_Flag'
GO





ALTER TABLE [dbo].[Store_Dim] WITH NOCHECK ADD
CONSTRAINT [Store_Dim_Price_Group_FK] FOREIGN KEY ([Price_Group_ID]) REFERENCES [dbo].[Price_Group_Dim] ([Price_Group_Dim_ID])
ALTER TABLE [dbo].[Store_Dim] WITH NOCHECK ADD
CONSTRAINT [Store_Dim_District_Dim_FK] FOREIGN KEY ([Region_Dim_ID], [District_Dim_ID]) REFERENCES [dbo].[District_Dim] ([Region_Dim_ID], [District_Dim_ID])
ALTER TABLE [dbo].[Store_Dim] WITH NOCHECK ADD
CONSTRAINT [Store_Dim_Region_Dim_FK] FOREIGN KEY ([Territory_Dim_ID], [Region_Dim_ID], [Zone_Dim_ID]) REFERENCES [dbo].[Region_Dim] ([Territory_Dim_ID], [Region_Dim_ID], [Zone_Dim_ID])
ALTER TABLE [dbo].[Store_Dim] WITH NOCHECK ADD
CONSTRAINT [Store_Dim_Territory_Dim_FK] FOREIGN KEY ([Territory_Dim_ID], [Zone_Dim_ID]) REFERENCES [dbo].[Territory_Dim] ([Territory_Dim_ID], [Zone_Dim_ID])
ALTER TABLE [dbo].[Store_Dim] WITH NOCHECK ADD
CONSTRAINT [Store_Dim_Zone_Dim_FK] FOREIGN KEY ([Zone_Dim_ID]) REFERENCES [dbo].[Zone_Dim] ([Zone_Dim_ID])










GO
