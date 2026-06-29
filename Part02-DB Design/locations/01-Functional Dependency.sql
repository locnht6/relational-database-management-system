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
CREATE TABLE District
(
	DName nvarchar(30)
)

-- Có bao nhiêu quận ở VN.
SELECT District FROM Locations -- 10581 quận được lặp lại ứng với 10581 phường/xã khác nhau

SELECT DISTINCT District FROM Locations -- 683 dòng, 683 quận khác nhau
-- RẤT CẨN THẬN KHI CHƠI VỚI QUẬN/HUYỆN.
-- TIỀN GIANG, VĨNH LONG, TRÀ VINH, ĐỀU CÓ HUYỆN "CHÂU THÀNH".
-- BẢNG DISTRICT CHỈ CÓ 1 CHÂU THÀNH, LÁT HỒI CÓ TRỤC TRẶC!
-- PK của District không thể là tên quận/huyện được!


SELECT COUNT(DISTINCT District) FROM Locations -- 683

-- CHÈN VÀO TABLE QUẬN.
INSERT INTO District SELECT DISTINCT District FROM Locations

SELECT * FROM District

-- PROVINCE VÀ DISTRICT CÓ SỰ PHỤ THUỘC LẪN NHAU, TỪ THẰNG NÀY SUY RA ĐƯỢC THẰNG KIA.
-- NHÌN QUẬN CÓ THỂ ĐOÁN TỈNH/THÀNH (CHIỀU NÀY KHÔNG CHẮC AN TOÀN). NHÌN CHÂU THÀNH SAO ĐOÁN ĐƯỢC TỈNH? SÓC TRĂNG, TRÀ VINH, VĨNH LONG,... 
-- NHÌN TỈNH/THÀNH ĐOÁN RA QUẬN (HỢP LÍ VỀ SUY LUẬN). VĨNH LONG -> MANG THÍT, CHÂU THÀNH, ...; SÓC TRĂNG -> CHÂU THÀNH, ....
-- FD NÊN ĐỌC LÀ PROVINCE -> DISTRICT.
-- TABLE CHỨA CÁC FD KIỂU PHỤ THUỘC NGANG GIỮA CÁC CỘT -> SUY NGHĨ TÁCH BẢNG,
-- TÁCH THẰNG VẾ TRÁI & PHẢI, RA TABLE KHÁC! TÁCH XONG THÌ PHẢI FK CHO PHẦN CÒN LẠI.

-- SAU KHI TÁCH TA CÓ TRONG TAY 3 TABLE
-- PROVINCE (PName)
-- DISTRICT (DName, PName (FK lên trên))
-- WARD (WName, DName (FK lên trên))

-- GIẢI PHÁP "DỞ" CHO HUYỆN CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY! TA SẼ LÀM SAU.
-- DÙNG KHÁI NIỆM NATURAL KEY, KEY TỰ NHIÊN - DÙNG TÊN CỦA TỈNH, HUYỆN LÀM KEY, 
-- DÙNG KEY TỰ GÁN, TỰ TĂNG, KEY THAY THẾ, KEY GIẢ (SURROGATE KEY/ARTIFICIAL KEY)

-- PHIÊN BẢN ĐẸP NHƯNG VẪN CÒN CHÚT CHÂU THÀNH!!!
DROP TABLE Province
DROP TABLE District

CREATE TABLE Province
(
	PName nvarchar(30) PRIMARY KEY
)

INSERT INTO Province SELECT DISTINCT Province FROM Locations

SELECT * FROM Province -- 63 tỉnh/thành

CREATE TABLE District
( 
	DName nvarchar(30) NOT NULL, -- GIẢ SỬ KHÔNG CÓ 2 CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY
	-- Quận nào vậy

	-- và thuộc về tỉnh/thành nào vậy
	PName nvarchar(30) NOT NULL REFERENCES Province(PName), -- THAM CHIẾU ĐỂ KHÔNG NHẬP TỈNH KHÔNG TỒN TẠI, TỈNH AHIHI
	PRIMARY KEY (DName, PName)
)

INSERT INTO District SELECT DISTINCT District, Province FROM Locations

SELECT * FROM District

-- Hỏi thử: TP HCM có những Quận nào?
SELECT * FROM District WHERE PName = N'Thành phố Hồ Chí Minh'
SELECT * FROM District WHERE PName = N'Tỉnh Long An'

-- THÀNH PHẦN ĐÔNG DATA NHẤT LÀ WARD/PHƯỜNG/XÃ, CÓ 10581 DÒNG
-- ỨNG VỚI VÔ SỐ LẶP LẠI CÁC QUẬN, FK.
-- Xã có trùng tên không?
CREATE TABLE Ward
(
	WName nvarchar(30),
	-- xã phường ơi, bạn ở quận huyện nào?
	DName nvarchar(30)
)

SELECT * FROM Locations -- 10851 xã phường, liệu rằng có trùng không?
SELECT COUNT(DISTINCT Ward) FROM Locations -- 7884, trùng tên gần 3000 tên.
SELECT Ward FROM Locations ORDER BY Ward

INSERT INTO WARD SELECT Ward, District FROM Locations

SELECT * FROM Ward

-- CHO XEM CÁC PHƯỜNG CỦA QUẬN 1 TP. HCM
SELECT * FROM Ward WHERE DName = N'Quận 1'

-- Huyện Ba Tri của Bến Tre có những xã nào?
SELECT w.WName, w.DName, d.PName FROM Ward w INNER JOIN District d ON w.DName = d.DName WHERE d.DName = N'Huyện Ba Tri' AND d.PName = N'Tỉnh Bến Tre'