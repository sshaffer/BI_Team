CREATE TABLE [dbo].[Gift_Card_Top_Ups_Fact]
(
[Calendar_Dim_ID] [smallint] NOT NULL,
[Gift_Card_Serial_No] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Gift_Card_Top_Up_Value] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Gift_Card_Top_Ups_Fact] ADD CONSTRAINT [Gift_Card_Top_Ups_Fact_PK] PRIMARY KEY CLUSTERED  ([Gift_Card_Serial_No], [Calendar_Dim_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Calendar_Day_Gift_Top_UpsX] ON [dbo].[Gift_Card_Top_Ups_Fact] ([Calendar_Dim_ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Gift_Card_Top_Ups_Fact] ADD CONSTRAINT [Calendar_Day_Gift_Top_Ups] FOREIGN KEY ([Calendar_Dim_ID]) REFERENCES [dbo].[Calendar_Dim] ([Calendar_Dim_Id])
GO
