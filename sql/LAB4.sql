SELECT * FROM tblDepartment
SELECT * FROM tblDependent
SELECT * FROM tblEmployee
SELECT * FROM tblDepLocation

SELECT * FROM tblLocation
SELECT * FROM tblProject
SELECT * FROM tblWorksOn



SELECT E.empSSN, E.empName, SUM(W.workHours) AS [Hour]
FROM tblEmployee AS E
	JOIN tblWorksOn AS W ON W.empSSN = E.empSSN
WHERE E.supervisorSSN = (
	SELECT E.empSSN
	FROM tblEmployee AS E
	WHERE E.empName = N'Mai Duy An'
)
GROUP BY E.empSSN, E.empName

SELECT tblEmployee.empSSN, tblEmployee.empName, SUM (tblWorksOn.workHours) AS HoursSum
FROM tblEmployee
JOIN tblWorksOn ON tblWorksOn.empSSN = tblEmployee.empSSN
WHERE tblEmployee.supervisorSSN = (
	SELECT tblEmployee.empSSN FROM tblEmployee
	WHERE tblEmployee.empName = 'Mai Duy An'
)
GROUP BY tblEmployee.empSSN, tblEmployee.empName
