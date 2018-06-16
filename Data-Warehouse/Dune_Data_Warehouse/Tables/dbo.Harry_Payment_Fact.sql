CREATE TABLE [dbo].[Harry_Payment_Fact]
(
[Store_Dim_ID] [int] NOT NULL,
[Transaction_Date_Dim_ID] [smallint] NOT NULL,
[Transaction_Time_Dim_ID] [smallint] NOT NULL,
[Register] [int] NOT NULL,
[Docket] [int] NOT NULL,
[Payment_Value_Home] [money] NOT NULL,
[Payment_Qty] [int] NOT NULL CONSTRAINT [Harry_Payment_Fact_Qty_DF] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Harry_Payment_Fact] ADD CONSTRAINT [Harry_Payment_Fact_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID], [Transaction_Date_Dim_ID], [Transaction_Time_Dim_ID], [Register], [Docket]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Harry_Payment_Fact] ADD CONSTRAINT [Harry_Payment_Fact_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Harry_Payment_Fact] ADD CONSTRAINT [Harry_Payment_Fact_Date_FK] FOREIGN KEY ([Transaction_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Harry_Payment_Fact] ADD CONSTRAINT [Harry_Payment_Fact_Time_FK] FOREIGN KEY ([Transaction_Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
