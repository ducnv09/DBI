-- THONG TIN KHACH HANG DA THUE XE GI VA THUE BAO NHIEU LAN
SELECT
    C.First_Name AS Customer_First_Name,
    C.Last_Name AS Customer_Last_Name,
    MAX(RentalCount) AS MaxRentals,
    CarID,
    Car.Model AS Car_Model,
    Car.Brand AS Car_Brand
FROM Customers C
JOIN (
    SELECT
        R.Customer_ID,
        R.CarID AS CarID,
        COUNT(*) AS RentalCount
    FROM Rentals R
    GROUP BY R.Customer_ID, R.CarID
) AS RentalCounts
ON C.ID = RentalCounts.Customer_ID
JOIN Cars Car
ON RentalCounts.CarID = Car.ID
GROUP BY C.First_Name, C.Last_Name, CarID, Car.Model, Car.Brand
ORDER BY MaxRentals DESC
