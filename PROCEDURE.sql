CREATE PROCEDURE sp_TimThuCungTheoKhachHang
    @MaKH INT
AS
BEGIN
    SELECT
        TC.MaPet,
        TC.TenPet,
        TC.Loai,
        TC.Giong,
        TC.GioiTinh,
        TC.NgaySinh,
        TC.CanNang,
        KH.HoTen AS TenKhachHang
    FROM ThuCung TC
    JOIN KhachHang KH ON TC.MaKH = KH.MaKH
    WHERE KH.MaKH = @MaKH;
END;
GO

CREATE PROCEDURE sp_TimLichChamSocTheoPet
    @MaPet INT
AS
BEGIN
    SELECT
        LC.MaLich,
        TC.TenPet,
        NV.HoTen AS TenNhanVien,
        LC.NgayHen,
        LC.GioHen,
        LC.TrangThai,
        LC.GhiChu
    FROM LichChamSoc LC
    JOIN ThuCung TC ON LC.MaPet = TC.MaPet
    JOIN NhanVien NV ON LC.MaNV = NV.MaNV
    WHERE LC.MaPet = @MaPet;
END;
GO

CREATE PROCEDURE sp_TimHoaDonTheoKhachHang
    @MaKH INT
AS
BEGIN
    SELECT
        HD.MaHD,
        KH.HoTen AS TenKhachHang,
        NV.HoTen AS TenNhanVien,
        HD.NgayLap,
        HD.TongTien,
        HD.PhuongThucTT,
        HD.TrangThai,
        HD.GhiChu
    FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKH = KH.MaKH
    JOIN NhanVien NV ON HD.MaNV = NV.MaNV
    WHERE HD.MaKH = @MaKH;
END;
GO


CREATE OR ALTER PROCEDURE sp_TimKhachHangTheoSDT
    @SDT VARCHAR(15)
AS
BEGIN
    SELECT
        MaKH,
        HoTen,
        SDT,
        Email,
        DiaChi,
        NgayDangKy,
        GhiChu
    FROM KhachHang
    WHERE SDT = @SDT;
END
GO

CREATE OR ALTER PROCEDURE sp_TimDichVuTheoLoai
    @LoaiDV NVARCHAR(50)
AS
BEGIN
    SELECT
        MaDV,
        TenDV,
        LoaiDV,
        DonGia,
        ThoiGianDuKien,
        MoTa,
        TrangThai
    FROM DichVu
    WHERE LoaiDV = @LoaiDV;
END
GO

CREATE OR ALTER PROCEDURE sp_TimLichChamSocTheoNhanVien
    @MaNV INT
AS
BEGIN
    SELECT
        LC.MaLich,
        NV.MaNV,
        NV.HoTen AS TenNhanVien,
        TC.MaPet,
        TC.TenPet,
        KH.HoTen AS TenKhachHang,
        LC.NgayHen,
        LC.GioHen,
        LC.TrangThai,
        LC.GhiChu
    FROM LichChamSoc LC
    JOIN NhanVien NV ON LC.MaNV = NV.MaNV
    JOIN ThuCung TC ON LC.MaPet = TC.MaPet
    JOIN KhachHang KH ON TC.MaKH = KH.MaKH
    WHERE LC.MaNV = @MaNV;
END
GO

CREATE OR ALTER PROCEDURE sp_TimHoSoSucKhoeTheoPet
    @MaPet INT
AS
BEGIN
    SELECT
        HS.MaHoSo,
        TC.MaPet,
        TC.TenPet,
        KH.HoTen AS TenKhachHang,
        HS.CanNang,
        HS.TinhTrangSucKhoe,
        HS.TienSuBenh,
        HS.DiUng,
        HS.NgayCapNhat,
        HS.GhiChu
    FROM HoSoSucKhoe HS
    JOIN ThuCung TC ON HS.MaPet = TC.MaPet
    JOIN KhachHang KH ON TC.MaKH = KH.MaKH
    WHERE HS.MaPet = @MaPet
    ORDER BY HS.NgayCapNhat DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_TimTiemChungTheoPet
    @MaPet INT
AS
BEGIN
    SELECT
        TC.MaTiem,
        PET.MaPet,
        PET.TenPet,
        KH.HoTen AS TenKhachHang,
        TC.TenVacXin,
        TC.MuiTiem,
        TC.NgayTiem,
        TC.NgayNhac,
        TC.NoiTiem,
        TC.GhiChu
    FROM TiemChung TC
    JOIN ThuCung PET ON TC.MaPet = PET.MaPet
    JOIN KhachHang KH ON PET.MaKH = KH.MaKH
    WHERE TC.MaPet = @MaPet
    ORDER BY TC.NgayTiem DESC;
END
GO

CREATE OR ALTER PROCEDURE sp_TimChiTietHoaDon
    @MaHD INT
AS
BEGIN
    SELECT
        HD.MaHD,
        KH.HoTen AS TenKhachHang,
        NV.HoTen AS TenNhanVien,
        HD.NgayLap,
        DV.MaDV,
        DV.TenDV,
        CT.SoLuong,
        CT.DonGia,
        CT.ThanhTien,
        HD.TongTien,
        HD.PhuongThucTT,
        HD.TrangThai
    FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKH = KH.MaKH
    JOIN NhanVien NV ON HD.MaNV = NV.MaNV
    JOIN ChiTietHoaDon CT ON HD.MaHD = CT.MaHD
    JOIN DichVu DV ON CT.MaDV = DV.MaDV
    WHERE HD.MaHD = @MaHD;
END
GO

CREATE OR ALTER PROCEDURE sp_TimHoaDonTheoTrangThai
    @TrangThai NVARCHAR(30)
AS
BEGIN
    SELECT
        HD.MaHD,
        KH.HoTen AS TenKhachHang,
        KH.SDT,
        NV.HoTen AS TenNhanVien,
        HD.NgayLap,
        HD.TongTien,
        HD.PhuongThucTT,
        HD.TrangThai,
        HD.GhiChu
    FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKH = KH.MaKH
    JOIN NhanVien NV ON HD.MaNV = NV.MaNV
    WHERE HD.TrangThai = @TrangThai
    ORDER BY HD.NgayLap DESC;
END
GO