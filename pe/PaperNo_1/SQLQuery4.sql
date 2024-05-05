alter trigger trg_not_duplicate on Film
for insert 
as
begin
    if ( select count(i.film_id) from Film f, inserted i where F.film_id = i.film_id) > 0
	         rollback transaction
end