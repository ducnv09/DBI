/*
--Q1
CREATE TABLE Departments(
	DepID VARCHAR(10) PRIMARY KEY,
	DepName NVARCHAR(40),
	DepDescription NVARCHAR(200)
);
GO
CREATE TABLE Lecturers(
	LecID VARCHAR(40) PRIMARY KEY,
	FirstName NVARCHAR(40),
	LastName NVARCHAR(40),
	DepID VARCHAR(10),
	FOREIGN KEY (DepID) REFERENCES Departments(DepID)
);

GO
CREATE TABLE Subjects(
	SubID VARCHAR(40) PRIMARY KEY,
	SubName NVARCHAR(40),
	SubDescription VARCHAR(40),
	NumberOfPerios INT
);
GO
CREATE TABLE Lecture(
	LecID VARCHAR(40),
	SubID VARCHAR(40),
	Semester NVARCHAR(40),
	SchoolYear NVARCHAR(40),
	PRIMARY KEY (LecID, SubID),
	FOREIGN KEY (LecID) REFERENCES Lecturers(LecID),
	FOREIGN KEY (SubID) REFERENCES Subjects(SubID)
);
*/

--Q2
SELECT D.location_id, D.department_id, D.department_name
FROM departments AS D
WHERE D.location_id > 2400

--Q3


SELECT L.location_id, L.country_id, L.street_address, L.city
FROM locations AS L
WHERE L.country_id = 'CA' OR L.country_id = 'US'
ORDER BY L.location_id DESC

--Q4


SELECT E.employee_id, (E.first_name + ', ' + E.last_name) AS full_name, J.job_title, E.phone_number 
FROM employees AS E
	 JOIN jobs AS J ON E.job_id = J.job_id
WHERE E.phone_number LIKE '590%'
ORDER BY E.phone_number ASC

--Q5
SELECT D.department_id, D.department_name, MIN(E.salary) AS "MIN(salary)"
FROM employees AS E
	 JOIN departments AS D ON E.department_id = D.department_id
GROUP BY D.department_id, D.department_name
ORDER BY MIN(E.salary) ASC

--Q6
SELECT TOP 10 E.first_name, E.last_name
FROM employees AS E
WHERE E.employee_id NOT IN (
	SELECT E.manager_id
	FROM employees AS E
	WHERE E.manager_id IS NOT NULL
)
ORDER BY E.last_name;

--Q7

SELECT C.country_id, C.country_name, COUNT(E.employee_id) AS "number of employees"
FROM employees AS E
	 JOIN departments AS D ON E.department_id = D.department_id
	 JOIN locations AS L ON D.location_id = L.location_id
	 JOIN countries AS C ON C.country_id = L.country_id
GROUP BY C.country_id, C.country_name
HAVING COUNT(E.employee_id) >= 2
ORDER BY COUNT(E.employee_id) DESC

-- Q8


CREATE TRIGGER Salary_Min_Max
ON employees
AFTER UPDATE
AS
BEGIN
	
	DECLARE @EmployeeID INT,
			@NewSalary DECIMAL(8, 2),
			@MinSalary DECIMAL(8, 2),
			@MaxSalary DECIMAL(8, 2)

	SELECT @EmployeeID = I.employee_id,
		   @NewSalary = I.salary
	FROM inserted AS I -- chọn dữ liệu khi truyền vào trigger

	SELECT @MinSalary = J.min_salary,
		   @MaxSalary = J.max_salary
	FROM employees AS E
		 JOIN jobs AS J ON E.job_id = J.job_id
	WHERE E.employee_id = @EmployeeID

	IF (@NewSalary < @MinSalary OR @NewSalary > @MaxSalary)
	BEGIN
		PRINT 'Salary update is outside the valid range for this job.'
		ROLLBACK TRANSACTION
		--RAISEERROR('Salary update is outside the valid range for this job.', 16, 1) --16 LÀ MỨC ĐỘ NGUY HIỂM, 1 LÀ GIÁ TRỊ CỦA LỖI
	END
END

UPDATE employees 
	   SET salary = 17000
	   WHERE employee_id = 102
SELECT * FROM employees 
WHERE employee_id = 102

--Q9
CREATE FUNCTION dbo.Get_ManagerID (
	@EmployeeID INT
)
RETURNS INT
AS
BEGIN
	DECLARE @ManagerID INT

	SELECT @ManagerID = manager_id
	FROM employees
	WHERE employee_id = @EmployeeID

	RETURN @ManagerID
END

DECLARE @id INT = 101;
SELECT @id AS EmployeeID, 
		dbo.Get_ManagerID(@id) AS ManagerID;

--Q10
-- Delete dependents of employees whose first_name is Alexander.
SELECT * FROM countries
SELECT * FROM departments
SELECT * FROM dependents
SELECT * FROM employees
SELECT * FROM jobs
SELECT * FROM locations
SELECT * FROM regions

DELETE FROM dependents
WHERE employee_id IN (
	SELECT employee_id
	FROM employees
	WHERE first_name = 'Alexander'
)