CREATE TABLE [dbo].[Freight_Forwarder_Booking_Dim]
(
[Freight_Forwarder_Booking_Dim_ID] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[Freight_Forwarder_Code] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Vessel_Name] [char] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Booking_Reference] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Ship_Date] [date] NOT NULL,
[Arrival_Date] [date] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Freight_Forwarder_Booking_Dim] ADD CONSTRAINT [Freight_Forwarder_Booking_Dim_PK] PRIMARY KEY CLUSTERED  ([Freight_Forwarder_Booking_Dim_ID], [Freight_Forwarder_Code]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Freight_Forwarder_Freight_Forwarder_BookingX] ON [dbo].[Freight_Forwarder_Booking_Dim] ([Freight_Forwarder_Code]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Spreadsheet info for Freight Forwarder shipping details', 'SCHEMA', N'dbo', 'TABLE', N'Freight_Forwarder_Booking_Dim', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Actual intake date', 'SCHEMA', N'dbo', 'TABLE', N'Freight_Forwarder_Booking_Dim', 'COLUMN', N'Arrival_Date'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Booking in reference for intake e.g. SSH4320', 'SCHEMA', N'dbo', 'TABLE', N'Freight_Forwarder_Booking_Dim', 'COLUMN', N'Booking_Reference'
GO
