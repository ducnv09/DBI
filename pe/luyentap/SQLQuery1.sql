CREATE TABLE Buildings(
BuildingCode VARCHAR(10) PRIMARY KEY,
Name NVARCHAR(50),
Adress NVARCHAR(100)
);

CREATE TABLE Rooms(
DoorNumber INT PRIMARY KEY,
[Floor] INT ,
BuildingCode VARCHAR(10) FOREIGN KEY REFERENCES Buildings(BuildingCode)
);

CREATE TABLE Departments(
DepartmentID INT PRIMARY KEY,
Name NVARCHAR(100)
);
