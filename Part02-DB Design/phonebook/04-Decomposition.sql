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

-- * ƯU ĐIỂM
-- Count ngon, group by theo nick, theo loại phone.
-- Where theo loại phone ngon.

-- * NHƯỢC ĐIỂM
-- Tính không nhất quán (inconsistency) của loại phone: có người gõ" Cell, CELL, cell không sợ vì cùng là 1 kiểu,
-- nhưng gõ thêm: Di động, DĐ -> cảm đám là một, nhưng máy hiểu khác nhau.
-- Query liệt kê các số di động của tất cả mọi người, toang khi WHERE.
-- Vì không biết được có bao nhiêu loại chữ biểu diễn cho DI ĐỘNG.
INSERT INTO PhoneBookV4_1 VALUES ('093x', 'MOBILE', N'binhle')

-- SQL. Liệt kê các số di động của binhle
SELECT * FROM PhoneBookV4_1 WHERE PhoneType IN ('Cell', 'CELL', 'MOBILE', 'DĐ') -- Bạn tính IN cái tập hợp này đến bao giờ khi người ta gõ từ khác
																				-- cùng biểu diễn khái niệm di động.
-- QUY TẮC THÊM: CÓ NHỮNG LOẠI DỮ LIỆU BIẾT TRƯỚC LÀ NHIỀU, NHƯNG HỮU HẠN VALUE NHẬP,
-- TỈNH THÀNH NHIỀU, CHỈ CÓ 34, QUỐC GIA NHIỀU, CHỈ CÓ 230, TRƯỜNG THPT, 500 TRƯỜNG,...
-- CÓ NÊN CHO NGƯỜI TA GÕ TAY HAY KHÔNG, KHÔNG, VÌ NÓ SẼ GÂY NÊN KHÔNG NHẤT QUÁN!
-- TỐT NHẤT CHO CHỌN, CHỌN PHẢI TỪ CÁI CÓ SẴN, SẴN TỨC LÀ TỪ TABLE KHÁC.

-- KHÔNG CHO GÕ LUNG TUNG, GÕ TRONG CÁI ĐÃ CÓ - DÍNH 2 THỨ, TABLE KHÁC, FK ĐỂ ĐẢM BẢO CHỌN ĐÚNG TRONG ĐÓ.