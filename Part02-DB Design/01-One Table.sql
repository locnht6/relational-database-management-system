CREATE DATABASE DBDESIGN_ONETABLE
-- CREATE DÙNG ĐỂ TẠO CẤU TRÚC LƯU TRỮ/DÀN KHUNG/THÙNG CHỨA DÙNG LƯU TRỮ DATA/INFO,
-- TƯƠNG ĐƯƠNG VIỆC XÂY PHÒNG CHỨA ĐỒ - DATABASE
-- MUA TỦ ĐỂ TRONG PHÒNG - TABLE.
-- 1 DB CHỨA NHIỀU TABLE - 1 PHÒNG CÓ NHIỀU TỦ, 1 NHÀ CÓ NHIỀU PHÒNG.
-- TẠO RA CẤU TRÚC LƯU TRỮ - CHƯA NÓI DATA BỎ VÀO - DDL (PHÂN NHÁNH CỦA SQL).

USE DBDESIGN_ONETABLE

-- Tạo table lưu trữ hồ sơ sv: mã số (phân biệt các sv với nhau), tên, dob, địa chỉ...
-- 1 SV ~~~ 1 OBJECT ~~ 1 Entity
-- 1 TABLE DÙNG LƯU TRỮ NHIỀU ENTITY

DROP TABLE StudentV1

CREATE TABLE StudentV1
(
	StudentID char(8),
	LastName nvarchar(40),  -- tại sao không gộp fullname cho rồi?
	FirstName nvarchar(10), -- n: lưu kí tự Unicode tiếng Việt
	DOB datetime,
	Address nvarchar(50)
)

-- THAO TÁC TRÊN DATA/MÓN ĐỒ TRONG TỦ/TRONG TABLE - DML/DQL (dành riêng cho SELECT)
SELECT * FROM StudentV1

-- ĐƯA DATA VÀO TABLE/MUA ĐỒ QUẦN ÁO BỎ VÀO TỦ.
INSERT INTO StudentV1 VALUES('SE123456', N'Nguyễn', N'An', '2003-01-01', N'TP Hồ Chí Minh') -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KHÔNG CHE THÔNG TIN

-- MỘT SỐ CỘT CHƯA THÈM NHẬP INFO, ĐƯỢC QUYỀN BỎ TRỐNG NẾU CỘT CHO PHÉP TRỐNG VALUE,
-- DEFAULT KHI ĐÓNG CÁI TỦ/MUA TỦ/THIẾT KẾ TỦ, MẶC ĐỊNH LÀ NULL.
INSERT INTO StudentV1 VALUES('SE123457', N'Lê', N'Bình', '2003-02-01', NULL)

-- TÊN THÀNH PHỐ LÀ NULL, WHERE = 'NULL' OKIE VÌ NÓ LÀ DATA.
-- NULL Ở CÂU TRÊN WHERE ADDRESS IS NULL.
INSERT INTO StudentV1 VALUES('SE123458', N'Võ', N'Cường', '2003-03-01', N'NULL')

-- TÔI CHỈ MUỐN LƯU VÀI INFO, KHÔNG ĐỦ SỐ CỘT, MIỄN CỘT CÒN LẠI CHO PHÉP BỎ TRỐNG.
INSERT INTO StudentV1(StudentID, LastName, FirstName) VALUES('SE123459', N'Trần', N'Dũng')

INSERT INTO StudentV1(LastName, FirstName, StudentID) VALUES(N'Trần', N'Dũng', 'SE123460')

INSERT INTO StudentV1(LastName, FirstName, StudentID) VALUES(NULL, NULL, NULL)

INSERT INTO StudentV1(LastName, FirstName, StudentID) VALUES(NULL, NULL, NULL) 
-- SIÊU NGUY HIỂM, SV TOÀN INFO BỎ TRỐNG.
-- GÀI CÁCH ĐƯA DATA VÀO CÁC CỘT SAO CHO HỢP LÍ.
-- CONSTRAINT TRÊN DATA/CELL/COLUMN.

-- CÚ NGUY HIỂM NÀY CÒN LỚN HƠN!
-- TRÙNG MÃ SỐ KHÔNG CHẤP NHẬN ĐƯỢC, KHÔNG XÁC ĐỊNH ĐƯỢC 1 SINH VIÊN.
-- GÀI RÀNG BUỘC DỮ LIỆU QUAN TRỌNG NÀY, CỘT MÀ VALUE CẤM TRÙNG TRÊN MỌI CELL CÙNG CỘT.
-- DÙNG LÀM CHÌA KHÓA/KEY ĐỂ TÌM RA/MỞ RA/XÁC ĐỊNH DUY NHẤT 1 INFO, 1 SV, 1 ENTITY, 1 OBJECT.
-- CỘT NÀY ĐƯỢC GỌI LÀ PRIMARY KEY.
INSERT INTO StudentV1(LastName, FirstName, StudentID) VALUES(N'Đỗ', N'Giang', 'SE123460')

SELECT * FROM StudentV1 WHERE StudentID = 'se123460'

-- GÀI CÁCH ĐƯA DATA VÀO TABLE ĐỂ KHÔNG CÓ NHỮNG HIỆN TƯỢNG BẤT THƯỜNG, 1 DÒNG TRỐNG TRƠN,
-- KEY TRÙNG, KEY NULL - DEFAULT THIẾT KẾ CHO PHÉP NULL TẤT CẢ.
-- GÀI - CONSTRAINTS
CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY, -- bao hàm luôn NOT NULL - bắt buộc đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL, -- (*) đó, registration/sign-up
	DOB datetime,
	Address nvarchar(50)
)	

INSERT INTO StudentV2 VALUES('SE123456', N'Nguyễn', N'An', '2003-01-01', N'TP Hồ Chí Minh')

SELECT * FROM StudentV2

-- Thử coi qua mặt được không?
INSERT INTO StudentV2(StudentID, LastName, FirstName) VALUES(NULL, NULL, NULL) -- Insert fails

INSERT INTO StudentV2(StudentID, LastName, FirstName) VALUES('AHIHI', NULL, NULL) -- Insert fails

-- Xem có được trùng mã số sv hay không?
INSERT INTO StudentV2 VALUES('SE123456', N'Nguyễn', N'An', '2003-01-01', N'TP Hồ Chí Minh') -- Insert fails

-- Thử tiếp PK
INSERT INTO StudentV2 VALUES('GD123456', N'Nguyễn', N'An', '2003-01-01', N'TP Hồ Chí Minh')

INSERT INTO StudentV2 VALUES('SE123457', N'Lê', N'Bình', '2003-02-01', NULL)

INSERT INTO StudentV2 VALUES('SE123458', N'Võ', N'Cường', NULL, NULL)

INSERT INTO StudentV2(StudentID, LastName, FirstName) VALUES('SE123460', N'Trần', N'Dũng')

INSERT INTO StudentV2 VALUES (NULL, NULL, NULL, NULL, NULL) -- gẫy 3 chỗ null

CREATE TABLE StudentV3
(
	StudentID char(8) NOT NULL PRIMARY KEY, -- bao hàm luôn NOT NULL - bắt buộc đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL, -- (*) đó, registration/sign-up
	DOB datetime NULL,
	Address nvarchar(50) NULL -- thừa từ NULL, do default là vậy
)

CREATE TABLE StudentV4
(
	StudentID char(8) NOT NULL, -- bao hàm luôn NOT NULL - bắt buộc đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL, -- (*) đó, registration/sign-up
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	PRIMARY KEY(StudentID)
)

INSERT INTO StudentV4 VALUES('SE123456', N'Nguyễn', N'An', '2003-01-01', N'TP Hồ Chí Minh')

SELECT * FROM StudentV4

-- GENERATE TỪ ERD TRONG TOOL THIẾT KẾ.
CREATE TABLE StudentV5 (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  PRIMARY KEY (StudentID)
);

INSERT INTO StudentV5 VALUES('SE123456', 'Nguyen', 'An')

SELECT * FROM StudentV5

-------------------------------------------------------------------------------------------------------
-- CONSTRAINTS - TRONG ĐÓ CÓ PK CONSTRAINT
-- Ràng buộc là cách ta/db designer ép cell/cột nào đó value phải như thế nào.
-- Đặt ra quy tắc/rule cho việc nhập data.
-- Vì có nhiều quy tắc, nên tránh nhầm lẫn, dễ kiểm soát ta sẽ có quyền đặt tên cho các quy tắc, constraint name.
-- Vd: Má ở nhà đặt quy tắc/nội quy cho mình:
-- Rule #1: Vào SG học thật tốt nha con. Tốt: điểm tb >= 8.0 && không rớt môn nào
--			&& 9 học kì ra trường && không đổi chuyên ngành.
-- Rule #2: Tối đi chơi về nhà sớm. Sớm: trong tối cùng ngày, trước 10h.
-- Rule #3: ...
-- Tên ràng buộc/quy tắc:	nội dung/cái data được gài vào.
-- PK_???						PRIMARY KEY
-- Mặc định các DB Engine tự đặt tên cho các ràng buộc nó thấy khi bạn gõ lệnh DDL.
-- DB Engine cho mình cơ chế tự đặt tên ràng buộc.

CREATE TABLE StudentV6
(
	StudentID char(8) NOT NULL, 
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	-- PRIMARY KEY(StudentID) -- tự db engine đặt tên cho ràng buộc
	CONSTRAINT PK_STUDENTV6 PRIMARY KEY (StudentID)
)

-- DÂN PRO ĐÔI KHI CÒN LÀM CÁCH SAU, NGƯỜI TA TÁCH HẲN VIỆC TẠO RÀNG BUỘC KHÓA CHÍNH, KHÓA NGOẠI
-- RA HẲN CẤU TRÚC TABLE, TỨC LÀ CREATE TABLE CHỈ CHỨA TÊN CẤU TRÚC - CỘT - DOMAIN.
-- TẠO TABLE XONG RỒI CHỈNH SỬA TABLE - SỬA CÁI TỦ CHỨ KHÔNG PHẢI DATA TRONG TỦ.

DROP TABLE StudentV7
CREATE TABLE StudentV7
(
	StudentID char(8) NOT NULL, 
	LastName nvarchar(40) NOT NULL, 
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	Address nvarchar(50) NULL,
	-- PRIMARY KEY(StudentID) -- tự db engine đặt tên cho ràng buộc
	-- CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)
)

ALTER TABLE StudentV7 ADD CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)

-- XÓA 1 RÀNG BUỘC ĐƯỢC KHÔNG, ĐƯỢC, CHO ADD THÌ CHO DROP.
ALTER TABLE StudentV7 DROP CONSTRAINT PK_STUDENTV7

ALTER TABLE StudentV2 DROP CONSTRAINT PK__StudentV__32C52A798E55472E