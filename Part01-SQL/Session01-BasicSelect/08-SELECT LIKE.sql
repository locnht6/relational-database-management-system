USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Trong thực tế có những lúc ta muốn tìm dữ liệu/fiter theo kiểu gần đúng, gần đúng trên chuỗi,
-- ví dụ: liệt kê ai đó có tên là AN, khác câu liệt kê ai đó tên bắt đầu bằng chữ A.
-- Tìm đúng, TOÁN TỬ = 'AN',
-- tìm gần đúng, tìm có sự xuất hiện, không dùng =, dùng toán tử LIKE: ... LIKE 'A...' ...
-- Để sử dụng toán tử LIKE, ta cần thêm 2 thứ trợ giúp, dấu % và dấu _
-- % đại diện cho 1 chuỗi bất kì nào đó
-- _ đại diện cho 1 kí tự bất kì nào đó
-- Vd: Name LIKE 'A%', bất kì ai có tên xuất hiện bằng chữ A, phần còn lại là gì không care.
--	   Name LIKE 'A_', bất kì ai có tên là 2 kí tự, trong đó kí tự đầu phải là A.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. In ra danh sách nhân viên.
SELECT * FROM Employees

-- 2. Nhân viên nào có tên bắt đầu chữ A.
SELECT * FROM Employees WHERE FirstName = 'A%' -- 0, vì toán tử so sánh bằng A%, có ai tên là A%
SELECT * FROM Employees WHERE FirstName LIKE 'A%' -- 2 rows

-- 2.1. Nhân viên nào có tên bắt đầu chữ A, in ra cả fullname được ghép đầy đủ.
SELECT EmployeeID, FirstName + ' ' + LastName AS [Full Name], Title FROM Employees WHERE FirstName LIKE 'A%' -- 2 rows
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS [Full Name], Title FROM Employees WHERE FirstName LIKE 'A%' -- 2 rows

-- 3. Nhân viên nào tên có chữ A cuối cùng.
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS [Full Name], Title FROM Employees WHERE FirstName LIKE '%A' -- 1 row

-- 4. Nhân viên nào tên có 4 kí tự.
-- Dùng hàm kiểm tra độ dài tên = 4 hay không.
SELECT * FROM Employees WHERE LEN(FirstName) = 4 -- 1 row
SELECT * FROM Employees WHERE FirstName LIKE '____' -- 1 row

-- 5. Xem danh sách các sản phẩm/món đồ đang có.
SELECT * FROM Products -- 77 rows

-- 6. Những sản phẩm nào tên bắt đầu bằng Ch.
SELECT * FROM Products WHERE ProductName LIKE 'Ch%' -- 6 rows

SELECT * FROM Products WHERE ProductName LIKE '%Ch%' -- 14 rows
-- Trong tên có chữ Ch, không quan tâm vị trí xuất hiện.

-- 7. Những sản phẩm tên có 5 kí tự.
SELECT * FROM Products WHERE ProductName LIKE '_____' -- 3 rows

-- 8. Những sản phảm trong tên có từ cuối cùng là 5 kí tự.
SELECT * FROM Products WHERE ProductName LIKE '%_____' -- 75 rows, tên có từ 5 kí tự trở lên

SELECT * FROM Products WHERE ProductName LIKE '% _____' -- 11 rows, tên có ít nhất 2 từ, từ cuối cùng 5 kí tự,
														-- vô tình loại đi tên chỉ có đúng 5 kí tự.

SELECT * FROM Products WHERE ProductName LIKE '_____' OR ProductName LIKE '% _____' -- 14 rows