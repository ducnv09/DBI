--Q6
with a as (select ps.SubcategoryID, ps.Name as SubcategoryName,
ps.Category, count(p.SubcategoryID) as NumberOfProducts
from ProductSubcategory ps 
left join Product p
on ps.SubcategoryID = p.SubcategoryID
group by  ps.SubcategoryID, ps.Name,
ps.Category)
select * from a 
where NumberOfProducts = (select min(NumberOfProducts) from a)