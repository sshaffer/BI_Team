CREATE TABLE [dbo].[Finance_Store_SqrFoot_Import]
(
[Store_Dim_ID] [int] NOT NULL,
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Sqr_Foot] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Finance_Store_SqrFoot_Import] ADD CONSTRAINT [Finance_Store_SqrFoot_Import_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID], [Calendar_Week_Dim_ID]) ON [PRIMARY]
GO
