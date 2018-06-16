USE Dune_Data_Warehouse
GO

/* Currency_Dim */
IF NOT EXISTS (SELECT 1 FROM Currency_Dim WHERE Currency_Dim_ID = 0) BEGIN
	INSERT INTO Currency_Dim(Currency_Dim_ID, Currency_Code, Currency_Description)
	VALUES (0, '~~~', 'Unknown Currency');
END;
GO

/* Country_Dim */
IF NOT EXISTS (SELECT 1 FROM Country_Dim WHERE Country_Dim_ID = 0) BEGIN
	INSERT INTO Country_Dim(Country_Dim_ID, Country_Code, Country_Name)
	VALUES (0, '', 'Unknown Country');
END;
GO

/* Customer_Type_Dim */
IF NOT EXISTS (SELECT 1 FROM Customer_Type_Dim WHERE Customer_Type_Dim_ID = 0) BEGIN
	INSERT INTO Customer_Type_Dim(Customer_Type_Dim_ID, Customer_Type_Code, Customer_Type_Desc)
	VALUES (0, '', 'Unknown Customer Type');
END;
GO

/* Discount_Reason_Dim */
IF NOT EXISTS (SELECT 1 FROM Discount_Reason_Dim WHERE Discount_Reason_Dim_ID = 0) BEGIN
	INSERT INTO Discount_Reason_Dim(Discount_Reason_Dim_ID, Discount_Reason_Code, Discount_Reason_Desc)
	VALUES(0,'~~~','Unknown Reason');
END;

/* Return_Reason_Dim */
IF NOT EXISTS (SELECT 1 FROM Return_Reason_Dim WHERE Return_Reason_Dim_ID = 0) BEGIN
	INSERT INTO Return_Reason_Dim(Return_Reason_Dim_ID,Return_Reason_Code,Return_Reason_Desc,Store_Customer_Indicator)
	VALUES(0,'~~~','Unknown Reason','X');
END;

/* Price_Group_Dim */
IF NOT EXISTS (SELECT 1 FROM Price_Group_Dim WHERE Price_Group_Dim_ID = 0) BEGIN
	INSERT INTO Price_Group_Dim(Price_Group_Dim_ID, Price_Group_Code, Price_Group_Desc, Currency_Dim_ID)
	VALUES (0,'~~~','Unknown / NA', 0)
END;

/* Zone_Dim */
IF NOT EXISTS (SELECT 1 FROM Zone_Dim WHERE Zone_Dim_ID = 0) BEGIN
	INSERT INTO Zone_Dim(Zone_Dim_ID, Zone_Code, Zone_Name)
	VALUES (0,'~~~','Unknown / NA')
END;

/* Territory_Dim */
IF NOT EXISTS (SELECT 1 FROM Territory_Dim WHERE Territory_Dim_ID = 0) BEGIN
	INSERT INTO Territory_Dim(Zone_Dim_ID, Territory_Dim_ID, Territory_Code, Territory_Name)
	VALUES (0,0,'~~~','Unknown / NA')
END;

/* Region_Dim */
IF NOT EXISTS (SELECT 1 FROM Region_Dim WHERE Region_Dim_ID = 0) BEGIN
	INSERT INTO Region_Dim(Territory_Dim_ID, Region_Dim_ID, Zone_Dim_ID, Region_Code, Region_Name)
	VALUES (0,0,0,'~~~','Unknown / NA')
END;

/* District_Dim */
IF NOT EXISTS (SELECT 1 FROM District_Dim WHERE District_Dim_ID = 0) BEGIN
	INSERT INTO District_Dim(Region_Dim_ID, District_Dim_ID, Territory_Dim_ID, Zone_Dim_ID, District_Code, District_Name)
	VALUES (0,0,0,0,'~~~','Unknown / NA')
END;

/* Class _Dim */
IF NOT EXISTS (SELECT 1 FROM Class_Dim WHERE Class_Dim_ID = -32768) BEGIN
	INSERT INTO Class_Dim (
		Division_Dim_ID
		,Department_Dim_ID
		,Subdepartment_Dim_ID
		,Class_Dim_ID
		,Class_Code
		,Class_Name
	) VALUES (
		0
		,0
		,-32768
		,-32768
		,''
		,''
	);
END;

/* Channel_Dim */
IF NOT EXISTS (SELECT * FROM dbo.Channel_Dim WHERE Channel_Dim_ID = 0) 
BEGIN
	INSERT INTO dbo.Channel_Dim
	        ( Channel_Dim_ID
	        ,Channel_Code
	        ,Channel_Name
	        ,Store_Dim_ID
	        )
	VALUES
	        ( 0, 
	         '~~~',
	         'UNKNOWN', 
	         -2147483648  
	        );
END;

/* Supplier_Dim */


IF NOT EXISTS (SELECT 1 FROM Supplier_Dim WHERE Supplier_Dim_ID = -2147483648) BEGIN
INSERT INTO Supplier_Dim (
	Supplier_Dim_ID
	,Supplier_Code
	,Supplier_Name
	,Supplier_Contact_Name
	,Supplier_Address_Line_1
	,Supplier_Address_Line_2
	,Supplier_City
	,Supplier_State
	,Supplier_Post_Code
	,Country_Dim_ID
	,Contact_Telephone_No
	,Default_Terms_Description
	,Default_Terms_Code
	,Expected_Lead_Time
	,Factory_Name
	,Factory_Address_Line_1
	,Factory_Address_Line_2
	,Factory_City
	,Factory_State
	,Factory_Post_Code
	,Factory_Country_Name
	,FOB_Point
	,FOB_Terms_Description
	,FOB_Terms_Code
) VALUES (
	-2147483648
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,0
	,''
	,''
	,''
	,0
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
);
END;

/* Department_Dim */
IF NOT EXISTS (SELECT 1 FROM Department_Dim WHERE Department_Dim_ID = 0) BEGIN
	INSERT INTO Department_Dim (
		Division_Dim_ID
		,Department_Dim_ID
		,Department_Code
		,Department_Name
	) VALUES (
		0
		,0
		,'~~~'
		,'Unknown Department'
	);
END;

/* Division_Dim */
IF NOT EXISTS (SELECT 1 FROM Division_Dim WHERE Division_Dim_ID = 0) BEGIN
	INSERT INTO Division_Dim (
		Division_Dim_ID
		,Division_Code
		,Division_Name
	) VALUES (
		0
		,'~~'
		,'Unknown Division'
	)
END;

IF NOT EXISTS (SELECT 1 FROM dbo.Subdepartment_Group_Dim WHERE Subdepartment_Group_Dim_ID = 0)
BEGIN
INSERT INTO dbo.Subdepartment_Group_Dim
        ( Group_Name, Subgroup_Name )
VALUES
        ( 'Other',
          'Other'  -- Subgroup_Name - varchar(256)
          )
END;

/* Subdepartment_Dim */
IF NOT EXISTS (SELECT 1 FROM Subdepartment_Dim WHERE Subdepartment_Dim_ID = -32768) BEGIN
	INSERT INTO Subdepartment_Dim (
		Subdepartment_Dim_ID,
		Subdepartment_Code,
		Subdepartment_Name,
		Department_Dim_ID,
		Division_Dim_ID,
		Subdepartment_Group_Dim_ID
	) VALUES (
		-32768
		,'~~~~'
		,'Unknown Subdepartment'
		,0
		,0
		,0
	)
END;

/* Order_Source_Dim */
IF NOT EXISTS (
	SELECT
		*
	FROM dbo.Order_Source_Dim
	WHERE Order_Source_Dim_ID = -32768
) 
BEGIN
	INSERT INTO dbo.Order_Source_Dim
	        ( Order_Source_Dim_ID
	        ,Order_Source_Code
	        ,Order_Source_Desc
	        )
	VALUES
	        (-32768,
	         '~~~~~~~',
	         'UNKNOWN ORDER SOURCE'
			 );
END;


/* Colour_Dim */
IF NOT EXISTS (
	SELECT
		*
	FROM dbo.Colour_Dim
	WHERE Colour_Dim_ID = -32768
) BEGIN
INSERT INTO dbo.Colour_Dim
        ( Colour_Dim_ID
        ,Colour_Code
        ,Colour_Name
        )
VALUES
        ( -32768,
         '~~~',
         'UNKNOWN' 
        );
END;


/* Item_Dim */
IF NOT EXISTS ( SELECT 1 FROM Item_Dim WHERE Item_Dim_ID = -2147483648 ) BEGIN
	INSERT INTO dbo.Item_Dim (
		Item_Dim_ID
		,Item_Code
		,Style
		,Item_Description
		,Item_Short_Description
		,Currency_Dim_ID
		,Current_Cost_Price
		,Commodity_Code
		,SKU
		,Vendor_Style
		,GTIN
		,Prepack_Type
		,Prepack_Flag
		,Prepack_Qty
		,Colour_Code
		,Colour_Name
		,Country_Dim_ID
		,Country_of_Manufacture_Country_Dim_ID
		,Country_of_Origin_Country_Dim_ID
		,Supplier_Dim_ID
		,Size_Code
		,Size_Name
		,Class_Dim_ID
		,Division_Dim_ID
		,Department_Dim_ID
		,Subdepartment_Dim_ID
		,Colour_Dim_ID
	) VALUES (
		-2147483648
		,''
		,'0000'
		,'Unknown Item'
		,'NA'
		,0
		,0
		,''
		,''
		,''
		,''
		,''
		,''
		,0
		,''
		,''
		,0
		,0
		,0
		,-2147483648
		,''
		,''
		,-32768
		,0
		,0
		,-32768
		,-32768
	);

	INSERT INTO dbo.Last_reference_Id (Table_Name, Last_Reference_No)
	VALUES ('Item_Dim_ID',-2147483648);
END;

/* IPD Return only item hack */
IF NOT EXISTS (SELECT * FROM Item_Dim WHERE SKU = '151696') BEGIN

DECLARE @Last_ID BIGINT 
SET @Last_ID = (SELECT Last_Reference_No FROM dbo.Last_Reference_Id WHERE Table_Name = 'Item_Dim_ID')

INSERT INTO dbo.Item_Dim (
		Item_Dim_ID
		,Item_Code
		,Style
		,Item_Description
		,Item_Short_Description
		,Currency_Dim_ID
		,Current_Cost_Price
		,Commodity_Code
		,SKU
		,Vendor_Style
		,GTIN
		,Prepack_Type
		,Prepack_Flag
		,Prepack_Qty
		,Colour_Code
		,Colour_Name
		,Country_Dim_ID
		,Country_of_Manufacture_Country_Dim_ID
		,Country_of_Origin_Country_Dim_ID
		,Supplier_Dim_ID
		,Size_Code
		,Size_Name
		,Class_Dim_ID
		,Division_Dim_ID
		,Department_Dim_ID
		,Subdepartment_Dim_ID
		,Colour_Dim_ID
	) VALUES (
		@Last_ID + 1                      
		,''
		,'0000'
		,'Return Only Item'
		,'NA'
		,0
		,0
		,''
		,'151696'
		,''
		,''
		,''
		,''
		,0
		,''
		,''
		,0
		,0
		,0
		,-2147483648
		,''
		,''
		,-32768
		,0
		,0
		,-32768
		,-32768
	);

UPDATE Last_Reference_Id
SET Last_Reference_No = @Last_ID + 1
WHERE Table_Name = 'Item_Dim_ID';
END; /* IPD Return only item hack */

/* Store_Dim */
IF NOT EXISTS (SELECT 1 FROM Store_Dim WHERE Store_Dim_ID = -2147483648) BEGIN
INSERT INTO Store_Dim (
Store_Dim_ID
	,Store_Number
	,Store_Name
	,Store_Address_Line_1
	,Store_Address_Line_2
	,City
	,STATE
	,Post_Code
	,Country
	,Store_Manager
	,Telephone_No
	,Price_Group_ID
	,Zone_Dim_ID
	,Territory_Dim_ID
	,Region_Dim_ID
	,District_Dim_ID
	,Open_Date
	,Open_Time_Sun
	,Close_Time_Sun
	,Open_Time_Mon
	,Close_Time_Mon
	,Open_Time_Tues
	,Close_Time_Tues
	,Open_Time_Wed
	,Close_Time_Wed
	,Open_Time_Thurs
	,Close_Time_Thurs
	,Open_Time_Fri
	,Close_Time_Fri
	,Open_Time_Sat
	,Close_Time_Sat
	,Warehouse_Flag

) VALUES (
-2147483648
,'00000'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,0
,0
,0
,0
,0
,'1900-01-01'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'00:00:00'
,'N'
)
END;

/************************************************************************************/
/* Name:        Seed Last_Reference_Id table                                        */  
/* Author:      James Wolfisz														*/
/* Created:     20/06/2013															*/
/* Description: Seeds Last_Reference_Id with the Table_Name and lowest BIGINT       */
/*              value if it does not already exist in the table                     */
/* 																					*/
/* Audit:       <user> <chage date> <reason>										*/
/************************************************************************************/
/* TINYINT */
DECLARE @TinyIntStart TINYINT = 0; /* Smallest TINYINT number you can have */
DECLARE @TinyInt_Table_List TABLE (
	Table_Name VARCHAR(256)
);
/* List of tables that require id values */
INSERT INTO @TinyInt_Table_List
VALUES ('Customer_Type_Dim'),
       ('Country_Dim'),
	   ('Currency_Dim'),
	   ('Channel_Dim'),
	   ('Division_Dim'),
	   ('Department_Dim'),
	   ('Zone_Dim'),
	   ('Territory_Dim'),
	   ('Region_Dim'),
	   ('District_Dim'),
	   ('Price_Group_Dim'),
	   ('Cancellation_Reason_Code_Dim'),
	   ('Delivery_Method_Dim'),
	   ('Order_Type_Dim'),
	   ('Discount_Reason_Dim'),
	   ('Return_Reason_Dim');
/* If table does not exists in reference table then add it with default id */
INSERT INTO Last_Reference_Id(Table_Name, Last_Reference_No)
SELECT
	Table_Name,
	@TinyIntStart
FROM @TinyInt_Table_List l
WHERE NOT EXISTS (SELECT 1 FROM Last_Reference_Id WHERE Table_Name = l.Table_Name)

DECLARE @IntStart INT = -2147483648; /* Smallest INT number you can have */
DECLARE @Int_Table_List TABLE (
	Table_Name VARCHAR(256)
);

/* SMALLINT */
DECLARE @SmallIntStart SMALLINT = -32768; /* Smallest SMALLINT number you can have */
DECLARE @SmallInt_Table_List TABLE (
	Table_Name VARCHAR(256)
);
INSERT INTO @SmallInt_Table_List
VALUES ('Subdepartment_Dim'),
	   ('Class_Dim'),
	   ('Order_Source_Dim');
/* If table does not exists in reference table then add it with default id */
INSERT INTO Last_Reference_Id(Table_Name, Last_Reference_No)
SELECT
	Table_Name,
	@SmallIntStart
FROM @SmallInt_Table_List l
WHERE NOT EXISTS (SELECT 1 FROM Last_Reference_Id WHERE Table_Name = l.Table_Name)

/* INT */
INSERT INTO @Int_Table_List 
VALUES  ('Customer_Dim')
		,('Customer_Ship_Address_Dim')
		,('Supplier_Dim')
		,('Item_Dim')
		,('Item_Attribute_Dim')
		,('Store_Dim')
		,('Store_Attribute_Dim')
		,('AR_Customer_Dim');
/* If table does not exists in reference table then add it with default id */
INSERT INTO Last_Reference_Id (Table_Name, Last_Reference_No)
SELECT
	Table_Name,
	@IntStart
FROM @Int_Table_List l
WHERE NOT EXISTS ( SELECT 1 FROM Last_Reference_Id WHERE Table_Name = l.Table_Name )
GO

/* BIGINT */
DECLARE @BigIntStart BIGINT = -9223372036854775808; /* Smallest BIGINT number you can have */
DECLARE @BigInt_Table_List TABLE (
	Table_Name VARCHAR(256)
);
/* List of tables that require id values */
INSERT INTO @BigInt_Table_List 
VALUES  ('VIP_Customer_Dim')	   
/* If table does not exists in reference table then add it with default id */
INSERT INTO Last_Reference_Id (Table_Name, Last_Reference_No)
SELECT
	Table_Name,
	@BigIntStart
FROM @BigInt_Table_List l
WHERE NOT EXISTS ( SELECT 1 FROM Last_Reference_Id WHERE Table_Name = l.Table_Name )
GO

/************************************************************************************/
/* Name:        Seed Last_Load_Id table                                             */
/* Author:      James Wolfisz														*/
/* Created:     13/06/2013															*/
/* Description: Seeds Last_Load_Id if it contains 0 rows                            */
/* 																					*/
/* Audit:       <user> <chage date> <reason>										*/
/************************************************************************************/

IF(SELECT COUNT(*) FROM dbo.Last_Load_Id) = 0 BEGIN
	INSERT INTO Last_Load_Id (Last_Load_Id, Load_Date)
	VALUES (-9223372036854775808, 'January 1, 1753'); /* Smallest BIGINT and earliest DATETIME */
END;
GO
