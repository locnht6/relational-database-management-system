USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- CÚ PHÁP CHUẨN
-- SELECT CỘT, HÀM GOM NHÓM(), ... FROM <TÊN-TABLE> WHERE ... GROUP BY ... HAVING (WHERE THỨ 2)

-- CỘT XUẤT HIỆN TRONG SELECT HÀM Ý ĐẾM THEO CỘT NÀY, CỘT PHẢI XUẤT HIỆN TRONG GROUP BY
-- TỈNH, <ĐẾM CÁI GÌ ĐÓ CỦA TỈNH> -> RÕ RÀNG PHẢI CHIA THEO TỈNH MÀ ĐẾM, GROUP BY TỈNH.
-- CHUYÊN NGÀNH, <ĐẾM CỦA CHUYÊN NGÀNH> -> CHIA THEO CHUYÊN NGÀNH, GROUP BY CHUYÊN NGÀNH.
-- CÓ QUYỀN GROUP BY TRÊN NHIỀU CỘT
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

-- 9. In ra danh sách nhân viên
SELECT * FROM Employees ORDER BY Region -- 9 rows

-- 10. Đếm xem mỗi khu vực có bao nhiêu nhân viên.
SELECT COUNT(*) FROM Employees -- 9 nhân viên
SELECT COUNT(*) FROM Employees GROUP BY Region -- 4 (NULL) 5 (WA)
-- 2 NHÓM REGION, 2 CỤM REGION: WA, NULL

SELECT COUNT(Region) FROM Employees GROUP BY Region -- 2 cụm Region NULL WA
-- 0 và 5, do NULL không được xem là value đề đếm, nhưng vẫn là một value để được chia nhóm, nhóm không giá trị.

SELECT Region, COUNT(Region) FROM Employees GROUP BY Region -- sai do đếm null
SELECT Region, COUNT(*) FROM Employees GROUP BY Region -- đúng do đếm dòng

-- 11. Khảo sát đơn hàng.
SELECT * FROM Orders -- 830 rows
-- Mỗi quốc gia có bao nhiêu đơn hàng.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry

-- 12. Quốc gia nào có từ 50 đơn hàng trở lên.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >= 50

-- 13. Quốc gia nào có nhiều đơn hàng nhất.
SELECT MAX([No orders]) FROM (SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry) AS CNTRY -- lấy được max rồi
 
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry HAVING COUNT(*) = (SELECT MAX([No orders]) FROM (SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry) AS CNTRY)

-- 14. Liệt kê các đơn hàng của khách hàng mã số VINET.
SELECT * FROM Orders WHERE CustomerID = 'VINET' -- 5 rows

-- 15. Khách hàng VINET đã mua bao nhiêu lần?
SELECT CustomerID, COUNT(*) FROM Orders WHERE CustomerID = 'VINET' GROUP BY CustomerID

SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID HAVING CustomerID = 'VINET'