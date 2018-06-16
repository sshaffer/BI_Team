
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Merge_Purchase_Order_Fact]
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
           ,'Merge_Purchase_Order_Fact'
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

    DECLARE @CalendarDate DATE = ( SELECT
                                    Calendar_Date
                                   FROM
                                    dbo.Calendar_Dim
                                   WHERE
                                    Relative_Day = 0
                                 );

    BEGIN TRANSACTION

    MERGE INTO dbo.Purchase_Order_Fact target
    USING Dune_Data_Warehouse_Staging..Purchase_Order_Fact source
    ON source.Purchase_Order_Dim_ID = target.Purchase_Order_Dim_ID
        AND source.From_Date = target.From_Date
        AND CASE WHEN source.Current_Flag = 0 THEN 1
                 ELSE source.Current_Flag
            END = target.Current_Flag
    WHEN MATCHED THEN
        UPDATE SET
               To_Date = source.To_Date
              ,Current_Flag = source.Current_Flag
              ,Created_Date_Dim_ID = source.Created_Date_Dim_ID
              ,Header_Ship_Date_Dim_ID = source.Header_Ship_Date_Dim_ID
              ,Item_Ship_Date_Dim_ID = source.Item_Ship_Date_Dim_ID
              ,Header_Anticipated_Delivery_Date_Dim_ID = source.Header_Anticipated_Delivery_Date_Dim_ID
              ,Item_Anticipated_Delivery_Date_Dim_ID = source.Item_Anticipated_Delivery_Date_Dim_ID
              ,Item_Closed = source.Item_Closed
              ,ASN_Code = source.ASN_Code
              ,Commodity_Code = source.Commodity_Code
              ,Item_Country_of_Manufacture = source.Item_Country_of_Manufacture
              ,Item_Country_of_Origin = source.Item_Country_of_Origin
              ,Store_Dim_ID = source.Store_Dim_ID
              ,Item_Dim_ID = source.Item_Dim_ID
              ,Landed_Cost = source.Landed_Cost
              ,Vendor_Cost = source.Vendor_Cost
              ,Retail_Cost = source.Retail_Cost
              ,Supplier_Cost = source.Supplier_Cost
              ,Margin = source.Margin
              ,Order_Qty = source.Order_Qty
              ,Order_Component_Qty = source.Order_Component_Qty
              ,Received_Qty = source.Received_Qty
              ,Received_Component_Qty = source.Received_Component_Qty
              ,Header_Air_Sequence = source.Header_Air_Sequence
              ,Header_Sea_Sequence = source.Header_Sea_Sequence
              ,Header_Duty_Sequence = source.Header_Duty_Sequence
              ,Header_Agent_Fee_Sequence = source.Header_Agent_Fee_Sequence
              ,Header_Carraige_Sequence = source.Header_Carraige_Sequence
              ,Header_Road_Sequence = source.Header_Road_Sequence
              ,Header_Air_Type = source.Header_Air_Type
              ,Header_Sea_Type = source.Header_Sea_Type
              ,Header_Duty_Type = source.Header_Duty_Type
              ,Header_Agent_Fee_Type = source.Header_Agent_Fee_Type
              ,Header_Carraige_Type = source.Header_Carraige_Type
              ,Header_Road_Type = source.Header_Road_Type
              ,Header_Air_Value = source.Header_Air_Value
              ,Header_Sea_Value = source.Header_Sea_Value
              ,Header_Duty_Value = source.Header_Duty_Value
              ,Header_Agent_Fee_Value = source.Header_Agent_Fee_Value
              ,Header_Carraige_Value = source.Header_Carraige_Value
              ,Header_Road_Value = source.Header_Road_Value
              ,Header_Air_Cost_per_Unit = source.Header_Air_Cost_per_Unit
              ,Header_Sea_Cost_per_Unit = source.Header_Sea_Cost_per_Unit
              ,Header_Duty_Cost_per_Unit = source.Header_Duty_Cost_per_Unit
              ,Header_Agent_Fee_per_Unit = source.Header_Agent_Fee_per_Unit
              ,Header_Carraige_Cost_per_Unit = source.Header_Carraige_Cost_per_Unit
              ,Header_Road_Cost_per_Unit = source.Header_Road_Cost_per_Unit
              ,Item_Air_Sequence = source.Item_Air_Sequence
              ,Item_Sea_Sequence = source.Item_Sea_Sequence
              ,Item_Duty_Sequence = source.Item_Duty_Sequence
              ,Item_Agent_Fee_Sequence = source.Item_Agent_Fee_Sequence
              ,Item_Carraige_Sequence = source.Item_Carraige_Sequence
              ,Item_Road_Sequence = source.Item_Road_Sequence
              ,Item_Air_Type = source.Item_Air_Type
              ,Item_Sea_Type = source.Item_Sea_Type
              ,Item_Duty_Type = source.Item_Duty_Type
              ,Item_Agent_Fee_Type = source.Item_Agent_Fee_Type
              ,Item_Carraige_Type = source.Item_Carraige_Type
              ,Item_Road_Type = source.Item_Road_Type
              ,Item_Air_Value = source.Item_Air_Value
              ,Item_Sea_Value = source.Item_Sea_Value
              ,Item_Duty_Value = source.Item_Duty_Value
              ,Item_Agent_Fee_Value = source.Item_Agent_Fee_Value
              ,Item_Carraige_Value = source.Item_Carraige_Value
              ,Item_Road_Value = source.Item_Road_Value
              ,Item_Air_Cost_per_Unit = source.Item_Air_Cost_per_Unit
              ,Item_Sea_Cost_per_Unit = source.Item_Sea_Cost_per_Unit
              ,Item_Duty_Cost_per_Unit = source.Item_Duty_Cost_per_Unit
              ,Item_Agent_Fee_per_Unit = source.Item_Agent_Fee_per_Unit
              ,Item_Carraige_Cost_per_Unit = source.Item_Carraige_Cost_per_Unit
              ,Item_Road_Cost_per_Unit = source.Item_Road_Cost_per_Unit
              ,Header_International_Cost_per_Unit = source.Header_International_Cost_per_Unit
              ,Item_International_Cost_per_Unit = source.Item_International_Cost_per_Unit
              ,Header_International_Sequence = source.Header_International_Sequence
              ,Header_International_Type = source.Header_International_Type
              ,Header_International_Value = source.Header_International_Value
              ,Item_International_Sequence = source.Item_International_Sequence
              ,Item_International_Type = source.Item_International_Type
              ,Item_International_Value = source.Item_International_Value
              ,Prepack_Flag = source.Prepack_Flag
              ,Prepack_Qty = source.Prepack_Qty
              ,Buyer_ID = source.Buyer_ID
              ,User_ID = source.User_ID
              ,Ship_Via = source.Ship_Via
              ,FOB_Point = source.FOB_Point
              ,Agent_Name = source.Agent_Name
              ,Terms_Description = source.Terms_Description
              ,Closed_Flag = source.Closed_Flag
              ,Handling_Type = source.Handling_Type
              ,Currency_Type = source.Currency_Type
              ,Currency_Exchange_Rate = source.Currency_Exchange_Rate
              ,Original_ExFac = source.Original_ExFac
              ,First_Delay = source.First_Delay
              ,Second_Delay = source.Second_Delay
              ,Third_Delay = source.Third_Delay
              ,Discount_Comments = source.Discount_Comments
              ,Vessel_Details = source.Vessel_Details
              ,Estimated_Week = source.Estimated_Week
              ,MDA = source.MDA
              ,Printed_Comments = source.Printed_Comments
              ,Comments_for_Supplier_1 = source.Comments_for_Supplier_1
              ,Comments_for_Supplier_2 = source.Comments_for_Supplier_2
              ,Internal_Comments = source.Internal_Comments
              ,Country_of_Origin = source.Country_of_Origin
    WHEN NOT MATCHED THEN
        INSERT
               (Purchase_Order_Dim_ID
               ,From_Date
               ,To_Date
               ,Current_Flag
               ,Created_Date_Dim_ID
               ,Header_Ship_Date_Dim_ID
               ,Item_Ship_Date_Dim_ID
               ,Header_Anticipated_Delivery_Date_Dim_ID
               ,Item_Anticipated_Delivery_Date_Dim_ID
               ,Item_Closed
               ,ASN_Code
               ,Commodity_Code
               ,Item_Country_of_Manufacture
               ,Item_Country_of_Origin
               ,Store_Dim_ID
               ,Item_Dim_ID
               ,Landed_Cost
               ,Vendor_Cost
               ,Retail_Cost
               ,Supplier_Cost
               ,Margin
               ,Order_Qty
               ,Order_Component_Qty
               ,Received_Qty
               ,Received_Component_Qty
               ,Header_Air_Sequence
               ,Header_Sea_Sequence
               ,Header_Duty_Sequence
               ,Header_Agent_Fee_Sequence
               ,Header_Carraige_Sequence
               ,Header_Road_Sequence
               ,Header_Air_Type
               ,Header_Sea_Type
               ,Header_Duty_Type
               ,Header_Agent_Fee_Type
               ,Header_Carraige_Type
               ,Header_Road_Type
               ,Header_Air_Value
               ,Header_Sea_Value
               ,Header_Duty_Value
               ,Header_Agent_Fee_Value
               ,Header_Carraige_Value
               ,Header_Road_Value
               ,Header_Air_Cost_per_Unit
               ,Header_Sea_Cost_per_Unit
               ,Header_Duty_Cost_per_Unit
               ,Header_Agent_Fee_per_Unit
               ,Header_Carraige_Cost_per_Unit
               ,Header_Road_Cost_per_Unit
               ,Item_Air_Sequence
               ,Item_Sea_Sequence
               ,Item_Duty_Sequence
               ,Item_Agent_Fee_Sequence
               ,Item_Carraige_Sequence
               ,Item_Road_Sequence
               ,Item_Air_Type
               ,Item_Sea_Type
               ,Item_Duty_Type
               ,Item_Agent_Fee_Type
               ,Item_Carraige_Type
               ,Item_Road_Type
               ,Item_Air_Value
               ,Item_Sea_Value
               ,Item_Duty_Value
               ,Item_Agent_Fee_Value
               ,Item_Carraige_Value
               ,Item_Road_Value
               ,Item_Air_Cost_per_Unit
               ,Item_Sea_Cost_per_Unit
               ,Item_Duty_Cost_per_Unit
               ,Item_Agent_Fee_per_Unit
               ,Item_Carraige_Cost_per_Unit
               ,Item_Road_Cost_per_Unit
               ,Header_International_Cost_per_Unit
               ,Item_International_Cost_per_Unit
               ,Header_International_Sequence
               ,Header_International_Type
               ,Header_International_Value
               ,Item_International_Sequence
               ,Item_International_Type
               ,Item_International_Value
               ,Prepack_Flag
               ,Prepack_Qty
               ,Buyer_ID
               ,User_ID
               ,Ship_Via
               ,FOB_Point
               ,Agent_Name
               ,Terms_Description
               ,Closed_Flag
               ,Handling_Type
               ,Currency_Type
               ,Currency_Exchange_Rate
               ,Original_ExFac
               ,First_Delay
               ,Second_Delay
               ,Third_Delay
               ,Discount_Comments
               ,Vessel_Details
               ,Estimated_Week
               ,MDA
               ,Printed_Comments
               ,Comments_for_Supplier_1
               ,Comments_for_Supplier_2
               ,Internal_Comments
               ,Country_of_Origin
               )
        VALUES (source.Purchase_Order_Dim_ID
               ,source.From_Date
               ,source.To_Date
               ,source.Current_Flag
               ,source.Created_Date_Dim_ID
               ,source.Header_Ship_Date_Dim_ID
               ,source.Item_Ship_Date_Dim_ID
               ,source.Header_Anticipated_Delivery_Date_Dim_ID
               ,source.Item_Anticipated_Delivery_Date_Dim_ID
               ,source.Item_Closed
               ,source.ASN_Code
               ,source.Commodity_Code
               ,source.Item_Country_of_Manufacture
               ,source.Item_Country_of_Origin
               ,source.Store_Dim_ID
               ,source.Item_Dim_ID
               ,source.Landed_Cost
               ,source.Vendor_Cost
               ,source.Retail_Cost
               ,source.Supplier_Cost
               ,source.Margin
               ,source.Order_Qty
               ,source.Order_Component_Qty
               ,source.Received_Qty
               ,source.Received_Component_Qty
               ,source.Header_Air_Sequence
               ,source.Header_Sea_Sequence
               ,source.Header_Duty_Sequence
               ,source.Header_Agent_Fee_Sequence
               ,source.Header_Carraige_Sequence
               ,source.Header_Road_Sequence
               ,source.Header_Air_Type
               ,source.Header_Sea_Type
               ,source.Header_Duty_Type
               ,source.Header_Agent_Fee_Type
               ,source.Header_Carraige_Type
               ,source.Header_Road_Type
               ,source.Header_Air_Value
               ,source.Header_Sea_Value
               ,source.Header_Duty_Value
               ,source.Header_Agent_Fee_Value
               ,source.Header_Carraige_Value
               ,source.Header_Road_Value
               ,source.Header_Air_Cost_per_Unit
               ,source.Header_Sea_Cost_per_Unit
               ,source.Header_Duty_Cost_per_Unit
               ,source.Header_Agent_Fee_per_Unit
               ,source.Header_Carraige_Cost_per_Unit
               ,source.Header_Road_Cost_per_Unit
               ,source.Item_Air_Sequence
               ,source.Item_Sea_Sequence
               ,source.Item_Duty_Sequence
               ,source.Item_Agent_Fee_Sequence
               ,source.Item_Carraige_Sequence
               ,source.Item_Road_Sequence
               ,source.Item_Air_Type
               ,source.Item_Sea_Type
               ,source.Item_Duty_Type
               ,source.Item_Agent_Fee_Type
               ,source.Item_Carraige_Type
               ,source.Item_Road_Type
               ,source.Item_Air_Value
               ,source.Item_Sea_Value
               ,source.Item_Duty_Value
               ,source.Item_Agent_Fee_Value
               ,source.Item_Carraige_Value
               ,source.Item_Road_Value
               ,source.Item_Air_Cost_per_Unit
               ,source.Item_Sea_Cost_per_Unit
               ,source.Item_Duty_Cost_per_Unit
               ,source.Item_Agent_Fee_per_Unit
               ,source.Item_Carraige_Cost_per_Unit
               ,source.Item_Road_Cost_per_Unit
               ,source.Header_International_Cost_per_Unit
               ,source.Item_International_Cost_per_Unit
               ,source.Header_International_Sequence
               ,source.Header_International_Type
               ,source.Header_International_Value
               ,source.Item_International_Sequence
               ,source.Item_International_Type
               ,source.Item_International_Value
               ,source.Prepack_Flag
               ,source.Prepack_Qty
               ,source.Buyer_ID
               ,source.User_ID
               ,source.Ship_Via
               ,source.FOB_Point
               ,source.Agent_Name
               ,source.Terms_Description
               ,source.Closed_Flag
               ,source.Handling_Type
               ,source.Currency_Type
               ,source.Currency_Exchange_Rate
               ,source.Original_ExFac
               ,source.First_Delay
               ,source.Second_Delay
               ,source.Third_Delay
               ,source.Discount_Comments
               ,source.Vessel_Details
               ,source.Estimated_Week
               ,source.MDA
               ,source.Printed_Comments
               ,source.Comments_for_Supplier_1
               ,source.Comments_for_Supplier_2
               ,source.Internal_Comments
               ,source.Country_of_Origin
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

    SET @Error_Response = 'An Error has occured in stored procedure dbo.Merge_Purchase_Order_Fact: (%d)%s';
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
