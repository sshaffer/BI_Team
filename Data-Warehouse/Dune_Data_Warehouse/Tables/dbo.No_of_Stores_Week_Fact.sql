CREATE TABLE [dbo].[No_of_Stores_Week_Fact]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Item_Colour_Code] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[No_of_Stores] [int] NOT NULL
) ON [PRIMARY]
WITH (DATA_COMPRESSION = PAGE)
GO
ALTER TABLE [dbo].[No_of_Stores_Week_Fact] ADD CONSTRAINT [No_of_Stores_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Item_Colour_Code]) WITH (DATA_COMPRESSION = PAGE) ON [PRIMARY]
GO
