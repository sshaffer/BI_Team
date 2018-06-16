
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Wholesale_Order_Curr_Fact_View]
AS
SELECT
    Wholesale_Order_Dim_ID
   ,From_Date
   ,To_Date
   ,Current_Flag
   ,Sale_Order_Created_Date_Dim_ID
   ,Sale_Order_Line_Created_Date_Dim_ID
   ,Optional_Request_to_Ship_Date_Dim_ID
   ,Order_Type_Dim_ID
   ,Order_Source_Dim_ID
   ,Channel_Dim_ID
   ,Currency_Dim_ID
   ,Sales_Order_Received_Date_Dim_ID
   ,Customer_Dim_ID
   ,Store_Dim_ID
   ,Delivery_Method_Dim_ID
   ,Sales_Order_Actual_Ship_Date_Dim_ID
   ,Item_Dim_ID
   ,Sales_Order_Qty
   ,Sales_Order_Reserved_Qty
   ,Sales_Order_Allocated_Qty
   ,Sales_Order_Shipped_Qty
   ,Sales_Order_Backorder_Qty
   ,Sales_Order_Cancelled_Qty
   ,Entered_Unit_Price_Home
   ,Entered_Unit_Price_Curr
   ,VAT_Unit_Price_Home
   ,VAT_Unit_Price_Curr
   ,Additional_Shipping_Charge_Home
   ,Additional_Shipping_Charge_Curr
   ,Tax_Amount_Home
   ,Tax_Amount_Curr
   ,Cancellation_Reason_Code_Dim_ID
   ,Other_Charge_Home
   ,Other_Charge_Curr
   ,Other_Tax_Home
   ,Other_Tax_Curr
   ,Line_Message
   ,Purchase_Order_Dim_ID
   ,Order_Status
   ,Country_Code
   ,Carraige_Sequence
   ,Carraige_Routing_Method
   ,Carraige_Value
   ,International_Charge_Sequence
   ,International_Charge_Routing_Method
   ,International_Charge_Value
   ,Licence_Fee_Sequence
   ,Licence_Fee_Routing_Method
   ,Licence_Fee_Value
   ,Apply_Licence_Fee
   ,Include_Licence_Fee_In_Cost
   ,Retail_Minus_Cost_Plus
   ,Retail_Factor
   ,Licence_Fee_Per_Unit
FROM
    dbo.Wholesale_Order_Fact
WHERE
    Current_Flag = 1
GO
