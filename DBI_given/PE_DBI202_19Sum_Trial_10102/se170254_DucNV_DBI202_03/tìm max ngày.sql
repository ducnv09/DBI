SELECT * FROM Category
SELECT * FROM Customer
SELECT * FROM OrderDetails
SELECT * FROM Orders
SELECT * FROM Product
SELECT * FROM SubCategory

SELECT O.ID, O.OrderDate
FROM Orders AS O
WHERE O.OrderDate = (
	SELECT MAX(T.DATE) 
	FROM (
		SELECT O.OrderDate AS DATE
		FROM Orders AS O
	) T
)







