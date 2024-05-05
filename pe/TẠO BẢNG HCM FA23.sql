CREATE TABLE Departments(
	DepartmentID INT IDENTITY (1,1) PRIMARY KEY,
	DepartmentName VARCHAR(100)
);

CREATE TABLE Employees(
	EmployeeID INT IDENTITY (1,1) PRIMARY KEY,
	FirstName VARCHAR(50),
	Salary MONEY,
	LastNAME VARCHAR(50),
	Gender Bit,
	Address VARCHAR(500),
	ManagerDepartmentID INT,
	HasDepartmentID INT,
	FOREIGN KEY (ManagerDepartmentID) REFERENCES Departments(DepartmentID),
	FOREIGN KEY (HasDepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
	ProjectID INT IDENTITY (1,1) PRIMARY KEY,
	ProjectName VARCHAR(100),
	Place VARCHAR(200),
	ControlDepartmentID INT,
	FOREIGN KEY (ControlDepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Hobby(
	Hobby VARCHAR(50),
	EmployeeID INT,
	PRIMARY KEY (Hobby, EmployeeID),
	FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE WORK(
	EmployeeID INT,
	ProjectID INT,
	Hours INT,
	PRIMARY KEY (EmployeeID, ProjectID),
	FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
	FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);