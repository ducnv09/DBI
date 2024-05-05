-- 1
SELECT Sname
FROM Sailors JOIN Reserves ON Sailors.Sid = Reserves.Sid
WHERE Reserves.Bid = 103


-- 2
SELECT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
JOIN Boats ON Reserves.Bid = Boats.Bid
WHERE Color = 'Red'
GROUP BY Sname
HAVING COUNT(Reserves.Bid) = 1

-- 3
SELECT DISTINCT Color
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
JOIN Boats ON Reserves.Bid = Boats.Bid
WHERE Sname = 'Lubber'

-- 4
SELECT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
GROUP BY Sname
HAVING COUNT(Reserves.Sid) >= 1

-- 5
SELECT DISTINCT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
JOIN Boats ON Reserves.Bid = Boats.Bid
WHERE Color = 'Red' OR Color = 'Green'

-- 7
SELECT DISTINCT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
JOIN Boats ON Reserves.Bid = Boats.Bid
WHERE Color <> 'Red' AND Age > 20

-- 8
SELECT Sname
FROM Sailors
WHERE NOT EXISTS (
	SELECT DISTINCT Boats.Bid FROM Boats
	EXCEPT 
	SELECT Reserves.Bid 
	FROM Reserves
	WHERE Sailors.Sid = Reserves.Sid
)

-- 9
SELECT DISTINCT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
JOIN Boats ON Reserves.Bid = Boats.Bid
WHERE Bname = 'Interlake'

-- 10
SELECT DISTINCT Sname
FROM Reserves JOIN Sailors ON Sailors.Sid = Reserves.Sid 
GROUP BY Sname
HAVING COUNT(Reserves.Sid) >= 2
