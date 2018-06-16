
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[Wholesale_Order_Fact_UpdateView]
AS

SELECT
	d.Sales_Order_Number
	,d.Sales_Order_Line_Number
	,f.Wholesale_Order_Dim_ID
	,f.From_Date
	,f.To_Date
	,f.Current_Flag
	,f.Sale_Order_Created_Date_Dim_ID
	,f.Sale_Order_Line_Created_Date_Dim_ID
	,f.Optional_Request_to_Ship_Date_Dim_ID
	,f.Order_Type_Dim_ID
	,f.Order_Source_Dim_ID
	,f.Channel_Dim_ID
	,f.Currency_Dim_ID
	,f.Sales_Order_Received_Date_Dim_ID
	,f.Customer_Dim_ID
	,f.Store_Dim_ID
	,f.Delivery_Method_Dim_ID
	,f.Sales_Order_Actual_Ship_Date_Dim_ID
	,f.Item_Dim_ID
	,f.Sales_Order_Qty
	,f.Sales_Order_Reserved_Qty
	,f.Sales_Order_Allocated_Qty
	,f.Sales_Order_Shipped_Qty
	,f.Sales_Order_Backorder_Qty
	,f.Sales_Order_Cancelled_Qty
	,f.Entered_Unit_Price_Home
	,f.Entered_Unit_Price_Curr
	,f.VAT_Unit_Price_Home
	,f.VAT_Unit_Price_Curr
	,f.Additional_Shipping_Charge_Home
	,f.Additional_Shipping_Charge_Curr
	,f.Tax_Amount_Home
	,f.Tax_Amount_Curr
	,f.Cancellation_Reason_Code_Dim_ID
	,f.Other_Charge_Home
	,f.Other_Charge_Curr
	,f.Other_Tax_Home
	,f.Other_Tax_Curr
	,f.Line_Message
	,f.Purchase_Order_Dim_ID
	,f.Order_Status
	,f.Country_Code
	,f.Carraige_Sequence
	,f.Carraige_Routing_Method
	,f.Carraige_Value
	,f.International_Charge_Sequence
	,f.International_Charge_Routing_Method
	,f.International_Charge_Value
	,f.Licence_Fee_Sequence
	,f.Licence_Fee_Routing_Method
	,f.Licence_Fee_Value
	,f.Apply_Licence_Fee
	,f.Include_Licence_Fee_In_Cost
	,f.Retail_Minus_Cost_Plus
	,f.Retail_Factor
	,f.Licence_Fee_Per_Unit
FROM dbo.Wholesale_Order_Fact f
JOIN dbo.Wholesale_Order_Dim d
	ON d.Wholesale_Order_Dim_ID = f.Wholesale_Order_Dim_ID

GO
