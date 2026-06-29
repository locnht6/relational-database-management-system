-- TRIGGER LÀ 1 HÀM VOID, KHÔNG NHẬN THAM SỐ, KHÔNG TRẢ VỀ,
-- NÓ LÀM NHIỆM VỤ GÁC CỔNG 1 TABLE NÀO ĐÓ.
-- NẾU CÓ SỰ THAY ĐỔI DATA TRONG TABLE, NÓ SẼ TỰ ĐỘNG ĐƯỢC THỰC THI/CHẠY,
-- DÙNG ĐỂ KIỂM TRA/HAY ĐẢM BẢO TÍNH TOÀN VẸN/NHẤT QUÁN/CONSISTENCY CỦA DỮ LIỆU
-- HOẶC DÙNG ĐỂ KIỂM TRA CÁC RÀNG BUỘC MÀ SQL CHUẨN KHÔNG THỂ CUNG CẤP ĐỦ.

-- CHỈ TỰ GỌI LIÊN QUAN ĐẾN TABLE NÀO ĐÓ VÀ LIÊN QUAN ĐẾN 3 LỆNH INSERT, UPDATE, DELETE.
-- GẮN CHẶT VỚI 1 TABLE, NHƯNG KHÔNG CẤM CODE CỦA NÓ CAN THIỆP TABLE.
-- 1 TABLE KHÔNG ÉP PHẢI CÓ TRIGGER.

CREATE TABLE [Event]
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(50) NOT NULL
)

GO

CREATE TRIGGER TR_CheckInsertionOnEvent ON [Event]
FOR INSERT
AS
BEGIN
	PRINT 'You have just inserted a record in Event table!'
END

GO

EXEC PR_InsertEvent N'Blockchain & Game (part 2)' -- kiểm tra xem có thông báo 1 câu khi insert an event

SELECT * FROM Event

-- THỬ NGHIỆM: KHÔNG CHO INSERT VÀO TABLE EVENT.

GO

CREATE TRIGGER TR_ForbidInsertionEvent ON [Event]
FOR INSERT
AS
BEGIN
	PRINT 'You have just inserted a record in Event table. Sorry!'
	ROLLBACK -- cấm, undo những gì đã xảy ra khi insert
END

GO

EXEC PR_InsertEvent N'Thổi nến và Tài chính 4.0'

DROP TRIGGER TR_ForbidInsertionEvent
DROP TRIGGER TR_CheckInsertionOnEvent

-- KIỂM TRA KHÔNG CHO INSERT QUÁ 5 RECORDS/EVENTS.
-- SQL CÓ THỂ ĐẾM, QUYẾT ĐỊNH ĐẾM XONG LÀM GÌ TIẾP -> LẬP TRÌNH! -> TRIGGER CHẶN KHÔNG CHO VÀO.

GO

CREATE TRIGGER TR_CheckInsertionLimitationOnEvent ON Event
FOR INSERT
AS
BEGIN
	-- XEM THỬ NGƯỜI TA CHÈN CÁI EVENT GÌ VÀO TABLE?
	SELECT * FROM INSERTED
	ROLLBACK
END

GO

EXEC PR_InsertEvent N'Thổi nến và Tài chính 4.0'

-- LƯU Ý KHI CHƠI VỚI TRIGGER:
-- DB ENGINE SẼ TỰ TẠO RA 2 TABLE "ẢO" LÚC RUNTIME LIÊN QUAN ĐẾN TRIGGER.

-- CÂU LỆNH INSERT VÀO TABLE -> DB ENGINE TẠO RA 1 TABLE ẢO TÊN LÀ INSERTED,
-- CHỨA RECORD VỪA ĐƯA VÀO TỪ CÂU LỆNH INSERT.

-- CÂU LỆNH DELETE FROM TABLE -> DB ENGINE TẠO RA 1 TABLE ẢO TÊN LÀ DELETED,
-- CHỨA NHỮNG DÒNG VỪA BỊ XÓA!

-- CÂU LỆNH UPDATE EVENT SET NAME = 'ĐỔI TÊN SỰ KIỆN' -> DB ENGINE TẠO 2 TABLE ẢO,
-- INSERTED CHỨA VALUE MỚI ĐƯA VÀO.
-- DELETED CHỨA VALUE CŨ/BỊ GHI ĐÈ.

GO

CREATE TRIGGER TR_CheckInsertionLimitationOnEvent ON Event
FOR INSERT
AS
BEGIN
	-- Kiểm tra xem trong table Event không cho vượt quá 5 sự kiện.
	-- If số sự kiện > 5 thì rollback!!!
	-- Phải đếm số sự kiện đang có!
	-- Lấy được số sự kiện ra để if, tức là khai báo biến,
	-- nhớ lệnh count(*) trong SELECT TRẢ VỀ 1 TABLE
	DECLARE @noEvents int
	SELECT @noEvents = COUNT(*) FROM [Event]
	-- PRINT @noEvents
	-- SELECT @noEvents
	IF @noEvents > 5
	BEGIN
		PRINT 'To much events. No more 5 events!!!'
		ROLLBACK
	END

END

GO

-- LIÊN QUAN ĐẾN TABLE, CÓ 2 LOẠI TRIGGER CƠ BẢN:
-- CHẶN TRƯỚC KHI DỮ LIỆU ĐƯA VÀO TABLE, LÚC NÀY DỮ LIỆU MỚI VÀO INSERTED (BEFORE).
-- CHẶN SAU KHI ĐÃ VÀO INSERTED VÀ ĐỒNG THỜI VÀO LUÔN TABLE RỒI (AFTER).

SELECT * FROM Event

EXEC PR_InsertEvent N'làm sao sống sót ở FU.HCM' -- Vào được vì mới có 5 event
EXEC PR_InsertEvent N'Thổi nến và Tài chính 4.0' -- Bị chặn