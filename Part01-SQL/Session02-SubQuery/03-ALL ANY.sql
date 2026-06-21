USE Northwind

--------------------------------------------------------------
-- LÍ THUYẾT
-- Cú pháp chuẩn của lệnh SELECT
-- SELECT * FROM <TÊN-TABLE> WHERE ...
-- WHERE CỘT TOÁN-TỬ-SO-SÁNH VỚI-VALUE-CẦN-LỌC
--		 CỘT > >= < <= = != <> VALUE
--							   DÙNG CÂU SUB-QUERU TÙY NGỮ CẢNH
--		 CỘT				=  (SUB CHỈ CÓ 1 VALUE)
--		 CỘT				IN (SUB CHỈ CÓ 1 CỘT NHƯNG NHIỀU VALUE)
--		 CỘT				> >= < <= ALL (1 CÂU SUB 1 CỘT NHIỀU VALUE)
--									  ANY (1 CÂU SUB 1 CỘT NHIỀU VALUE)
--------------------------------------------------------------
-- THỰC HÀNH
-- Tạo 1 table có 1 cột tên là Numbr, chỉ chứa 1 đống dòng các số nguyên.
CREATE TABLE Num
(
	Numbr int
)

SELECT * FROM Num
INSERT INTO Num VALUES (1)
INSERT INTO Num VALUES (1)
INSERT INTO Num VALUES (2)
INSERT INTO Num VALUES (9)
INSERT INTO Num VALUES (5)
INSERT INTO Num VALUES (100)
INSERT INTO Num VALUES (101)

-- 1. In ra những số > 5.
SELECT * FROM Num WHERE Numbr > 5 -- 3 rows

-- 2. In ra số lớn nhất trong các số đã nhập.
-- Số lớn nhất trong 1 đám được định nghĩa là mày lớn hơn hết cả đám đó, và mày bằng chính mình.
-- Lớn hơn tất cả, ngoại trừ chính mình -> mình là MAX của đám.
SELECT * FROM Num WHERE Numbr >= ANY (SELECT * FROM Num) -- 101
SELECT * FROM Num WHERE Numbr > ALL (SELECT * FROM Num) -- 0

-- 3. Số nhỏ nhất là số nào?
SELECT * FROM Num WHERE Numbr <= ALL (SELECT * FROM Num) -- 1

-- 4. Nhân viên nào lớn tuổi nhất.
SELECT * FROM Employees WHERE BirthDate <= ALL (SELECT BirthDate FROM Employees) -- Margaret Peacook

-- 5. Đơn hàng nào có trọng lượng nặng nhất.
SELECT * FROM Orders WHERE Freight >= ALL (SELECT Freight FROM Orders) -- 1007.64