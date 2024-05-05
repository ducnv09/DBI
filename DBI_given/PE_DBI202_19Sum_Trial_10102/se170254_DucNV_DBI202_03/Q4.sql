SELECT O.ID, O.OrderDate, SUM(OD.SalePrice * OD.Quantity * (1 - OD.Discount)) AS TotalAmount
FROM Orders AS O
	 JOIN OrderDetails AS OD ON O.ID = OD.OrderID
GROUP BY O.ID, O.OrderDate
HAVING SUM(OD.SalePrice * OD.Quantity * (1 - OD.Discount)) > 8000
ORDER BY TotalAmount DESC