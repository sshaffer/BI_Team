SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Update_Calendar_Last_Reference_No
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
EXEC dbo.Log_Start @Source, 'Update_Calendar_Last_Reference_No', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

IF NOT EXISTS (SELECT 1 FROM dbo.Last_Reference_Id WHERE Table_Name = 'Calendar_Dim') BEGIN
	INSERT INTO dbo.Last_Reference_Id(Table_Name, Last_Reference_No)
	SELECT 
		'Calendar_Dim' AS Table_Name
		,MAX(Calendar_Dim_Id) AS Last_Refence_No
	FROM dbo.Calendar_Dim
END ELSE BEGIN
	UPDATE dbo.Last_Reference_Id
	SET Last_Reference_No = (SELECT MAX(Calendar_Dim_Id) FROM dbo.Calendar_Dim)
	WHERE Table_Name = 'Calendar_Dim'
END;

SET @Row_Count = @@ROWCOUNT;
EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1
GO
