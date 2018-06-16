CREATE TABLE [dbo].[Flash_Sales_Day_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Store_Dim_ID] [int] NOT NULL,
[Sale_Qty] [int] NOT NULL,
[Sale_Value_Home] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Flash_Sales_Day_Fact] ADD CONSTRAINT [Flash_Sales_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Calendar_Dim_ID], [Store_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Flash_Sales_Day_Fact] ADD CONSTRAINT [Flash_Sales_Day_Fact_Day_FK] FOREIGN KEY ([Calendar_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Flash_Sales_Day_Fact] ADD CONSTRAINT [Flash_Sales_Day_Fact_Store_FK] FOREIGN KEY ([Store_Dim_ID]) REFERENCES [dbo].[Store_Dim] ([Store_Dim_ID])
GO
