-- THIẾT KẾ ĐẦU TIÊN: GOM TẤT CẢ TRONG 1 TABLE.
-- Đặc điểm chính là cột, value đặc điểm chính là cell.
-- Thông tin chích ngừa bao gồm: tên: An Nguyễn, cccd: 123456789...

CREATE DATABASE DBDESIGN_VACCINATION
USE DBDESIGN_VACCINATION

CREATE TABLE VaccinationV1
(
	ID char(12) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10), -- sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, -- constraint, cấm trùng nhưng không phải là PK
									   -- key ứng viên, candidate key
	InjectionInfo nvarchar(255)
)
-- Cách thiết kế này lưu trữ các mũi chích vaccine của mình được không? ĐƯỢC.

INSERT INTO VaccinationV1 VALUES('000000000001', N'NGUYỄN', N'AN', '090x', N'AZ Ngày 29.06.2026 ĐH FPT | AZ Ngày 29.07.2026 BV Lê Văn Việt, TP. HCM')

SELECT * FROM VaccinationV1

-- PHÂN T ÍCH:
-- ƯU ĐIỂM: DỄ LƯU TRỮ, SELECT CÓ NGAY, đa trị tốt trong vụ này.
-- NHƯỢC ĐIỂM: THỐNG KÊ KHÔNG ĐƯỢC, ÍT NHẤT ĐI CẮT CHUỖI, CĂNG DO ĐA TRỊ!

-- SOLUTION: CẦN QUAN TÂM THỐNG KÊ, TÍNH TOÁN SỐ LIỆU (BAO NHIÊU MŨI, AZ CÓ BAO NHIÊU NGƯỜI DÙNG...)
-- TÁCH CỘT, TÁCH BẢNG.

CREATE TABLE VaccinationV2
(
	ID char(12) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10), -- sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, -- constraint, cấm trùng nhưng không phải là PK
									   -- key ứng viên, candidate key
	Dose1 nvarchar(100), -- AZ, Astra... 29.06.2026 - COMPOSITE (phức hợp)
	Dose2 nvarchar(100)  -- AZ, Astra...
)

-- PHÂN TÍCH:
-- ƯU ĐIỂM: gọn gàng, select gọn gàng.
-- NHƯỢC ĐIỂM: NULL! THÊM MŨI NHẮC 3, 4 HÀNG NĂM THÌ SAO?
-- CHỈ VÌ VÀI NGƯỜI MÀ TA PHẢI CHỪA CHỖ NULL.
-- THỐNG KÊ! CỘT COMPOSITE CHƯA CHO MÌNH ĐƯỢC THỐNG KÊ.

-- MULTI-VALUED CELL: MỘT CELL CHỨA NHIỀU INFO ĐỘC LẬP BÌNH ĐẲNG VỀ NGỮ NGHĨA.
-- Vd: Address: 1/1 Lê Lợi, Q.1, TP.HCM; 1/1 Man Thiện, TP.HCM
--					thường trú					tạm trú
-- GÓI COMBO, NHIỀU ĐỒ TRONG 1 CELL.
-- ĐỌC: CÓ 2 ĐỊA CHỈ.

-- COMPOSITE VALUE CELL: Một value duy nhất, mỗi value này gom nhiều miếng nhỏ hơn,
--						 nhiều biến nhỏ hơn, mỗi miếng có 1 vai trò riêng,
--						 gom chung lại thành 1 thứ khác.
-- Vd: Address: 1/1 Man Thiện, TP.HCM
--	   FullName: Ngô Huỳnh Tấn Lộc -> tên gọi đầy đủ
--				 Last   Mid	   First

-- VÌ SỐ LẦN CHÍNH CÒN CÓ THỂ GIA TĂNG CHO TỪNG NGƯỜI, MŨI 2, MŨI NHẮC, MŨI THƯỜNG NIÊN,
-- AI CHÍCH NHIỀU THÌ NHIỀU DÒNG, HAY HƠN HẲN.

CREATE TABLE PersonV3
(
	ID char(12) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10), 
	Phone varchar(11) NOT NULL UNIQUE
)

-- COMPOSITE GỘP N INFO VÀO TRONG 1 CELL, DỄ, NHANH LÀ ƯU ĐIỂM, NHẬP 1 CHUỖI DÀI LÀ XONG,
-- NHƯỢC ĐIỂM: KHÔNG THỐNG KÊ TỐT, KHÔNG SORT ĐƯỢC. FullName sort làm sao?
-- COMPOSITE SẼ TÁCH CỘT, VÌ MÌNH ĐÃ CỐ TRƯỚC ĐÓ GOM N THỨ KHÁC NHAU ĐỂ LÀM RA 1 THỨ KHÁC,
-- TÁCH CỘT TRẢ LẠI ĐÚNG NGỮ NGHĨA CHO TỪNG THẰNG.
CREATE TABLE VaccinationV3
(
	Dose nvarchar(100),
	PersonID char(12) FOREIGN KEY REFERENCES PersonV3(ID)
)

-- PHÂN TÍCH
-- ƯU ĐIỂM: CHÍCH THÊM NHÁT NÀO, THÊM DÒNG NHÁT ĐÓ, CHẤP 10 MŨI ĐỦ CHỖ LƯU, KHÔNG ẢNH HƯỞNG NGƯỜI CHƯA CHÍCH.
-- NHƯỢC: THỐNG KÊ KHÔNG ĐƯỢC.
-- COMPOSITE TÁCH TIẾP THÀNH NHIỀU CỘT, TRẢ LẠI ĐÚNG Ý NGHĨA CHO TỪNG MIẾNG INFO NHỎ.

CREATE TABLE PersonV4
(
	ID char(12) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10), 
	Phone varchar(11) NOT NULL UNIQUE
)

CREATE TABLE VaccinationV4
(
	Dose int, -- liều chích số 1
	InjDate datetime, -- giờ chích
	Vaccine nvarchar(50), -- tên vaccine
	Lot nvarchar(20),
	[Location] nvarchar(50),
	PersonID char(12) FOREIGN KEY REFERENCES PersonV4(ID)
)

INSERT INTO PersonV4 VALUES('000000000001', N'NGUYỄN', N'AN', '091x')
INSERT INTO PersonV4 VALUES('000000000002', N'LÊ', N'BÌNH', '090x')

INSERT INTO VaccinationV4 VALUES(1, GETDATE(), 'AZ', NULL, NULL, '000000000001')

SELECT * FROM PersonV4
SELECT * FROM VaccinationV4

-- IN RA XANH VÀNG CHO MỖI NGƯỜI.
SELECT * FROM PersonV4 p LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID

SELECT p.ID, p.FirstName, COUNT(*) AS [No Does] FROM PersonV4 p LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID GROUP BY p.ID, p.FirstName
-- COUNT(*)!!! BÌNH CÓ 1 DÒNG NULL.

SELECT p.ID, p.FirstName, COUNT(v.Dose) AS [No Does] FROM PersonV4 p LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID GROUP BY p.ID, p.FirstName

-- ĂN TIỀN XANH ĐỎ
SELECT p.ID, p.FirstName, IIF(COUNT(v.Dose) = 0, 'NOOP', IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN')) AS [No Does] FROM PersonV4 p LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID GROUP BY p.ID, p.FirstName

INSERT INTO VaccinationV4 VALUES(2, GETDATE(), 'AZ', NULL, NULL, '000000000001')

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PHÂN TÍCH
-- Cột Vaccine cho phép gõ các giá trị tên Vaccine một cách tự do -> Inconsistency
-- Az, Astra, AstraZeneca, Astra Zeneca, ...
-- >>> Có mùi của dropdown, mùi của combo box >>> Lookup table
-- không cho gõ mà cho chọn từ danh sách có sẵn, tham chiếu từ danh sách có sẵn.
-- Vaccine phải tách thành table CHA, table 1, ĐÁM CON ĐÁM N PHẢI REFERENCE VỀ.

CREATE TABLE PersonV5
(
	ID char(12) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10), 
	Phone varchar(11) NOT NULL UNIQUE
)

CREATE TABLE VaccineV5
(
	VaccineName varchar(30) PRIMARY KEY,
	-- hãng sx, địa chỉ hãng, thông tin về lâm sàng...
)
-- PRIMARY KEY MÀ LÀ VARCHAR() LÀM GIẢM HIỆU NĂNG VỀ THỰC THI QUERY, CHẠY CHẬM.
-- THƯỜNG NGƯỜI TA SẼ CHỌN PK LÀ CON SỐ LÀ TỐT NHẤT, TỐT NHÌ LÀ CHAR.

CREATE TABLE VaccinationV5
(
	SEQ int IDENTITY PRIMARY KEY, -- CỨ TĂNG MÃI MÃI ĐI, HƠN 2 TỶ 1 LẦN CHÍCH
	Dose int, -- liều chích số 1, 2 có thể lặp lại cho mỗi Person, không thể là PK
	InjDate datetime, -- giờ chích
	Vaccine varchar(30) REFERENCES VaccineV5(VaccineName), 
	-- tên vaccine KHÔNG CHO GÕ TỰ DO, PHẢI THAM CHIẾU
	Lot nvarchar(20),
	[Location] nvarchar(50), -- nơi chích bản chất là COMPOSITE, TÁCH THÀNH CỘT CITY, PHƯỜNG/XÃ.
							 -- LẠI ALF LOOKUP NẾU MUỐN, ĐỂ KHÔNG GÕ LUNG TUNG, THỐNG KÊ TIỆN TỪNG ĐƠN VỊ.
	PersonID char(12) FOREIGN KEY REFERENCES PersonV5(ID),
	
	-- FOREIGN KEY (Vaccine) REFERENCES VaccineV5(VaccineName),
	-- CONSTRAINT FK_VCN_VC FOREIGN KEY (Vaccine) REFERENCES VaccineV5(VaccineName)
)

-- CHỐT HẠ: TÁCH ĐA TRỊ, HAY COMPOSITE DỰA TRÊN NHU CẦU THỐNG KÊ NẾU CÓ CỦA DỮ LIỆU TA LƯU TRỮ.
-- GOM BẢNG -> TÌM ĐA TRỊ, TÌM COMPOSITE, TÌM LOOKUP TÁCH THEO NHU CẦU!

INSERT INTO VaccineV5 VALUES('AstraZeneca')
INSERT INTO VaccineV5 VALUES('Pfizer')
INSERT INTO VaccineV5 VALUES('Verocell')
INSERT INTO VaccineV5 VALUES('Moderna')

INSERT INTO PersonV5 VALUES('000000000001', N'NGUYỄN', N'AN', '091x')
INSERT INTO PersonV5 VALUES('000000000002', N'LÊ', N'BÌNH', '090x')

INSERT INTO VaccinationV5 VALUES(1, GETDATE(), 'AstraZeneca', NULL, NULL, '000000000001')		-- OK
INSERT INTO VaccinationV5 VALUES(2, '2027-06-29', 'AstraZeneca', NULL, NULL, '000000000001')	-- OK
INSERT INTO VaccinationV5 VALUES(3, '2028-06-29', 'AZ', NULL, NULL, '000000000001')				-- THẤT BẠI vì không có loại vaccine gõ tay AZ
-- SEQ tăng nó thành số 3 và bị thất bại!

INSERT INTO VaccinationV5 VALUES(1, GETDATE(), 'Verocell', NULL, NULL, '000000000002')		-- OK

SELECT * FROM VaccineV5
SELECT * FROM VaccinationV5
SELECT * FROM PersonV5

-- THỐNG KÊ ĐƯỢC NHỮNG GÌ?
-- 1. Có bao nhiêu mũi vaccine AZ đã được chích (chích bao nhát, không quan tâm người nào).
-- Output: loại vaccine, tổng số mũi đã chich.
SELECT v.VaccineName, COUNT(vc.Dose) AS [Total] FROM VaccineV5 v LEFT JOIN VaccinationV5 vc ON v.VaccineName = vc.Vaccine WHERE  v.VaccineName = 'AstraZeneca' GROUP BY v.VaccineName

-- 2. Ngày 29-06-2026 có bao nhiêu mũi đã được chích.
-- Output: ngày, tổng số mũi đã chích.
SELECT CONVERT(date, vc.InjDate) AS [Date], COUNT(vc.Dose) AS [Total] FROM VaccineV5 v RIGHT JOIN VaccinationV5 vc ON v.VaccineName = vc.Vaccine WHERE CONVERT(date, vc.InjDate) = '2026-06-29' GROUP BY CONVERT(date, vc.InjDate)

-- 3. Thống kê số mũi chích của mỗi cá nhân.
-- Output: CCCD, Tên (full), di động, số mũi đã chích (0, 1, 2, 3).
SELECT p.ID, p.LastName + ' ' + p.FirstName AS [Full Name], p.Phone, COUNT(vc.Dose) AS [No vaccines] FROM PersonV5 p LEFT JOIN VaccinationV5 vc ON p.ID = vc.PersonID GROUP BY p.ID, p.FirstName, p.LastName, p.Phone

-- 4. In ra thông tin chích của mỗi cá nhân.
-- Output: CCCD, Tên (full), di động, số mũi đã chích (0, 1, 2, 3), MÀU SẮC.
SELECT p.ID, p.LastName + ' ' + p.FirstName AS [Full Name], p.Phone, COUNT(vc.Dose) AS [No vaccines], IIF(COUNT(vc.Dose) = 0, 'NOOP', IIF(COUNT(vc.Dose) = 1, 'YELLOW', 'GREEN')) AS [Status] FROM PersonV5 p LEFT JOIN VaccinationV5 vc ON p.ID = vc.PersonID GROUP BY p.ID, p.FirstName, p.LastName, p.Phone

-- 5. Có bao nhiêu công dân đã chích ít nhất 1 vaccine.
SELECT p.ID, p.LastName + ' ' + p.FirstName AS [Full Name], p.Phone, COUNT(vc.Dose) AS [No vaccines] FROM PersonV5 p LEFT JOIN VaccinationV5 vc ON p.ID = vc.PersonID GROUP BY p.ID, p.FirstName, p.LastName, p.Phone HAVING COUNT(vc.Dose) >= 1

-- 6. Những công dân nào chưa chích mũi nào?
-- Output: CCCD, Tên.
SELECT p.ID, p.LastName + ' ' + p.FirstName AS [Full Name], COUNT(vc.Dose) AS [No vaccines] FROM PersonV5 p LEFT JOIN VaccinationV5 vc ON p.ID = vc.PersonID GROUP BY p.ID, p.FirstName, p.LastName HAVING COUNT(vc.Dose) = 0

-- 7. Công dân có CCCD 000000000001 đã chích những mũi nào.
-- Output: CCCD, Tên, thông tin chích (in gộp + chuỗi, tái nhập composite).
SELECT p.ID, p.LastName + ' ' + p.FirstName AS [Full Name], N'Lần: ' + CONVERT(nvarchar, vc.Dose) + N' | Loại: ' + vc.Vaccine + N' | Ngày: ' + CONVERT(nvarchar, vc.InjDate) AS [Info] FROM PersonV5 p LEFT JOIN VaccinationV5 vc ON p.ID = vc.PersonID WHERE p.ID = '000000000001'


-- 8. Thống kê số mũi vaccine đã chích của mỗi loại vaccine.
SELECT * FROM VaccinationV5 -- Chỉ thấy Verocell và Az không à, mất tiêu Moderna, Pfizer.

SELECT * FROM VaccineV5 v INNER JOIN VaccinationV5 vc ON v.VaccineName = vc.Vaccine -- chả khác câu trên vì JOIN =

SELECT * FROM VaccineV5 v LEFT JOIN VaccinationV5 vc ON v.VaccineName = vc.Vaccine

SELECT v.VaccineName, COUNT(*) AS [No] FROM VaccineV5 v LEFT JOIN VaccinationV5 vc ON v.VaccineName = vc.Vaccine GROUP BY v.VaccineName
-- SAI, COUNT(*) là toang cho thằng chơi hệ LEFT do có 1 dòng Pfizer và Moderna chủ yếu NULL do chưa ai chích, NHỚ COUNT(*) KHÁC COUNT(NULL).

SELECT v.VaccineName, COUNT(vc.Dose) AS [No] FROM VaccineV5 v LEFT JOIN VaccinationV5 vc ON v.VaccineName = vc.Vaccine GROUP BY v.VaccineName
-- WHERE DATE CHÍCH LÀ THỐNG KÊ THEO NGÀY, PHƯỜNG/XÃ NỮA LÀ THỐNG KÊ THEO PHƯỜNG/XÃ.