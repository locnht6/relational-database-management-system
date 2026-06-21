USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Trong thực tế có những lúc dữ liệu/info chưa xác định được nó là gì.
-- Vd: kí tên vào danh sách thi, danh sách kí tên có cột điểm, điểm ngay lúc kí tên chưa xác định, từ từ sẽ có, update sau.
-- Hiện tượng dữ liệu chưa xác định, chưa biết, từ từ đưa vào sau, hiện nhìn vào chưa thấy có data,
-- thì ta gọi giá trị chưa xác định này là NULL.
-- NULL đại diện cho thứ chưa xác định, chưa xác định tức là không có giá trị,
-- không giá trị thì không thể so sánh > >= < <= = !=
-- Cấm tuyệt đối xài các toán tử so sánh kèm với giá trị NULL.
-- Ta dùng toán tử IS NULL, IS NOT NULL, NOT (IS NULL) để filter cell có giá trị NULL.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. In ra danh sách nhân viên.
SELECT * FROM Employees -- 9 rows

-- 2. Ai chưa xác định khu vực ở, region NULL.
SELECT * FROM Employees WHERE Region = 'NULL' -- 0, vì không ai ở khu vực tên là NULL
SELECT * FROM Employees WHERE Region = NUll -- 0, vì NULL không thể dùng > < =

SELECT * FROM Employees WHERE Region IS NULL -- 4 rows

-- 3. Những ai đã xác định được khu vực cư trú?
SELECT * FROM Employees WHERE Region IS NOT NULL -- 5 rows
SELECT * FROM Employees WHERE NOT (Region IS NULL) -- 5 rows

-- 4. Những nhân viên đại diện kinh doanh và xác định được nơi cứ trú.
SELECT * FROM Employees WHERE Title = 'Sales Representative' AND Region IS NOT NULL -- 3 rows
SELECT * FROM Employees WHERE Title = 'Sales Representative' AND NOT (Region IS NULL) -- 3 rows

-- 5. Liệt kê danh sách khách hàng đến từ Anh, Pháp, Mĩ, có cả thông tin số fax và region.
SELECT * FROM Customers WHERE Country IN ('UK', 'France', 'USA') AND Fax IS NOT NULL AND Region IS NOT NULL -- 9 rows