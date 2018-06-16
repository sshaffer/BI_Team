--USE Dune_Data_Warehouse
--SELECT Item_Code,GTIN,Item_Dim_Id FROM dbo.Item_Dim
--WHERE GTIN = '05053841000017'


--SELECT Item_Code,GTIN FROM dbo.Item_Dim
--WHERE GTIN = '05053841000017'

-- 07585086300145020400
-- 00755089500044929901

-- Class 0075(4)
-- Vendor 50895(5)
-- Style 0004 (4)
-- Colour 492 (3)
-- Size 9901 (4)


USE Dune_Data_Warehouse_Staging
; WITH GtinLookup AS (
SELECT [new gtin] AS GTIN
,RIGHT('000'+CAST([new class] AS VARCHAR(4)),4) AS NewClass
,[new vendor] AS NewVendor -- 5
,RIGHT('000'+CAST([new style] AS VARCHAR(4)),4) AS NewStyle
,RIGHT('000'+CAST([new colour] AS VARCHAR(3)),3) AS NewColour
,RIGHT('000'+CAST([new size] AS VARCHAR(4)),4) AS NewSize

,RIGHT('000'+CAST([old class] AS VARCHAR(4)),4) AS OldClass
,[old vendor] AS OldVendor
,RIGHT('000'+CAST([old style] AS VARCHAR(4)),4) AS OldStyle
,RIGHT('000'+CAST([old colour] AS VARCHAR(3)),3) AS OldColour
,RIGHT('000'+CAST([old size] AS VARCHAR(4)),4) AS OldSize


  FROM stage_purgedGTINS s
  )
,
ItemCode AS (
SELECT 
GTIN
,CONCAT(NewClass,GtinLookup.NewVendor,NewStyle,NewColour,NewSize) AS Item_Code
,CONCAT(OldClass,OldVendor,OldStyle,OldColour,OldSize) AS Purged_Item_Code

 FROM GtinLookup
)

