SELECT O.CustomerID, C.CustomerName, COUNT(O.ID) AS NumberOfOrders
FROM Customer AS C 
	 JOIN Orders AS O ON C.ID = O.CustomerID
GROUP BY O.CustomerID, C.CustomerName
HAVING COUNT(O.ID) = (
	SELECT MAX(T.NUM)
	FROM (
		SELECT COUNT(O.ID) AS NUM
		FROM Orders AS O
		GROUP BY O.CustomerID
	)T
)