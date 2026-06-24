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