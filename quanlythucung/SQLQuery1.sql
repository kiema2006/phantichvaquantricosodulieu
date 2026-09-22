-- =========================================================
-- FUNCTION: TÍNH TOÁN VÀ TRUY VẤN
-- =========================================================

-- 1. Hàm Scalar: Tính tổng tiền của một hóa đơn dựa trên ChiTietHoaDon
CREATE FUNCTION fn_TinhTongTienHoaDon(@MaHD INT)
RETURNS DECIMAL(12,2)
AS
BEGIN
    DECLARE @TongTien DECIMAL(12,2)
    SELECT @TongTien = ISNULL(SUM(SoLuong * DonGia), 0)
    FROM ChiTietHoaDon
    WHERE MaHD = @MaHD
    RETURN @TongTien
END
GO

-- 2. Hàm Scalar: Tính tuổi của thú cưng (theo năm) dựa trên Ngày Sinh
CREATE FUNCTION fn_TinhTuoiThuCung(@MaPet INT)
RETURNS INT
AS
BEGIN
    DECLARE @Tuoi INT
    SELECT @Tuoi = DATEDIFF(YEAR, NgaySinh, GETDATE())
    FROM ThuCung
    WHERE MaPet = @MaPet AND NgaySinh IS NOT NULL
    RETURN ISNULL(@Tuoi, 0)
END
GO

-- 3. Hàm Table-Valued: Lấy danh sách lịch làm việc của nhân viên trong khoảng thời gian cụ thể
CREATE FUNCTION fn_LichLamViecNhanVien(@MaNV INT, @TuNgay DATE, @DenNgay DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        LC.MaLich, 
        LC.NgayHen, 
        LC.GioHen, 
        LC.TrangThai, 
        TC.TenPet, 
        KH.HoTen AS TenKhachHang
    FROM LichChamSoc LC
    JOIN ThuCung TC ON LC.MaPet = TC.MaPet
    JOIN KhachHang KH ON TC.MaKH = KH.MaKH
    WHERE LC.MaNV = @MaNV AND LC.NgayHen BETWEEN @TuNgay AND @DenNgay
)
GO

-- =========================================================
-- TRIGGER: RÀNG BUỘC VÀ TỰ ĐỘNG HÓA DỮ LIỆU
-- =========================================================

-- 1. Trigger: Tự động cập nhật TongTien trong bảng HoaDon 
-- khi có thay đổi (Thêm/Sửa/Xóa) ở bảng ChiTietHoaDon
CREATE TRIGGER trg_CapNhatTongTienHoaDon
ON ChiTietHoaDon
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Lấy danh sách các Mã Hóa Đơn bị ảnh hưởng
    DECLARE @AffectedHD TABLE (MaHD INT)
    INSERT INTO @AffectedHD (MaHD)
    SELECT MaHD FROM inserted
    UNION
    SELECT MaHD FROM deleted

    -- Cập nhật lại TongTien cho các hóa đơn đó bằng cách gọi Function
    UPDATE HoaDon
    SET TongTien = dbo.fn_TinhTongTienHoaDon(HoaDon.MaHD)
    FROM HoaDon
    JOIN @AffectedHD ahd ON HoaDon.MaHD = ahd.MaHD
END
GO

-- 2. Trigger: Kiểm tra và ngăn chặn việc đặt trùng lịch hẹn 
-- (Cả về phía Nhân viên và Thú cưng)
CREATE TRIGGER trg_KiemTraTrungLichChamSoc
ON LichChamSoc
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra trùng lịch của Nhân viên
    IF EXISTS (
        SELECT 1
        FROM LichChamSoc LC
        JOIN inserted i ON LC.MaNV = i.MaNV
                     AND LC.NgayHen = i.NgayHen
                     AND LC.GioHen = i.GioHen
                     AND LC.MaLich <> i.MaLich -- Tránh tự so sánh với chính nó khi UPDATE
    )
    BEGIN
        RAISERROR(N'Lỗi: Nhân viên đã có lịch hẹn trùng vào thời gian này!', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    -- Kiểm tra trùng lịch của Thú cưng
    IF EXISTS (
        SELECT 1
        FROM LichChamSoc LC
        JOIN inserted i ON LC.MaPet = i.MaPet
                     AND LC.NgayHen = i.NgayHen
                     AND LC.GioHen = i.GioHen
                     AND LC.MaLich <> i.MaLich
    )
    BEGIN
        RAISERROR(N'Lỗi: Thú cưng đã có lịch hẹn trùng vào thời gian này!', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO

-- 3. Trigger: Ngăn chặn thêm Dịch vụ đã ngưng hoạt động (TrangThai = 0) vào Hóa đơn
CREATE TRIGGER trg_KiemTraDichVuHoatDong_HoaDon
ON ChiTietHoaDon
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN DichVu DV ON i.MaDV = DV.MaDV
        WHERE DV.TrangThai = 0 
    )
    BEGIN
        RAISERROR(N'Lỗi: Dịch vụ đã ngưng hoạt động, không thể thêm vào hóa đơn!', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO


-- Giả sử thú cưng có MaPet = 1
SELECT dbo.fn_TinhTuoiThuCung(1) AS TuoiThuCung;


-- Xem lịch của nhân viên MaNV = 1 từ ngày 01/09/2026 đến 30/09/2026
SELECT * FROM dbo.fn_LichLamViecNhanVien(3, '2026-09-01', '2026-09-30');