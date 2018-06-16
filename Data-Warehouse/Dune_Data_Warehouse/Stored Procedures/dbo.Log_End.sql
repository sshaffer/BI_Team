SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE dbo.Log_End
	@Row_Count BIGINT,
	@Log_Id BIGINT,
	@Log_Load_Id BIGINT,
	@Success BIT
AS

SET NOCOUNT ON;

UPDATE Load_Log
SET Row_Count = @Row_Count,
        End_Time = GETDATE(),
        Load_Id = @Log_Id,
		Success = @Success
WHERE Load_Log_Id = @Log_Load_Id;
GO
