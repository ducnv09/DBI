DROP DATABASE Q1
CREATE DATABASE Q1
USE Q1

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY,
	CustomerAddress NVARCHAR(100),
	CustomerPhone VARCHAR(20)
);

CREATE TABLE Manufactures(
	ManufactureID INT PRIMARY KEY,
	ManufactureAddress NVARCHAR(100),
	ManufacturePhone VARCHAR(20), 
	Manufacturefax VARCHAR(20)
);

CREATE TABLE Laptops(
	LaptopSKU VARCHAR(10) PRIMARY KEY,
	LaptopName NVARCHAR(50),
	Price DECIMAL(6,2),
	Description NVARCHAR(500),
	ManufactureID INT,
	FOREIGN KEY (ManufactureID) REFERENCES Manufactures(ManufactureID)
);

CREATE TABLE Purchase(
	CustomerID INT,
	LaptopSKU VARCHAR(10), 
	Date DATETIME,
	Quantity INT,
	PRIMARY KEY (CustomerID, LaptopSKU),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
	FOREIGN KEY (LaptopSKU) REFERENCES Laptops(LaptopSKU)
);