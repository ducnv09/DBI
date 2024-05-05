-- q1
/*
CREATE DATABASE Q1;
DROP DATABASE Q1;
USE Q1;

CREATE TABLE Promotions(
	PromoCode VARCHAR(30) PRIMARY KEY,
	Description NVARCHAR(200),
	[Percent] FLOAT
);

CREATE TABLE Products (
	ProductNo VARCHAR(20) PRIMARY KEY,
	Name NVARCHAR(100),
	Description NVARCHAR(255),
	Category NVARCHAR(100)
);

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
	Time DATETIME
);

CREATE TABLE include(
	ProductNo VARCHAR(20),
	OrderID INT,
	PromoCode VARCHAR(30),
	quantity INT,
	UntiPrice FLOAT,
	PRIMARY KEY (ProductNo, OrderID, PromoCode),
	FOREIGN KEY (ProductNo) REFERENCES Products(ProductNo),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (PromoCode) REFERENCES Promotions(PromoCode),
);
*/

-- Q2
SELECT * 
FROM Courses AS C
WHERE C.credits > 3

-- Q3
SELECT * FROM Assessments
SELECT * FROM Courses
SELECT * FROM Departments


SELECT A.id AS AssessmentId, A.type, A.name, A.[percent], C.title AS CourseTitle 
FROM Assessments AS A
	 JOIN Courses AS C ON A.courseId = C.id
WHERE C.title = 'Introduction to Databases'

-- Q4
SELECT * FROM Assessments
SELECT * FROM Courses
SELECT * FROM Departments
SELECT * FROM enroll
SELECT * FROM marks
SELECT * FROM semesters
SELECT * FROM Students

SELECT ST.id AS studentId, ST.name AS StudentName, ST.department, 
	   SM.code AS SemesterCode, SM.[year], C.title AS CourseTitle
FROM Students AS ST
	 JOIN enroll AS E ON ST.id = E.studentId
	 JOIN semesters AS SM ON E.semesterId = SM.ID
	 JOIN Courses AS C ON E.courseId = C.id
WHERE C.title = 'Operating Systems'
ORDER BY SM.[year] ASC, SM.code ASC, ST.id ASC

-- Q5
SELECT * FROM Assessments
SELECT * FROM Courses
SELECT * FROM Departments
SELECT * FROM enroll
SELECT * FROM marks
SELECT * FROM semesters
SELECT * FROM Students

SELECT C.id AS CourseId, C.code, C.title, COUNT(DISTINCT CASE WHEN SM.year = 2019 THEN E.StudentID END) AS NumberOfEnrolledStudents
FROM Courses AS C
	 JOIN enroll AS E ON E.courseId = C.id
	 JOIN semesters AS SM ON E.semesterId = SM.ID
GROUP BY C.id, C.code, C.title

--Q6
SELECT C.id AS courseId, C.code, C.title, COUNT(DISTINCT A.type) AS NumberOfAssessmentTypes,
	   COUNT(A.id) AS NumberOfAssessmentTypes
FROM Courses AS C
	 JOIN Assessments AS A ON C.id = A.courseId
GROUP BY C.id, C.code, C.title
HAVING COUNT(A.id) = (
	SELECT MAX(T.NUM) 
	FROM (
		SELECT COUNT(A.id) AS NUM
		FROM Courses AS C
			JOIN Assessments AS A ON C.id = A.courseId
		GROUP BY C.id
	) T
)

-- Q7
SELECT * FROM Assessments
SELECT * FROM Courses
SELECT * FROM Departments
SELECT * FROM enroll
SELECT * FROM marks
SELECT * FROM semesters
SELECT * FROM Students

SELECT E.enrollId, C.id AS CourseId, C.title, E.studentId,
	   ST.name AS StudentName, E.semesterId, SM.code AS SemesterCode,
	   ROUND(SUM(DISTINCT M.mark * A.[percent]) / SUM(A.[percent]), 3) AS AverageMark
FROM enroll AS E
	 JOIN marks AS M ON	E.enrollId = M.enrollId
	 JOIN Students AS ST ON	E.studentId = ST.id
	 JOIN semesters AS SM ON E.semesterId = SM.id
	 JOIN Courses AS C ON E.courseId = C.id
	 JOIN Assessments AS A ON M.assessmentId = A.id
WHERE C.title = 'Introduction to Databases'
GROUP BY E.enrollId, C.id, C.title, E.studentId,
	   ST.name, E.semesterId, SM.code
ORDER BY E.studentId ASC, E.semesterId DESC

-- Q8
SELECT * FROM Assessments
SELECT * FROM Courses
SELECT * FROM Departments
SELECT * FROM enroll
SELECT * FROM marks
SELECT * FROM semesters
SELECT * FROM Students

CREATE PROC P2 @studentId INT,
			   @semesterCode VARCHAR(20),
			   @numberOfCourses INT OUTPUT
AS
BEGIN
	SELECT @numberOfCourses = COUNT(ST.id)
	FROM enroll AS E
		 JOIN Students AS ST ON	E.studentId = ST.id
		 JOIN semesters AS SM ON E.semesterId = SM.id
	WHERE SM.code = @semesterCode AND ST.id = @studentId
	GROUP BY ST.id
END

DECLARE @x INT
EXEC P2 9, 'Sp2019', @x OUTPUT
SELECT @x AS NumberOfCourses

-- Q9
SELECT * FROM Assessments
SELECT * FROM Courses
SELECT * FROM Departments
SELECT * FROM enroll
SELECT * FROM marks
SELECT * FROM semesters
SELECT * FROM Students

CREATE TRIGGER Tr1
ON enroll
AFTER INSERT
AS
BEGIN

	INSERT INTO marks(enrollId, assessmentId, mark)
	SELECT I.enrollId, A.id AS assessmentId, 0
	FROM inserted AS I
		 JOIN Assessments AS A ON I.courseId = A.courseId
	
	DECLARE @enrollId INT
	SELECT @enrollId = enrollId FROM inserted

	SELECT *
	FROM marks AS M
	WHERE M.enrollId = @enrollId
END

DROP TRIGGER Tr1

INSERT INTO enroll(enrollId, studentId, courseId, semesterId)
VALUES(600, 9, 11, 4)

DELETE FROM enroll 
WHERE enrollId = 600

DELETE FROM marks 
WHERE enrollId = 600

SELECT *
FROM enroll AS E
	 JOIN Students AS ST ON	E.studentId = ST.id
	 JOIN Courses AS C ON E.courseId = C.id
	 JOIN Assessments AS A ON E.courseId = A.courseId
WHERE C.id = 11 AND ST.id = 9

--Q10
/*
Write a query to insert a student with id = 110, name = 'Mary Jane',
birthdate on 12 May 2001, gender = 'Female' into the department named
'Business Administration'. Note that you must use a subquery to find 
the code of the department named 'Business Administration' to
be inserted in your query.
*/

SELECT * FROM Assessments
SELECT * FROM Courses
SELECT * FROM Departments
SELECT * FROM enroll
SELECT * FROM marks
SELECT * FROM semesters
SELECT * FROM Students

DECLARE @departmentCode VARCHAR(50)
SELECT @departmentCode = D.Code
FROM Departments AS D
WHERE D.Name = 'Business Administration'

INSERT INTO Students(id, name, birthdate, gender, department)
VALUES(110, 'Mary Jane', '2001-05-12', 'Female', @departmentCode)

