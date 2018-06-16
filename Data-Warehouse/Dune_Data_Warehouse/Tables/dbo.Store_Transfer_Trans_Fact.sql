CREATE TABLE [dbo].[Store_Transfer_Trans_Fact]
(
[Transfer_Date_Dim_ID] [smallint] NOT NULL,
[From_Store_Dim_ID] [int] NOT NULL,
[Item_Dim_ID] [int] NOT NULL,
[To_Store_Dim_ID] [int] NOT NULL,
[Store_Acknowledgement_Date_Dim_ID] [smallint] NOT NULL,
[Delivery_Status] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Transfer_Qty] [int] NOT NULL,
[Transfer_Cost_Value] [money] NOT NULL,
[Transfer_Retail_Value] [money] NOT NULL,
[Acknowledgement_Qty] [int] NOT NULL,
[Acknowledgement_Cost_Value] [money] NOT NULL,
[Acknowledgement_Retail_Value] [money] NOT NULL,
[Discrepancy_Qty] [int] NOT NULL,
[Discrepancy_Cost_Value] [money] NOT NULL,
[Distribution_Number] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Allocation_Number] [char] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Distribution_Sequence_Number] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
