USE [master]
GO

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'sp_Kill_Connections_To_BIS' 
) BEGIN
	DROP PROCEDURE dbo.sp_Kill_Connections_To_BIS;
END;
GO

CREATE PROCEDURE dbo.sp_Kill_Connections_To_BIS
AS

DECLARE @Kill VARCHAR(8000) = '';
SELECT 
	@Kill = @Kill + 'kill ' + CONVERT(VARCHAR(5), spid) + ';'
FROM master..sysprocesses
WHERE dbid IN ( 
	DB_ID('Dune_Data_Warehouse'), 
	DB_ID('Dune_Data_Warehouse_PreStaging'), 
	DB_ID('Dune_Data_Warehouse_Staging'), 
	DB_ID('Dune_Data_Warehouse_PreStaging_Archive')
);
IF (@Kill <> '') BEGIN
	EXEC (@Kill);
END
GO