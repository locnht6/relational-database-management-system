CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

-- TÁCH BẢNG THÌ INFO BỊ PHÂN MẢNH, NẰM NHIỀU NƠI, PHẢI JOIN RỒI,
-- NHẬP DATA COI CHỪNG BỊ VÊNH, XÓA DATA COI CHỪNG LẠC TRÔI,
-- PHÂN MẢNH PHẢI CÓ LÚC TÁI NHẬP (JOIN) JOIN TRÊN CỘT NÀO?
-- FK XUẤT HIỆN!!!
-- Không thích chơi FK được không? được và không được.
-- nếu chỉ cần join không cần FK, cột = value, khớp là join, nối bảng, ghép ngang,
-- nếu kèm thêm xóa, sửa, thêm, lộn xộn không nhất quán.

CREATE TABLE PersonV4_1
(
	Nick nvarchar(30),
	Title nvarchar(30),
	Company nvarchar(40)
)

CREATE TABLE PhoneBookV4_1
(
	Phone char(11),
	PhoneType nvarchar(20),
	Nick nvarchar(30) -- không cần FK, chỉ cần join vẫn được
)

SELECT * FROM PhoneBookV4_1
SELECT * FROM PersonV4_1

INSERT INTO PhoneBookV4_1 VALUES ('090x', 'Cell', N'locnht')

INSERT INTO PhoneBookV4_1 VALUES ('090x', 'Cell', N'annguyen')
INSERT INTO PhoneBookV4_1 VALUES ('091x', 'Home', N'annguyen')

INSERT INTO PhoneBookV4_1 VALUES ('090x', 'Cell', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES ('090x', 'Cell', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES ('090x', 'Cell', N'binhle')

INSERT INTO PersonV4_1 VALUES (N'locnht', N'Student', N'FPTU HCM')
INSERT INTO PersonV4_1 VALUES (N'annguyen', N'Student', N'FPTU HCM')
INSERT INTO PersonV4_1 VALUES (N'binhle', N'Student', N'FPTU HL')