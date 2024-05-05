-- 1.	Write trigger to select all the information of Sailor when a new row of was inserted to Reserves.
-- CHÈN VÀO BẢNG BOATS TÌM TÊN CỦA THÙY THỦ
CREATE TRIGGER Insert_trigger ON Reserves
FOR INSERT
AS
BEGIN
	SELECT * FROM Sailors, inserted
	WHERE Sailors.Sid = inserted.Sid;
END

INSERT INTO Reserves
VALUES (31,107,'2008-11-12')

GO

-- 2.	Write trigger when you delete a boat from Boats all the record of that boat will be inserted into a new table call backup.


CREATE TABLE [Backup](
	[Sid] int,
	Bid int,
	Bname varchar(50), 
	Color varchar(50),
	[Day] date
);

DROP TABLE 
GO

CREATE TRIGGER dele_tg ON Boats
AFTER DELETE
AS
BEGIN
	INSERT INTO [Backup]
	SELECT Reserves.Sid, deleted.Bid, deleted.Bname, deleted.color, Reserves.Day 
	FROM deleted, Reserves
	WHERE Reserves.Bid = deleted.Bid
	SELECT * FROM [Backup]
END

DELETE FROM Boats WHERE Boats.Bid = 102

