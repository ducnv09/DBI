-- LAY THONG TIN CAR VA SO LAN THUE
SELECT c.ID,c.Brand,c.Color,COUNT(r.CarID)FROM Cars c
LEFT JOIN Rentals r
ON c.ID=r.CarID
GROUP BY c.ID,c.Brand,c.Color

-- LAY THONG TIN CAC CAR THUE MIN 
SELECT c.ID, c.Brand, c.Color, COUNT(r.CarID) AS RentalsCount
FROM Cars c
LEFT JOIN Rentals r ON c.ID = r.CarID
GROUP BY c.ID, c.Brand, c.Color
HAVING COUNT(r.CarID) = (
    SELECT MIN(RentalsCount) FROM (
        SELECT COUNT(r1.CarID) AS RentalsCount
        FROM Rentals r1
        GROUP BY r1.CarID
    ) AS RentalCounts
);

--MIN U MAX
-- Hàm lấy xe được thuê ít nhất

CREATE FUNCTION GetCarWithMinRentals()
RETURNS TABLE AS
RETURN (
    SELECT c.ID, c.Brand, c.Color, COUNT(r.CarID) AS RentalsCount
    FROM Cars c
    LEFT JOIN Rentals r ON c.ID = r.CarID
    GROUP BY c.ID, c.Brand, c.Color
    HAVING COUNT(r.CarID) = (
        SELECT MIN(RentalsCount)
        FROM (
            SELECT COUNT(r1.CarID) AS RentalsCount
            FROM Rentals r1
            GROUP BY r1.CarID
        ) AS RentalCounts
    )
);

-- Hàm lấy xe được thuê nhiều nhất
CREATE FUNCTION GetCarWithMaxRentals()
RETURNS TABLE AS
RETURN (
    SELECT c.ID, c.Brand, c.Color, COUNT(r.CarID) AS RentalsCount
    FROM Cars c
    LEFT JOIN Rentals r ON c.ID = r.CarID
    GROUP BY c.ID, c.Brand, c.Color
    HAVING COUNT(r.CarID) = (
        SELECT MAX(RentalsCount)
        FROM (
            SELECT COUNT(r2.CarID) AS RentalsCount
            FROM Rentals r2
            GROUP BY r2.CarID
        ) AS RentalCounts
    )
);

-- Kết hợp kết quả
SELECT * FROM GetCarWithMinRentals()
UNION
SELECT * FROM GetCarWithMaxRentals();