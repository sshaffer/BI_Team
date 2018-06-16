SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.Update_Last_Reference_No
	@Table_Name VARCHAR(256)
	,@Last_Reference_No BIGINT
AS

IF EXISTS (SELECT 1 FROM Last_Reference_Id WHERE Table_Name = @Table_Name) BEGIN
	UPDATE Last_Reference_Id
	SET Last_Reference_No = @Last_Reference_No
	WHERE Table_Name = @Table_Name
END ELSE BEGIN
	INSERT INTO Last_Reference_Id (Table_Name, Last_Reference_No)
	VALUES (@Table_Name, @Last_Reference_No)
END
GO
