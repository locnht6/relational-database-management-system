USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Cú pháp chuẩn của lệnh SELECT
-- SELECT * FROM <TÊN-TABLE> WHERE ...

-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT LIKE PATTERN NÀO ĐÓ e.g. '_____'
-- Vd: City IN ('London', 'Berlin', 'New York') -- thay bằng OR OR OR
--												   City = 'London' OR City = 'Berlin' ...
-- Nếu có 1 câu SQL trả về được 1 cột, nhiều dòng,
-- 1 cột và nhiều dòng thì ta có thể xem nó tương đương một tập hợp.
-- SELECT City FROM Employees, bạn được 1 loạt các thành phố.
-- Ta có thể nhét/lồng câu 1 cột/nhiều dòng vào trong mệnh đề IN của câu SQL bên ngoài.
-- Cú pháp:
-- WHERE CỘT IN (MỘT CÂU SELECT TRẢ VỀ 1 CỘT NHIỀU DÒNG - NHIỀU VALUE CÙNG KIỂU - TẬP HỢP)
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. Liệt kê các nhóm hàng.
SELECT * FROM Categories -- 8 rows

-- 2. In ra các món hàng thuộc nhóm 1, 6, 8.
SELECT * FROM Products WHERE CategoryID IN (1, 6, 8) ORDER BY CategoryID -- 30 rows
SELECT * FROM Products WHERE CategoryID = 1 OR CategoryID = 6 OR CategoryID = 8 ORDER BY CategoryID -- 30 rows

-- 3. In ra các món hàng thuộc nhóm bia/rượu, thịt, và hải sản.
SELECT * FROM Products WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName IN ('Beverages', 'Meat/Poultry', 'Seafood')) ORDER BY CategoryID -- 30 rows

-- 4. Nhân viên quê London phụ trách những đơn hàng nào.
SELECT * FROM Orders WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE City = 'London') ORDER BY EmployeeID -- 224 rows

-- 5. Các nhà cung cấp đến từ Mĩ cung cấp những mặt hàng nào.
SELECT * FROM Suppliers WHERE Country = 'USA' -- 4 rows
SELECT * FROM Products WHERE SupplierID IN (SELECT SupplierID FROM Suppliers WHERE Country = 'USA') -- 12 rows

-- 6. Các nhà cung cấp đến từ Mĩ cung cấp những nhóm hàng nào.
SELECT * FROM Categories WHERE CategoryID IN (SELECT CategoryID FROM Products WHERE SupplierID IN (SELECT SupplierID FROM Suppliers WHERE Country = 'USA')) -- 4 rows

-- 7. Các đơn hàng vận chuyển tới thành phố Sao Paulo được vận chuyển bởi những hãng vận chuyển nào.
SELECT * FROM Shippers WHERE ShipperID IN (SELECT ShipVia FROM Orders WHERE ShipCity = 'Sao Paulo') -- 3 rows

-- 8. Khách hàng đến từ thành phố Berlin, London, Madrid có những đơn hàng nào.
SELECT * FROM Customers WHERE City IN ('Berlin', 'London', 'Madrid')
SELECT * FROM Orders WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE City IN ('Berlin', 'London', 'Madrid')) -- 60 rows