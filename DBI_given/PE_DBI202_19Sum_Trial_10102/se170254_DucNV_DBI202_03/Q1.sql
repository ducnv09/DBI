CREATE TABLE Students(
	StudentID INT PRIMARY KEY,
	Name NVARCHAR(50),
	Address NVARCHAR(200),
	Gender CHAR(1)
);

CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY,
	Name NVARCHAR(50),
	Address NVARCHAR(200),
	Gender CHAR(1)
);

CREATE TABLE Classes(
	ClassID INT PRIMARY KEY,
	GroupID CHAR(6),
	courseID CHAR(6),
	NoCredits INT,
	Semester CHAR(10),
	[year] INT,
	TeacherID INT,
	FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

CREATE TABLE Attend(
	StudentID INT,
	ClassID INT,
	[Date] DATE,
	Slot INT,
	Attend BIT,
	PRIMARY KEY (StudentID, ClassID, [Date]),
	FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);