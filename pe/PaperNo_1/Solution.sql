-- 1 (just got 1.89/2, need improvement)
create table Employees
(
EmpID int primary key,
name nvarchar(50),
salary money
)

create table Managers
(
bonus money,
EmpID int foreign key references Employees(EmpID),
primary key (EmpID)
)

create table Projects
(
ProjectID int primary key,
name nvarchar(200),
EmpID int foreign key references Employees(EmpID),
)

create table Works
(
EmpID int foreign key references Employees(EmpID),
ProjectID int foreign key references Projects(ProjectID),
[hours] int
primary key (EmpID, ProjectID)
)

-- 2
select * from Location
where CostRate > 0

-- 3
select ProductID, Price, StartDate, EndDate
from ProductPriceHistory
where year(EndDate) = 2003 and Price < 100
order by Price desc

-- 4
select t.ProductID, t.ProductName, t.Color, t.SubcategoryID, s.Name as SubCategoryName, s.Category, h.StartDate, h.EndDate, h.Cost as HistoryCost
from (select ProductID, Name as ProductName, Color, SubcategoryID
from Product where Color = 'Black' and Name like 'HL%') as t left join ProductSubcategory s on t.SubcategoryID = s.SubcategoryID left join ProductCostHistory h on t.ProductID = h.ProductID

-- 5
select i.ProductID, p.Name, sum(Quantity) as TotalQuantity
from ProductInventory i, Product p
where p.ProductID = i.ProductID
group by i.ProductID, p.Name
having sum(Quantity) > 1700
order by TotalQuantity desc, Name asc

-- 6
select s.SubcategoryID, s.Name as SubcategoryName, Category, count(p.SubcategoryID) as NumberOfProducts
from ProductSubcategory s, Product p
where s.SubcategoryID = p.SubcategoryID
group by s.SubcategoryID, s.Name, Category
having count(p.SubcategoryID) = (select min(a.NumberOfProducts) from (select s.SubcategoryID, s.Name as SubcategoryName, Category, count(p.SubcategoryID) as NumberOfProducts
from ProductSubcategory s, Product p
where s.SubcategoryID = p.SubcategoryID
group by s.SubcategoryID, s.Name, Category) as a)

-- 7
-- 7.1
select d.ModelID, d.ModelName, d.ProductID, d.ProductName, count(d.ProductID) as 'NumberOfLocations' from (select c.ModelID, c.ModelName, c.ProductID, c.Name as 'ProductName', c.LocationName from (select * from (select ModelID, Name as 'ModelName' from ProductModel where Name like 'HL Mountain%') as a
left join
(select p.ModelID as 'MID', p.ProductID, p.Name, l.Name as 'LocationName' from Product p, ProductInventory i, Location l
where p.ProductID = i.ProductID and i.LocationID = l.LocationID) as b
on a.ModelID = b.MID) as c) as d
group by d.ModelID, d.ModelName, d.ProductID, d.ProductName

-- 7.2
select b.Category, c.Name as 'SubcategoryName', b.NumberOfProduct from (select a.Category, max(a.Count) as 'NumberOfProduct' from (select s.Category, s.Name, count(s.SubcategoryID) as 'Count' from ProductSubcategory s, Product p
where s.SubcategoryID = p.SubcategoryID
group by s.Category, s.Name) as a
group by a.Category) as b, (select s.Category, s.Name, count(s.SubcategoryID) as 'Count' from ProductSubcategory s, Product p
where s.SubcategoryID = p.SubcategoryID
group by s.Category, s.Name) as c
where b.Category = c.Category and b.NumberOfProduct = c.Count
order by NumberOfProduct desc

-- 8
create proc proc_product_location
(
	@productid int,
	@numberOfLocation int output
)
as
begin
	set @numberOfLocation = (select count(*) from ProductInventory p, Location l where p.ProductID = @productid and p.LocationID = l.LocationID)
end

-- 9
create trigger tr_delete_productInventory_location
on ProductInventory
for delete as
begin
select d.ProductID, d.LocationID, l.Name, d.Shelf, d.Bin, d.Quantity from deleted d, Location l where l.LocationID = d.LocationID
end

-- 10
update ProductInventory set quantity = 2000 where productID in (select ProductID from Product where ModelID = 33)