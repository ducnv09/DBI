Create trigger Tr1 on Category
for delete
as
begin
	Update Cars
	set Category_ID = NULL
	WHERE Category_ID in
	(select c.Category_ID
	from Cars c
	join deleted d on d.ID = c.Category_ID)
end

DELETE FROM Category
WHERE ID = 1