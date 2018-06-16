SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Merchandising_Division_LFL_Week_Fact]
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
           ,'Merge_Merchandising_Division_LFL_Week_Fact'
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

    MERGE INTO dbo.Merchandising_Division_LFL_Week_Fact target
    USING
        ( 

		SELECT
            thisYear.Sale_Week_Dim_ID AS Calendar_Week_Dim_Id
           ,thisYear.Store_Dim_ID
           ,thisYear.Division_Dim_Id
           ,CASE WHEN ( thisYear.total IS NOT NULL
                        AND lastYear.total IS NOT NULL
                      ) THEN 1
                 ELSE 0
            END AS LFL
           ,CASE WHEN ( thisYear.total IS NOT NULL
                        AND nextYear.total IS NOT NULL
                      ) THEN 1
                 ELSE 0
            END AS LFL_LY
          FROM
            ( SELECT
                f.Sale_Week_Dim_ID
               ,cal.Week_Timeline
               ,f.Store_Dim_ID
               ,p.Division_Dim_Id
               ,SUM(f.Actual_Sales_Value_Home) total
              FROM
                dbo.Sale_Week_Fact f
              JOIN
                ( SELECT DISTINCT
                    Calendar_Week_Dim_Id
                   ,Week_Timeline
                  FROM
                    dbo.BIS_Calendar_Dim_View
                ) cal
                ON cal.Calendar_Week_Dim_Id = f.Sale_Week_Dim_ID
              JOIN
                dbo.Product_Dim p
                ON p.Item_Dim_ID = f.Item_Dim_ID
              GROUP BY
                f.Sale_Week_Dim_ID
               ,cal.Week_Timeline
               ,f.Store_Dim_ID
               ,p.Division_Dim_Id
            ) thisYear
          LEFT JOIN ( SELECT
                        f.Sale_Week_Dim_ID
                       ,cal.Week_Timeline
                       ,f.Store_Dim_ID
                       ,p.Division_Dim_Id
                       ,SUM(f.Actual_Sales_Value_Home) total
                      FROM
                        dbo.Sale_Week_Fact f
                      JOIN
                        ( SELECT DISTINCT
                            Calendar_Week_Dim_Id
                           ,Week_Timeline
                          FROM
                            dbo.BIS_Calendar_Dim_View
                        ) cal
                        ON cal.Calendar_Week_Dim_Id = f.Sale_Week_Dim_ID
                      JOIN
                        dbo.Product_Dim p
                        ON p.Item_Dim_ID = f.Item_Dim_ID
                      GROUP BY
                        f.Sale_Week_Dim_ID
                       ,cal.Week_Timeline
                       ,f.Store_Dim_ID
                       ,p.Division_Dim_Id
                    ) lastYear
            ON lastYear.Division_Dim_Id = thisYear.Division_Dim_Id
               AND lastYear.Store_Dim_ID = thisYear.Store_Dim_ID
               AND lastYear.Week_Timeline = thisYear.Week_Timeline - 52
          LEFT JOIN ( SELECT
                        f.Sale_Week_Dim_ID
                       ,cal.Week_Timeline
                       ,f.Store_Dim_ID
                       ,p.Division_Dim_Id
                       ,SUM(f.Actual_Sales_Value_Home) total
                      FROM
                        dbo.Sale_Week_Fact f
                      JOIN
                        ( SELECT DISTINCT
                            Calendar_Week_Dim_Id
                           ,Week_Timeline
                          FROM
                            dbo.BIS_Calendar_Dim_View
                        ) cal
                        ON cal.Calendar_Week_Dim_Id = f.Sale_Week_Dim_ID
                      JOIN
                        dbo.Product_Dim p
                        ON p.Item_Dim_ID = f.Item_Dim_ID
                      GROUP BY
                        f.Sale_Week_Dim_ID
                       ,cal.Week_Timeline
                       ,f.Store_Dim_ID
                       ,p.Division_Dim_Id
                    ) nextYear
            ON nextYear.Division_Dim_Id = thisYear.Division_Dim_Id
               AND nextYear.Store_Dim_ID = thisYear.Store_Dim_ID
               AND nextYear.Week_Timeline = thisYear.Week_Timeline + 52
		  
        ) source
    ON source.Calendar_Week_Dim_ID = target.Calendar_Week_Dim_ID
        AND source.Store_Dim_ID = target.Store_Dim_ID
        AND source.Division_Dim_Id = target.Division_Dim_Id
    WHEN MATCHED THEN
        UPDATE SET
               LFL = source.LFL
              ,LFL_LY = source.LFL_LY
    WHEN NOT MATCHED THEN
        INSERT
               ( Store_Dim_ID
               ,Calendar_Week_Dim_ID
               ,Division_Dim_Id
               ,LFL
               ,LFL_LY
               )
        VALUES ( source.Store_Dim_ID
               ,source.Calendar_Week_Dim_ID
               ,source.Division_Dim_Id
               ,source.LFL
               ,source.LFL_LY
               );


	SET @Row_Count = @@ROWCOUNT;

	/* do same for warehouses */
	/* Warehouses always LFL */
	MERGE INTO dbo.Merchandising_Division_LFL_Week_Fact target
	USING (
          SELECT
            cal.Calendar_Week_Dim_Id
           ,s.Store_Dim_ID
           ,d.Division_Dim_Id
           ,LFL = 1
           ,LFL_LY = 1
          FROM
            dbo.BIS_Store_Dim s
          CROSS JOIN dbo.Division_Dim d
          CROSS JOIN ( SELECT DISTINCT
                        Calendar_Week_Dim_Id
                       FROM
                        dbo.BIS_Calendar_Dim_View
                       WHERE
                        Year_Timeline > -2
                        AND Year_Timeline <= 0
                     ) cal
          WHERE
            s.Warehouse_Flag = 'Y'
	) source
		ON source.Calendar_Week_Dim_Id = target.Calendar_Week_Dim_ID
		AND source.Store_Dim_ID = target.Store_Dim_ID
		AND source.Division_Dim_Id = target.Division_Dim_Id
	WHEN MATCHED THEN 
		UPDATE SET
               LFL = source.LFL
              ,LFL_LY = source.LFL_LY
    WHEN NOT MATCHED THEN
        INSERT
               ( Store_Dim_ID
               ,Calendar_Week_Dim_ID
               ,Division_Dim_Id
               ,LFL
               ,LFL_LY
               )
        VALUES ( source.Store_Dim_ID
               ,source.Calendar_Week_Dim_ID
               ,source.Division_Dim_Id
               ,source.LFL
               ,source.LFL_LY
               );
			

    SET @Row_Count = @Row_Count + @@ROWCOUNT;
    COMMIT TRANSACTION;


END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;

    SELECT
        @Error_Message = ERROR_MESSAGE()
       ,@Error_Number = ERROR_NUMBER()
       ,@Error_Severity = ERROR_SEVERITY()
       ,@Error_State = ERROR_STATE();

    SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Merchandising_Division_LFL_Week_Fact: (%d)%s';
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
