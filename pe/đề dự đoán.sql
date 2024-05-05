--Q1
/*
CREATE TABLE Buildings (
	BuildingCode VARCHAR(10) PRIMARY KEY,
	Name NVARCHAR(50),
	Address NVARCHAR(100)
);

CREATE TABLE Rooms (
	DoorNumber INT PRIMARY KEY,
	Floor INT
	BuildingCode VARCHAR(10),
	FOREIGN KEY (BuildingCode) REFERENCES Buildings(BuildingCode)
);

CREATE TABLE Departments (
	DepartmentID INT PRIMARY KEY,
	Name NVARCHAR(100)
	DoorNumber INT, 
	FOREIGN KEY (DoorNumber) REFERENCES Rooms(DoorNumber)
);
*/

--Q2
SELECT * 
FROM Cars
WHERE Color = 'Red'

--Q3

/*
Retrieve a list of customer names and their mobile 
phone numbers in "California" and sort them by their 
names.
*/
SELECT
    C.First_Name,
    C.Last_Name,
    C.Mobile_phone
FROM
    Customers AS C
WHERE
    C.State = 'California'

--Q4
/*
Display the rentals that occurred between 
January 1, 2023, and December 31, 2023.
*/

SELECT * 
FROM Rentals AS R
WHERE R.Pick_up_date >= '2023-1-1' AND R.Return_date <= '2023-12-31'

--Q5
/*
Retrieve a list of all customers (Customers) and 
the number of rentals (Rentals) each customer has 
made, along with the total amount (Amount) each 
customer has paid.
*/


SELECT C.ID, COUNT(R.Reservation_Number) AS Total_Reservation, SUM(R.Amount) AS Sum_Reservation
FROM Customers AS C
	 JOIN Rentals AS R ON C.ID = R.Customer_ID
GROUP BY C.ID

--Q6
/*
Retrieve information about cars with the minimum 
and maximum number of rentals.
*/


SELECT C.ID, C.Description, C.Model, C.Brand, C.Color, C.Purchase_Date, C.Category_ID
FROM Cars AS C
	 JOIN Rentals AS R ON C.ID = R.CarID
GROUP BY C.ID, C.Description, C.Model, C.Brand, C.Color, C.Purchase_Date, C.Category_ID
HAVING COUNT(R.Reservation_Number) = (
	SELECT MAX(T.NUM)
	FROM (
		SELECT COUNT(R.Reservation_Number) AS NUM
		FROM Rentals AS R
		GROUP BY R.CarID
	) T
)
OR COUNT(R.Reservation_Number) = (
	SELECT MIN(T.NUM)
	FROM (
		SELECT COUNT(R.Reservation_Number) AS NUM
		FROM Rentals AS R
		GROUP BY R.CarID
	) T
)

--Q7
/*
Retrieve information about the customer (Customers) 
with the most rentals and the car (Cars) they have 
rented the most times.
*/


SELECT C.ID, C.SSN, C.First_Name, C.Last_Name
FROM Customers AS C
	 JOIN Rentals AS R ON C.ID = R.Customer_ID
GROUP BY C.ID, C.SSN, C.First_Name, C.Last_Name
HAVING COUNT(R.Reservation_Number) = (
	SELECT MAX(T.NUM)
	FROM (
		SELECT COUNT(R.Reservation_Number) AS NUM
		FROM Rentals AS R
		GROUP BY R.CarID
	) T
)
AND COUNT(R.CarID) = (
	SELECT MAX(T.NUM)
	FROM (
		SELECT COUNT(R.CarID) AS NUM
		FROM Rentals AS R
		GROUP BY R.CarID
	) T
)

--Q8
/*
Create a stored procedure to calculate the total 
number of rentals for a specific car type, with 
the input being the @ID of the car.
*/

SELECT * FROM Cars
SELECT * FROM Category
SELECT * FROM Customers
SELECT * FROM Location
SELECT * FROM Location_Phone_Number
SELECT * FROM Rentals

CREATE PROC Proc4 @CarID INT, 
				  @TotalRentals INT OUTPUT
AS
BEGIN
	SELECT @TotalRentals = COUNT(R.Reservation_Number)
	FROM Rentals AS R
	WHERE R.CarID = @CarID
	GROUP BY R.CarID
END

DECLARE @CarID INT
EXEC Proc4 3, @CarID OUTPUT
SELECT @CarID AS NumberRentals


--Q10
DELETE FROM Cars
WHERE Category_ID IN (
	SELECT ID
	FROM Category AS C
	WHERE C.Label = 'economy'
)
