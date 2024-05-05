select distinct c.ID as CustomerID, c.First_Name, c.Last_Name, coalesce(sum(r.Amount), NULL) as TotalAmount
from Customers c
left join
(
select * from Rentals
join Location ON Location.ID = Rentals.Pick_up_location
where Country = 'United States'
)
r on r.Customer_ID = c.ID
left join
(
	select * from Location
	where Country = 'United States'
) l on l.ID = r.Pick_up_location
group by c.ID, c.First_Name, c.Last_Name
order by TotalAmount desc