USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Mệnh đề WHERE dùng làm bộ lọc/filter/nhặt ra những dữ liệu ta cần theo 1 tiêu chí nào đó,
-- ví dụ: lọc ra những SV có quê ở TP HCM,
--		  lọc ra những SV có quê ở Hà Nội và điểm trung bình >=8.
-- Cú pháp bộ lọc:
-- SELECT * (cột bạn muốn in ra) FROM <TÊN-TABLE> WHERE <ĐIỀU KIỆU LỌC>
-- Điều kiện lọc: tìm từng dòng, với cái-cột có giá trị cần lọc,
--				  lọc theo tên cột với value thế nào, lấy tên cột, xem value trong cell,
--				  có thỏa điều kiện lọc hay không?
-- Để viết điều kiện lọc ta cần:
-- Tên cột.
-- Value của cột (cell).
-- Toán tử (operator) > >= < <= = != <> (!= hoặc <> đều là khác nhau),
-- nhiều điều kiện lọc đi kèm, dùng thêm logic operators, AND, OR, NOT.
-- Ví dụ: WHERE City = N'Bình Dương'
--		  WHERE City = N'Hà Nội' AND Gpa >= 8

-- Lọc liên quan đến giá trị/value/cell chứa gì, ta phải quan tâm đến data types:
-- Số: nguyên/thực, ghi số ra như truyền thống 5, 10, 3.14, 9.8
-- Chuỗi/kí tự: 'A', 'Ahihi'
-- Ngày tháng: '2003-01-01'

-- CÔNG THỨC FULL CỦA SELECT
-- SELECT ...		FROM ...		WHERE ... GROUP BY ... HAVING ... ORDER BY ...
--		DISTINCT		1, N TABLE
--		HÀM()
--	NESTED QUERY/SUB QUERY

-- RẤT CẨN THẬN KHI TRONG MỆNH ĐỀ WHERE LẠI CÓ AND OR TRỘN VỚI NHAU, TA PHẢI XÀI THÊM ()
-- ĐỂ PHÂN TÁCH THỨ TỰ FILTER: ... (SO SÁNH AND OR KHÁC NỮA) AND (SO SÁNH KHÁC)
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. In ra danh sách các khách hàng.
SELECT * FROM Customers -- 92 rows

-- 2. In ra danh sách khách hàng đến từ Ý.
SELECT * FROM Customers WHERE Country = 'Italy' -- 3 rows

-- 3. In ra danh sách khách hàng đến từ Mĩ.
SELECT * FROM Customers WHERE Country = 'USA' -- 13 rows

-- 4. In ra những khách hàng đến từ Mĩ, Ý.
-- Đời thường có thể nói: những khách hàng đến từ Ý và Mĩ, Ý hoặc Mĩ.
SELECT * FROM Customers WHERE Country = 'USA' AND Country = 'Italy' -- 0 row
SELECT * FROM Customers WHERE Country = 'USA' OR Country = 'Italy' -- 16 rows

-- sort theo Ý, Mĩ để gom cùng cụm cho dễ theo dõi.
SELECT * FROM Customers WHERE Country = 'USA' OR Country = 'Italy' ORDER BY Country -- 16 rows

-- 5. In ra khách hàng đến từ thủ đô nước Đức.
SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin' -- 1 row

-- 6. In ra thông tin của nhân viên.
SELECT * FROM Employees

-- 7. In ra thông tin nhân viên có năm sinh từ năm 1960 trở lại gần đây.
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 -- 4 rows

-- 8. In ra thông tin nhân viên có tuổi từ 60 trở lên.
SELECT EmployeeID, FirstName, LastName, Title, BirthDate, YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate) >= 60 -- 9 rows

-- 9. Những nhân viên nào ở Luân Đôn.
SELECT * FROM Employees WHERE City = 'London' -- 4 rows

-- 10. Những nhân viên nào không ở Luân Đôn.
SELECT * FROM Employees WHERE City != 'London' -- 5 rows
SELECT * FROM Employees WHERE City <> 'London' -- 5 rows

-- Vi diệu
-- Đảo mệnh đề!!!
SELECT * FROM Employees WHERE NOT(City = 'London') -- 5 rows

-- 11. In ra hồ sơ nhân viên có mã số là 1.
-- ĐI vào ngân hàng giao dịch, hoặc đưa số tài khoản, kèm CCCD, filter theo CCCD
SELECT * FROM Employees WHERE EmployeeID = 1 -- kiểu số, không có '', chơi như lập trình.
-- WHERE trên Key chỉ ra 1 mà thôi,
-- SELECT mà có WHERE Key chỉ có 1 dòng trả về và DISTINCT là vô nghĩa.
SELECT DISTINCT EmployeeID, FirstName, LastName, City FROM Employees WHERE EmployeeID = 1 ORDER BY EmployeeID

-- 12. Xem thông tin bên đơn hàng.
SELECT * FROM Orders -- 830 rows

-- 13. Xem thông tin bên đơn hàng sắp xếp giảm dần theo trọng lượng.
SELECT * FROM Orders ORDER BY Freight DESC

-- 14. In thông tin đơn hàng có trọng lượng >= 500kg và sắp xếp giảm dần theo trọng lượng.
SELECT * FROM Orders WHERE Freight >= 500 ORDER BY Freight DESC -- 13 rows

-- 15. In thông tin đơn hàng có trọng lượng nằm trong khoảng từ 100 đến 500 và sắp xếp giảm dần theo trọng lượng.
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 500 ORDER BY Freight DESC -- 174 rows

-- 16. In thông tin đơn hàng có trọng lượng nằm trong khoảng từ 100 đến 500, ship bới công ty giao vận số 1, và sắp xếp giảm dần theo trọng lượng.
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1 ORDER BY Freight DESC -- 52 rows

-- 17. Và không ship tới London.
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND ShipCity != 'London' ORDER BY Freight DESC -- 50 rows
SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND NOT(ShipCity = 'London') ORDER BY Freight DESC -- 50 rows

-- 18. Liệt kê khách hàng đến từ Mĩ hoặc Mexico.
SELECT * FROM Customers WHERE Country = 'USA' OR Country = 'Mexico' ORDER BY Country -- 18 rows

-- 19. Liệt kê khách hàng không đến từ Mĩ hoặc Mexico.
SELECT * FROM Customers WHERE NOT(Country = 'USA' OR Country = 'Mexico') ORDER BY Country -- 73 rows
SELECT * FROM Customers WHERE Country <> 'USA' AND Country <> 'Mexico' ORDER BY Country -- 73 rows

-- 20. Liệt kê các nhân viên sinh ra trong đoạn [1960, 1970]
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970 ORDER BY BirthDate -- 4 rows