CREATE TABLE [dbo].[Apparel_Merchandising_Division_LFL_Week_Fact]
(
[Calendar_Week_Dim_Id] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[LFL] [int] NOT NULL,
[LFL_LY] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Apparel_Merchandising_Division_LFL_Week_Fact] ADD CONSTRAINT [Apparel_Merchandising_Division_LFL_Week_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_Id], [Store_Dim_ID], [Division_Dim_ID]) ON [PRIMARY]
GO
