/*
Mỗi giảng vien có thể tổ chức nhiều seminar/buổi phụ đạo khác nhau,
mà mỗi seminar/buổi phụ đạo chỉ do một giảng viên phụ trách.
Thông tin lưu trữ bao gồm: mã số giảng viên, tên giảng viên, email, phone, bộ môn (SE, CF, ITS, Incubator),
ngày giờ seminar/phụ đạo, loại hình tổ chức (seminar, phụ đạo, workshop),
chủ đề, tóm tắt nội dung, phòng học (nếu tiến hành offline),
online-link (nếu tiến hành online), sĩ số dự kiến
*/

-- CHIẾN LƯỢC: GOM 1 BẢNG
-- XEM: ĐA TRỊ, COMPOSITE, LOOKUP, LẶP LẠI TRÊN 1 NHÓM CỘT, TÁCH THÊM DÒNG TỐT HƠN THÊM CỘT (KHI CẦN THÊM DATA).

CREATE DATABASE DBDESIGN_ACTIVITIES
USE DBDESIGN_ACTIVITIES

CREATE TABLE ACTIVITY_V1
(
	LecturerID char(8),
	LectName nvarchar(30), -- composite, tách nếu muốn sort
	Email varchar(50),
	Phone char(10),
	Major varchar(30),
	StartDate datetime, -- ngày giờ bắt đầu
	ActType nvarchar(30), -- workshop, seminar, phụ đạo
	Topic nvarchar(30), -- Giới thiệu về Array List, ...
	Intro nvarchar(250),
	Room nvarchar(50), -- lưu hyperlink của Zoom, Meet, số phòng học
	Seats int,
)

INSERT INTO ACTIVITY_V1 VALUES ('00000001', N'HÒA ĐNT', 'hoadnt@gmail.com', '090x', 'CF', '2026-06-29', 'Seminar', N'Nhập môn Machine Learning', N'...', N'Phòng seminar thư viện ĐH FPT HCM', 100)

INSERT INTO ACTIVITY_V1 VALUES ('00000001', N'HÒA ĐNT', 'hoadnt@gmail.com', '090x', 'CF', '2026-06-29', 'seminar', N'Giới thiệu về YOLO V4', N'...', N'Phòng seminar thư viện ĐH FPT HCM', 100)

INSERT INTO ACTIVITY_V1 VALUES ('00000001', N'HÒA ĐNT', 'hoadnt@gmail.com', '090x', 'CF', '2026-07-01 08:00:00', 'workshop', N'Giới thiệu về YOLO V4 (part 2)', N'...', N'Phòng seminar thư viện ĐH FPT HCM', 100)

SELECT * FROM ACTIVITY_V1

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE LECTURER_V2
(
	LectID char(8) PRIMARY KEY,
	LectName nvarchar(30),
	Email varchar(50),
	Phone char(10),
	Major varchar(30)
)

CREATE TABLE ACTIVITY_V2
(
	SEQ int IDENTITY PRIMARY KEY,
	StartDate datetime,
	ActType nvarchar(30), -- cẩn thận gõ WORKSHOP, TRAINING, có mùi của LOOKUP, DROPDOWN
	Topic nvarchar(30),
	Intro nvarchar(250),
	Room nvarchar(50),
	Seats int,
	LectID char(8) REFERENCES LECTURER_V2(LectID)
)

INSERT INTO LECTURER_V2 VALUES ('00000001', N'HÒA ĐNT', 'hoadnt@gmail.com', '090x', 'CF')

INSERT INTO ACTIVITY_V2 VALUES ('2026-06-29 08:00:00', 'Seminar', N'Nhập môn Machine Learning', N'...', N'Phòng seminar thư viện ĐH FPT HCM', 100, '00000001')
INSERT INTO ACTIVITY_V2 VALUES ('2026-06-30 10:00:00', 'seminar', N'Giới thiệu về YOLO V4', N'...', N'Phòng seminar thư viện ĐH FPT HCM', 100, '00000001')
INSERT INTO ACTIVITY_V2 VALUES ('2026-07-01 14:00:00', 'workshop', N'Giới thiệu về YOLO V4 (part 2)', N'...', N'Phòng seminar thư viện FPTU HCM', 100, '00000001')

SELECT * FROM LECTURER_V2
SELECT * FROM ACTIVITY_V2