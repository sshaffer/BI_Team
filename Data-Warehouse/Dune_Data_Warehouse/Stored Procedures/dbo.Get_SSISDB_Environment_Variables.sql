SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Get_SSISDB_Environment_Variables]
	@Filter VARCHAR(1000) = null
AS

SET @Filter = ISNULL(@Filter,'%');

SELECT
	CONVERT(VARCHAR(1000),ISNULL(e.environment_name,'')) AS Environment,
	CONVERT(VARCHAR(1000),ISNULL(v.name,'')) AS Name,
	CONVERT(VARCHAR(1000),ISNULL(v.value,'')) AS Value
FROM SSISDB.Internal.environment_variables v
JOIN SSISDB.Internal.environments e
	ON v.environment_id = e.environment_id
WHERE name LIKE @Filter	

GO
GRANT EXECUTE ON  [dbo].[Get_SSISDB_Environment_Variables] TO [DUNE\IISBISWEB]
GO
