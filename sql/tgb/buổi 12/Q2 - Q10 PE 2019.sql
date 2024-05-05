-- q2: Write a query to display all customers who are ‘Consumer’ 
-- and are from Arlington city
SELECT * FROM Customer
WHERE Segment = 'Consumer' AND City = 'Arlington'

-- Q3: Write a query to display all customers having CustomerName 
--starting with B and placed orders in December 2017. 
-- Display the result by descending order of Segment and then by ascending order of CustomerName.
SELECT * FROM Orders
SELECT * FROM OrderDetails

SELECT C.ID, C.CustomerName, C.Segment, C.Country, C.City, C.State, C.PostalCode, C.Region
FROM Customer AS C
	 JOIN Orders AS O ON C.ID = O.CustomerID
WHERE CustomerName LIKE 'B%' AND MONTH(O.OrderDate) = 12 
							 AND YEAR(O.OrderDate) = 2017
ORDER BY C.Segment DESC, C.CustomerName ASC

-- Q4: Write a query to display SubCategoryID, SubCategoryName and the 
-- corresponding number of products (NumberOfProducts) in each sub-category having the 
-- number of products greater than 100, by descending order of NumberOfProducts.

SELECT P.SubCategoryID, S.SubCategoryName ,COUNT(SubCategoryID) AS NumberOfProduct
FROM Product AS P
	 JOIN SubCategory AS S ON P.SubCategoryID = S.ID
GROUP BY P.SubCategoryID, S.SubCategoryName
HAVING COUNT(SubCategoryID) > 100
ORDER BY NumberOfProduct DESC

-- Q5: Write a query to display ProductID, ProductName, Quantity of all products 
-- which have the highest Quantity in one order.

SELECT MAX(Quantity) AS Quantity
FROM OrderDetails

SELECT O.ProductID, P.ProductName, O.Quantity
FROM OrderDetails AS O
	 JOIN Product AS P ON O.ProductID = P.ID
WHERE O.Quantity = (
	SELECT MAX(O.Quantity)
	FROM OrderDetails AS O
)



-- Q6: Write a query to display CustomerID, CustomerName and the number of orders 
-- (NumberOfOrders) of customers who have the highest number of orders.
SELECT * FROM Orders

SELECT O.CustomerID, C.CustomerName, COUNT(O.CustomerID) AS NumberOfOrders
FROM Orders AS O
	 JOIN Customer AS C ON O.CustomerID = C.ID
GROUP BY O.CustomerID, C.CustomerName
HAVING COUNT(O.CustomerID) = (
	SELECT MAX(T.NUM)
	FROM (
		SELECT COUNT(O.CustomerID) AS NUM
		FROM Orders AS O
		GROUP BY O.CustomerID
	) T
)

C2:
SELECT O.CustomerID, C.CustomerName, COUNT(O.CustomerID) AS NumberOfOrders
FROM Orders AS O
	 JOIN Customer AS C ON O.CustomerID = C.ID
GROUP BY O.CustomerID, C.CustomerName
HAVING COUNT(O.CustomerID) = (
	SELECT TOP 1 COUNT(O.CustomerID)
	FROM Orders AS O
		 JOIN Customer AS C ON O.CustomerID = C.ID
	GROUP BY O.CustomerID
	ORDER BY COUNT(O.CustomerID) DESC
)

-- Q7: Display 5 products with the highest unit prices 
-- and 5 products with the smallest unit prices as follows:

SELECT *
FROM (
	SELECT TOP 5 *
	FROM Product AS P
	ORDER BY P.UnitPrice DESC
	) AS TABLE1
UNION
SELECT * 
FROM (
	SELECT TOP 5 *
	FROM Product AS P
	ORDER BY P.UnitPrice ASC
	) AS TABLE2
ORDER BY UnitPrice DESC

-- Q8: Write a stored procedure named CountProduct 
-- to calculate the number of different products in 
-- an order with OrderID (nvarchar(255)) is input 
-- parameter and the NbProducts (int) is the output 
-- parameter of the procedure.
SELECT * FROM Orders

SELECT OD.ProductID, COUNT(*) AS NumberOfProduct
FROM OrderDetails AS OD
WHERE OD.OrderID = 'CA-2014-100006'
GROUP BY OD.ProductID

CREATE PROC CountProduct @OrderId NVARCHAR(255),
						 @NbProduct INT OUTPUT
AS
BEGIN
	SELECT @NbProduct = COUNT (*) 
	FROM OrderDetails AS OD
	WHERE OD.OrderID = @OrderId
END

DROP PROC CountProduct

DECLARE @t INT
EXEC CountProduct 'CA-2014-100391', @t OUTPUT
PRINT @t

-- Q9: Create a trigger InsertProduct which 
-- will be activated by an insert statement 
-- into the Product table. The trigger will 
-- display the ProductName and the SubCategoryName
-- of the products which have just been inserted by
-- the insert statement.
CREATE TRIGGER InsertProduct
ON Product
AFTER INSERT
AS
BEGIN
	SELECT i.ProductName, SC.SubCategoryName
	FROM inserted i
		 JOIN SubCategory AS SC ON I.SubCategoryID = SC.ID
END

DROP TRIGGER InsertProduct

INSERT INTO Product(ProductName, UnitPrice, SubCategoryID)
VALUES ('Craft paper', 0.5, 3)

-- Q10: Insert the following information:
-- - A category named 'Sports' into table Category
-- - A subcategory named 'Tennis' and a subcategory named 
--   'Football' into table SubCategory, both these two subcategories 
--    are subcategories of Category 'Sports'
INSERT INTO Category (CategoryName)
VALUES ('Sports')

DELETE FROM Category 
WHERE CategoryName = 'Sports'

SELECT * FROM Category
SELECT * FROM SubCategory
ORDER BY CategoryID DESC

INSERT INTO SubCategory (SubCategoryName, CategoryID) 
VALUES (
	'Tennis', 
	(SELECT ID 
	FROM Category 
	WHERE CategoryName = 'Sports')
)	

INSERT INTO SubCategory (SubCategoryName, CategoryID) 
VALUES (
	'Football', 
	(SELECT ID 
	FROM Category 
	WHERE CategoryName = 'Sports')
)