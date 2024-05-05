CREATE TABLE Students (
   ID int PRIMARY KEY,
   Name varchar(50),
   Age int  
);

-- Tạo AFTER Trigger để kiểm tra tuổi học sinh phải >=18 khi INSERT
/*CREATE TRIGGER trg_CheckAge 
ON Students
AFTER INSERT
AS 
BEGIN
  DECLARE @Age int
  SELECT @Age = Age FROM inserted

  IF (@Age < 18)
  BEGIN
     PRINT 'Tuổi học sinh phải >= 18' 
	 ROLLBACK TRANSACTION
  END
END
*/

CREATE TRIGGER trg_Testing
ON Students
AFTER INSERT
AS
BEGIN
	SELECT * FROM inserted
END

INSERT INTO Students
VALUES(4, 'A', 14)
-- SAU KHI CHẠY XONG LỆNH NÀY 
-- THÌ CHẠY LUÔN LỆNH Ở TRONG BEGIN - END

SELECT * FROM Students
 
--
CREATE TRIGGER trg_Testing_Delete
ON Students
AFTER DELETE
AS
BEGIN
	SELECT * FROM deleted
END

DELETE FROM Students
WHERE ID  = 6

DELETE FROM Students
WHERE ID  = 2 OR ID = 4

-- 
CREATE TRIGGER trg_CheckAge
ON Students
AFTER INSERT
AS
BEGIN
	DECLARE @Age INT 
	SELECT @Age = Age FROM inserted

	IF (@Age < 18)
	BEGIN 
		PRINT 'Tuổi học sinh phải >= 18'
		ROLLBACK TRANSACTION
	END
END

INSERT INTO Students
VALUES(5, 'A', 13) -- -> LỖI

INSERT INTO Students
VALUES(6, 'A', 18)

SELECT * FROM Students

/* 1.
Viết trigger để kiểm tra ngày bắt đầu hợp đồng 
(StartDate) phải nhỏ hơn ngày kết thúc hợp đồng 
(EndDate). Nếu sai thì hiển thị thông báo lỗi.
*/

CREATE DATABASE trigger_exercise1
GO


USE trigger_exercise1
GO


CREATE TABLE Contracts 
(
    ID int PRIMARY KEY,
    StartDate datetime,
    EndDate datetime
)
GO

CREATE TRIGGER trig_CheckDate
ON Contracts
AFTER UPDATE, INSERT
AS
BEGIN
	-- DECLARE @start_Date,
	-- DECLARE @end_Date

	IF EXISTS(SELECT * FROM inserted
			  WHERE StartDate > EndDate
	)
	BEGIN
		PRINT N'NGÀY BẮT ĐẦU PHẢI TRƯỚC NGÀY KẾT THÚC'
		ROLLBACK TRANSACTION
	END
END

INSERT Contracts
VALUES(1, '2000/01/01', '1999/01/01')

INSERT Contracts
VALUES(1, '2000/01/01', '2003/01/01')

SELECT * FROM Contracts

