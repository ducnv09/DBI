CREATE TABLE Products (
	ProductNo VARCHAR(30) PRIMARY KEY,
	Category NVARCHAR(100),
	PName NVARCHAR(100),
	[Description] NVARCHAR(255)
);

CREATE TABLE Sizes (
	SizeCode VARCHAR(15) PRIMARY KEY,
	[Description] NVARCHAR(200)
);

CREATE TABLE Items (
	Color VARCHAR(30) PRIMARY KEY,
	Price DECIMAL(10,2),
	ProductNo VARCHAR(30),
	SizeCode VARCHAR(15),
	FOREIGN KEY (ProductNo) REFERENCES Products(ProductNo),
	FOREIGN KEY (SizeCode) REFERENCES Sizes(SizeCode),
);