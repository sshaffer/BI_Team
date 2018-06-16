SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Merge_Last_Reference_No
	@Source VARCHAR(MAX),
	@Log_ID BIGINT,
	@Cache BIT,
	@Process BIT
AS

SET NOCOUNT ON;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE (
	val BIGINT
)
INSERT INTO @return
EXEC dbo.Log_Start @Source, 'Merge_Last_Reference_No', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

MERGE INTO dbo.Last_Reference_Id target
USING Dune_Data_Warehouse_Staging..Last_Reference_Id source
ON source.Table_Name = target.Table_Name
WHEN MATCHED THEN
UPDATE
SET Last_Reference_No = source.Last_Reference_No
WHEN NOT MATCHED THEN
INSERT (
	Table_Name
	,Last_Reference_No
	)
VALUES (
	source.Table_Name
	,source.Last_Reference_No
);

SET @Row_Count = @@ROWCOUNT;
EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1
GO
