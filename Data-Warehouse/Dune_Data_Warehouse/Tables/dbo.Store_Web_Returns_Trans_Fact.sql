CREATE TABLE [dbo].[Store_Web_Returns_Trans_Fact]
(
[Sale_Commission_Date_Dim_ID] [smallint] NOT NULL,
[Time_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Return_Reason_Dim_ID] [tinyint] NOT NULL,
[Return_Value] [money] NOT NULL,
[Return_Qty] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Web_Returns_Trans_Fact] ADD CONSTRAINT [Store_Web_Returns_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([Sale_Commission_Date_Dim_ID], [Time_Dim_ID], [Store_Dim_ID], [Item_Dim_ID], [Return_Reason_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Store_Web_Returns_Trans_Fact] ADD CONSTRAINT [Store_Web_Returns_Trans_Fact_Item_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Web_Returns_Trans_Fact] ADD CONSTRAINT [Store_Web_Returns_Trans_Fact_Return_Reason_FK] FOREIGN KEY ([Return_Reason_Dim_ID]) REFERENCES [dbo].[Return_Reason_Dim] ([Return_Reason_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Web_Returns_Trans_Fact] ADD CONSTRAINT [Store_Web_Returns_Trans_Fact_Date_FK] FOREIGN KEY ([Sale_Commission_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Store_Web_Returns_Trans_Fact] ADD CONSTRAINT [Store_Web_Returns_Trans_Fact_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
ALTER TABLE [dbo].[Store_Web_Returns_Trans_Fact] ADD CONSTRAINT [Store_Web_Returns_Trans_Fact_Time_FK] FOREIGN KEY ([Time_Dim_ID]) REFERENCES [dbo].[Time_Dim] ([Time_Dim_ID])
GO
