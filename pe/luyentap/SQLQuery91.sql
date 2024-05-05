-- Tạo trigger kiểm tra ngày mua khi thêm bản ghi thuê
CREATE TRIGGER rental_ins_trig
ON Rentals
AFTER INSERT
AS
BEGIN
    -- Kiểm tra ngày mua của xe trong bản ghi
    DECLARE @CarPurchaseDate date;
    DECLARE @CurrentDate date;
    SET @CurrentDate = GETDATE(); -- Lấy ngày hiện tại
    
    SELECT @CarPurchaseDate = c.Purchase_Date
    FROM inserted i
    JOIN Cars c ON i.CarID = c.ID;

    -- Kiểm tra nếu ngày mua nằm ngoài khoảng 6 tháng gần đây
    IF DATEDIFF(month, @CarPurchaseDate, @CurrentDate) > 6
    BEGIN
        -- Ngăn chặn thêm bản ghi
        ROLLBACK;
        
        -- In ra thông báo lỗi
        PRINT 'Không thể thêm bản ghi thuê vì ngày mua nằm ngoài khoảng 6 tháng gần đây.';
    END
END;

INSERT INTO Rentals (Customer_ID, CarID, Pick_up_date)
VALUES (2, 2, '2022-09-01');