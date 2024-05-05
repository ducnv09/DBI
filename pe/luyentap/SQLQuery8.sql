-- DEM SO LAN THUE CUA XE BANG ID
CREATE PROCEDURE CalculateTotalRentalsForCarType
    @CarID int
AS
BEGIN
    -- Declare a variable to store the total rentals count
    DECLARE @TotalRentals int;

    -- Calculate the total number of rentals for the specified car type
    SELECT @TotalRentals = COUNT(*)
    FROM Rentals
    WHERE CarID = @CarID;

    -- Return the total rentals count
    SELECT @TotalRentals AS TotalRentalsForCarType;
END;

EXEC CalculateTotalRentalsForCarType @CarID = 5;


