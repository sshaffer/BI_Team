SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Increment_Last_Load_Id]
AS

SET NOCOUNT ON;

DECLARE @Last_Load_Id BIGINT;

SET @Last_Load_Id = (
		SELECT Last_Load_Id
		FROM Last_Load_Id l
		INNER JOIN (
			SELECT Max(Load_Date) AS Last_Load_Date
			FROM Last_Load_Id
		) Last_Load
		ON Last_Load.Last_Load_Date = l.Load_Date
);

INSERT INTO Last_Load_Id (
	Last_Load_Id
	,Load_Date
) VALUES (
	@Last_Load_Id + 1
	,GETDATE()
);
GO
