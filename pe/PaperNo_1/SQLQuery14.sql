--ex7
create proc NumberOfFilm
@catName varchar(25),
@count int output
as
	begin
		set @count = (select count(f.film_id) from dbo.film f, dbo.film_category fc, dbo.category c
						where f.film_id = fc.film_id and fc.category_id = c.category_id and c.name = @catName)
	end

declare @count int
exec NumberOfFilm 'Documentary', @count output
select @count