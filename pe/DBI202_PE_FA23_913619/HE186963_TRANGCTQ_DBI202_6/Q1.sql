CREATE TABLE Items(
	Color VARCHAR(30) PRIMARY KEY,
	Price DECIMAL(10,2),
)

CREATE TABLE Products(
	ProductNo VARCHAR(30) PRIMARY KEY,
	Category NVARCHAR(100),
	PName NVARCHAR(100),
	Description NVARCHAR(255),
	Color VARCHAR(30) FOREIGN KEY REFERENCES Items(Color)
)

CREATE TABLE Sizes(
	SizeCode VARCHAR(15) PRIMARY KEY,
	Description NVARCHAR(200),
	Color VARCHAR(30) FOREIGN KEY REFERENCES Items(Color)
)