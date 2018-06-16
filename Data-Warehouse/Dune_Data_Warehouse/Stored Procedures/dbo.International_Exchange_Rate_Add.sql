SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.International_Exchange_Rate_Add
	@Currency_Code CHAR(3),
	@From_Date DATETIME,
	@To_Date DATETIME,
	@Rate DECIMAL(11,3)
AS

BEGIN TRY 

BEGIN TRANSACTION

IF EXISTS (
	SELECT * 
	FROM dbo.International_Currency_Conversion_Rate_Fact
	WHERE Currency_Code = @Currency_Code
	AND To_Date = '2025-01-01'
)
BEGIN
	UPDATE dbo.International_Currency_Conversion_Rate_Fact
	SET To_Date = CONVERT(DATE,@To_Date)
	WHERE Currency_Code = @Currency_Code
	AND To_Date = '2025-01-01'
END;

INSERT INTO dbo.International_Currency_Conversion_Rate_Fact (
	Currency_Code,
	From_Date,
	To_Date,
	Rate
) VALUES (
	@Currency_Code,
	CONVERT(DATE,@From_Date),
	'2025-01-01',
	@Rate
);

COMMIT TRANSACTION

SELECT 0 AS [ReturnCode],'OK' AS [Message];

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION

SELECT -1 AS [ReturnCode],'Failed to add Currency Exchange Rate ' + @Currency_Code + ' (' + @Rate + ').' AS [Message];

END CATCH
GO
GRANT EXECUTE ON  [dbo].[International_Exchange_Rate_Add] TO [DUNE\IISBISWEB]
GO
