USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Khi ta SELECT ít cột từ table gốc thì có nguy cơ dữ liệu sẽ bị trùng lại,
-- không phải ta bị sai, không phải người thiết kế table và người nhập liệu bị sai,
-- do chúng ta có nhiều info trùng nhau/đặc điểm trùng nhau,
-- nên nếu chỉ tập trung vào data này thì trùng nhau chắc chắn xảy ra.
-- Vd: 100 triệu người dân VN được quản lí info bao gồm: ID, Tên, DOB,... Tỉnh thành sinh sống
--																			34 tỉnh thành
-- Lệnh SELECT hỗ trợ loại trừ dòng trùng nhau/trùng 100%:
-- SELECT DISTINCT TÊN-CÁC-CỘT FROM <TÊN-TABLE>
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. Liệt kê danh sách nhân viên.
SELECT * FROM Employees
-- Phân tích: 9 người nhưng chỉ có 4 title ~~~ 100 triệu người dân VN nhưng chỉ có 34 tỉnh thành.
SELECT TitleOfCourtesy FROM Employees -- 9 danh xưng.
SELECT DISTINCT TitleOfCourtesy FROM Employees -- Chỉ là 4.

SELECT DISTINCT EmployeeID, TitleOfCourtesy FROM Employees
-- Nếu DISTINCT đi kèm với ID/Primary Key, nó vô dụng, Key sao trùng mà loại trừ.

-- 2. In ra thông tin khách hàng.
SELECT * FROM Customers -- 92 rows.

-- 3. Có bao nhiêu quốc gia xuất hiện trong thông tin khách hàng, in ra.
SELECT Country FROM Customers -- 92 rows.

SELECT DISTINCT Country FROM Customers -- 22 rows.