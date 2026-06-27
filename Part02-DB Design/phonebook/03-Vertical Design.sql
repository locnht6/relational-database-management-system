CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBookV3_1
(
	Nick nvarchar(30),
	Phone char(11) -- chỉ 1 số phone thôi
)
-- MỞ RỘNG TABLE THEO CHIỀU DỌC, AI CÓ NHIỀU SIM THÌ THÊM DÒNG!!!


SELECT * FROM PhoneBookV3_1

INSERT INTO PhoneBookV3_1 VALUES (N'locnht', '090x')

INSERT INTO PhoneBookV3_1 VALUES (N'annguyen', '090x')
INSERT INTO PhoneBookV3_1 VALUES (N'annguyen', '091x')

INSERT INTO PhoneBookV3_1 VALUES (N'binhle', '090x')
INSERT INTO PhoneBookV3_1 VALUES (N'binhle', '091x')
INSERT INTO PhoneBookV3_1 VALUES (N'binhle', '092x')

-- ***** PHÂN TÍCH:
-- >>>>> ƯU ĐIỂM: SELECT PHONE LÀ RA ĐƯỢC TẤT CẢ CÁC SỐ DI ĐỘNG.
-- Thống kê số lượng số điện thoại mỗi người xài, mấy sim?
-- không bị NULL, muốn thêm bao nhiêu Phone thì thêm!
SELECT Nick, COUNT(*) AS [No phones] FROM PhoneBookV3_1 GROUP BY Nick

-- >>>>> NHƯỢC ĐIỂM:
-- Không biết số phone X nào đó thuộc loại nào?
-- Vi phạm PK, redundancy, binhle lặp lại nhiều lần làm gì khi binhle mới lưu nick thôi,
-- fullname, title, tên cty, email, ...

-- TRÁNH BỊ REDUNDANCY, PK -> TÁCH BẢNG, PHẦN LẶP LẠI RA 1 CHỖ KHÁC.

-------------------------------------------------------------------------------------------
-- TA CẦN GIẢI QUYẾT PHONE NÀY THUỘC LOẠI NÀO?

CREATE TABLE PhoneBookV3_2
(
	Nick nvarchar(30),
	Phone char(11), -- cần giải nghĩa thêm số này là số gì
	PhoneType nvarchar(20) -- 090x - Home, 091x - Work
)

INSERT INTO PhoneBookV3_2 VALUES (N'locnht', '090x', 'Cell')

INSERT INTO PhoneBookV3_2 VALUES (N'annguyen', '090x', 'Cell')
INSERT INTO PhoneBookV3_2 VALUES (N'annguyen', '091x', 'Home')

INSERT INTO PhoneBookV3_2 VALUES (N'binhle', '090x', 'Work')
INSERT INTO PhoneBookV3_2 VALUES (N'binhle', '091x', 'Cell')
INSERT INTO PhoneBookV3_2 VALUES (N'binhle', '092x', 'Cell')

SELECT * FROM PhoneBookV3_2

-- PHÂN TÍCH
-- * ƯU ĐIỂM:
-- COUNT ngon, GROUP BY theo nick, theo loại phone.
-- WHERE theo loại phone ngon.

-- * NHƯỢC ĐIỂM:
-- Redundancy trên info của nick/fullname/cty/email/năm sinh.

-- MỘT KHI BỊ TRÙNG LẶP INFO, LẶP LẠI INFO, REDUNDANCY, CHỈ CÓ 1 SOLUTION,
-- KHÔNG CHO TRÙNG, TỨC LÀ XUẤT HIỆN 1 LẦN, TỨC LÀ RA BẢNG KHÁC -> DECOMPOSITION PHÂN RÃ.