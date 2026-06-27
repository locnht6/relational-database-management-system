CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBookV2_
(
	Nick nvarchar(30),
	-- Phone varchar(50) -- cấm đa trị, cấm gộp nhiều số phone trong 1 cell
	Phone1 char(11), -- chỉ 1 số phone thôi
	Phone2 char(11),
	Phone3 char(11) -- Không biết cột nào alf loại phone nào, đặt theo kiểu 1 2 3 vô hồn
)

CREATE TABLE PhoneBookV2
(
	Nick nvarchar(30),
	-- Phone varchar(50) -- cấm đa trị, cấm gộp nhiều số phone trong 1 cell
	HomePhone char(11), -- chỉ 1 số phone thôi
	WorkPhone char(11),
	CellPhone char(11)
)
-- MỞ RỘNG TABLE THEO CHIỀU NGANG - THÊM CỘT!!!

SELECT * FROM PhoneBookV2

INSERT INTO PhoneBookV2 VALUES (N'locnht', NULL, NULL, '090x')
INSERT INTO PhoneBookV2 VALUES (N'annguyen', '090x', '091x', NULL)
INSERT INTO PhoneBookV2 VALUES (N'binhle', '090x', '091x', '092x')

-- ***** PHÂN TÍCH:
-- >>>>> ƯU ĐIỂM: SELECT PHONE LÀ RA ĐƯỢC TẤT CẢ CÁC SỐ DI ĐỘNG.
-- 1.SQL. Cho tui biết các số dị động của mọi người.
SELECT Nick, CellPhone FROM PhoneBookV2
SELECT p.Nick, p.CellPhone FROM PhoneBookV2 p

-- >>>>> Cho tui biết số để bàn, ở nhà của anh binhle.
SELECT p.Nick, p.HomePhone, p.CellPhone FROM PhoneBookV2 p WHERE p.Nick = ''

-- >>>>> NHƯỢC ĐIỂM:
-- Thống kê số lượng số điện thoại mỗi người xài, mấy sim? Không trả lời được.
-- Data bị NULL, phí không gian lưu trữ.
-- NGƯỜI CÓ 4 PHONE, 5 PHONE THÌ SAO?
-- Solution: thêm cột, càng thêm cột trừ hao về người có nhiều phone, những người còn lại bị null càng nhiều.
-- PHÍ VÌ CHỈ VÀI 1 NGƯỜI ĐẶC BIỆT NHIỀU PHONE MÀ TẤT CẢ ANH EM KHÁC ĐỀU ĐƯỢC XEM CHUNG LÀ NHIỀU SỐ PHONE, PHÍ KHÔNG GIAN LƯU TRỮ.
-- GIẢ SỬ VẪN QUYẾT TÂM THEO CỘT, NỞ CỘT RA, THÌ GIÁ PHẢI TRẢ SỬA CODE LẬP TRÌNH,
-- SAU NÀY, VÌ TÊN CỘT MỚI ĐƯỢC THÊM VÔ KHI NÂNG CẤP APP, SỬA THÊM CÂU QUERY.

-- TRIẾT LÍ THIẾT KẾ: CỐ GẮNG GIỮ NGUYÊN CÁI TỦ, CHỈ THÊM ĐỒ, KHÔNG THÊM CỘT CỦA TABLE,
-- CHỈ CẦN THÊM DÒNG NẾU CÓ BIẾN ĐỘNG SỐ LƯỢNG.

-- PHIÊN BẢN 3 - PHIÊN BẢN NGON BẮT ĐẦU, AI NHIỀU PHONE THÌ NHIỀU DÒNG, NHIỀU CELL THEO CHIỀU DỌC THÊM DÒNG.
-- COUNT NGON LÀNH LUÔN, TRẢ LỜI NGAY ĐƯỢC CÂU BAO NHIÊU SIM BAO NHIÊU SÓNG.