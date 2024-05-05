CREATE PROC P2 @customerID INT, 
			   @numberOfRentals INT OUTPUT
AS
BEGIN
	SELECT @numberOfRentals = COUNT(R.Reservation_Number)
	FROM Rentals AS R
	WHERE R.Customer_ID = @customerID
	GROUP BY R.Customer_ID
END