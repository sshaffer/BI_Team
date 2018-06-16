CREATE TABLE [dbo].[Gift_Card_Dim]
(
[Purchase_Date] [date] NOT NULL,
[Customer_Dim_ID] [int] NOT NULL,
[Gift_Card_Serial_No] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Activation_Date] [date] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Gift_Card_Dim] ADD
CONSTRAINT [Gift_Card_Dim_Customer_Dim_FK] FOREIGN KEY ([Customer_Dim_ID]) REFERENCES [dbo].[Customer_Dim] ([Customer_Dim_ID])

GO
ALTER TABLE [dbo].[Gift_Card_Dim] ADD CONSTRAINT [Gift_Card_Dim_PK] PRIMARY KEY CLUSTERED  ([Purchase_Date], [Gift_Card_Serial_No]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Gift_Card_Dim_Customer_Dim_FKX] ON [dbo].[Gift_Card_Dim] ([Customer_Dim_ID]) ON [PRIMARY]
GO
