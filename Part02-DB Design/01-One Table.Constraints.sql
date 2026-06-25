-- PHẦN NÀY THÍ NGHIỆM CÁC LOẠI RÀNG BUỘC - CONSTRAINTS - QUY TẮC GÀI TRÊN DATA.

-- 1. RÀNG BUỘC PRIMARY KEY.
-- Tạm thời chấp nhận PK là 1 cột (tương lai có thể nhiều cột) mà giá trị của nó trên mọi dòng/mọi cell của cột này không trùng lại,
-- mục đích dùng để WHERE ra được 1 dòng duy nhất.
-- VALUE CỦA KEY CÓ THỂ ĐƯỢC TẠO RA THEO 2 CÁCH:
-- CÁCH 1: TỰ NHẬP = TAY, DB ENGIN SẼ TỰ KIỂM TRA GIÙM MÌNH CÓ TRÙNG HAY KHÔNG?
--		   NẾU TRÙNG DB ENGINE TỰ BÁO VI PHẠM PK CONSTRAINT

-- CÁCH 2: KHÔNG CẦN NHẬP = TAY CÁI VALUE CỦA PK, MÁY/DB ENGINE TỰ GENERATE CHO MÌNH 1 CON SỐ KHÔNG TRÙNG LẠI! CON SỐ TỰ TĂNG, CON SỐ HEXA...

-- THỰC HÀNH
-- Thiết kế table lưu thông tin đăng kí event nào đó (giống đăng kí qua Google Form)
-- thông tin cần lưu trữ: số thứ tự đăng ki, tên full name, email, ngày giờ đăng kí, số di động....
-- Phân tích:
-- ngày giờ đăng kí: không bắt nhập, default
-- số thứ tự: nhập vào là bậy rồi!!! tự gán chứ!!!
-- email, phone: không cho trùng heng, 1 email 1 lần là được
-- ...
USE DBDESIGN_ONETABLE

/*
CREATE TABLE Registration
(
	SEQ int PRIMARY KEY, -- PHẢI TỰ NHẬP SỐ THỨ TỰ, VỚ VẨN
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50), -- CẤM TRÙNG LÀM SAO?
	Phone varchar(11),
	RegDate datetime DEFAULT GETDATE() -- CONSTRAINT DEFAULT
)
*/

CREATE TABLE Registration
(
	SEQ int PRIMARY KEY IDENTITY, -- Mặc định đi từ 1, nhảy ++ cho người sau, IDENTITY(1, 5) từ 1, 6, 11, ...
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50),
	Phone varchar(11),
	RegDate datetime DEFAULT GETDATE()
)
-- ĐĂNG KÍ EVENT
INSERT INTO Registration VALUES (N'An', N'Nguyễn', 'an@gmail.com', '090x')
-- báo lỗi do không map được các cột rõ ràng

INSERT INTO Registration VALUES (N'An', N'Nguyễn', 'an@gmail.com', '090x', NULL)

INSERT INTO Registration(FirstName, LastName, Email, Phone) VALUES (N'Bình', N'Lê', 'binh@gmail.com', '091x')

SELECT * FROM Registration

-- XÓA 1 DÒNG CÓ AUTO GENERATED KEY, THÌ TABLE SẼ LỦNG SỐ, DB ENGINE KHÔNG LẤP CHỖ LỦNG.
-- 1 2 3 4 5 6, XÓA 3, 1 2 4 5 6, ĐĂNG KÍ TIẾP TÍNH TỪ 7.

-- GENERATED FROM TOOL
CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID)
);

CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  LastName  varchar(40) NOT NULL, 
  MajorID   char(2) NOT NULL, 
  PRIMARY KEY (StudentID)
);

ALTER TABLE Student ADD CONSTRAINT FKStudent939401 FOREIGN KEY (MajorID) REFERENCES Major (MajorID) ON UPDATE Cascade ON DELETE Set null;

-- GENERATED FROM TOOL FOR MySQL
CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID)
);
CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  LastName  varchar(40) NOT NULL, 
  MajorID   char(2) NOT NULL, 
  PRIMARY KEY (StudentID)
);
ALTER TABLE Student ADD CONSTRAINT FKStudent939401 FOREIGN KEY (MajorID) REFERENCES Major (MajorID) ON UPDATE Cascade ON DELETE Set null;