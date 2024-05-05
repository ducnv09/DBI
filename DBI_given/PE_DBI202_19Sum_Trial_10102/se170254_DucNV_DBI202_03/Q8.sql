CREATE PROC TotalAMount @OrderID NVARCHAR(255),
						@TotalAmount FLOAT OUTPUT
AS
BEGIN
	SELECT @TotalAmount = SUM(OD.SalePrice * OD.Quantity * (1 - OD.Discount))
	FROM OrderDetails AS OD
	WHERE @OrderID = OD.OrderID
	GROUP BY OD.OrderID
END