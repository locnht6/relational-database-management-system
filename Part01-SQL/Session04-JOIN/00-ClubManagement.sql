USE ClubManagement

-- 1. Liệt kê thông tin sinh viên đang theo học.
SELECT * FROM Student

-- 2. Liệt kê thông tin sinh viên đang theo học kèm theo CLB bạn í đang tham gia.
-- Output 1: Mã sv, tên sv, mã clb
-- Output 2: Mã sv, tên sv, mã clb, tên clb

SELECT * FROM Student s JOIN Registration r ON s.StudentID = r.StudentID -- ghép 2 table để sát nhau, nhiều cột

SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full Name], r.ClubID FROM Student s JOIN Registration r ON s.StudentID = r.StudentID --  rút bớt cột
-- Thiếu 2 sinh viên 4 và 5 vì JOIN =.

SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full Name], r.ClubID FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID -- 9 rows

-- 3. In ra thông tin tham gia clb của các sv.
-- Output: mã sv, tên sv, mã clb, tên clb, joined date
SELECT * FROM Student s JOIN Registration r ON s.StudentID = r.StudentID JOIN Club c ON r.ClubID = c.ClubID -- 7 rows

SELECT s.StudentID, s.FirstName, c.ClubID, c.ClubName, r.JoinedDate FROM Student s JOIN Registration r ON s.StudentID = r.StudentID JOIN Club c ON r.ClubID = c.ClubID -- 7 rows
-- Vấn đề lớn: mất 2 bạn sv 4 và 5, mất luôn cả clb FCODE và FEV

SELECT * FROM Student
SELECT * FROM Club

SELECT s.StudentID, s.FirstName, c.ClubID, c.ClubName, r.JoinedDate FROM Student s, Registration r, Club c WHERE s.StudentID = r.StudentID AND r.ClubID = c.ClubID
-- Viết kiểu này không lấy được phần hụt, vì nó chỉ đi tìm đám bằng nhau common field.
-- Ghép và in ra, thằng nào không bằng, hụt, không quan tâm.

-- JOIN SẼ GIÚP, VÌ NÓ NHÌN LUÔN PHẦN CHUNG VÀ PHẦN HỤT.
SELECT s.StudentID, s.FirstName, c.ClubID, c.ClubName, r.JoinedDate FROM Student s FULL JOIN Registration r ON s.StudentID = r.StudentID FULL JOIN Club c ON r.ClubID = c.ClubID -- 11 rows

-- BTVN
-- 1. Đếm số CLB mà mỗi SV đã tham gia.
-- Output: mã sv, tên sv, số-clb-tham-gia.
SELECT * FROM Student
SELECT * FROM Registration
SELECT s.StudentID, s.LastName, s.FirstName, COUNT(r.ClubID) AS [No clubs] FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID GROUP BY s.StudentID, s.LastName, s.FirstName

-- 2. Sinh viên SE1 tham gia mấy CLB.
-- Output: mã sv, tên sv, số-clb-tham-gia.
SELECT s.StudentID, s.LastName, s.FirstName, COUNT(r.ClubID) AS [No clubs] FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID WHERE s.StudentID = 'SE1' GROUP BY s.StudentID, s.LastName, s.FirstName

-- 3. SV nào tham gia nhiều clb nhất?
SELECT s.StudentID, s.LastName, s.FirstName, COUNT(r.ClubID) AS [No clubs] FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID GROUP BY s.StudentID, s.LastName, s.FirstName HAVING COUNT(r.ClubID) >= ALL (SELECT COUNT(r.ClubID) FROM Student s LEFT JOIN Registration r ON s.StudentID = r.StudentID GROUP BY s.StudentID)

-- 4. CLB Cộng đồng Sinh viên Tình nguyện có những sv nào tham gia (gián tiếp).
SELECT * FROM Club
SELECT * FROM Registration
SELECT c.ClubID, c.ClubName, s.StudentID, s.LastName, s.FirstName FROM Registration r RIGHT JOIN Club c ON r.ClubID = c.ClubID LEFT JOIN Student s ON r.StudentID = s.StudentID WHERE c.ClubName = N'Cộng đồng Sinh viên Tình nguyện'

-- 5. Mỗi clb có bao nhiêu thành viên.
-- Output: mã clb, tên clb, số thành viên.
SELECT c.ClubID, c.ClubName, COUNT(r.StudentID) AS [No students] FROM Club c LEFT JOIN Registration r ON c.ClubID = r.ClubID GROUP BY c.ClubID, c.ClubName

-- 6. CLB nào đông member nhất.
-- Output: mã clb, tên clb, số thành viên.
SELECT c.ClubID, c.ClubName, COUNT(r.StudentID) AS [No students] FROM Club c LEFT JOIN Registration r ON c.ClubID = r.ClubID GROUP BY c.ClubID, c.ClubName HAVING COUNT(r.StudentID) >= ALL (SELECT COUNT(r.StudentID)FROM Club c LEFT JOIN Registration r ON c.ClubID = r.ClubID GROUP BY c.ClubID)

-- 7. CLB Siti và CSG có bao nhiêu member, đếm riêng từng clb.
-- Output: mã clb, tên clb, số thành viên (2 dòng).
SELECT c.ClubID, c.ClubName, COUNT(r.StudentID) AS [No students] FROM Club c LEFT JOIN Registration r ON c.ClubID = r.ClubID WHERE c.ClubID = 'SiTi' OR c.ClubID = 'CSG' GROUP BY c.ClubID, c.ClubName

-- 8. Có tổng cộng bao nhiêu lượt sv tham gia clb.
SELECT * FROM Registration
SELECT COUNT(*) AS [No students] FROM Registration