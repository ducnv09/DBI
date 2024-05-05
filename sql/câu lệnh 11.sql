-- 1.	Return the sid of the person who reserved the boat on 9/08/08.
SELECT Sid
FROM Reserves
WHERE Day = '2008-09-08'

-- 2.	Return the day when sharper was reserved.
SELECT Day
FROM Reserves JOIN Boats ON Reserves.Bid = Boats.Bid
WHERE Bname = 'Sharpaer'

-- 3.	Return the month which most boats were reserved.
SELECT MONTH(DAY) AS MONTH
FROM Reserves
GROUP BY DAY
HAVING COUNT(MONTH(DAY)) = 
	(
	SELECT MAX(B.MONTH)
	FROM (
		SELECT COUNT(MONTH(DAY)) AS MONTH
		FROM Reserves
		GROUP BY DAY
	) B
)

-- 4.	Return the name of the ship where id of the ship is the input from user.
DECLARE @InputID INT;
SET @InputID = 101;

SELECT Bname
FROM Boats
WHERE Bid = @InputID;

-- 5.	Return the age of sailors who have reserved all boats
SELECT Age
FROM Sailors
WHERE NOT EXISTS 
(
	SELECT Boats.Bid
	FROM Boats
	EXCEPT
	SELECT Reserves.Bid
	FROM Reserves
	WHERE Sailors.Sid = Reserves.Sid
)

-- 6.	A Procedure to update name of the sailor where name is input.
CREATE PROC UpdateName
@old_name VARCHAR(100),
@new_name VARCHAR(100)
AS
BEGIN
	UPDATE Sailors
	SET Sname = @new_name
	WHERE Sname = @old_name
END

EXEC UpdateName 'Dustin','OK TRANG'

DROP PROC UpdateName

SELECT * FROM Boats 
SELECT * FROM Reserves
SELECT * FROM Sailors

DROP TABLE Boats
DROP TABLE Reserves
DROP TABLE Sailors
