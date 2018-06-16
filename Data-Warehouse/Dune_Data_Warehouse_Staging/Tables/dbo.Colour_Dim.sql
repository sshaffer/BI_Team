CREATE TABLE [dbo].[Colour_Dim]
(
[Colour_Dim_ID] [smallint] NOT NULL,
[Colour_Code] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Colour_Name] [char] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Colour_Dim] ADD CONSTRAINT [Colour_Dim_PK] PRIMARY KEY CLUSTERED  ([Colour_Dim_ID]) ON [PRIMARY]
GO
