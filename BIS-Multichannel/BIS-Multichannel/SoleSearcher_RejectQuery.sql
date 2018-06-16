
;
WITH one AS (
SELECT 
COUNT(o.EnRouteDate) AS TotalOrders
,o.SendingStore AS StoreNumber
,o.SendingStore_Store_Dim_Id
,o.SendingStore_Store_Name
FROM dbo.OCS_Dashboard o
GROUP BY o.SendingStore
,o.SendingStore_Store_Dim_Id
,o.SendingStore_Store_Name
)
,two AS
(SELECT COUNT(EnRouteDate) AS TotalNumberOfRejections
,o.SendingStore
,o.SendingStore_Store_Dim_Id
,o.SendingStore_Store_Name
,o.OrderRef

FROM dbo.OCS_Dashboard o
WHERE TransferStatus = 'R'
GROUP BY o.SendingStore
,o.SendingStore_Store_Dim_Id
,o.SendingStore_Store_Name
,o.OrderRef)

SELECT 
       two.SendingStore  AS StoreNumber,
       two.SendingStore_Store_Name AS StoreName,
	   two.TotalNumberOfRejections ,
	   two.OrderRef
 
	   ,one.TotalOrders - two.TotalNumberOfRejections AS TotalNumberOfShippedOrders
	         ,one.TotalOrders AS TotalNumberofOrders
			--,(CONVERT(int,one.TotalOrders *10 /two.TotalNumberOfRejections)) + '%'
			-- ,CONVERT(varchar(10), convert(int,two.TotalNumberOfRejections/one.TotalOrders)) + '%' as Pctg
	   
FROM two
JOIN one ON one.SendingStore_Store_Dim_Id = two.SendingStore_Store_Dim_Id

WHERE two.OrderRef = 'M202007087'


--USE Dune_Data_Warehouse
--SELECT COUNT(EnRouteDate) FROM dbo.OCS_Dashboard
--WHERE SendingStore_Store_Dim_Id = '-2147483626'
--AND TransferStatus = 'R'
--SELECT COUNT(EnRouteDate) FROM dbo.OCS_Dashboard
--WHERE SendingStore_Store_Dim_Id = '-2147483626'


--SELECT CONVERT(NUMERIC(10,5), ' 12345.12 ');

--select CONVERT(varchar(10), convert(int,100.0 * 10 /75)) + '%' as Pctg
 

 
--256 Stratford – 15 rejects 12 other lines
--151 Oxford Circus 22 rejections 25 other lines
--257 oxford st 39 rejections 19 other lines
