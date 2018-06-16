
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_BIS_Channel_Dim]
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
EXEC dbo.Log_Start @Source, 'Merge_BIS_Channel_Dim', @Cache, @Process;
SET @Log_Load_ID = (SELECT TOP 1 val FROM @return);

/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

BEGIN TRANSACTION 

MERGE INTO dbo.BIS_Channel_Dim target
USING
    ( SELECT
        ch.Channel_Dim_ID
       ,ch.Channel_Code
       ,ch.Channel_Name
       ,ch.Store_Dim_ID
	   ,st.Store_Number
	   ,st.Store_Name
       ,st.Zone_Dim_ID
       ,st.Zone_Code
       ,st.Zone_Name
       ,st.Territory_Dim_ID
       ,st.Territory_Code
       ,st.Territory_Name
       ,st.Region_Dim_ID
       ,st.Region_Code
       ,st.Region_Name
       ,st.District_Dim_ID
       ,st.District_Code
       ,st.District_Name
      FROM
        dbo.Channel_Dim ch
      JOIN
        dbo.BIS_Store_Dim st
        ON st.Store_Dim_ID = ch.Store_Dim_ID
    ) source
ON source.Channel_Dim_ID = target.Channel_Dim_ID
WHEN MATCHED THEN
    UPDATE SET
               Channel_Code = source.Channel_Code
              ,Channel_Name = source.Channel_Name
              ,Store_Dim_ID = source.Store_Dim_ID
			  ,Store_Number = source.Store_Number
			  ,Store_Name = source.Store_Name
              ,Zone_Dim_ID = source.Zone_Dim_ID
              ,Zone_Code = source.Zone_Code
              ,Zone_Name = source.Zone_Name
              ,Territory_Dim_ID = source.Territory_Dim_ID
              ,Territory_Code = source.Territory_Code
              ,Territory_Name = source.Territory_Name
              ,Region_Dim_ID = source.Region_Dim_ID
              ,Region_Code = source.Region_Code
              ,Region_Name = source.Region_Name
              ,District_Dim_ID = source.District_Dim_ID
              ,District_Code = source.District_Code
              ,District_Name = source.District_Name
WHEN NOT MATCHED THEN
    INSERT
           (Channel_Dim_ID
           ,Channel_Code
           ,Channel_Name
           ,Store_Dim_ID
		   ,Store_Number
		   ,Store_Name
           ,Zone_Dim_ID
           ,Zone_Code
           ,Zone_Name
           ,Territory_Dim_ID
           ,Territory_Code
           ,Territory_Name
           ,Region_Dim_ID
           ,Region_Code
           ,Region_Name
           ,District_Dim_ID
           ,District_Code
           ,District_Name
           )
    VALUES (source.Channel_Dim_ID
           ,source.Channel_Code
           ,source.Channel_Name
           ,source.Store_Dim_ID
		   ,source.Store_Number
		   ,source.Store_Name
           ,source.Zone_Dim_ID
           ,source.Zone_Code
           ,source.Zone_Name
           ,source.Territory_Dim_ID
           ,source.Territory_Code
           ,source.Territory_Name
           ,source.Region_Dim_ID
           ,source.Region_Code
           ,source.Region_Name
           ,source.District_Dim_ID
           ,source.District_Code
           ,source.District_Name
           );

SET @Row_Count = @@ROWCOUNT;
COMMIT TRANSACTION;


END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;

SELECT @Error_Message = ERROR_MESSAGE(),
	   @Error_Number = ERROR_NUMBER(),
	   @Error_Severity = ERROR_SEVERITY(),
	   @Error_State = ERROR_STATE();

SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_BIS_Channel_Dim: (%d)%s';
RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 0;
RETURN -1;

END CATCH;


EXEC dbo.Log_End @Row_Count, @Log_ID, @Log_Load_ID, 1;
RETURN 0;

GO
