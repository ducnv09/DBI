-- 1
SELECT Sname
FROM Sailors
EXCEPT
SELECT Sname
FROM Sailors JOIN Reserves ON Sailors.Sid = Reserves.Sid

SELECT Sname
FROM Sailors LEFT JOIN Reserves ON Sailors.Sid = Reserves.Sid
-- WHERE Reserves.Bid IS NULL
GROUP BY Sname
HAVING COUNT(Reserves.Bid) = 0

-- 2
SELECT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
			  JOIN Boats ON Reserves.Bid = Boats.Bid

WHERE Boats.Color = 'Red'
GROUP BY Sname
HAVING COUNT(Reserves.Bid) = 1

-- 3
SELECT Sailors.Sid, Sailors.Sname, COUNT(Reserves.Bid)
FROM Sailors LEFT JOIN Reserves ON Sailors.Sid = Reserves.Sid
GROUP BY Sailors.Sid, Sailors.Sname

-- 4
SELECT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 

GROUP BY Sname
HAVING COUNT(Reserves.Bid) = (
	SELECT MAX(B.NUM) 
	FROM (
		SELECT COUNT(Reserves.Bid) AS NUM
		FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
		GROUP BY Sailors.Sid
	) B
) 

-- 4
SELECT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 

GROUP BY Sname
HAVING COUNT(Reserves.Bid) >= ALL (
	SELECT COUNT(Reserves.Bid)
	FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
	GROUP BY Sailors.Sid
) 
-- 5
SELECT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
			  JOIN Boats ON Reserves.Bid = Boats.Bid
GROUP BY Sname
HAVING COUNT(DISTINCT(Boats.Color)) > 2

-- 6
SELECT Sname
FROM Sailors
WHERE Age >= 20 AND Age <= 40
EXCEPT
SELECT Sname
FROM Sailors JOIN Reserves ON Sailors.Sid = Reserves.Sid

-- 7
SELECT Age
FROM Sailors
WHERE NOT EXISTS
(
SELECT Boats.Bid
FROM Boats
EXCEPT 
SELECT Reserves.Bid
FROM Reserves 
WHERE Sailors.Sid = Reserves.Sid)

SELECT Age
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
GROUP BY Sailors.Age
HAVING COUNT(DISTINCT(Reserves.Bid)) = (
SELECT COUNT(Boats.Bid)
FROM Boats
)

-- 8
SELECT Reserves.Day
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
			  JOIN Boats ON Reserves.Bid = Boats.Bid
WHERE Boats.Bname = 'Interlake'

-- 9
SELECT Rating
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
GROUP BY Rating
HAVING COUNT(Reserves.Bid) > (
	SELECT COUNT(Reserves.Bid)
	FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid  
	WHERE Sailors.Sname = 'Horatio'
	GROUP BY Sailors.Sname
	)

-- 10
SELECT SUM(T.NUM)
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 

(
SELECT Sailors.Sid, Sailors.Sname, COUNT(Reserves.Bid) AS NUM
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid  
WHERE Sailors.Sname = 'Dustin' OR Sailors.Sname = 'Lubber'
) T