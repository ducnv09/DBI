
SELECT C.ID, C.CustomerName, C.City, C.State
FROM Customer AS C
	 JOIN Orders AS O ON C.ID = O.CustomerID
WHERE O.OrderDate BETWEEN '2017-12-5' AND '2017-12-10' 
	  AND DAY(O.ShipDate) - DAY(O.OrderDate) < 3
ORDER BY [State] ASC, City DESC