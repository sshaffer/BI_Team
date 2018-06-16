SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[Stores_From_Array] (
	@Array CHAR(5000)
)
RETURNS @Store_Array TABLE (
	STX INT
)
AS BEGIN
	DECLARE @Length INT;
	DECLARE @Counter INT = 1;

	SET @Length = (SELECT LEN(@Array))

	WHILE @Counter <= @Length BEGIN
		IF SUBSTRING(@Array,@Counter,1) = 1 BEGIN
			INSERT INTO @Store_Array VALUES (@Counter);
		END

		SET @Counter = @Counter + 1
	END

	RETURN
END
GO
