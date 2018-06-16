CREATE TABLE [dbo].[Sequence_Number_Dim]
(
[Sequence_Number] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sequence_Number_Dim] ADD CONSTRAINT [Sequence_Number_Dim_PK] PRIMARY KEY CLUSTERED  ([Sequence_Number]) ON [PRIMARY]
GO
