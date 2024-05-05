CREATE TABLE DEP ( 
	MaK int not null,
	Tais varchar(100) not null,
	PRIMARY KEY (MaK)
); 

CREATE TABLE Student ( 
	StudentID int NOT NULL,
	Name varchar(100) not null,
	YOB int,
	Mak int,
	PRIMARY KEY (StudentID),
	FOREIGN KEY (MaK) REFERENCES DEP (MaK)
);

CREATE TABLE Subject ( 
	MaMon INT not null,
	TenMon varchar(100) not null,
	Stc int,
	PRIMARY KEY (MaMon)
);

CREATE TABLE StudentSubject (
	StudentID int NOT NULL,
    MaMon int NOT NULL,
    CONSTRAINT PK_StudentSubject PRIMARY KEY
    (
        StudentID,
        MaMon
    ),
    FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
    FOREIGN KEY (MaMon) REFERENCES Subject (MaMon)
);

DROP TABLE StudentSubject;
DROP TABLE Subject;
DROP TABLE DEP;
DROP TABLE Student

CREATE DATABASE StudentDB