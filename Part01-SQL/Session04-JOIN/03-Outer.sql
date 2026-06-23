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