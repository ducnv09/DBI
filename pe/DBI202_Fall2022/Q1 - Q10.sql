-- q1
/*
Logins(username: primary key (nvarchar(50)), password: nvarchar(255)


*/

-- Create Staffs Table
/*
CREATE TABLE Staffs (
StaffID INT PRIMARY KEY,
Name NVARCHAR(100)
);
GO


-- Create Logins Table
CREATE TABLE Logins (
username NVARCHAR(50) PRIMARY KEY,
password NVARCHAR(255),
role NVARCHAR(100),
StaffID INT,
CONSTRAINT (FK_Logins_Staffs) FOREIGN KEY (StaffID) REFERENCES Staffs(StaffID)
);
GO


-- Create Reports Table
CREATE TABLE Reports (
ReportNumber INT PRIMARY KEY,
Date DATE,
IssueReturn NVARCHAR(200),
username NVARCHAR(50),
CONSTRAINT (FK_Reports_Logins) FOREIGN KEY (username) REFERENCES Logins(username)
);
GO
*/


--Q2


SELECT S.StockItemID, S.StockItemName, S.SupplierID, S.Color
FROM StockItems AS S
WHERE S.Color = 'Blue'

--Q3
SELECT ST.SupplierTransactionID, ST.SupplierID, S.SupplierName, ST.TransactionDate, ST.TransactionAmount
FROM SupplierTransactions AS ST
	 JOIN Suppliers AS S ON ST.SupplierID = S.SupplierID
WHERE ST.TransactionDate BETWEEN '2013-02-01' AND '2013-02-15'

--Q4


SELECT SI.StockItemID, SI.StockItemName, S.SupplierID, S.SupplierName, SI.OuterPackageID, PT.PackageTypeName AS OuterPack, SI.UnitPrice
FROM StockItems AS SI
	 JOIN PackageTypes AS PT ON SI.OuterPackageID = PT.PackageTypeID
	 JOIN Suppliers AS S ON SI.SupplierID = S.SupplierID
WHERE SI.StockItemID >= 135
ORDER BY PT.PackageTypeName ASC,
		 SI.StockItemName ASC

-- Q5
SELECT S.SupplierID, S.SupplierName, COUNT(PO.PurchaseOrderID) AS NumberOfPurchaseOrders
FROM Suppliers AS S
	 LEFT JOIN PurchaseOrders AS PO ON S.SupplierID = PO.SupplierID
GROUP BY S.SupplierID, S.SupplierName
ORDER BY NumberOfPurchaseOrders DESC

-- Q6


SELECT TOP 1 SI.UnitPackageID, PT.PackageTypeName AS UnitPackageTypeName, COUNT(SI.StockItemID) AS NumberOfStockItems
FROM PackageTypes AS PT
	 JOIN StockItems AS SI ON PT.PackageTypeID = SI.UnitPackageID
GROUP BY SI.UnitPackageID, PT.PackageTypeName
ORDER BY NumberOfStockItems ASC

-- C2
SELECT SI.UnitPackageID, PT.PackageTypeName AS UnitPackageTypeName, COUNT(SI.StockItemID) AS NumberOfStockItems
FROM PackageTypes AS PT
	 JOIN StockItems AS SI ON PT.PackageTypeID = SI.UnitPackageID
GROUP BY SI.UnitPackageID, PT.PackageTypeName
HAVING COUNT(SI.StockItemID) = (
	SELECT MIN(T.NUM) 
	FROM (
		SELECT COUNT(SI.StockItemID) AS NUM
		FROM StockItems AS SI
		GROUP BY SI.UnitPackageID
	) T
)

--Q7
SELECT PT.PackageTypeID, PT.PackageTypeName, 
	   (SELECT COUNT(SI.StockItemID)
	   FROM StockItems AS SI
	   WHERE PT.PackageTypeID = SI.UnitPackageID)
	   AS NumberOfStockItems_UnitPackage,
	   (SELECT COUNT(SI.StockItemID)
	   FROM StockItems AS SI
	   WHERE PT.PackageTypeID = SI.OuterPackageID)
	   AS NumberOfStockItems_OuterPackage
FROM PackageTypes AS PT
WHERE PT.PackageTypeName = 'Each' OR
	  PT.PackageTypeName = 'Packet' OR
	  PT.PackageTypeName = 'Pair' OR
	  PT.PackageTypeName = 'Bag' OR
	  PT.PackageTypeName = 'Carton' OR
	  PT.PackageTypeName = 'Box' 
GROUP BY PT.PackageTypeID, PT.PackageTypeName
ORDER BY NumberOfStockItems_OuterPackage DESC,
		 PT.PackageTypeName ASC

-- Q8
CREATE PROC Proc4 @stockItemID INT,
				  @OrderYear INT,
				  @numberOfPurchaseOrders INT OUTPUT
AS
BEGIN
	SELECT @numberOfPurchaseOrders = COUNT(PO.PurchaseOrderID)
	FROM PurchaseOrders AS PO
		 JOIN PurchaseOrderLines AS POL ON PO.PurchaseOrderID = POL.PurchaseOrderID
	WHERE POL.StockItemID = @stockItemID AND
		  YEAR(PO.OrderDate) = @OrderYear
	GROUP BY PO.SupplierID
END

DECLARE @x INT
EXEC Proc4 95, 2013, @x OUTPUT
SELECT @x AS NumberOfPurchaseOrders

--TÍNH SỐ LƯỢNG HÓA ĐƠN CỦA MÃ CHỨNG KHOÁN CO StockID = ? 

SELECT COUNT(PO.PurchaseOrderID) AS TOTAL
FROM PurchaseOrders AS PO
	 JOIN PurchaseOrderLines AS POL ON PO.PurchaseOrderID = POL.PurchaseOrderID
WHERE POL.StockItemID = 95 AND YEAR(PO.OrderDate) = 2013
GROUP BY PO.SupplierID

--Q9


CREATE TRIGGER Tr4
ON StockItems
AFTER INSERT
AS
BEGIN
	SELECT I.StockItemID, I.StockItemName, I.OuterPackageID, PT.PackageTypeName AS OuterPackageTypeName, I.UnitPrice, I.TaxRate
	FROM inserted AS I
		 JOIN PackageTypes AS PT ON I.OuterPackageID = PT.PackageTypeID
END

INSERT INTO StockItems(StockItemID, StockItemName, UnitPackageID, OuterPackageID,
					   QuantityPerOuter, IsChillerStock, TaxRate, UnitPrice, TypicalWeightPerUnit, SupplierID)

VALUES (308, 'T-shirt Red bull', 7, 6, 1, 0, 0.15, 10.5, 0.4, 4),
	   (309, 'T-shirt Micket', 10, 9, 1, 0, 0.15, 12.0, 0.45, 4)

DELETE FROM StockItems
WHERE StockItemID = 308

--Q10
SELECT * FROM StockItems
SELECT * FROM PackageTypes
SELECT * FROM PurchaseOrderLines
SELECT * FROM PurchaseOrders
SELECT * FROM Suppliers
SELECT * FROM SupplierTransactions

DELETE FROM PackageTypes 
WHERE PackageTypeID NOT IN (
	SELECT UnitPackageID
	FROM StockItems
)
AND PackageTypeID NOT IN (
	SELECT OuterPackageID
	FROM StockItems
)
