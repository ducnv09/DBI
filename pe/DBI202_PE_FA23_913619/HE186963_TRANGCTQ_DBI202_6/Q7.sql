select c.Category_ID as CategoryID, cat.Label, 
	Year(r.Pick_up_date) as Year, 
	SUM(r.Amount) as TotalAmount, 
	COUNT(c.ID) as NumberOfCustomer, 
	SUM(DATEDIFF(day, r.Pick_up_date, r.Return_date)) as TotalRentedDays
from Rentals r
join Cars c on c.ID = r.CarID
join Category cat on cat.ID = c.Category_ID
group by c.Category_ID, cat.Label, Year(r.Pick_up_date)
order by TotalAmount desc