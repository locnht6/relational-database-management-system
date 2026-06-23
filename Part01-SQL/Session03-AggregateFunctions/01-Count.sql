USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- DB Engine hỗ trợ 1 loạt nhóm hàm dùng để thao tác trên nhóm dòng/cột,
-- gom data tính toán trên đám data gom này - nhóm hàm gom nhóm - AGGREGATE FUNCTIONS, AGGREGATION.
-- COUNT() SUM() MIN() MAX() AVG()

-- CÚ PHÁP CHUẨN:
-- SELECT CỘT..., HÀM GOM NHÓM(), ... FROM <TÊN-TABLE>

-- CÚ PHÁP MỞ RỘNG:
-- SELECT CỘT..., HÀM GOM NHÓM(), ... FROM <TÊN-TABLE> ... WHERE ... GROUP BY (GOM THEO CỤM CỘT NÀO)

-- SELECT CỘT..., HÀM GOM NHÓM(), ... FROM <TÊN-TABLE> ... WHERE ... GROUP BY (GOM THEO CỤM CỘT NÀO) HAVING ...

-- HÀM COUNT(...) DÙNG ĐỂ ĐẾM SỐ LẦN XUẤT HIỆN CỦA 1 CÁI GÌ ĐÓ.
--     COUNT(*): ĐẾM SỐ DÒNG TRONG TABLE, ĐẾM TẤT CẢ CÁC DÒNG, KHÔNG CARE TIÊU CHUẨN NÀO KHÁC.
--	   COUNT(*) FROM ... WHERE ...: CHỌN RA NHỮNG DÒNG THỎA TIÊU CHÍ WHERE NÀO ĐÓ TRƯỚC ĐÃ, RỒI MỚI ĐẾM, FILTER RỒI ĐẾM.
--	   COUNT(CỘT NÀO ĐÓ):

-- Phát hiện hàm count(cột): nếu cell của cột chứa null, không tính, không đếm.
--------------------------------------------------------------
-- THỰC HÀNH
-- 1. In ra danh sách các nhân viên.
SELECT * FROM Employees -- 9 rows

-- 2. Đếm xem có bao nhiêu nhân viên.
SELECT COUNT(*) FROM Employees
SELECT COUNT(*) AS [Number of employees] FROM Employees

-- 3. Có bao nhiêu nhân viên ở London.
SELECT COUNT(*) AS [No emps in London] FROM Employees WHERE City = 'London'

-- 4. Có bao nhiêu lượt thành phố xuất hiện - cứ xuất hiện tên thành phố là đếm, không care lặp lại hay không.
SELECT Count(City) FROM Employees -- 9

-- 5. Đếm xem có bao nhiêu Region.
SELECT COUNT(Region) FROM Employees -- 5

-- 6. Đếm xem có bao nhiêu khu vực null, có bao nhiêu dòng region null.
SELECT COUNT(*) FROM Employees WHERE Region IS NULL -- đếm sự xuất hiện dòng chứa Region null

SELECT COUNT(Region) FROM Employees WHERE Region IS NULL --0, vì null không đếm được, không value

-- 7. Có bao nhiêu thành phố trong table Employees.
SELECT * FROM Employees -- 9 rows

SELECT City FROM Employees -- 9 rows

SELECT DISTINCT City FROM Employees -- 5 rows
-- Ta coi kết quả trên là 1 table, mất quá trời công sức lọc ra 5 thành phố.

-- SUB QUERY MỚI, COI 1 CÂU SELECT LÀ 1 TABLE, BIẾN TABLE NÀY VÀO TRONG MỆNH ĐỀ FROM.
SELECT * FROM (SELECT DISTINCT City FROM Employees) AS CITIES -- 1 table phải có định danh, nên phải đặt tên giả cho table.

SELECT COUNT(*) FROM (SELECT DISTINCT City FROM Employees) AS CITIES

SELECT COUNT(*) FROM Employees -- 9 NV
SELECT COUNT(City) FROM Employees -- 9 City
SELECT COUNT(DISTINCT City) FROM Employees -- 5 City

-- 8. Đếm xem mỗi thành phố có bao nhiêu nhân viên.
-- Khi câu hỏi có tính toán gom data (hàm aggregate) mà lại chứa từ khóa MỖI,
-- gặp từ "MỖI" chính là chia để đếm, chia để trị, chia cụm để gom đếm.
SELECT * FROM Employees -- 9 NV

-- Seattle 2 | Tacoma 1 | Kirkland 1 | Redmond 1 | London 4
-- Sự xuất hiện của nhóm.
-- Đếm theo sự xuất hiện của nhóm, count++ trong nhóm thôi, sau đó reset lại ở nhóm mới.
SELECT City, COUNT(City) AS [No employees] FROM Employees GROUP BY City
-- Đếm value của City, nhưng đếm theo nhóm, chia City thành nhóm rồi đếm trong nhóm.

SELECT EmployeeID, City, COUNT(City) AS [No employees] FROM Employees GROUP BY City, EmployeeID -- vô nghĩa, chia nhóm theo key, mssv vô nghĩa

-- CHỐT HẠ: KHI XÀI HÀM GOM NHÓM, BẠN CÓ QUYỀN LIỆT KÊ TÊN CỘT LẺ Ở SELECT,
-- NHƯNG CỘT LẺ ĐÓ BẮT BUỘC PHẢI XUẤT HIỆN TRONG MỆNH ĐỀ GROUP BY ĐỂ ĐẢM BẢO LOGIC:
-- CỘT HIỂN THỊ | SỐ LƯỢNG ĐI KÈM, ĐẾM GOM THEO CỘT HIỂN THỊ MỚI LOGIC,
-- CỨ THEO CỘT CITY MÀ GOM, CỘT CITY NẰM Ở SELECT LÀ HỢP LÍ,
-- MUỐN HIỂN THỊ SỐ LƯỢNG CỦA AI ĐÓ, GÌ ĐÓ, GOM NHÓM THEO CÁI GÌ ĐÓ.

-- NẾU BẠN GOM THEO KEY/PK, VÔ NGHĨA HENG, VÌ KEY KHÔNG TRÙNG, MỖI THẰNG 1 NHÓM, ĐẾM CÁI GÌ?

-- MÃ SỐ SV -- ĐẾM CÁI GÌ? VÔ NGHĨA!
-- MÃ CHUYÊN NGÀNH -- ĐẾM SỐ SV CHUYÊN NGÀNH!
-- MÃ QUỐC GIA -- ĐẾM SỐ ĐƠN HÀNG!
-- ĐIỂM THI -- ĐẾM SỐ LƯỢNG SV ĐẠT ĐƯỢC ĐIỂM ĐÓ!
-- CÓ CỘT ĐỂ GOM NHÓM, CỘT ĐÓ SẼ DÙNG ĐỂ HIỂN THỊ SỐ LƯỢNG KẾT QUẢ.

-- 9. Hãy cho tôi biết thành phố nào có từ 2 nhân viên trở lên.
-- 2 chặng làm:
-- 9.1. Các thành phố có bao nhiêu nhân viên.
-- 9.2. Đếm xong mỗi thành phố, ta bắt đầu lọc lại kết quả sau đếm.
-- FILTER SAU ĐẾM, WHERE SAU ĐẾM, WHERE SAU KHI ĐÃ GOM NHÓM, AGGREGATE THÌ GỌI LÀ HAVING.
SELECT City, COUNT(City) AS [No employees] FROM Employees GROUP BY City
SELECT City, COUNT(*) AS [No employees] FROM Employees GROUP BY City

SELECT * FROM (SELECT City, COUNT(*) AS [No employees] FROM Employees GROUP BY City) AS Cities WHERE [No employees] >= 2 -- 2 rows

SELECT City, COUNT(*) AS [No employees] FROM Employees GROUP BY City HAVING COUNT(*) >= 2 -- 2 rows

-- 10. Đếm số nhân viên của 2 thành phố Seattle và London.
SELECT COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') -- 6 đứa, sai rồi

SELECT City, COUNT(*) AS [No employees] FROM Employees WHERE City IN ('Seattle', 'London') GROUP BY City

-- 11. Trong 2 thành phố, London, Seattle, thành phố nào có nhiều hơn 3 nhân viên.
SELECT City, COUNT(*) AS [No employees] FROM Employees WHERE City IN ('Seattle', 'London') GROUP BY City HAVING COUNT(*) >= 3 -- London

-- 12. Đếm xem có bao nhiêu đơn hàng đã bán ra.
SELECT * FROM Orders -- 830 rows
SELECT COUNT(*) AS [No orders] FROM Orders -- 830
SELECT COUNT(OrderID) AS [No orders] FROM Orders -- 830
-- 830 mã đơn khác nhau, đếm mã đơn, hay đếm cả cái đơn là như nhau, nếu cột có value NULL là ăn hành!

-- 12.1. Nước Mĩ có bao nhiêu đơn hàng.
-- Đi tim Mĩ mà đếm, lọc Mĩ rồi tính tiếp, WHERE MĨ.
-- Không phải là câu gom chia nhóm, không có mỗi quốc gia có bao nhiêu đơn hàng,
-- mỗi quốc gia có bao nhiêu đơn, COUNT theo quốc gia, GROUP BY theo quốc gia.
SELECT COUNT(*) AS [No USA orders] FROM Orders WHERE ShipCountry = 'USA' -- 122
SELECT ShipCountry, COUNT(*) AS [No USA orders] FROM Orders WHERE ShipCountry = 'USA' GROUP BY ShipCountry -- 122

-- 12.2. Mĩ Anh Pháo chiếm tổng cộng bao nhiêu đơn hàng.
SELECT COUNT(*) AS [No orders] FROM Orders WHERE ShipCountry IN ('USA', 'UK', 'France') -- 255

-- 12.3. Mĩ Anh Pháp, mỗi quốc gia có bao nhiêu đơn hàng.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders WHERE ShipCountry IN ('USA', 'UK', 'France') GROUP BY ShipCountry

-- 12.4. Trong 3 quốc gia Anh Pháp Mĩ, quốc gia nào có từ 100 đơn hàng trở lên.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders WHERE ShipCountry IN ('USA', 'France', 'UK') GROUP BY ShipCountry HAVING COUNT(*) >= 100

-- 13. Đếm xem có bao nhiêu mặt hàng có trong kho.
SELECT * FROM Products
SElECT COUNT(*) AS [No products] FROM Products -- 77 rows

-- 14. Đếm xem có bao nhiêu lượt quốc gia đã mua hàng.
SELECT COUNT(ShipCountry) AS [No orders] FROM Orders -- 830

-- 15. Đếm xem có bao nhiêu quốc gia đã mua hàng (mỗi quốc gia đếm một lần)
SELECT DISTINCT ShipCountry FROM Orders
SELECT COUNT(DISTINCT ShipCountry) FROM Orders -- 21

-- 16. Đếm số lượng đơn hàng của mỗi quốc gia.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry

-- 17. Quốc gia nào có từ 10 đơn hàng trở lên.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >= 10 -- 19 rows
 

-- 18. Đếm xem mỗi chủng loại hàng có bao nhiêu mặt hàng (bia rượu có 5 sản phẩm, thủy sản 10 sản phẩm).
SELECT * FROM Products
SELECT * FROM Categories
SELECT CategoryID, COUNT(*) AS [No products] FROM Products GROUP BY CategoryID

-- 19. Trong 3 quốc gia Anh Pháp Mĩ, quốc gia nào có nhiều đơn hàng nhất.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders WHERE ShipCountry IN ('UK', 'USA', 'France') GROUP BY ShipCountry HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM Orders WHERE ShipCountry IN ('UK', 'USA', 'France') GROUP BY ShipCountry) -- USA - 122

-- 20. Quốc gia nào có nhiều đơn hàng nhất.
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM Orders GROUP BY ShipCountry) -- USA & Germany

-- 21. Thành phố nào có nhiều nhân viên nhất?
SELECT City, COUNT(*) AS [No emps] FROM Employees GROUP BY City HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM Employees GROUP BY City) -- London - 4