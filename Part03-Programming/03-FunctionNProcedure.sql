-- HÀM: 1 NHÓM CÂU LỆNH ĐẶT 1 TÊN, NHÓM LỆNH NÀY LÀM 1 VIỆC GÌ ĐÓ. HÀM DÙNG ĐỂ RE-USE.
-- HÀM CĂN BẬC 2, LẤY CĂN.

-- TRONG LẬP TRÌNH CÓ 2 LOẠI HÀM:
-- HÀM VOID: KHÔNG TRẢ VỀ 1 GIÁ TRỊ NÀO CẢ.
-- HÀM CÓ TRẢ VỀ 1 GIÁ TRỊ (CHỈ 1): LỆNH RETURN.

-- RDBMS (CSDL DỰA TRÊN RELATION/TABLE) TA CÓ 2 LOẠI HÀM Y CHANG:
-- STORED PROCEDURE ~~~ VOID.
-- FUNCTION ~~~ RETURN.

-- VIẾT HÀM IN RA CÂU CHÀO!
-- CREATE PROCEDURE PR_Hello() {...code...}

CREATE DATABASE DBPROGRAMMING
USE DBPROGRAMMING

GO

CREATE PROCEDURE PR_Hello_1 AS
	PRINT N'Xin chào - Welcome to my own first procedure!'

GO

-- DÙNG PROCEDURE - LÀ HÀM VOID, GỌI TÊN EM LÀ ĐỦ.
GO

PR_Hello_1
dbo.PR_Hello_1

EXECUTE PR_Hello_1 -- TÔI MUỐN THỰC THI, CHẠY THỦ TỤC/NHÓM LỆNH ĐÃ ĐẶT TÊN
EXEC PR_Hello_1

GO

CREATE PROC PR_Hello AS
	PRINT N'Xin chào - Welcome to my own 2nd procedure!'

EXEC PR_Hello

---------------------------------------------------------------------------------------------------
-- HÀM, PHẢI TRẢ VỀ GIÁ TRỊ! QUA LỆNH RETURN.
GO

DROP FUNCTION FN_Hello

CREATE FUNCTION FN_Hello() RETURNS nvarchar(100) AS
	BEGIN
		RETURN N'Xin chào - Welcome to my own first function!'
	END

GO

-- LƯU Ý - Y CHANG BÊN LẬP TRÌNH, HÀM TRẢ VỀ GIÁ TRỊ THÌ ĐƯỢC QUYỀN DÙNG TRONG CÁC CÂU LỆNH KHÁC.
--       - GỌI HÀM MÀ KHÔNG KÈM THÊM GÌ KHÁC, ĐỪNG HỎI TẠI SAO MÀN HÌNH KHÔNG THẤY GÌ!
--		   NHIỆM VỤ HÀM LÀ TRẢ VỀ GIÁ TRỊ, IN KHÔNG LÀ VIỆC CỦA HÀM, VIỆC KHÁC CŨNG THẾ,
--		   IN XEM HÀM XỬ LÍ RA SAO, THÌ PHẢI KÈM LỆNH IN VÀ LỆNH GỌI HÀM.
--		   sqrt(4);				-> không kết quả khi chạy
--		   Math.sqrt(4)			-> không kết quả khi chạy
--		   sout(Math.sqrt(4))	-> có kết quả khi chạy

SELECT dbo.FN_Hello()
SELECT FN_Hello() -- bắt buộc phải có dbo.tên-hàm
SELECT GETDATE() -- HÀM DÙNG XỬ LÍ TRẢ VỀ KẾT QUẢ, PHẢI DÙNG KẾT QUẢ TRONG LỆNH NÀO ĐÓ

GETDATE() -- báo lỗi, phải ghép vào lệnh khác

PRINT dbo.FN_Hello()

---------------------------------------------------------------------------------------------------
-- VIẾT HÀM - PROCEDURE ĐỔI TỪ ĐỘ C SANG ĐỘ F, F = C * 1.8 + 32
-- THAM SỐ/ĐẦU VÀO/ARGUMENT
GO

CREATE PROC PR_C2F
@cDegree float
AS
BEGIN
	DECLARE @fDegree float = @cDegree * 1.8 + 32
	PRINT @fDegree
END

GO

-- Xài, vì có tham số, cần truyền vào
EXEC PR_C2F @CDegree = 37
EXEC PR_C2F 37

---------------------------------------------------------------------------------------------------
GO

CREATE FUNCTION FN_C2F(@cDegree float)
RETURNS float
AS
BEGIN
	DECLARE @fDegree float = @cDegree * 1.8 + 32
	RETURN @fDegree
END

GO

-- Sử dụng hàm, hàm là phải viết kèm với lệnh khác.
PRINT dbo.FN_C2F(37)
PRINT N'37 độ C là ' + CONVERT(nvarchar, dbo.FN_C2F(37)) + N' độ F'
PRINT N'37 độ C là ' + CAST(dbo.FN_C2F(37) AS nvarchar) + N' độ F'

-- PROCEDURE LÀM ĐƯỢC NHIỀU VIỆC KHÁC:
-- VIẾT 1 PROCEDURE IN RA DANH SÁCH CÁC NHÂN VIÊN QUÊ Ở ĐÂU ĐÓ, ĐÂU ĐÓ ĐƯA VÀO PROCEDURE.
-- VIEW: IN RA AI Ở LONDON.
-- VIEW: IN RA AI Ở KIRDLAND, ....
-- MỖI VIEW LÀ 1 SELECT VÀ LÀ 1 TABLE ĐỂ RE-USE.
-- PROCEDURE IN RA KẾT QUẢ NHƯ VIEW, KHÔNG RE-USE LẠI (CHỈ IN RA) NHƯNG LẠI NHẬN ĐƯỢC THAM SỐ.

USE Northwind

GO

CREATE PROC PR_EmployeeListByCity
@city nvarchar(30)
AS
	SELECT * FROM Employees WHERE City = @city

GO

SELECT * FROM Employees WHERE City = 'Redmond'

EXEC PR_EmployeeListByCity @city = 'Redmond'

EXEC PR_EmployeeListByCity 'Seattle'

EXEC PR_EmployeeListByCity 'London'

-- ỨNG DỤNG THÊM CỦA PROCEDURE, VIẾT PROC INSERT DATA.

USE DBPROGRAMMING

CREATE TABLE [Event]
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(30) NOT NULL
)

INSERT INTO [Event] VALUES (N'Lời nói dối chân thật')

SELECT * FROM Event

GO

CREATE PROC PR_InsertEvent
@name nvarchar(30)
AS
	INSERT INTO [Event] VALUES (@name)

GO

-- CHÈN CÁC DÒNG VÀO TABLE
EXEC PR_InsertEvent @name = N'Bí quyết dùng source ở FE'
EXEC PR_InsertEvent @name = N'Hồ Sen chờ ai'