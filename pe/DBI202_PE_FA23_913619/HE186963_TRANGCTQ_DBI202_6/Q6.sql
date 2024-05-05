select distinct c.ID as CarID, c.Model, c.Brand, c.Color, res.Reservation_Number, r.Amount
from Cars c
join Rentals res on res.CarID = c.ID
join (
	select carID, Min(Amount) as Amount
	from Rentals re
	join Cars ca on ca.ID = re.CarID
	group by carID

) r on r.Amount = res.Amount
order by r.Amount ASC
