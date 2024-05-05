CREATE TABLE STARS (
	Name VARCHAR(100)
	Address VARCHAR(100)
	Phone VARCHAR(100)
);

CREATE TABLE MOVIES (
	Title varchar(100)
	year YEAR
	length int
	genre BOOLEAN
);

DROP TABLE STARS
DROP TABLE MOVIES

-- write sql queries to do following tasks:
Add a named DESCRIPTION into MOVIES table (you must determine the data typy for it)
ALTER TABLE MOVIES
ADD DESCRIPTION TEXT

Add a column named HOBBIES into STARS table (you must determine the data typy for it)
ALTER TABLE STARS
ADD HOBBIES varchar(100)

Add a column named BIRTHDAY into STARS table (you must determine the data typy for it)
ALTER TABLE STARS
ADD BIRTHDAY DATE

-- Write sql queries to do following tasks:
Remove the column named DESCRIPTION from MOVIES table 
ALTER TABLE MOVIES
DROP COLUMN DESCRIPTION

Remove the column named HOBBIES from STARS table 
ALTER TABLE STARS
DROP COLUMN HOBBIES

Remove the column named BIRTHDAY from STARS table 
ALTER TABLE STARS
DROP COLUMN BIRTHDAY

-- write a sql query to show all tuples in table EMPLOYEES
SELECT * FROM EMPLOYEES

-- write a sql query to show all SALARY (but eliminating duplications) in table EMPLOYEES
SELECT DISTINCT SALARY 
FROM EMPLOYEES

-- Write a SQL query to show all DEPARTMENT_ID (but eliminating duplications) in table EMPLYEES
SELECT DISTINCT DEPARTMENT_ID 
FROM EMPLOYEES

-- Write a SQL query to delete all tuples in EMPLOYEES table
TRUNCATE TABLE EMPLOYEES

--Write a SQL query to delete all tuples with NULL value in DEPARTMENT_ID 
DELETE FROM EMPLOYEES 
WHERE DEPARTMENT_ID == NULL

-- Write a SQL query to set DEPARTMENT_ID to the value 10
UPDATE EMPLOYEES
SET DEPARTMENT_ID = 10



-- Write a SQL query to set DEPARTMENT_ID to the value 10 if DEPARTMENT_ID is NULL
UPDATE EMPLOYEES
SET DEPARTMENT_ID = 10
WHERE DEPARTMENT_ID == NULL

-- Write a SQL query to insert some new tuples into EMPLOYEES 
INSERT INTO EMPLOYEES (LAST_NAME, SALARY)
VALUES ('DUC NGUYEN', 10000)

INSERT INTO EMPLOYEES (LAST_NAME, DEPARTMENT_ID, SALARY)
VALUES ('DUC NGUYEN', 101, 10000)
