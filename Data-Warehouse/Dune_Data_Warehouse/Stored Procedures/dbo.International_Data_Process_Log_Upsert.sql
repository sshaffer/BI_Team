SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[International_Data_Process_Log_Upsert]
	@File_Name VARCHAR(8000) = NULL,
	@Process_Date VARCHAR(19) = NULL,
	@Status VARCHAR(1000) = NULL
AS

SET NOCOUNT ON;

IF @File_Name IS NULL 
BEGIN
	RAISERROR('@File_Name is required.',16,1)
	RETURN
END ELSE BEGIN
	DECLARE @name NVARCHAR(255)
	DECLARE @pos INT

	WHILE CHARINDEX('\', @File_Name) > 0
	BEGIN
		SELECT @pos  = CHARINDEX('\', @File_Name)  
		SELECT @File_Name = SUBSTRING(@File_Name, @pos+1, LEN(@File_Name)-@pos)
	END;
END;

IF @Process_Date IS NULL
BEGIN
	SET @Process_Date = CAST(GETDATE() AS DATETIME2(0));
END;

IF @Status IS NULL 
BEGIN	
	SET @Status = 'Processing'
END;

MERGE INTO International_Data_Process_Log target
USING (
	SELECT
		@File_Name AS File_Name,
		@Process_Date AS Process_Date,
		@Status AS Status
) source
	ON target.File_Name = source.File_Name
	AND target.Processed_Date = source.Process_Date
WHEN MATCHED THEN
UPDATE SET 
	Status = source.Status
WHEN NOT MATCHED THEN
INSERT (
	File_Name,
	Processed_Date,
	Status
) VALUES (
	source.File_Name,
	source.Process_Date,
	source.Status
);

SELECT @Process_Date AS Process_Date;
GO
