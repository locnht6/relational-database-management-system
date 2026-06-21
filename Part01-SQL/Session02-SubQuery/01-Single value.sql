USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Cú pháp chuẩn của lệnh SELECT
-- SELECT * FROM <TÊN-TABLE> WHERE ...

-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT LIKE PATTERN NÀO ĐÓ e.g. '_____'
-- WHERE CỘT BETWEEN RANGE
-- WHERE CỘT IN (TẬP HỢP GIÁ TRỊ ĐƯỢC LIỆT KÊ)

-- MỘT CÂU SELECT TÙY CÁCH VIẾT CÓ THỂ TRẢ VỀ ĐÚNG 1 VALUE/CELL
-- MỘT CÂU SELECT TÙY CÁCH VIẾT CÓ THỂ TRẢ VỀ ĐÚNG 1 TẬP GIÁ TRỊ/CELL,
-- TẬP KẾT QUẢ NÀY ĐỒNG NHẤT (CÁC GIÁ TRỊ KHÁC NHAU CỦA 1 BIẾN).

-- WHERE CỘT = VALUE NÀO ĐÓ e.g. YEAR(DOB) = 2003
--			 = THAY VALUE NÀY = 1 CÂU SQL KHÁC MIỄN TRẢ VỀ 1 CELL
-- KĨ THUẬT VIẾT CÂU SQL THEO KIỂU HỎI GIÁN TIẾP, LỒNG NHAU, TRONG CÂU SQL CHỨA CÂU SQL KHÁC.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. In ra danh sách nhân viên.
SELECT * FROM Employees
SELECT FirstName FROM Employees WHERE EmployeeID = 1 -- 1 cell/value
SELECT FirstName FROM Employees -- 1 tập giá trị/1 cột/phép chiếu

-- 2. Liệt kê các nhân viên ở London.
SELECT * FROM Employees WHERE City = 'London' -- 4 rows

-- 3. Liệt kê những nhân viên cùng quê với King Robert.
SELECT * FROM Employees WHERE FirstName = 'Robert'

SELECT City FROM Employees WHERE FirstName = 'Robert' -- 1 value là London

SELECT * FROM Employees WHERE City = (SELECT City FROM Employees WHERE FirstName = 'Robert') -- 4 rows
-- Câu này 9.9 điểm, trong kết quả còn Robert bị dư, tìm cùng quê Robert không cần nói lại Robert.

SELECT * FROM Employees WHERE City = (SELECT City FROM Employees WHERE FirstName = 'Robert') AND FirstName <> 'Robert' -- 3 rows

-- 4. Liệt kê các đơn hàng.
SELECT * FROM Orders ORDER BY Freight DESC

-- 4.1. Liệt kê tất cả các đơn hàng trọng lượng lớn hơn 252kg.
SELECT * FROM Orders WHERE Freight > 252 ORDER BY Freight DESC -- 47 rows

-- 4.2. Liệt kê tất cả các đơn hàng có trọng lượng lớn hơn trọng lượng đơn hàng 10555.
SELECT * FROM Orders WHERE Freight >= (SELECT Freight FROM Orders WHERE OrderID = 10555) ORDER BY Freight DESC -- 47 rows

SELECT * FROM Orders WHERE Freight >= (SELECT Freight FROM Orders WHERE OrderID = 10555) AND OrderID <> 10555 ORDER BY Freight DESC -- 46 rows

-- 5. Liệt kê danh sách các công ty vận chuyển hàng.
SELECT * FROM Shippers -- 4 rows

-- 6. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có mã số là 1.
SELECT * FROM Orders WHERE ShipVia = 1 -- 249 rows

-- 7. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có tên Speedy Express.
SELECT * FROM Orders WHERE ShipVia = (SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express') -- 249 rows

-- 8. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có tên Speedy Express và trọng lượng từ 50 - 100.
SELECT * FROM Orders WHERE ShipVia = (SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express') AND Freight BETWEEN 50 AND 100 ORDER BY Freight DESC -- 50 rows

-- 5. Liệt kê các mặt hàng cùng chủng loại với mặt hàng Filo Mix.
SELECT * FROM Products
SELECT * FROM Categories

SELECT * FROM Products WHERE CategoryID = (SELECT CategoryID FROM Products WHERE ProductName = 'Filo Mix') AND ProductName <> 'Filo Mix' -- 6 rows

-- 6. Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet.
SELECT * FROM Employees WHERE BirthDate >= (SELECT BirthDate FROM Employees WHERE FirstName = 'Janet') AND FirstName <> 'Janet' ORDER BY BirthDate DESC -- 1 row