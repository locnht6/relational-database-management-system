USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Một DB là nơi chứa data (bán hàng, thư viện, quản lí SV, ...).
-- Data được lưu dưới dạng TABLE, tách thành nhiều TABLE (nghệ thuật design DB, NF)
-- Dùng lệnh SELECT để xem/in dữ liệu từ table, cũng hiển thị dưới dạng table.
-- Cú pháp chuẩn: SELECT * FROM <TÊN-TABLE>
--						 * đại diện cho việc tôi muốn lấy all of columns.

-- Cú pháp mở rộng: SELECT TÊN-CÁC-CỘT-MUỐN-LẤY, CÁCH-NHAU-DẤU-PHẨY FROM <TÊN-TABLE>

--					SELECT CÓ THỂ DÙNG CÁC HÀM XỬ LÍ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ FROM <TÊN-TABLE>

-- Data trả về có cell/ô có NULL, hiểu rằng chưa xác định value/giá trị, chưa có, chưa biết,
-- từ từ cập nhật sau. Vd: SV kí tên vào danh sách thi, cột điểm ngay lúc kí tên gọi là NULL,
-- mang trạng thái chưa xác định.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. Xem thông tin của tất cả các khách hàng đang giao dịch.
SELECT * FROM Customers
INSERT INTO Customers(CustomerID, CompanyName, ContactName) VALUES ('ALFKI', 'FPT University', 'Thanh Nguyen Khac')
															-- Bị chửi vì trùng Primary Key.		

INSERT INTO Customers(CustomerID, CompanyName, ContactName) VALUES ('FPTU', 'FPT University', 'Thanh Nguyen Khac')
															-- Ngon lành cành đào.

-- 2. Xem thông tin nhân viên, xem hết các cột luôn.
SELECT * FROM Employees

-- 3. Xem các sản phẩm có trong kho.
SELECT * FROM Products

-- 4. Mua hàng, thì thông tin sẽ nằm ở table Orders và OrderDetails.
SELECT * FROM Orders -- 830 bills.

-- 5. Xem thông tin công ty giao hàng.
SELECT * FROM Shippers
INSERT INTO Shippers(CompanyName, Phone) VALUES ('Fedex Vietnam', '(084) 666-8888')

-- 6. Xem chi tiết mua hàng.
SELECT * FROM Orders			-- Phần trên của bill siêu thị.
SELECT * FROM [Order Details]	-- Phần Table kẻ gióng lề những món hàng đã mua.

-- 7. In ra thông tin khách hàng, chỉ gồm cột Id, CompanyName, ContactName
SELECT CustomerID, CompanyName, ContactName, Country FROM Customers

-- 8. In ra thông tin nhân viên
-- Tên người tách thành Last & First: dành cho mục tiêu sort theo tiêu chí tên, họ.
-- In ra tên theo quy ước mỗi quốc gia.
SELECT * FROM Employees
SELECT EmployeeID, LastName, FirstName, Title, BirthDate FROM Employees

-- 9. In ra thông tin nhân viên, ghép tên cho đẹp/gộp cột, tính luôn tuổi.
SELECT EmployeeID, LastName + ' ' + FirstName AS [Full Name], Title, BirthDate FROM Employees

SELECT EmployeeID, LastName + ' ' + FirstName AS [Full Name], Title, BirthDate, YEAR(BirthDate) FROM Employees

SELECT EmployeeID, LastName + ' ' + FirstName AS [Full Name], Title, BirthDate, YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees

-- 10. In ra thông tin chi tiết mua hàng.
SELECT * FROM [Order Details]

SELECT *, UnitPrice * Quantity AS [Total Price] FROM [Order Details]

-- Công thức tính tổng tiền phải trả từng món, có trừ đi giảm giá, phần trăm:
-- SL * ĐG - TIỀN GIẢM GIẢ			==> TIỀN PHẢI TRẢ.
-- SL * ĐG - SL * ĐG * DISCOUNT (%) ==> TIỀN PHẢI TRẢ.
-- SL * ĐG * (1 - DISCOUNT (%))		==> TIỀN PHẢI TRẢ.
SELECT *, UnitPrice * Quantity * (1 - Discount) AS SubTotal FROM [Order Details]