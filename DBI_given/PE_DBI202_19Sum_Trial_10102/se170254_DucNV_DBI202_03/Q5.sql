SELECT OD.ProductID, P.ProductName, OD.Quantity
FROM OrderDetails AS OD
	 JOIN Product AS  P ON P.ID = OD.ProductID
WHERE OD.Quantity = (
	SELECT MAX(T.NUM) 
	FROM (
		SELECT OD.Quantity AS NUM
		FROM OrderDetails AS OD
	)T
)