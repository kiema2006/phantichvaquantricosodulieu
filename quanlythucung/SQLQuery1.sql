-- =========================================================
-- PHẦN 1: FUNCTION
-- =========================================================

-- 1. Hàm Scalar: Tính tổng tiền của một hóa đơn
DROP FUNCTION IF EXISTS fn_TinhTongTienHoaDon;
GO
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

-- 2. Hàm Scalar: Tính tuổi của thú cưng
DROP FUNCTION IF EXISTS fn_TinhTuoiThuCung;
GO
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

-- 3. Hàm Table-Valued: Lấy danh sách lịch làm việc của nhân viên
DROP FUNCTION IF EXISTS fn_LichLamViecNhanVien;
GO
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

-- 4. Hàm Scalar: Đếm số lượng thú cưng của một khách hàng
DROP FUNCTION IF EXISTS fn_DemSoThuCungCuaKhachHang;
GO
CREATE FUNCTION fn_DemSoThuCungCuaKhachHang(@MaKH INT)
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT
    SELECT @SoLuong = COUNT(MaPet) 
    FROM ThuCung 
    WHERE MaKH = @MaKH
    RETURN ISNULL(@SoLuong, 0)
END
GO

-- 5. Hàm Scalar: Tính tổng doanh thu theo Tháng/Năm
DROP FUNCTION IF EXISTS fn_DoanhThuTheoThang;
GO
CREATE FUNCTION fn_DoanhThuTheoThang(@Thang INT, @Nam INT)
RETURNS DECIMAL(14,2)
AS
BEGIN
    DECLARE @DoanhThu DECIMAL(14,2)
    SELECT @DoanhThu = ISNULL(SUM(TongTien), 0)
    FROM HoaDon
    WHERE MONTH(NgayLap) = @Thang AND YEAR(NgayLap) = @Nam
    RETURN @DoanhThu
END
GO

-- 6. Hàm Scalar: Tìm tên Dịch vụ được sử dụng nhiều nhất của 1 Thú cưng
DROP FUNCTION IF EXISTS fn_DichVuThuongDungCuaPet;
GO
CREATE FUNCTION fn_DichVuThuongDungCuaPet(@MaPet INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @TenDV NVARCHAR(100)
    SELECT TOP 1 @TenDV = DV.TenDV
    FROM ChiTietHoaDon CTHD
    JOIN HoaDon HD ON CTHD.MaHD = HD.MaHD
    JOIN DichVu DV ON CTHD.MaDV = DV.MaDV
    WHERE HD.MaKH = (SELECT MaKH FROM ThuCung WHERE MaPet = @MaPet)
    GROUP BY DV.TenDV
    ORDER BY SUM(CTHD.SoLuong) DESC
    RETURN ISNULL(@TenDV, N'Chưa có dữ liệu')
END
GO

-- 7. Hàm Table-Valued: Lấy danh sách hóa đơn và chi tiết dịch vụ của 1 Khách hàng
DROP FUNCTION IF EXISTS fn_ChiTietHoaDonKhachHang;
GO
CREATE FUNCTION fn_ChiTietHoaDonKhachHang(@MaKH INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        HD.MaHD, HD.NgayLap, HD.TongTien, 
        DV.TenDV, CTHD.SoLuong, CTHD.DonGia, 
        (CTHD.SoLuong * CTHD.DonGia) AS ThanhTienDV
    FROM HoaDon HD
    JOIN ChiTietHoaDon CTHD ON HD.MaHD = CTHD.MaHD
    JOIN DichVu DV ON CTHD.MaDV = DV.MaDV
    WHERE HD.MaKH = @MaKH
)
GO

-- 8. Hàm Scalar: Tính mức giảm giá dựa trên tổng chi tiêu
DROP FUNCTION IF EXISTS fn_TinhMucGiamGia;
GO
CREATE FUNCTION fn_TinhMucGiamGia(@MaKH INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @TongChiTieu DECIMAL(14,2)
    DECLARE @MucGiam DECIMAL(5,2) = 0.00

    SELECT @TongChiTieu = ISNULL(SUM(TongTien), 0)
    FROM HoaDon
    WHERE MaKH = @MaKH

    IF @TongChiTieu >= 50000000 SET @MucGiam = 0.15
    ELSE IF @TongChiTieu >= 20000000 SET @MucGiam = 0.10
    ELSE IF @TongChiTieu >= 5000000 SET @MucGiam = 0.05

    RETURN @MucGiam
END
GO

-- 9. Hàm Table-Valued: Liệt kê các Nhân viên có lịch làm việc vào 1 ngày
DROP FUNCTION IF EXISTS fn_NhanVienLamViecTheoNgay;
GO
CREATE FUNCTION fn_NhanVienLamViecTheoNgay(@Ngay DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT 
        NV.MaNV, NV.HoTen AS TenNhanVien, 
        COUNT(LC.MaLich) AS SoLichHen
    FROM NhanVien NV
    JOIN LichChamSoc LC ON NV.MaNV = LC.MaNV
    WHERE LC.NgayHen = @Ngay
    GROUP BY NV.MaNV, NV.HoTen
)
GO

-- 10. Hàm Scalar: Đếm số lượng lịch hẹn đã hoàn thành của thú cưng
DROP FUNCTION IF EXISTS fn_DemLichKhamHoanThanh;
GO
CREATE FUNCTION fn_DemLichKhamHoanThanh(@MaPet INT)
RETURNS INT
AS
BEGIN
    DECLARE @SoLich INT
    SELECT @SoLich = COUNT(MaLich)
    FROM LichChamSoc
    WHERE MaPet = @MaPet AND TrangThai = N'Đã hoàn thành'
    RETURN ISNULL(@SoLich, 0)
END
GO

-- =========================================================
-- PHẦN 2: TRIGGER
-- =========================================================

-- 1. Trigger: Tự động cập nhật TongTien trong HoaDon


-- 1. Trigger: Tự động cập nhật TongTien trong HoaDon khi ChiTietHoaDon thay đổi
CREATE TRIGGER trg_CapNhatTongTienHoaDon
ON ChiTietHoaDon
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @AffectedHD TABLE (MaHD INT)
    
    INSERT INTO @AffectedHD (MaHD)
    SELECT MaHD FROM inserted
    UNION
    SELECT MaHD FROM deleted

    UPDATE HoaDon
    SET TongTien = dbo.fn_TinhTongTienHoaDon(HoaDon.MaHD)
    FROM HoaDon
    JOIN @AffectedHD ahd ON HoaDon.MaHD = ahd.MaHD
END
GO

-- 2. Trigger: Kiểm tra trùng lịch hẹn (Nhân viên và Thú cưng)
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
                     AND LC.MaLich <> i.MaLich
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


-- 4. Trigger: Ngăn chặn xóa Khách hàng nếu có dữ liệu liên quan
DROP TRIGGER IF EXISTS trg_KhongXoaKhachHangCoDuLieu;
GO
CREATE TRIGGER trg_KhongXoaKhachHangCoDuLieu
ON KhachHang
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted d JOIN ThuCung TC ON d.MaKH = TC.MaKH)
    BEGIN
        RAISERROR(N'Lỗi: Không thể xóa khách hàng đang có thú cưng!', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    DELETE FROM KhachHang WHERE MaKH IN (SELECT MaKH FROM deleted)
END
GO

-- 5. Trigger: Tự động tạo lịch khám ban đầu khi thêm Thú cưng mới
DROP TRIGGER IF EXISTS trg_TuDongTaoLichKhamBanDau;
GO
CREATE TRIGGER trg_TuDongTaoLichKhamBanDau
ON ThuCung
AFTER INSERT
AS
BEGIN
    INSERT INTO LichChamSoc (MaPet, MaNV, NgayHen, GioHen, TrangThai, GhiChu)
    SELECT 
        i.MaPet, 
        1,
        DATEADD(DAY, 7, GETDATE()),
        '09:00', 
        N'Chờ xử lý', 
        N'Lịch khám sức khỏe ban đầu tự động'
    FROM inserted i
END
GO

-- 6. Trigger: Tự động lấy ĐơnGiá từ bảng Dịch vụ nếu ChiTietHoaDon nhập thiếu
DROP TRIGGER IF EXISTS trg_TuDongLayDonGiaDichVu;
GO
CREATE TRIGGER trg_TuDongLayDonGiaDichVu
ON ChiTietHoaDon
AFTER INSERT
AS
BEGIN
    UPDATE CTHD
    SET DonGia = DV.DonGia
    FROM ChiTietHoaDon CTHD
    JOIN inserted i ON CTHD.MaHD = i.MaHD AND CTHD.MaDV = i.MaDV
    JOIN DichVu DV ON i.MaDV = DV.MaDV
    WHERE i.DonGia IS NULL OR i.DonGia = 0
END
GO

-- 7. Trigger: Ngăn chặn xóa Dịch vụ đã có trong Hóa đơn
DROP TRIGGER IF EXISTS trg_KhongXoaDichVuDaCoHoaDon;
GO
CREATE TRIGGER trg_KhongXoaDichVuDaCoHoaDon
ON DichVu
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted d JOIN ChiTietHoaDon CTHD ON d.MaDV = CTHD.MaDV)
    BEGIN
        RAISERROR(N'Lỗi: Không thể xóa dịch vụ đã có trong hóa đơn!', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    DELETE FROM DichVu WHERE MaDV IN (SELECT MaDV FROM deleted)
END
GO

-- =========================================================
-- PHẦN 3: TEST
-- =========================================================
SELECT dbo.fn_TinhTuoiThuCung(1) AS TuoiThuCung;
SELECT * FROM dbo.fn_LichLamViecNhanVien(3, '2026-09-01', '2026-09-30');
SELECT dbo.fn_DemSoThuCungCuaKhachHang(1) AS SoThuCung;
SELECT dbo.fn_DoanhThuTheoThang(9, 2026) AS DoanhThuT9;
SELECT * FROM dbo.fn_ChiTietHoaDonKhachHang(1);
SELECT dbo.fn_TinhMucGiamGia(1) AS MucGiamGia;
SELECT * FROM dbo.fn_NhanVienLamViecTheoNgay('2026-10-13');
SELECT dbo.fn_DemLichKhamHoanThanh(1) AS SoLichHoanThanh;

