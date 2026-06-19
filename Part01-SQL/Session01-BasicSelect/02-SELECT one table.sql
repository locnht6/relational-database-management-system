USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Một DB là nơi chứa data (bán hàng, thư viện, quản lí SV, ...).
-- Data được lưu dưới dạng TABLE, tách thành nhiều TABLE (nghệ thuật design DB, NF)
-- Dùng lệnh SELECT để xem/in dữ liệu từ table, cũng hiển thị dưới dạng table.
-- Cú pháp chuẩn: SELECT * FROM <TÊN-TABLE>
--						 * đại diện cho việc tôi muốn lấy all of columns.

-- Data trả về có cell/ô có NULL, hiểu rằng chưa xác định value/giá trị, chưa có, chưa biết,
-- từ từ cập nhật sau. Vd: SV kí tên vào danh sách thi, cột điểm ngay lúc kí tên gọi là NULL,
-- mang trạng thái chưa xác định.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. Xem thông tin của tất cả các khách hàng đang giao dịch.
SELECT * FROM Customers

-- 2. Xem thông tin nhân viên, xem hết các cột luôn.
SELECT * FROM Employees

-- 3. Xem các sản phẩm có trong kho.
SELECT * FROM Products

-- 4. Mua hàng, thì thông tin sẽ nằm ở table Orders và OrderDetails.
SELECT * FROM Orders -- 830 bills.

-- 5. Xem thông tin công ty giao hàng.
SELECT * FROM Shippers

-- 6. Xem chi tiết mua hàng.
SELECT * FROM Orders			-- Phần trên của bill siêu thị.
SELECT * FROM [Order Details]	-- Phần Table kẻ gióng lề những món hàng đã mua.