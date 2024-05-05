CREATE TABLE Sailors(
	Sid int,
	Sname varchar(50), 
	Rating int,
	Age int
);

CREATE TABLE Reserves(
	Sid int,
	Bid int,
	Day Date
);

CREATE TABLE Boats(
	Bid int,
	Bname varchar(50), 
	Color varchar(50)
);

INSERT INTO Sailors
VALUES
(22, 'Dustin', 7, 45.0),
(29, 'Brutus', 1, 33.0),
(31, 'Lubber', 8, 55.5),
(32, 'Andy', 8, 25.5),
(58, 'Rusty', 10, 35.0),
(64, 'Horatio', 7, 35.0),
(71, 'Zorba', 10, 16.0),
(74, 'Horatio', 9, 35.0),
(85, 'Art', 3, 25.5),
(95, 'Bob', 3, 63.5)
GO
INSERT INTO Boats
VALUES
(101, 'Interlake', 'Blue'),
(102, 'Interlake', 'Red'),
(103, 'Clipper' , 'Green'),
(104, 'Marine' , 'Red');
GO
INSERT INTO Reserves
VALUES (22,101,'10-10-08'),
(22,102,'10-10-08'),
(22,103,'10-08-08'),
(22,104,'10-07-08'),
(31,102,'11-10-08'),
(31,103,'11-06-08'),
(31,104,'11-12-08'),
(64,101,'9-05-08'),
(64,102,'9-08-08'),
(74,103,'9-08-08')