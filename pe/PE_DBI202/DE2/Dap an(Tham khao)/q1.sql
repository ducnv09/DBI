create table Departments(
	DepartmentID int primary key,
	[Name] nvarchar(100)
)

create table Projects(
	ProjectID int primary key,
	Title nvarchar(255),
	DepartmentID int foreign key references Departments(DepartmentID)
)

create table Employees(
	EmployeeID int primary key,
	[Name] nvarchar(100),
	DOB date
)

create table Participate(
	ProjectID int foreign key references Projects(ProjectID),
	EmployeeID int foreign key references Employees(EmployeeID),
	[Hours] int,
	primary key(ProjectID, EmployeeID)
)