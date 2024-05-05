select r.Reservation_Number, r.Amount, r.Pick_up_date, r.Return_date, c.First_Name + ' '+c.Last_Name as CustomerFullname, l.Country as PickupCountry, m.Country as ReturnCountry
from Rentals r
join Customers c on r.Customer_ID = c.ID
join Location l on l.ID = r.Pick_up_location
join Location m on m.ID = r.Return_location
where l.Country != m.Country
order by r.Amount desc