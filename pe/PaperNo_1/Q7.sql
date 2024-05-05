--Q7
SELECT PM.ModelID,PM.Name ModelName,P.ProductID,P.Name ProductName,
COUNT(L.LocationID) NumberOfLocations   FROM ProductInventory PN
LEFT JOIN Product P 
ON PN.ProductID = P.ProductID
RIGHT JOIN ProductModel PM
ON PM.ModelID = P.ModelID 
LEFT JOIN Location L 
ON L.LocationID = PN.LocationID
WHERE PM.Name LIKE 'HL MOUNTAIN%'
GROUP BY PM.ModelID,PM.Name ,P.ProductID,P.Name 


