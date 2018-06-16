CREATE TABLE [dbo].[BIS_Store_Dim]
(
[Store_Dim_ID] [int] NOT NULL,
[Store_Number] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Name] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Address_Line_1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Address_Line_2] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Post_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Country_Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Manager] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Telephone_No] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Price_Group_ID] [tinyint] NOT NULL,
[Price_Group_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Price_Group_Desc] [char] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Zone_Dim_ID] [tinyint] NOT NULL,
[Zone_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Zone_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Territory_Dim_ID] [tinyint] NOT NULL,
[Territory_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Territory_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Region_Dim_ID] [tinyint] NOT NULL,
[Region_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Region_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[District_Dim_ID] [tinyint] NOT NULL,
[District_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[District_Name] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
[SSTX] [numeric] (5, 0) NOT NULL,
[Trading_Space] [smallint] NOT NULL,
[Non_Trading_Space] [smallint] NOT NULL,
[Total_Space] [smallint] NOT NULL,
[Area_Number] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Clearance] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customs_Warehousing] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Delivery_Run] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Host] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Standalone_Type] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Stock_Room_1] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Stock_Room_2] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Type] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[HostStoreAndWeb] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Store_Dim_HostStoreAndWeb_DF] DEFAULT ('UNKNOWN'),
[BricksAndMortarInt] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Store_Dim_attBricksAndMortarInt_DF] DEFAULT ('UNKNOWN'),
[HarryInStore] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Store_Dim_HarryInStore_DF] DEFAULT ('UNKNOWN'),
[Store_Type] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Store_Dim_StoreType_DF] DEFAULT ('Dune'),
[Currency] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Store_Dim_Currency_DF] DEFAULT (''),
[Apparel_Facia] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Store_Dim_ApparelFacia_DF] DEFAULT (''),
[Apparel_Exclude_from_Reports] [bit] NOT NULL CONSTRAINT [BIS_Store_Dim_ApparelExcludeFromReports_DF] DEFAULT ((0)),
[Store_Email] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [BIS_Store_Dim_StoreEmail_DF] DEFAULT ('')
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)


CREATE NONCLUSTERED INDEX [BIS_Store_Dim_Store_Number_Name_ID_IX] ON [dbo].[BIS_Store_Dim] ([Store_Number], [Store_Name], [Store_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [BIS_Store_Dim_Zon_Ter_Reg_Dis_Store_Codes_IX] ON [dbo].[BIS_Store_Dim] ([Zone_Code], [Territory_Code], [Region_Code], [District_Code], [Store_Number]) INCLUDE ([District_Name], [Region_Name], [Store_Name], [Territory_Name], [Zone_Name]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [BIS_Store_Dim_Zon_Ter_Reg_Dis_Store_Names_IX] ON [dbo].[BIS_Store_Dim] ([Zone_Name], [Territory_Name], [Region_Name], [District_Name], [Store_Name]) INCLUDE ([District_Code], [Region_Code], [Territory_Code], [Zone_Code]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [BIS_Store_Dim_StoreType_IX] ON [dbo].[BIS_Store_Dim] ([Store_Type]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [BIS_Store_Dim_StoreTypeStoreNumber_IX] ON [dbo].[BIS_Store_Dim] ([Store_Type], [Store_Number]) ON [PRIMARY]



GO
ALTER TABLE [dbo].[BIS_Store_Dim] ADD CONSTRAINT [BIS_Store_Dim_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [BIS_Store_Dim_Zon_Ter_Reg_Dis_Store_IDs_IX] ON [dbo].[BIS_Store_Dim] ([Zone_Dim_ID], [Territory_Dim_ID], [Region_Dim_ID], [District_Dim_ID], [Store_Dim_ID]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
