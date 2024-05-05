﻿--Q2
SELECT * FROM DEPARTMENT
SELECT * FROM [DEPENDENT]
SELECT * FROM DEPT_LOCATIONS
SELECT * FROM EMPLOYEE
SELECT * FROM PROJECT
SELECT * FROM WORKS_ON

SELECT E.Bdate, E.Address
FROM EMPLOYEE AS E
WHERE E.Fname = 'John' AND
	  E.Minit = 'B' AND
	  E.Lname = 'Smith'

--Q3
SELECT * FROM DEPARTMENT
SELECT * FROM [DEPENDENT]
SELECT * FROM DEPT_LOCATIONS
SELECT * FROM EMPLOYEE
SELECT * FROM PROJECT
SELECT * FROM WORKS_ON

SELECT E.Fname, E.Lname
FROM EMPLOYEE AS E
WHERE E.Ssn IN (
	SELECT E.Super_ssn
	FROM EMPLOYEE AS E
	GROUP BY E.Super_ssn
	HAVING COUNT(E.Super_ssn) > 6
)

--Q4
SELECT * FROM DEPARTMENT
SELECT * FROM [DEPENDENT]
SELECT * FROM DEPT_LOCATIONS
SELECT * FROM EMPLOYEE
SELECT * FROM PROJECT
SELECT * FROM WORKS_ON

SELECT E.Lname, E.Fname
FROM EMPLOYEE AS E
	 JOIN DEPARTMENT AS D ON E.Dno = D.Dnumber
WHERE E.Salary = (
		SELECT MAX(E.Salary)
		FROM EMPLOYEE AS E
)

--Q5

SELECT Dnumber, Dname, COUNT(E.Ssn) AS NumOfEmployee
FROM (
	SELECT Dnumber, Dname  
	FROM DEPARTMENT AS D
	JOIN EMPLOYEE AS E ON E.Dno = D.Dnumber
	GROUP BY Dnumber, Dname
	HAVING COUNT(E.Ssn) > 5
)D
JOIN (
	SELECT * FROM EMPLOYEE AS E
	WHERE Salary > 40000
) E ON E.Dno = D.Dnumber
GROUP BY D.Dnumber, D.Dname
ORDER BY NumOfEmployee DESC



--Q6

SELECT * FROM DEPARTMENT
SELECT * FROM [DEPENDENT]
SELECT * FROM DEPT_LOCATIONS
SELECT * FROM EMPLOYEE
SELECT * FROM PROJECT
SELECT * FROM WORKS_ON

SELECT DISTINCT E.*
FROM EMPLOYEE AS E
	 LEFT JOIN [DEPENDENT] AS D ON E.Ssn = D.Essn
WHERE D.Essn IS NULL or DATEDIFF(YEAR, D.Bdate, GETDATE()) < 18
ORDER BY E.Fname ASC


SELECT * 
FROM EMPLOYEE
WHERE Ssn NOT IN (
    SELECT Ssn FROM EMPLOYEE
	WHERE Ssn IN (
        SELECT Ssn FROM EMPLOYEE
		JOIN DEPENDENT ON DEPENDENT.Essn = EMPLOYEE.Ssn
    )
)
OR Ssn NOT IN (
    SELECT Ssn FROM EMPLOYEE
	JOIN DEPENDENT ON DEPENDENT.Essn = EMPLOYEE.Ssn
	WHERE Ssn IN (
        SELECT Ssn FROM EMPLOYEE
		JOIN DEPENDENT ON DEPENDENT.Essn = EMPLOYEE.Ssn
		WHERE YEAR(GETDATE()) - YEAR(DEPENDENT.Bdate) >= 18
    )
)
ORDER BY Fname ASC


--Q7

SELECT *
FROM EMPLOYEE E
WHERE NOT EXISTS ( --lọc những nhân viên chưa từng làm Stafford
    SELECT P.Pnumber
    FROM PROJECT P
    WHERE P.Plocation = 'Stafford'
    EXCEPT
    SELECT W.Pno
    FROM WORKS_ON W
    WHERE W.Essn = E.Ssn
);

--c2
SELECT Essn FROM WORKS_ON
JOIN PROJECT ON PROJECT.Pnumber = WORKS_ON.Pno
WHERE Plocation = 'Stafford'
GROUP BY Essn
HAVING COUNT(WORKS_ON.Pno) = 
(
	SELECT COUNT(Pnumber) FROM PROJECT
	WHERE Plocation = 'Stafford'
)

--Q8

CREATE PROCEDURE updateSalary
@InputLocation VARCHAR(15)
AS
BEGIN
	UPDATE EMPLOYEE
	SET Salary = Salary *1.1
	WHERE Salary <30000
	AND Ssn IN (
		SELECT Ssn FROM EMPLOYEE
		JOIN WORKS_ON ON WORKS_ON.Essn = Ssn
		JOIN PROJECT ON PROJECT.Pnumber = WORKS_ON.Pno
		WHERE PROJECT.Plocation = @InputLocation
	)
	SELECT * FROM EMPLOYEE
	WHERE Ssn 
	IN (
			SELECT Ssn FROM EMPLOYEE
			JOIN WORKS_ON ON WORKS_ON.Essn = Ssn
			JOIN PROJECT ON PROJECT.Pnumber = WORKS_ON.Pno
			WHERE PROJECT.Plocation = @InputLocation
		)
END

DROP PROC updateSalary

DECLARE @location varchar(15)
SET @location = 'Stafford'
EXEC updateSalary @location

SELECT *
FROM EMPLOYEE E
		 JOIN DEPARTMENT D ON E.Dno = D.Dnumber
		 JOIN PROJECT P ON D.Dnumber = P.Dnum

--Q9
CREATE TRIGGER tr_no_insert 
ON EMPLOYEE
FOR INSERT 
AS
BEGIN
	DECLARE @dnum INT
	SET @dnum = (
		SELECT inserted.Dno 
		FROM inserted
	)

	DECLARE @numOfDepartment INT 
	SET @numOfDepartment =
		(SELECT count(e.Ssn) FROM EMPLOYEE e
		RIGHT JOIN DEPARTMENT d ON e.Dno = d.Dnumber
		WHERE d.Dnumber = @dnum
		GROUP BY d.Dnumber,d.Dname)
	IF(@numOfDepartment > 5) 
	BEGIN 
		SELECT 'no insert' AS [the result]
		DELETE EMPLOYEE WHERE Ssn = (SELECT Ssn FROM inserted) 
	END

	ELSE 
	BEGIN
		SELECT 'inserted' AS [the result]
	END

END

--Q10


UPDATE EMPLOYEE
SET Salary = Salary * 1.10
WHERE Ssn IN (
	SELECT E.Ssn
	FROM EMPLOYEE E
		 JOIN DEPENDENT D ON E.Ssn = D.Essn
	WHERE YEAR(GETDATE()) - YEAR(D.Bdate) < 18
)

UPDATE EMPLOYEE
SET Salary = Salary * 1.1
WHERE Ssn IN (
    SELECT Essn
    FROM DEPENDENT
    WHERE YEAR(GETDATE()) - YEAR(Bdate) < 18
)