﻿-- 1
SELECT * FROM CUSTOMER
WHERE CUST_TYPE_CD = 'I'

-- 2
SELECT COUNT(*)
AS total
FROM CUSTOMER
WHERE CUST_TYPE_CD = 'B'
GROUP BY CUST_TYPE_CD

SELECT * FROM CUSTOMER
WHERE CUST_TYPE_CD = 'B'

-- 3
SELECT * FROM ACCOUNT
WHERE AVAIL_BALANCE <> PENDING_BALANCE

-- 4
SELECT C.CUST_ID, C.CUST_TYPE_CD, (I.FIRST_NAME + I.LAST_NAME) AS NAME
FROM CUSTOMER AS C 
	  JOIN INDIVIDUAL AS I
ON C.CUST_ID = I.CUST_ID
UNION
SELECT C.CUST_ID, C.CUST_TYPE_CD, B.NAME
FROM CUSTOMER AS C 
	  JOIN BUSINESS AS B
ON C.CUST_ID = B.CUST_ID

-- 5 ĐẾM TẤT CẢ ACCOUNT CỦA MỖI EMPLOYEE
SELECT * FROM ACCOUNT AS A
		RIGHT JOIN EMPLOYEE AS E
ON A.OPEN_EMP_ID = E.EMP_ID

SELECT * FROM ACCOUNT AS A
		JOIN EMPLOYEE AS E
ON A.OPEN_EMP_ID = E.EMP_ID

-- ĐẾM ACCOUNT_ID THEO NHÓM EMP_ID
SELECT COUNT(ACCOUNT_ID)
FROM ACCOUNT AS A
		JOIN EMPLOYEE AS E
ON A.OPEN_EMP_ID = E.EMP_ID

SELECT COUNT(ACCOUNT_ID)
FROM ACCOUNT AS A
		JOIN EMPLOYEE AS E
ON A.OPEN_EMP_ID = E.EMP_ID
GROUP BY EMP_ID

SELECT EMP_ID, (E.FIRST_NAME + E.LAST_NAME) AS NAME, COUNT(ACCOUNT_ID) AS NUMBER
FROM ACCOUNT AS A
		RIGHT JOIN EMPLOYEE AS E
ON A.OPEN_EMP_ID = E.EMP_ID
GROUP BY (E.FIRST_NAME + E.LAST_NAME), E.EMP_ID

-- 6 IN RA CUSTOMER CÓ 1 ACCOUNT
SELECT CUST_ID
FROM ACCOUNT
GROUP BY CUST_ID
HAVING COUNT(ACCOUNT_ID) = 1
