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