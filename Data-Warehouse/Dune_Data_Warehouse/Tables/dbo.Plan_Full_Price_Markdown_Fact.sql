CREATE TABLE [dbo].[Plan_Full_Price_Markdown_Fact]
(
[Fiscal_Year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fiscal_Period] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Division_Dim_ID] [tinyint] NOT NULL,
[Department_Dim_ID] [tinyint] NOT NULL,
[Plan_Full_Price_Value] [money] NOT NULL,
[Plan_Markdown_Value] [money] NOT NULL,
[Calendar_Period_Dim_ID] [smallint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Plan_Full_Price_Markdown_Fact] ADD CONSTRAINT [Plan_Full_Price_Markdown_PK] PRIMARY KEY CLUSTERED  ([Fiscal_Year], [Fiscal_Period], [Division_Dim_ID], [Department_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Period_Plan_Full_Price_MarkdownX] ON [dbo].[Plan_Full_Price_Markdown_Fact] ([Calendar_Period_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Plan_Full_Price_Markdown_Department_Dim_FKX] ON [dbo].[Plan_Full_Price_Markdown_Fact] ([Division_Dim_ID], [Department_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Plan_Full_Price_Markdown_Fact] ADD CONSTRAINT [Calendar_Period_Plan_Full_Price_Markdown_FK] FOREIGN KEY ([Calendar_Period_Dim_ID]) REFERENCES [dbo].[Calendar_Period_Dim] ([Calendar_Period_Dim_Id])
GO
ALTER TABLE [dbo].[Plan_Full_Price_Markdown_Fact] ADD CONSTRAINT [Plan_Full_Price_Markdown_Department_Dim_FK] FOREIGN KEY ([Division_Dim_ID], [Department_Dim_ID]) REFERENCES [dbo].[Department_Dim] ([Division_Dim_ID], [Department_Dim_ID])
GO
