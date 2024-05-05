-- Tạo trigger kiểm tra khi thêm bản ghi xe hơi
CREATE TRIGGER car_ins_trig
ON Cars
AFTER INSERT
AS
BEGIN
    -- Hiển thị thông tin chi tiết về xe hơi và tên loại xe
    SELECT
        c.ID AS Car_ID,
        c.Description AS Car_Description,
        c.Model AS Car_Model,
        c.Brand AS Car_Brand,
        cat.Label AS Category_Label
    FROM inserted i
    JOIN Cars c ON i.ID = c.ID
    JOIN Category cat ON c.Category_ID = cat.ID;
END;
