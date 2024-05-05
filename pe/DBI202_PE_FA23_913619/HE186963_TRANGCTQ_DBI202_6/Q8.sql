create proc P2
@Customer int,
@num int output
as
begin
	select @num = COUNT(r.Customer_ID)
	from Customers c
	join Rentals r on c.ID = r.Customer_ID
	where c.ID = @Customer
end