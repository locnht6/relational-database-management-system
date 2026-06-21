USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Khi cần lọc dữ liệu trong 1 đoạn cho trước, thay vì dùng >= ... AND <= ...,
-- ta có thể thay thế bằng mệnh đề BETWEEN, IN.
-- Cú pháp: CỘT BETWEEN VALUE-1 AND VALUE-2
--			BETWEEN thay thế cho 2 mệnh đề >= AND <=

-- Cú pháp: CỘT IN (Một tập các giá trị được liệt kê cách nhau dấu phẩy)
--			IN thay thế cho 1 loạt OR
-- Lưu ý IN: chỉ khi ta liệt kê được tập giá trị thì mới chơi IN,
-- khoảng số thực thì không làm được.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. Liệt kê danh sách nhân viên sinh trong năm 1960...1970.
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970 ORDER BY BirthDate DESC -- 4 rows

SELECT * FROM Employees WHERE YEAR(BirthDate) BETWEEN 1960 AND 1970 ORDER BY BirthDate DESC -- 4 rows

-- 2. Liệt kê các đơn hàng có trọng lượng từ 100 ... 500.
SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 500 ORDER BY Freight DESC -- 174 rows

-- 3. Liệt kê các đơn hàng gửi tới Anh, Pháp, Mĩ.
SELECT * FROM Orders WHERE ShipCountry = 'UK' OR ShipCountry = 'France' OR ShipCountry = 'USA' ORDER BY ShipCountry -- 255 rows

SELECT * FROM Orders WHERE ShipCountry IN ('UK', 'France', 'USA') ORDER BY ShipCountry -- 255 rows

-- 4. Liệt kê đơn hàng không gửi tới Anh, Pháp, Mĩ.
SELECT * FROM Orders WHERE NOT(ShipCountry = 'UK' OR ShipCountry = 'France' OR ShipCountry = 'USA') ORDER BY ShipCountry -- 575 rows

SELECT * FROM Orders WHERE ShipCountry NOT IN ('USA', 'France', 'UK') ORDER BY ShipCountry --  575 rows

-- 5. Liệt kê các đơn hàng trong năm từ 1996 ngoại trừ các tháng 6 7 8 9.
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) NOT IN (6, 7, 8, 9) ORDER BY OrderDate -- 82 rows

-- 6. Liệt kê các đơn hàng có trọng lượng từ 100...110.
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 110 ORDER BY Freight DESC -- 14 rows
SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 110 ORDER BY Freight DESC -- 14 rows
-- SELECT * FROM Orders WHERE Freight IN () -- 100 ... 110 vô số giá trị thực.