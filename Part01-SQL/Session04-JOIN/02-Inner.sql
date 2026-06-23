USE Northwind

SELECT * FROM VnDict, EnDict -- tích Đề-các

SELECT * FROM VnDict CROSS JOIN EnDict -- tích Đề-các

SELECT * FROM VnDict vn, EnDict en WHERE vn.Nmbr = en.Nmbr -- tích Đề-các, filter lại

SELECT * FROM VnDict vn, EnDict en WHERE Nmbr = Nmbr -- Bối rối tên

SELECT * FROM VnDict, EnDict WHERE VnDict.Nmbr = EnDict.Nmbr -- Nên đặt alias thì giúp ngắn gọn câu lệnh

-- CHUẨN THẾ GIỚI
SELECT * FROM VnDict vn INNER JOIN EnDict en ON vn.Nmbr = en.Nmbr -- Nhìn sâu table rồi ghép, không ghép bừa bãi, ghép có tương quan bên trong, theo điểm chung.

SELECT * FROM VnDict vn JOIN EnDict en ON vn.Nmbr = en.Nmbr -- Nhìn sâu table rồi ghép, không ghép bừa bãi

-- CÓ THẺ DÙNG THÊM WHERE ĐƯỢC HAY KHÔNG KHI XÀI INNER, JOIN?
-- JOIN CHỈ LÀ THÊM DATA ĐỂ TÍNH TOÁN, GỘP DATA LẠI NHIỀU HƠN, SAU ĐÓ ÁP DỤNG TOÀN BỘ KIẾN THỨC SELECT.

-- THÍ NGHIỆM THÊM CHO INNER JOIN, GHÉP NGANG CÓ XEM XÉT MÔN ĐĂNG HỘ ĐỐI HAY KHÔNG?
SELECT * FROM EnDict
SELECT * FROM VnDict

SELECT * FROM EnDict e, VnDict v WHERE e.Nmbr = v.Nmbr

SELECT * FROM EnDict e, VnDict v WHERE e.Nmbr > v.Nmbr -- GHÉP CÓ CHỌN LỌC, KHÔNG XÀI DẤU = MÀ DÙNG DẤU > >= < <= !=, NON-EQUI JOIN
													   -- VẪN KHÔNG LÀ GHÉP BỪA BÃI
-- 2Two 1Mot
-- 3Three 1Mot
-- 3Three 2Hai

SELECT * FROM EnDict e, VnDict v WHERE e.Nmbr != v.Nmbr -- THỰC DỤNG

SELECT * FROM EnDict e INNER JOIN VnDict v ON e.Nmbr != v.Nmbr -- CHUẨN MỰC
