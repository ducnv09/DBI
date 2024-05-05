/*
DROP DATABASE Q1
CREATE DATABASE Q1
USE Q1

CREATE TABLE tblStudents(
	stid NCHAR(7) PRIMARY KEY,
	name NVARCHAR(25),
	birthday DATE,
	phone NVARCHAR
);

CREATE TABLE tblSubjects(
	subid NCHAR(6) PRIMARY KEY,
	suname NVARCHAR(50),
	unit INT
);

CREATE TABLE Result(
	stid NCHAR(7),
	subid NCHAR(6),
	score01 FLOAT,
	score02 FLOAT,
	PRIMARY KEY (stid, subid),
	FOREIGN KEY (stid) REFERENCES tblStudents(stid),
	FOREIGN KEY (subid) REFERENCES tblSubjects(subid)
);
*/
-- Q2


SELECT * FROM tblInvoices AS I
WHERE I.employeeid = 'S002'

--Q3
SELECT P.proid, P.proname, S.supname
FROM tblSuppliers AS S
	 JOIN tblProducts AS P ON S.supcode = P.supcode
WHERE S.supname = N'Hoàn Vũ'

-- Q4
SELECT P.proname, SUM(ID.quantity) AS "Total quantity"
FROM tblProducts AS P
	 JOIN tblInv_Detail AS ID ON P.proid = ID.proid
WHERE P.proname = N'Router Wifi Chuẩn Wifi 6 AX5400 TP-Link Archer AX73'
GROUP BY P.proname

-- Q5
SELECT I.employeeid, COUNT(DISTINCT ID.invid) AS "Total quantity"
FROM tblInv_Detail AS ID
	 JOIN tblInvoices AS I ON ID.invid = I.invid
GROUP BY I.employeeid

-- Q6 


SELECT ID.invid, SUM(ID.quantity * ID.price) AS "Total Number"
FROM tblInv_Detail AS ID
GROUP BY ID.invid
HAVING SUM(ID.quantity * ID.price) = (
	SELECT MAX(T.NUM)
	FROM (
		SELECT SUM(ID.quantity * ID.price) AS NUM
		FROM tblInv_Detail AS ID
		GROUP BY ID.invid
	) T
)

-- Q7


SELECT ID.invid, I.invdate,ID.proid, ID.quantity, ID.price
FROM tblInv_Detail AS ID
	 JOIN tblInvoices AS I ON ID.invid = I.invid
WHERE I.employeeid = 'S003'

-- Q8
CREATE PROC procProductNumber @supcode VARCHAR(10),
							  @ProductNumber INT OUT
AS
BEGIN
	SELECT @ProductNumber = COUNT(*)
	FROM tblProducts AS P
	WHERE P.supcode = @supcode
END

DECLARE @Productnumber INT 
EXEC procProductNumber 'MT', @Productnumber OUTPUT
SELECT @Productnumber

-- Q9



DROP TRIGGER InsertInvoice

CREATE TRIGGER InsertInvoice
ON tblInv_Detail
AFTER INSERT
AS
BEGIN
	SELECT I.invid, SUM(ID.quantity * ID.price) AS "Total Amount"
	FROM inserted AS I
		 JOIN tblInv_Detail AS ID ON I.invid = ID.invid
	GROUP BY I.invid
END

INSERT INTO tblInv_Detail
VALUES('000003', 'RTPL02', 1, 10000000)

DELETE FROM tblInv_Detail
WHERE invid = '000003' AND proid = 'RTPL02'

-- Q10
SELECT * FROM tblInv_Detail
SELECT * FROM tblInvoices
SELECT * FROM tblProducts
SELECT * FROM tblSuppliers

DELETE FROM tblInvoices
WHERE customer = N'Lê Minh phương'
