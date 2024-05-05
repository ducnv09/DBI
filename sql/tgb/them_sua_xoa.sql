-- Studios (name, address)
create table Studios (
	Name nvarchar(100),
	Address nvarchar(100)
);


-- tạo mới bảng từ bảng đã có sẵn
create table new_table AS
select Name
from Studios

-- remove table
drop table table_name

-- remove all data in table, not remove table
TRUNCATE TABLE table_name

-- add column/ attribute in table
ALTER TABLE table_name
ADD column_name data_type

-- remove column in table
ALTER TABLE table_name
DROP COLUMN column_name

-- change name column
ALTER TABLE table_name
RENAME COLUMN old_name to new_name

-- change data type a column
ALTER TABLE table_name
ALTER COLUMN column_name data_type

-- xóa một bộ trong mảng
DELETE FROM table_name
WHERE condition;

-- chỉnh sửa lại cái giá trị của từng hàng trong bảng
UPDATE table_name
SET column1 = value1,
	column2 = value2,...
WHERE condition

ID  NAME  PHONE   ADDR    CITY   COUNTRY
1	 T    0345    HANOI   HANOI  VIETNAM
2	 B    0315    HANAM   HANOI  VIETNAM

UPDATE STUDENT
SET PHONE = '0912', ADDRESS = 'HANOI'
WHERE ID = 1

-- thêm một record/ hàng/ tuple vào bảng
INSERT INTO table_name (column1, column2,...)
VALUES (value1, value2,...)

-- dùng để chọn dữ liệu từ cơ sở dữ liệu

-- column : projection
SELECT column1, column2, ..
FROM table_name
WHERE condition

-- where is selection

-- dùng để kết hợp 2 bảng hoặc nhiều bảng lại với nhau thông qua các khóa ngoại 
ORDER TABLE
ORDERID  CUSTOMERID  ORDERDATE
1        2           2023-24-9
2        4           2023-24-9

CUSTOMER TABLE
CUSTOMERID  CUSTOMERNAME  CONTACTNAME  COUNTRY
2           DUC           A            B

SELECT ORDERID, CUSTOMERNAME, ORDERDATE
FROM ORDERS
INNER JOIN CUSTOMER
ON ORDER.CUSTOMERID = CUSTOMER.CUSTOMERID

ORDERID  CUSTOMERNAME  ORDERDATE
2        DUC           2023-24-9

4 KIỂU JOIN KHÁC NHAU:

(INNER) JOIN: trả về những bộ mà giá trị của thuộc tính giống nhau của 2 cột giống nhau
LEFT (OUTER)
RIGHT (OUTER)
