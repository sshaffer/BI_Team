CREATE TABLE [dbo].[Customer_Item_Cancellation_Day_Fact]
(
[Cancellation_Date_Dim_ID] [smallint] NOT NULL,
[Order_No] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Store_Dim_ID] [int] NULL,
[Order_Source_Dim_ID] [smallint] NOT NULL,
[Order_Type_Dim_ID] [tinyint] NOT NULL,
[Channel_Dim_ID] [tinyint] NOT NULL,
[Currency_Dim_ID] [tinyint] NULL,
[Cancellation_Reason_Dim_ID] [tinyint] NOT NULL,
[Cancellation_Qty] [int] NOT NULL,
[Cancellation_Value_Home] [money] NOT NULL,
[Cancellation_Value_Curr] [money] NOT NULL,
[Cancellation_Cost_Value_Home] [money] NOT NULL,
[Cancellation_Cost_Value_Curr] [money] NOT NULL,
[Cancellation_VAT_Value_Home] [money] NOT NULL,
[Cancellation_VAT_Value_Curr] [money] NOT NULL,
[Gross_Profit_Value_Home] [money] NOT NULL,
[Gross_Profit_Value_Curr] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Customer_Item_Cancellation_Day_Fact_PK] PRIMARY KEY CLUSTERED  ([Cancellation_Date_Dim_ID], [Order_No], [Customer_Dim_ID], [Item_Dim_ID], [Cancellation_Reason_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Dim_Customer_Item_Cancellation_Day_Fact_FKX] ON [dbo].[Customer_Item_Cancellation_Day_Fact] ([Cancellation_Date_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Cancel_Reason_Cust_Item_Cancel_Day_Fact_FKX] ON [dbo].[Customer_Item_Cancellation_Day_Fact] ([Cancellation_Reason_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Cancellation_Day_Fact_Channel_Dim_FKX] ON [dbo].[Customer_Item_Cancellation_Day_Fact] ([Channel_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Cancellation_Day_Fact_Customer_Dim_FKX] ON [dbo].[Customer_Item_Cancellation_Day_Fact] ([Customer_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Cancellation_Day_Fact_Item_Dim_FKX] ON [dbo].[Customer_Item_Cancellation_Day_Fact] ([Item_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Cancellation_Day_Fact_Order_Source_IDX] ON [dbo].[Customer_Item_Cancellation_Day_Fact] ([Order_Source_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Customer_Item_Cancellation_Day_Fact_Order_Type_Dim_FKX] ON [dbo].[Customer_Item_Cancellation_Day_Fact] ([Order_Type_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Calendar_Day_Dim_Customer_Item_Cancellation_Day_Fact_FK] FOREIGN KEY ([Cancellation_Date_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Cancel_Reason_Cust_Item_Cancel_Day_Fact_FK] FOREIGN KEY ([Cancellation_Reason_Dim_ID]) REFERENCES [dbo].[Cancellation_Reason_Code_Dim] ([Cancellation_Reason_Code_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Customer_Item_Cancellation_Day_Fact_Channel_Dim_FK] FOREIGN KEY ([Channel_Dim_ID]) REFERENCES [dbo].[Channel_Dim] ([Channel_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Customer_Item_Cancellation_Day_Fact_Customer_Dim_FK] FOREIGN KEY ([Customer_Dim_ID]) REFERENCES [dbo].[Customer_Dim] ([Customer_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Customer_Item_Cancellation_Day_Fact_Item_Dim_FK] FOREIGN KEY ([Item_Dim_ID]) REFERENCES [dbo].[Item_Dim] ([Item_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Customer_Item_Cancellation_Day_Fact_Order_Source_Dim_FK] FOREIGN KEY ([Order_Source_Dim_ID]) REFERENCES [dbo].[Order_Source_Dim] ([Order_Source_Dim_ID])
GO
ALTER TABLE [dbo].[Customer_Item_Cancellation_Day_Fact] ADD CONSTRAINT [Customer_Item_Cancellation_Day_Fact_Order_Type_Dim_FK] FOREIGN KEY ([Order_Type_Dim_ID]) REFERENCES [dbo].[Order_Type_Dim] ([Order_Type_Dim_ID])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost Value in local currency', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Cancellation_Day_Fact', 'COLUMN', N'Cancellation_Cost_Value_Curr'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Cost Value in Sterling', 'SCHEMA', N'dbo', 'TABLE', N'Customer_Item_Cancellation_Day_Fact', 'COLUMN', N'Cancellation_Cost_Value_Home'
GO
