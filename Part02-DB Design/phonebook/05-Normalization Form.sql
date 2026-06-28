CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

CREATE TABLE PersonV5_1_
(
	Nick nvarchar(30),
	Title nvarchar(30),
	Company nvarchar(40)
)

CREATE TABLE PhoneBookV5_1_
(
	Phone char(11),
	PhoneType nvarchar(20), -- CHO GÕ TRỰC TIẾP LOẠI PHONE, GÂY NÊN LỘN XỘN LOẠI PHONE, CELL, DĐ, MOBILE, ...
							-- THỐNG KÊ KHÓ KHĂN, OR, VÀ CÒN TIẾP TỤC SỬA OR NỮA DO CHO GÕ TỰ DO.
							-- HẠN CHẾ KHÔNG CHO GÕ LỘN XỘN, TỨC LÀ PHẢI GÕ/CHỌN THEO AI ĐÓ CÓ TRƯỚC, FK
	Nick nvarchar(30) -- không cần FK, chỉ cần join vẫn được
)

CREATE TABLE PersonV5_1
(
	Nick nvarchar(30),
	Title nvarchar(30),
	Company nvarchar(40)
)

-- TABLE MỚI XUẤT HIỆN, LƯU LOẠI PHONE, KHÔNG CHO GÕ LUNG TUNG ~~~ TABLE PROVINCE, CITY, COUNTRY, SEMESTER
CREATE TABLE PhoneTypeV5_1
(
	TypeName nvarchar(20)
)


-- KHÔNG MUỐN XÓA TABLE MÀ VẪN THÊM KHÓA CHÍNH
ALTER TABLE PhoneTypeV5_1 ADD CONSTRAINT PK_PhoneTypeV5_1 PRIMARY KEY(TypeName)

ALTER TABLE PhoneTypeV5_1 ADD PRIMARY KEY(TypeName)

ALTER TABLE PhoneTypeV5_1 ALTER COLUMN TypeName nvarchar(20) NOT NULL

CREATE TABLE PhoneBookV5_1
(
	Phone char(11),
	TypeName nvarchar(20) REFERENCES PhoneTypeV5_1(TypeName),
	Nick nvarchar(30) -- không cần FK, chỉ cần join vẫn được
)

INSERT INTO PhoneTypeV5_1 VALUES (N'Di động')
INSERT INTO PhoneTypeV5_1 VALUES (N'Nhà/Để bàn')
INSERT INTO PhoneTypeV5_1 VALUES (N'Công ty')
INSERT INTO PhoneTypeV5_1 VALUES (N'Cha dượng ngọt ngào')

INSERT INTO PhoneBookV5_1 VALUES ('090x', N'Di động', N'locnht')

INSERT INTO PhoneBookV5_1 VALUES ('090x', N'Di động', N'annguyen')
INSERT INTO PhoneBookV5_1 VALUES ('091x', N'Nhà/Để bàn', N'annguyen')

INSERT INTO PhoneBookV5_1 VALUES ('092x', N'Di động', N'binhle')
INSERT INTO PhoneBookV5_1 VALUES ('091x', N'Nhà/Để bàn', N'binhle')
INSERT INTO PhoneBookV5_1 VALUES ('090x', N'Công ty', N'binhle')
INSERT INTO PhoneBookV5_1 VALUES ('092x', N'CHA DƯỢNG NGỌT NGÀO', N'binhle')

INSERT INTO PersonV5_1 VALUES (N'locnht', N'Student', N'FPTU HCM')
INSERT INTO PersonV5_1 VALUES (N'annguyen', N'Student', N'FPTU HCM')
INSERT INTO PersonV5_1 VALUES (N'binhle', N'Student', N'FPTU HL')

SELECT * FROM PhoneTypeV5_1
SELECT * FROM PersonV5_1
SELECT * FROM PhoneBookV5_1

-----------------------------------------------------------------------------------
CREATE TABLE PersonV5
(
	Nick nvarchar(30) PRIMARY KEY, -- CÒN CẦN BÀN THÊM VỀ PK/PERFORMANCE
	Title nvarchar(30),
	Company nvarchar(40)
)

-- TABLE MỚI XUẤT HIỆN, LƯU LOẠI PHONE, KHÔNG CHO GÕ LUNG TUNG ~~~ TABLE PROVINCE, CITY, COUNTRY, SEMESTER
CREATE TABLE PhoneTypeV5
(
	TypeName nvarchar(20) NOT NULL, -- CÒN CẦN BÀN THÊM VỀ PK/PERFORMANCE
	PRIMARY KEY(TypeName)
)

CREATE TABLE PhoneBookV5
(
	Phone char(11) NOT NULL,										    -- số điện thoại là số mấy
	TypeName nvarchar(20) REFERENCES PhoneTypeV5(TypeName), -- thuộc loại gì
	Nick nvarchar(30) REFERENCES PersonV5(Nick),			-- của ai
	CONSTRAINT PK_PHONEBOOKV5 PRIMARY KEY(Phone)
) -- loại gì & của ai, không gõ lung tung