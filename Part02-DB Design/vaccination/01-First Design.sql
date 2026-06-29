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