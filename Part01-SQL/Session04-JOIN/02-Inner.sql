USE Northwind

SELECT * FROM VnDict, EnDict -- tích Đề-các

SELECT * FROM VnDict CROSS JOIN EnDict -- tích Đề-các

SELECT * FROM VnDict vn, EnDict en WHERE vn.Nmbr = en.Nmbr -- tích Đề-các, filter lại

SELECT * FROM VnDict vn, EnDict en WHERE Nmbr = Nmbr -- Bối rối tên

SELECT * FROM VnDict, EnDict WHERE VnDict.Nmbr = EnDict.Nmbr -- Nên đặt alias thì giúp ngắn gọn câu lệnh

-- CHUẨN THẾ GIỚI
SELECT * FROM VnDict INNER JOIN EnDict ON VnDict.Nmbr = EnDict.Nmbr -- Nhìn sâu table rồi ghép, không ghép bừa bãi, ghép có tương quan bên trong, theo điểm chung.

SELECT * FROM VnDict JOIN EnDict ON VnDict.Nmbr = EnDict.Nmbr -- Nhìn sâu table rồi ghép, không ghép bừa bãi

-- CÓ THẺ DÙNG THÊM WHERE ĐƯỢC HAY KHÔNG KHI XÀI INNER, JOIN?
-- JOIN CHỈ LÀ THÊM DATA ĐỂ TÍNH TOÁN, GỘP DATA LẠI NHIỀU HƠN, SAU ĐÓ ÁP DỤNG TOÀN BỘ KIẾN THỨC SELECT.