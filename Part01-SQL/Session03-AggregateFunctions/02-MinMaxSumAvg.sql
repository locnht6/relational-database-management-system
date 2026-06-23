USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- CÚ PHÁP CHUẨN
-- SELECT CỘT, HÀM GOM NHÓM(), ... FROM <TÊN-TABLE> WHERE ... GROUP BY ... HAVING (WHERE THỨ 2)
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. Liệt kê danh sách nhân viên.
SELECT * FROM Employees

-- 2. Năm sinh nào là bé nhất.
SELECT MIN(BirthDate) FROM Employees
SELECT MAX(BirthDate) FROM Employees

-- 3. Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info
SELECT * FROM Employees WHERE BirthDate = (SELECT MIN(BirthDate) FROM Employees)
SELECT * FROM Employees WHERE BirthDate <= ALL (SELECT BirthDate FROM Employees)

-- 4.1. Trọng lượng nào là lớn nhất trong các đơn hàng đã bán.
SELECT * FROM Orders ORDER BY Freight DESC

SELECT MAX(Freight) FROM Orders

-- 4.2. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhât.
SELECT * FROM Orders WHERE Freight = (SELECT MAX(Freight) FROM Orders)

-- 5. Tính tổng khối lượng của các đơn hàng đã vận chuyển.
SELECT * FROM Orders -- 830 rows
SELECT SUM(Freight) AS [Freight in total] FROM Orders

-- 6. Trung bình các đơn hàng nặng bao nhiêu?
SELECT AVG(Freight) AS [Freight in average] FROM Orders -- 78.2442

-- 7. Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT * FROM Orders WHERE Freight >= (SELECT AVG(Freight) FROM Orders) ORDER BY Freight DESC -- 242 rows

-- 8. Có bao nhiêu đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả.
SELECT COUNT(*) AS [No orders] FROM (SELECT * FROM Orders WHERE Freight >= (SELECT AVG(Freight) FROM Orders)) AS [AVG] -- 242

SELECT COUNT(*) AS [No orders] FROM Orders WHERE Freight >= (SELECT AVG(Freight) FROM Orders) -- 242