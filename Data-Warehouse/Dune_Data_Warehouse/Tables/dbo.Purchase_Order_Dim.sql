CREATE TABLE [dbo].[Purchase_Order_Dim]
(
[Purchase_Order_Dim_ID] [bigint] NOT NULL,
[Purchase_Order_Number] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Purchase_Order_Sequence_Number] [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Purchase_Order_Dim] ADD 
CONSTRAINT [Purchase_Order_Dim_PK] PRIMARY KEY CLUSTERED  ([Purchase_Order_Dim_ID], [Purchase_Order_Number], [Purchase_Order_Sequence_Number]) ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [Purchase_Order_Dim_PONum_Seq_UIX] ON [dbo].[Purchase_Order_Dim] ([Purchase_Order_Number], [Purchase_Order_Sequence_Number]) ON [PRIMARY]

GO
