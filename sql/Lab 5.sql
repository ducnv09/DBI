/*
a.	Get name, and class of ship that after launched year that was input by a user.
b.	Search all information of ship(s) where the name is input by a user.
c.	Return an output, which is the total number of ships that were built by the United States.
d.	Add a ship to table R, where all the information is input from the user.
e.	Update Displacement and numguns information of a ship in table S, where the information is input from the user.
f.	Create a trigger that prints all the information of the deleted ship by shipname.
g.	Create a trigger that returns the total number of ship after insertion.

*/

CREATE TRIGGER trig_Insert_Ship
ON R 
AFTER INSERT
AS
BEGIN
	DECLARE @TotalShip INT
	SELECT @TotalShip = COUNT(*) FROM R

	PRINT 'Total number of ship: ' + CAST(@TotalShip AS VARCHAR(10))
END

INSERT INTO R
VALUES('Titanic', 'Iowa', 1922)

DROP TRIGGER trig_Insert_Ship

SELECT * FROM R
SELECT * FROM S

CREATE TRIGGER trig_Delete_Ship
ON R 
AFTER DELETE
AS
BEGIN
	SELECT * FROM deleted
END

DROP TRIGGER trig_Delete_Ship

DELETE FROM R
WHERE name = 'Titanic'
