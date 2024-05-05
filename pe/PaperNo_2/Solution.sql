-- 1
select staff_id, first_name, last_name from staff where active = 1 order by staff_id

-- 2
select film_id, title, [length], rating from film where length >= 170 and film_id in (select film_id from film_category where category_id = (select category_id from category where name = 'Documentary')) order by film_id

-- 3
select c.name, count(f.category_id) as 'Number of films'from category c, film_category f where f.category_id = c.category_id
group by c.name
order by [Number of films]

-- 4
select c.name, count(f.category_id) as 'Number of films' from category c, film_category f where f.category_id = c.category_id
group by c.name
having count(f.category_id) = (select max(a.[Number of films]) from (select c.name, count(f.category_id) as 'Number of films'from category c, film_category f where f.category_id = c.category_id
group by c.name) as a)

-- 5
select a.first_name, count(f.actor_id) as 'Number of films' from film_actor f, actor a
where a.actor_id = f.actor_id
group by a.first_name
having count(f.actor_id) >= 90
order by [Number of films] asc

-- 6
select film_id, title, rating, [length] from film where length >= (select length from film
where title = 'THEORY MERMAID') and rating = (select rating from film
where title = 'THEORY MERMAID')
and not title = 'THEORY MERMAID'

-- 7
create proc NumberOFFilm
(
@catName varchar(25),
@count int output
)
as
begin
select count(f.film_id) from film f, film_category fc, category c
where f.film_id = fc.film_id and fc.category_id = c.category_id and c.name = @catName
end

-- 8
create trigger notDuplicated on Film
for insert
as
begin
if (select count(*) from film f, inserted i where f.title = i.title) > 1
	rollback transaction
end