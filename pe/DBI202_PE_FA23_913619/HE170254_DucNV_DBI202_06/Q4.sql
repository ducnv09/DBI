SELECT R.Reservation_Number,
	   R.Amount,
	   R.Pick_up_date,
	   R.Return_date,
	   (C.First_Name + C.Last_Name) AS CustomerFullname,
	   L.Country AS PickCountry,
	   L2.Country AS ReturnCountry
FROM Rentals AS R
	 JOIN Location AS L ON R.Pick_up_location = L.ID
	 JOIN Location AS L2 ON R.Return_location = L2.ID
	 JOIN Customers AS C ON R.Customer_ID = C.ID
WHERE L.Country <> L2.Country
ORDER BY R.Amount DESC