CREATE DATABASE DBDESIGN_VNLOCATIONS

USE DBDESIGN_VNLOCATIONS

-- THIẾT KẾ CƠ SỞ DỮ LIỆU LƯU ĐƯỢC THÔNG TIN PHƯỜNG/XÃ, QUẬN/HUYỆN, TỈNH/THÀNH PHỐ.
-- Chính là 1 phần của địa chỉ được tách ra cho nhu cầu thống kê,
-- nó là 1 phần của Composite field.
-- |SEQ|Dose|InjDate|Vaccine (FK)|Lot|Địa chỉ chích - composite|
-- |SEQ|Dose|InjDate|Vaccine (FK)|Lot|Số nhà|Phường-Quận-Tỉnh|

-- XÉT RIÊNG PHƯỜNG-QUẬN-TỈNH RÕ RÀNG 3 CỘT LOOKUP.
CREATE TABLE Locations
(
	Province nvarchar(30),
	District nvarchar(30),
	Ward nvarchar(30)
)

SELECT * FROM Locations

-- PHÂN TÍCH TABLE
-- 1. TRÙNG LẶP CỤM INFO TỈNH-QUẬN.
-- 2. LOOKUP TRÊN PROVINCE, DISTRICT (WARD).
-- 3. SỰ PHỤ THUỘC LOGIC GIỮA PROVINCE VÀ DISTRICT (WARD).
--	  FUNCTIONAL DEPENDENCY - FD - PHỤ THUỘC HÀM.
--	  CÓ 1 ÁNH XẠ, MỐI QUAN HỆ GIỮA A VÀ B, PROVINCE VS. DISTRICT.
--	  CỨ CHỌN TP.HCM -> Q1, Q2, Q3, ...
--    Y = F(X) = X^2, CỨ CHỌN F(2) -> 4

-- TÁCH LOOKUP VÌ DỄ NHẤT, RA ĐƯỢC 1 TABLE, PHẦN TABLE CÒN LẠI THÌ FK SANG LOOKUP.
-- Vaccination (liều chích, tên vaccine) FK sang Vaccine (tên vaccine).

-- CHỈ LOOKUP 63 TỈNH, KHÔNG CHO CHỌN LỘN XỘN.
CREATE TABLE Province
(
	PName nvarchar(30)
)

SELECT * FROM Province
SELECT * FROM Locations -- 10581 dòng ứng với 10581 xã/phường khác nhau,
						-- nhưng chỉ có 63 tỉnh thành lặp lại.

SELECT DISTINCT Province FROM Locations

-- Dùng nó để INSERT sang table lookup.

INSERT INTO Province VALUES (N'Thành phố Cần Thơ')
INSERT INTO Province VALUES (N'Tỉnh Vĩnh Long')

DELETE FROM Province

-- CÁCH INSERT THỨ 2.
INSERT INTO Province VALUES (N'Thành phố Cần Thơ'), (N'Tỉnh Vĩnh Long')

-- TUYỆT CHIÊU INSERT THỨ 3.
-- COPY & PASTE CHO 10K DÒNG.

-- TUYỆT CHIÊU INSERT THỨ 4.
-- INSERT INTO Province VALUES CÓ 63 TỈNH THÀNH LÀ NGON - TA XÀI KIỂU SUB-QUERY TRONG LỆNH INSERT

INSERT INTO Province SELECT DISTINCT Province FROM Locations

SELECT COUNT(*) FROM Locations -- 10581 XÃ PHƯỜNG
SELECT COUNT(DISTINCT Province) FROM Locations -- 63 TỈNH THÀNH

-- TẠO TABLE LOOKUP QUẬN/HUYỆN.