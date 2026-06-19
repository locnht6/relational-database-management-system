USE Northwind -- Chọn để chơi với thùng chứa data nào đó.
			  -- Tại 1 thời điểm chơi với 1 thùng chứa data.

SELECT * FROM Customers

SELECT * FROM Employees

--------------------------------------------------------------
-- LÍ THUYẾT
-- 1. DB Engine cung cấp câu lệnh SELECT dùng để:
-- In ra màn hình 1 cái gì đó ~~~ sout() - Java.
-- In ra dữ liệu có trong table (hàng/cột).
-- Dùng cho mục đích nào thì kết quả hiển thị luôn là 1 table.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. Hôm nay là ngày bao nhiêu?
SELECT GETDATE()

SELECT GETDATE() AS [Hôm nay là ngày]

-- 2. Bây giờ tháng mấy hỡi em?
SELECT MONTH(GETDATE()) AS [Bây giờ tháng mấy?]

SELECT YEAR(GETDATE())

-- 3. Trị tuyệt đối của -5 là mấy?
SELECT ABS(-5) AS [Trị tuyệt đối của -5 là]

-- 4. 5 + 5 là mấy?
SELECT 5 + 5 AS [5 + 5 =]

-- 5. In ra tên của mình
SELECT N'Ngô Huỳnh Tấn Lộc' AS [My name is]
SELECT N'Ngô Huỳnh Tấn ' + N'Lộc' AS [My name is]

-- 6. Tính tuổi
SELECT YEAR(GETDATE()) - 2003 AS [My age is]

SELECT N'Ngô Huỳnh Tấn Lộc is ' + CONVERT(nvarchar, (YEAR(GETDATE()) - 2003)) + ' years old.' AS [My profile]

SELECT N'Ngô Huỳnh Tấn Lộc is ' + CAST(YEAR(GETDATE()) - 2003 AS nvarchar) + ' years old.' AS [My profile]

-- 7. Phép nhân 2 số
SELECT 10 * 10 AS [10 x 10 =]