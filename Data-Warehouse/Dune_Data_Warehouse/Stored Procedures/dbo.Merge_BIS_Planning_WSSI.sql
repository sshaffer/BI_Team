
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_BIS_Planning_WSSI]
    @Source VARCHAR(MAX)
   ,@Log_ID BIGINT
   ,@Cache BIT
   ,@Process BIT
AS
SET NOCOUNT ON;

DECLARE @Row_Count BIGINT;
DECLARE @Log_Load_ID BIGINT;
DECLARE @return TABLE ( val BIGINT )
INSERT  INTO @return
        EXEC dbo.Log_Start
            @Source
           ,'Merge_BIS_Planning_WSSI'
           ,@Cache
           ,@Process;
SET @Log_Load_ID = ( SELECT TOP 1
                        val
                     FROM
                        @return
                   );


/* Process Data */
DECLARE @Error_Response NVARCHAR(4000);
DECLARE @Error_Message NVARCHAR(4000);
DECLARE @Error_Number INT;
DECLARE @Error_State INT;
DECLARE @Error_Severity INT;

BEGIN TRY

    BEGIN TRANSACTION 

    MERGE INTO dbo.BIS_Planning_WSSI target
    USING
        ( SELECT
            w.Calendar_Week_Dim_ID
           ,w.Subdepartment_Dim_ID
           ,w.Department_Dim_ID
           ,w.Division_Dim_ID
           ,w.Territory_Dim_ID
           ,w.Zone_Dim_ID
           ,[Mgn_%_Plan_FP] = MAX(CASE WHEN m.Measure_Code = 'Mgn%_PlnFP'
                                       THEN w.Measure_Value_Home
                                       ELSE 0
                                  END)
           ,[Mgn_%_Plan_MD] = MAX(CASE WHEN m.Measure_Code = 'Mgn%_PlnMD'
                                       THEN w.Measure_Value_Home
                                       ELSE 0
                                  END)
           ,[Sales_Tot_£_Plan] = MAX(CASE WHEN m.Measure_Code = 'Sls_Rtl_Pln'
                                          THEN w.Measure_Value_Home
                                          ELSE 0
                                     END)
           ,[Sales_Tot_£_FP_Plan] = MAX(CASE WHEN m.Measure_Code = 'Sls_Rtl_FPPln'
                                             THEN w.Measure_Value_Home
                                             ELSE 0
                                        END)
           ,[Sales_Tot_£_MD_Plan] = MAX(CASE WHEN m.Measure_Code = 'Sls_Rtl_MDPln'
                                             THEN w.Measure_Value_Home
                                             ELSE 0
                                        END)
           ,[VAT] = MAX(CASE WHEN m.Measure_Code = 'VAT'
                             THEN w.Measure_Value_Home
                             ELSE 0
                        END)
           ,[Sales_Totl_£_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Sls_Rtl_Appr'
                                                THEN w.Measure_Value_Home
                                                ELSE 0
                                           END)
           ,[Profit_£_Tot_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Profit_Appr'
                                                THEN w.Measure_Value_Home
                                                ELSE 0
                                           END)
           ,[Intake_U_FP_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Intake_U_FPApp'
                                               THEN w.Measure_Value_Home
                                               ELSE 0
                                          END)
           ,[Sales_U_FP_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Sls_U_FPApp'
                                              THEN w.Measure_Value_Home
                                              ELSE 0
                                         END)
           ,[Sales_U_MD_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'SlS_U_MDApp'
                                              THEN w.Measure_Value_Home
                                              ELSE 0
                                         END)
           ,[Sales_Tot_U_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Sls_U_Appr'
                                               THEN w.Measure_Value_Home
                                               ELSE 0
                                          END)
			
			/* Added 2014-11-24 */			
			,[Sales_U_FP_Plan] = MAX(CASE WHEN m.Measure_Code = 'Sls_U_FPPln'
										  THEN w.Measure_Value_Home
										  ELSE 0
									 END)
			,[Sales_U_MD_Plan] = MAX(CASE WHEN m.Measure_Code = 'Sls_U_MDPln'
										  THEN w.Measure_Value_Home
										  ELSE 0
									 END)
			,[Sales_£_FP_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Sls_Rtl_FPAppr'
										  THEN w.Measure_Value_Home
										  ELSE 0
									 END)
			,[Sales_£_MD_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Sls_Rtl_MDAppr'
										  THEN w.Measure_Value_Home
										  ELSE 0
									 END)
			,[Profit_£_FP_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Profit_FPAppr'
										  THEN w.Measure_Value_Home
										  ELSE 0
									 END)
			,[Profit_£_MD_Prev_Fcst] = MAX(CASE WHEN m.Measure_Code = 'Profit_MDAppr'
										  THEN w.Measure_Value_Home
										  ELSE 0
									 END)
			/* Added 2014-11-24 End */
          FROM
            dbo.Planning_WSSI w
          JOIN
            dbo.Planning_Measure_Dim m
            ON m.Planning_Measure_Dim_ID = w.Planning_Measure_Dim_ID
               AND m.Planning_Plan_Dim_ID = w.Planning_Plan_Dim_ID
          GROUP BY
            w.Calendar_Week_Dim_ID
           ,w.Subdepartment_Dim_ID
           ,w.Department_Dim_ID
           ,w.Division_Dim_ID
           ,w.Territory_Dim_ID
           ,w.Zone_Dim_ID
        ) source
    ON source.Calendar_Week_Dim_ID = target.Calendar_Week_Dim_ID
        AND source.Subdepartment_Dim_ID = target.Subdepartment_Dim_ID
        --AND source.Department_Dim_ID = target.Department_Dim_ID
        --AND source.Division_Dim_ID = target.Division_Dim_ID
        --AND source.Territory_Dim_ID = target.Territory_Dim_ID
        --AND source.Zone_Dim_ID = target.Zone_Dim_ID
    WHEN MATCHED THEN
        UPDATE SET
			Department_Dim_ID = source.Department_Dim_ID
			,Division_Dim_ID = source.Division_Dim_ID
			,Territory_Dim_ID = source.Territory_Dim_ID
			,Zone_Dim_ID = source.Zone_Dim_ID
               ,[Mgn_%_Plan_FP] = source.[Mgn_%_Plan_FP]
              ,[Mgn_%_Plan_MD] = source.[Mgn_%_Plan_MD]
              ,[Sales_Tot_£_Plan] = source.[Sales_Tot_£_Plan]
              ,[Sales_Tot_£_FP_Plan] = source.[Sales_Tot_£_FP_Plan]
              ,[Sales_Tot_£_MD_Plan] = source.[Sales_Tot_£_MD_Plan]
              ,[VAT] = source.[VAT]
              ,[Sales_Totl_£_Prev_Fcst] = source.[Sales_Totl_£_Prev_Fcst]
              ,[Profit_£_Tot_Prev_Fcst] = source.[Profit_£_Tot_Prev_Fcst]
              ,[Intake_U_FP_Prev_Fcst] = source.[Intake_U_FP_Prev_Fcst]
              ,[Sales_U_FP_Prev_Fcst] = source.[Sales_U_FP_Prev_Fcst]
              ,[Sales_U_MD_Prev_Fcst] = source.[Sales_U_MD_Prev_Fcst]
              ,[Sales_Tot_U_Prev_Fcst] = source.[Sales_Tot_U_Prev_Fcst]
			  ,[Sales_U_FP_Plan] = source.[Sales_U_FP_Plan]
			  ,[Sales_U_MD_Plan] = source.[Sales_U_MD_Plan]
			  ,[Sales_£_FP_Prev_Fcst] = source.[Sales_£_FP_Prev_Fcst]
			  ,[Sales_£_MD_Prev_Fcst] = source.[Sales_£_MD_Prev_Fcst]
			  ,[Profit_£_FP_Prev_Fcst] = source.[Profit_£_FP_Prev_Fcst]
			  ,[Profit_£_MD_Prev_Fcst] = source.[Profit_£_MD_Prev_Fcst]
    WHEN NOT MATCHED THEN
        INSERT
               ( Calendar_Week_Dim_ID
               ,Subdepartment_Dim_ID
               ,Department_Dim_ID
               ,Division_Dim_ID
               ,Territory_Dim_ID
               ,Zone_Dim_ID
               ,[Mgn_%_Plan_FP]
               ,[Mgn_%_Plan_MD]
               ,[Sales_Tot_£_Plan]
               ,[Sales_Tot_£_FP_Plan]
               ,[Sales_Tot_£_MD_Plan]
               ,[VAT]
               ,[Sales_Totl_£_Prev_Fcst]
               ,[Profit_£_Tot_Prev_Fcst]
               ,[Intake_U_FP_Prev_Fcst]
               ,[Sales_U_FP_Prev_Fcst]
               ,[Sales_U_MD_Prev_Fcst]
               ,[Sales_Tot_U_Prev_Fcst]
			   ,[Sales_U_FP_Plan]
			   ,[Sales_U_MD_Plan] 
			   ,[Sales_£_FP_Prev_Fcst]
			   ,[Sales_£_MD_Prev_Fcst] 
			   ,[Profit_£_FP_Prev_Fcst] 
			   ,[Profit_£_MD_Prev_Fcst] 
               )
        VALUES ( source.Calendar_Week_Dim_ID
               ,source.Subdepartment_Dim_ID
               ,source.Department_Dim_ID
               ,source.Division_Dim_ID
               ,source.Territory_Dim_ID
               ,source.Zone_Dim_ID
               ,source.[Mgn_%_Plan_FP]
               ,source.[Mgn_%_Plan_MD]
               ,source.[Sales_Tot_£_Plan]
               ,source.[Sales_Tot_£_FP_Plan]
               ,source.[Sales_Tot_£_MD_Plan]
               ,source.[VAT]
               ,source.[Sales_Totl_£_Prev_Fcst]
               ,source.[Profit_£_Tot_Prev_Fcst]
               ,source.[Intake_U_FP_Prev_Fcst]
               ,source.[Sales_U_FP_Prev_Fcst]
               ,source.[Sales_U_MD_Prev_Fcst]
               ,source.[Sales_Tot_U_Prev_Fcst]
			   ,source.[Sales_U_FP_Plan]
			   ,source.[Sales_U_MD_Plan] 
			   ,source.[Sales_£_FP_Prev_Fcst]
			   ,source.[Sales_£_MD_Prev_Fcst] 
			   ,source.[Profit_£_FP_Prev_Fcst] 
			   ,source.[Profit_£_MD_Prev_Fcst] 
               );

    SET @Row_Count = @@ROWCOUNT;
    COMMIT TRANSACTION;


END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;

    SELECT
        @Error_Message = ERROR_MESSAGE()
       ,@Error_Number = ERROR_NUMBER()
       ,@Error_Severity = ERROR_SEVERITY()
       ,@Error_State = ERROR_STATE();

    SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_BIS_Planning_WSSI: (%d)%s';
    RAISERROR(@Error_Response, @Error_Severity, @Error_State,@Error_Number,@Error_Message);

    EXEC dbo.Log_End
        @Row_Count
       ,@Log_ID
       ,@Log_Load_ID
       ,0;
    RETURN -1;

END CATCH;


EXEC dbo.Log_End
    @Row_Count
   ,@Log_ID
   ,@Log_Load_ID
   ,1;
RETURN 0;

GO
