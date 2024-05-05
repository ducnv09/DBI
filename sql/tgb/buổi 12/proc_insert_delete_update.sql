CREATE DATABASE ExamProcedures
GO

USE ExamProcedures
GO

CREATE TABLE KhachHang (
  MaKH INT PRIMARY KEY,
  TenKH NVARCHAR(100), 
  DiaChi NVARCHAR(100),
  SoDT VARCHAR(20)
)
GO

CREATE TABLE DonDatHang (
  MaDDH INT PRIMARY KEY,
  MaKH INT FOREIGN KEY REFERENCES KhachHang(MaKH),
  NgayDat DATE
)


INSERT INTO KhachHang
VALUES(1, 'NGUYEN DINH TU', 'HN', '034141141')

SELECT * FROM KhachHang

-- 1.  Viết thủ tục thêm mới một khách hàng vào bảng KhachHang.

CREATE PROC proc_Insert_KH @MaKH INT,
						   @TenKH NVARCHAR(100) = NULL,
						   @DiaChi NVARCHAR(100) = NULL,
						   @SoDT VARCHAR(20) = NULL
AS
BEGIN
	INSERT INTO KhachHang
	VALUES(@MaKH, @TenKH, @DiaChi, @SoDT)
END

DROP PROC proc_Insert_KH

EXEC proc_Insert_KH @MaKH = 2, 
					@TenKH = 'A',
					@DiaChi = 'B',
					@SoDT = 'C'

EXEC proc_Insert_KH @MaKH = 3 -- LỖI VÌ KHÔNG KHỞI TẠO BAN ĐẦU LÀ NULL
SELECT * FROM KhachHang


CREATE PROC proc_Insert_DH @MaDDH INT,
						   @MaKH INT = NULL,
						   @NgayDat DATE = NULL
AS
BEGIN
	INSERT INTO DonDatHang
	VALUES(@MaDDH, @MaKH, @NgayDat)
END

EXEC proc_Insert_DH @MaDDH = 1

DROP PROC proc_Insert_DH

--
CREATE PROC proc_Insert_DH @MaDDH INT,
						   @MaKH INT,
						   @NgayDat DATE = NULL
AS
BEGIN
	INSERT INTO DonDatHang
	VALUES(@MaDDH, @MaKH, @NgayDat)
END

EXEC proc_Insert_DH @MaDDH = 2,
					@MaKH = 1

SELECT * FROM DonDatHang

-- 2. Viết thủ tục cập nhật địa chỉ của khách hàng dựa vào mã khách hàng.
CREATE PROC proc_Update_Address @address NVARCHAR(100),
								@MaKH INT
AS
BEGIN
	UPDATE KhachHang
	SET DiaChi = @address
	WHERE MaKH = @MaKH
END

EXEC proc_Update_Address @address = 'HA_NOI',
						 @MaKH = 2

SELECT * FROM KhachHang

CREATE PROC 
-- 3. Viết thủ tục xóa đơn đặt hàng dựa vào mã đơn đặt hàng.
CREATE PROC proc_Delete_DonDH @Ma_DDH INT
AS
BEGIN
	DELETE FROM DonDatHang 
	WHERE MaDDH = @Ma_DDH
END

EXEC proc_Delete_DonDH @Ma_DDH = 1
SELECT * FROM DonDatHang