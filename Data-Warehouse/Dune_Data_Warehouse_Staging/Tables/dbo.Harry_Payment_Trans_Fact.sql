CREATE TABLE [dbo].[Harry_Payment_Trans_Fact]
(
[Store_Dim_ID] [int] NOT NULL,
[Transaction_Date_Dim_ID] [smallint] NOT NULL,
[Transaction_Time_Dim_ID] [smallint] NOT NULL,
[Register] [int] NOT NULL,
[Docket] [int] NOT NULL,
[Line_Number] [int] NOT NULL,
[Operator_Number] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Payment_Value_Home] [money] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Harry_Payment_Trans_Fact] ADD CONSTRAINT [Harry_Payment_Trans_Fact_PK] PRIMARY KEY CLUSTERED  ([Store_Dim_ID], [Transaction_Date_Dim_ID], [Transaction_Time_Dim_ID], [Register], [Docket], [Line_Number]) ON [PRIMARY]
GO
