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
(104, 'Marine' , 'Red'),
(105, 'Interlake', 'Blue'),
(106, 'Voyage', 'Yellow'),
(107, 'Sharpaer', 'Grey'),
(108, 'Marine', 'White');
GO
INSERT INTO Reserves
VALUES 
	(22, 101, '2008-10-10'),
    (22, 102, '2008-10-10'),
    (22, 103, '2008-10-08'),
    (22, 104, '2008-10-07'),
    (31, 102, '2008-11-10'),
    (31, 103, '2008-11-06'),
    (31, 104, '2008-11-12'),
    (64, 101, '2008-09-05'),
    (64, 102, '2008-09-08'),
    (74, 103, '2008-04-08'),
    (64, 108, '2008-01-06'),
    (22, 107, '2008-08-19'),
    (74, 106, '2008-04-09');

	-- YYYY-DD-MM