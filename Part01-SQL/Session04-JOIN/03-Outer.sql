USE Cartesian

-- 1. Liệt kê cho tôi các cặp từ điển Anh-Việt.
SELECT * FROM EnDict e, VnDict v WHERE e.Nmbr = v.Nmbr -- Có bằng cell thì mới ghép.

SELECT * FROM EnDict e INNER JOIN VnDict v ON e.Nmbr = v.Nmbr -- hãy ghép đi, trên cột này có cell/value này = cell/value bên kia
SELECT * FROM EnDict e JOIN VnDict v ON e.Nmbr = v.Nmbr

-- 2. Hụt mất của tui từ 4 - Four và 5 - Năm khong thấy xuất hiện!
-- Muốn xuất hiện 4Four và 5Nam thì tích Đề-các.
SELECT * FROM EnDict e, VnDict v

SELECT * FROM EnDict
SELECT * FROM VnDict

-- 3. Tui muốn xuất hiện lấy tiếng Anh làm chuẩn, tìm các nghĩa tiếng việt tương đương.
-- Nếu không có tương đương vẫn phát hiện ra.
SELECT * FROM EnDict e LEFT JOIN VnDict v ON e.Nmbr = v.Nmbr

SELECT * FROM EnDict e LEFT OUTER JOIN VnDict v ON e.Nmbr = v.Nmbr

-- 4. Tui muốn lấy tiếng Việt làm đầu!!!
SELECT * FROM VnDict v LEFT OUTER JOIN EnDict e ON e.Nmbr = v.Nmbr

-- Vẫn lấy tiếng Việt làm đầu, nhưng để tiếng Việt bên tay phải.
SELECT * FROM EnDict e RIGHT JOIN VnDict v ON e.Nmbr = v.Nmbr

SELECT * FROM EnDict e RIGHT OUTER JOIN VnDict v ON e.Nmbr = v.Nmbr

-- 5. Dù chung và riêng của mỗi bên, lấy tất cả, chấp nhận FA ở 1 vế.
SELECT * FROM EnDict e FULL OUTER JOIN VnDict v ON e.Nmbr = v.Nmbr

SELECT * FROM EnDict e FULL JOIN VnDict v ON e.Nmbr = v.Nmbr

SELECT * FROM VnDict v FULL JOIN EnDict e ON e.Nmbr = v.Nmbr
-- FULL OUTER JOIN, THỨ TỰ TABLE KHÔNG QUAN TRỌNG, VIẾT TRƯỚC SAU ĐỀU ĐƯỢC.
-- LEFT, RIGHT JOIN THỨ TỰ TABLE LÀ CÓ CHUYỆN KHÁC NHAU.

SELECT * FROM EnDict e LEFT JOIN VnDict v ON e.Nmbr = v.Nmbr -- SHOW 4 NULL

SELECT * FROM VnDict v LEFT JOIN EnDict e ON e.Nmbr = v.Nmbr -- SHOW 5 NULL

-- OUTER JOIN SINH RA ĐỂ ĐẢM BẢO VIỆC KẾT NỐI GHÉP BẢNG KHÔNG BỊ MẤT MÁT DATA!!!
-- DO INNER JOIN, JOIN = CHỈ TÌM CÁI CHUNG 2 BÊN.

-- SAU KHI TÌM RA ĐƯỢC DATA CHUNG RIÊNG, TA VẪN CÓ QUYỀN FILTER TRÊN LOẠI CELL NÀO ĐÓ, WHERE NHƯ BÌNH THƯỜNG.

-- 6. In ra bộ từ điển Anh Việt (Anh làm chuẩn) của những con số từ 3 trở lên.
SELECT * FROM EnDict e LEFT JOIN VnDict v ON e.Nmbr = v.Nmbr WHERE e.Nmbr >= 3

SELECT * FROM EnDict e LEFT JOIN VnDict v ON e.Nmbr = v.Nmbr WHERE v.Nmbr >= 3

-- 7. In ra bộ từ điển Anh Việt Việt Ạnh của những con số từ 3 trở lên.
SELECT * FROM EnDict e FULL JOIN VnDict v ON e.Nmbr = v.Nmbr WHERE e.Nmbr >= 3 -- toang, mất số 5 của tiếng Việt

SELECT * FROM EnDict e FULL JOIN VnDict v ON e.Nmbr = v.Nmbr WHERE v.Nmbr >= 3 -- có 5 mất 4

SELECT * FROM EnDict e FULL JOIN VnDict v ON e.Nmbr = v.Nmbr WHERE v.Nmbr >= 3 OR e.Nmbr >= 3

--------------------------------------------------------------------------------------------------------

CREATE DATABASE StudentManagement

USE StudentManagement

CREATE TABLE Major
(
	MajorID char(2) PRIMARY KEY,         -- PK Primary Key - Khóa chính
	MajorName varchar(30),
	Hotline varchar(11)
)

INSERT INTO Major VALUES('SE', 'Software Engineering', '090x')
INSERT INTO Major VALUES('IA', 'Information Assurance', '091x')
INSERT INTO Major VALUES('GD', 'Graphic Design', '092x')
INSERT INTO Major VALUES('JP', 'Japanese', '093x')
INSERT INTO Major VALUES('KR', 'Korean', '094x')

SELECT * FROM Major

DROP TABLE Student
CREATE TABLE Student
(
	StudentID char(8) PRIMARY KEY,          -- PK Primary Key - Khóa chính
	LastName nvarchar(30),
	FirstName nvarchar(10),
	DOB date,
	Address nvarchar(50), 
	MajorID char(2) REFERENCES Major(MajorID)  -- FK Foreign Key - Khóa ngoại
)

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE1', N'Nguyễn', N'Một', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE2', N'Lê', N'Hai', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE3', N'Trần', N'Ba', 'SE');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE4', N'Phạm', N'Bốn', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE5', N'Lý', N'Năm', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('SE6', N'Võ', N'Sáu', 'IA');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD7', N'Đinh', N'Bảy', 'GD');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('GD8', N'Huỳnh', N'Tám', 'GD');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID) VALUES('JP9', N'Ngô', N'Chín', 'JP');

-- 1. In ra thông tin chi tiết của SV kèm thông tin chuyên ngành.
SELECT * FROM Student		-- info tắt của chuyên ngành
SELECT * FROM Major	-- chỉ có info chuyên ngành, thiếu info sv
-- JOIN cầm chắc rồi, lấy info đang nằm ở bên kia ghép thêm theo chiều ngang
SELECT * FROM Student s, Major m WHERE s.MajorID = m.MajorID -- dư cột MajorID

SELECT s.*, m.MajorName, m.Hotline FROM Student s, Major m WHERE s.MajorID = m.MajorID -- 9 rows

SELECT s.*, m.MajorName, m.Hotline FROM Student s JOIN Major m ON s.MajorID = m.MajorID -- 9 rows

-- 2. In ra thông tin chi tiết của SV kèm info chuyên ngành. Chỉ quan tâm SV SE và IA.
SELECT s.*, m.MajorName, m.Hotline FROM Student s JOIN Major m ON s.MajorID = m.MajorID WHERE s.MajorID IN ('SE', 'IA') -- 6 rows

SELECT s.*, m.MajorID, m.MajorName, m.Hotline FROM Student s, Major m WHERE s.MajorID = m.MajorID AND m.MajorID IN ('SE', 'IA') -- 6 rows


-- 3. In ra thông tin các sinh viên kèm chuyên ngành. Chuyên ngành nào chưa có SV cũng in ra luôn.
-- Phân tích: căn theo SV mà in, thì HÀN QUỐC không xuất hiện.
SELECT s.*, m.* FROM Student s RIGHT JOIN Major m ON s.MajorID = m.MajorID -- 10 rows

SELECT s.*, m.* FROM Major m LEFT JOIN Student s ON s.MajorID = m.MajorID -- 10 rows, KOREAN FA NULL

SELECT s.*, m.* FROM Student s LEFT JOIN Major m ON s.MajorID = m.MajorID -- 9 rows, KOREAN biến mất

-- 4. Có bao nhiêu chuyên ngành?
SELECT * FROM Major

SELECT COUNT(*) AS [No majors] FROM Major
SELECT COUNT(MajorID) AS [No majors] FROM Major

-- 5. Mỗi chuyên ngành có bao nhiêu sinh viên?
-- output 0: số lượng sv đang theo học của từng chuyên ngành
-- output 1: mã CN | số lượng sv đang theo học
-- phân tích: hỏi sv, bao nhiêu sv, đếm sv! gặp thêm từ mỗi! mỗi chuyên ngành có 1 con số đếm, đếm theo chuyên ngành, chia nhóm chuyên ngành mà đếm!
SELECT * FROM Student

SELECT MajorID, COUNT(*) AS [No students] FROM Student GROUP BY MajorID -- 4 rows

SELECT MajorID, COUNT(MajorID) AS [No students] FROM Student GROUP BY MajorID -- 4 rows

-- 6. Chuyên ngành nào có từ 3 SV trở lên?
-- phân tích: chia chặng rồi, đầu tiên phải đếm chuyên ngành đã, quét qua bảng 1 lần để đếm ra sv,
-- đếm xong, dợt lại kết quả, lọc thêm cái từ 3 sv trở lên, phải đếm xong từng ngành rồi mới tính tiếp.
SELECT MajorID, COUNT(*) AS [No students] FROM Student GROUP BY MajorID HAVING COUNT(*) >= 3 -- 2 rows


-- 7. Chuyên ngành nào có ít sv nhất?
SELECT MajorID, COUNT(*) AS [No students] FROM Student GROUP BY MajorID HAVING COUNT(*) = 1 -- ĂN ĐÒN

SELECT MajorID, COUNT(MajorID) AS [No students] FROM Student GROUP BY MajorID HAVING COUNT(MajorID) <= ALL (SELECT COUNT(MajorID) FROM Student GROUP BY MajorID) -- JP

SELECT MajorID, COUNT(*) AS [No students] FROM Student GROUP BY MajorID HAVING COUNT(*) <= ALL (SELECT COUNT(*) FROM Student GROUP BY MajorID) -- JP

-- 8. Đếm sv của chuyên ngành SE.
-- phân tích: câu này không hỏi đếm các chuyên ngành.
SELECT COUNT(*) FROM Student WHERE MajorID = 'SE' -- câu này chạy nhanh

SELECT MajorID, COUNT(MajorID) AS [No students] FROM Student GROUP BY MajorID HAVING MajorID = 'SE' -- câu này chạy chậm

SELECT MajorID, COUNT(*) AS [No students] FROM Student WHERE MajorID = 'SE' GROUP BY MajorID -- chỉ còn lại 1 nhóm

-- 9. Đếm số SV của mỗi chuyên ngành
-- output: mã chuyên ngành, tên chuyên ngành, số lượng SV
-- phân tích: đáp án cần có info của 2 table, đếm trên 2 table, đếm trong Major không có info sv, đếm trong sv chỉ có được mã chuyên ngành,
-- muốn có mã chuyên ngành, tên chuyên ngành, số lượng sv -> JOIN 2 bảng rồi mới đếm.
SELECT s.StudentID, s.FirstName, m.MajorID, m.MajorName FROM Student s INNER JOIN Major m ON s.MajorID = m.MajorID

SELECT m.MajorID, m.MajorName, COUNT(*) AS [No students] FROM Student s INNER JOIN Major m ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName

-- 10. Câu 10 điểm nè.
-- thế còn chuyên ngành Hàn Quốc đâu rồi?
SELECT s.StudentID, s.FirstName, m.MajorID, m.MajorName FROM Student s RIGHT JOIN Major m ON s.MajorID = m.MajorID

SELECT m.MajorID, m.MajorName, COUNT(*) AS [No students] FROM Student s RIGHT JOIN Major m ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName 
-- Sai vì có 1 dòng HQ FA, NULL về SV
-- COUNT(1) có 1 dòng FA, HQ có 1 SV là sai

SELECT m.MajorID, m.MajorName, COUNT(s.MajorID) AS [No students] FROM Student s RIGHT JOIN Major m ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName

SELECT m.MajorID, m.MajorName, COUNT(StudentID) AS [No students] FROM Student s RIGHT JOIN Major m ON s.MajorID = m.MajorID GROUP BY m.MajorID, m.MajorName
-- COUNT NULL lại đúng trong trường hợp này, vì mã SV NULL ứng với chuyên ngành HQ.
-- COUNT(*) chỉ cần có dòng là ra số 1, chấp dòng có nhiều NULL hay không.
-- Đếm cell mà cell NULL -> 0

-- DASH BOARD MÀN HÌNH THỐNG KÊ CỦA ADMIN WEBSITE TUYỂN SINH.