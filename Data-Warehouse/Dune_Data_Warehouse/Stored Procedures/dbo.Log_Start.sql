SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Log_Start
	@Source VARCHAR(256),
	@Table_Name VARCHAR(256),
	@Cache BIT,
	@Process BIT
AS

SET NOCOUNT ON;

INSERT INTO Load_Log(Source, Table_Name, Start_Time, Cache, Process)
VALUES (@Source, @Table_Name, GETDATE(), @Cache, @Process);

SELECT SCOPE_IDENTITY() AS Load_Log_Id;
GO
