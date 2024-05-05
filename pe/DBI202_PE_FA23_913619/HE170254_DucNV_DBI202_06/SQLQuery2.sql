SELECT * FROM Cars
SELECT * FROM Category
SELECT * FROM Customers
SELECT * FROM Location
SELECT * FROM Location_Phone_Number
SELECT * FROM Rentals

--Q4
SELECT R.Reservation_Number, R.Amount, R.Pick_up_date,
	   R.Return_date, (C.First_Name + ' ' + C.Last_Name) AS CustomerFullname,
	   L.Country AS PickupCountry, L2.Country AS ReturnCountry
FROM Rentals AS R
	 JOIN Customers AS C ON R.Customer_ID = C.ID
	 JOIN Location AS L ON R.Pick_up_location = L.ID
	 JOIN Location AS L2 ON R.Return_location = L2.ID
WHERE L.Country <> L2.Country
ORDER BY R.Amount DESC

--Q5


SELECT C.ID AS CarID, C.Description AS Description,
	   C.Model, C.Brand, CA.Label AS CategoryLabel,
	   SUM(R.Amount) AS TotalAmount
FROM Cars AS C
	 JOIN Category AS CA ON CA.ID = C.Category_ID
	 LEFT JOIN (
		SELECT Rentals.CarID, Rentals.Amount
		FROM Rentals 
		WHERE YEAR(Rentals.Pick_up_date) = 2015
	 ) AS R ON R.CarID = C.ID
GROUP BY C.ID, C.Description,
		 C.Model, C.Brand, CA.Label
ORDER BY SUM(R.Amount) DESC,
		 C.Description ASC

--Q6
SELECT * FROM Cars
SELECT * FROM Category
SELECT * FROM Customers
SELECT * FROM Location
SELECT * FROM Location_Phone_Number
SELECT * FROM Rentals



SELECT C.ID AS CustomerID, C.First_Name, C.Last_Name, RE.Reservation_Number, R.Amount
FROM Customers AS C
	 JOIN Rentals AS RE ON RE.Customer_ID = C.ID
	 JOIN ( SELECT Rentals.Customer_ID, MAX(Rentals.AMOUNT) AS AMOUNT
			FROM Rentals 
			JOIN Customers ON Rentals.Customer_ID = Customers.ID
			GROUP BY Rentals.Customer_ID)
			AS R ON R.AMOUNT = RE.Amount
WHERE RE.Customer_ID = R.Customer_ID
ORDER BY R.Amount DESC

--Q7
SELECT * FROM Cars
SELECT * FROM Category
SELECT * FROM Customers
SELECT * FROM Location
SELECT * FROM Location_Phone_Number
SELECT * FROM Rentals

SELECT CA.ID AS CategoryID, CA.Label, 
	   YEAR(R.Pick_up_date) AS [Year],
	   SUM(R.Amount) AS TotalAmount,
	   COUNT(R.Reservation_Number) AS NumberOfRentals,
	   COUNT(CU.ID) AS NumberOfCustomers,
	   SUM(DATEDIFF(DAY, R.Pick_up_date, R.Return_date)) AS TotalRentedDays
FROM Category AS CA
	 JOIN Cars AS C ON C.Category_ID = CA.ID
	 JOIN Rentals AS R ON C.ID = R.CarID
	 JOIN Customers AS CU ON R.Customer_ID = CU.ID
GROUP BY CA.ID, CA.Label, YEAR(R.Pick_up_date)
ORDER BY CA.ID ASC,
		 [Year] ASC

SELECT * FROM Cars
SELECT * FROM Category
SELECT * FROM Customers
SELECT * FROM Location
SELECT * FROM Location_Phone_Number
SELECT * FROM Rentals

--TEST TRC KHI LÀM
SELECT COUNT(C.ID) 
FROM Category AS CA
	 JOIN Cars AS C ON CA.ID = C.Category_ID
WHERE CA.ID = 1
GROUP BY CA.ID

-- LÀM
CREATE PROC P1 @CaID INT,
			   @numCar INT OUTPUT
AS
BEGIN
	SELECT @numCar = COUNT(C.ID) 
	FROM Category AS CA
		 JOIN Cars AS C ON CA.ID = C.Category_ID
	WHERE CA.ID = @CaID
	GROUP BY CA.ID
END

DECLARE @X INT
EXEC P1 1, @X OUTPUT
SELECT @X AS NumberOfCar

--Q9


CREATE TRIGGER Tr1
ON Category
AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON

	UPDATE Cars
	SET Category_ID = NULL
	WHERE Category_ID IN (
		SELECT C.Category_ID
		FROM Cars AS C
			 JOIN deleted AS D ON D.ID = C.Category_ID
	)

	DELETE FROM Category
	WHERE ID IN (
		SELECT ID 
		FROM deleted
	)
END

DELETE FROM Category
WHERE ID = 1

--Q10
SELECT * FROM Cars
SELECT * FROM Category
SELECT * FROM Customers
SELECT * FROM Location
SELECT * FROM Location_Phone_Number
SELECT * FROM Rentals

UPDATE Location_Phone_Number
SET ID = 2
WHERE Location_ID = 5 AND Is_MainPhone <> 1

