CREATE TABLE [dbo].[Harry_Queue_Bust_Trans_Fact]
(
[Store_Dim_ID] [int] NOT NULL,
[Despatch_Date_Dim_ID] [smallint] NOT NULL,
[Despatch_Time_Dim_ID] [smallint] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[Register] [int] NOT NULL,
[Docket] [int] NOT NULL,
[Line_Number] [int] NOT NULL,
[Despatch_Qty] [int] NOT NULL,
[Despatch_Sale_Value_Home] [money] NOT NULL,
[Despatch_Net_Value_Home] [money] NOT NULL,
[Despatch_Tax_Value_Home] [money] NOT NULL,
[Despatch_Cost_Value_Home] [money] NOT NULL,
[Despatch_Margin_Value_Home] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Harry_Queue_Bust_Trans_Fact] ADD CONSTRAINT [Harry_Queue_Bust_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID], [Despatch_Date_Dim_ID], [Despatch_Time_Dim_ID], [Item_Dim_ID], [Register], [Docket], [Line_Number]) ON [PRIMARY]
GO
