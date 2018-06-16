CREATE TABLE [dbo].[Return_Reason_Dim]
(
[Return_Reason_Dim_ID] [tinyint] NOT NULL,
[Return_Reason_Code] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Return_Reason_Desc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Store_Customer_Indicator] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Return_Reason_Dim] ADD CONSTRAINT [Return_Reason_Dim_PK] PRIMARY KEY CLUSTERED  ([Return_Reason_Dim_ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [Return_Reason_Dim_Return_Reason_Code_UIX] ON [dbo].[Return_Reason_Dim] ([Return_Reason_Code]) ON [PRIMARY]
GO
