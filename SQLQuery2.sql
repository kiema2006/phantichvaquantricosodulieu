CREATE DATABASE QuanLyChamSocThuCung
GO

USE QuanLyChamSocThuCung
GO

CREATE TABLE NhanVien (
    MaNV INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    GioiTinh NVARCHAR(10),
    NgaySinh DATE,
    SDT VARCHAR(15),
    DiaChi NVARCHAR(200),
    ChucVu NVARCHAR(50),
    TrangThai BIT NOT NULL DEFAULT 1
)
GO

CREATE TABLE TaiKhoan (
    MaTK INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
    MatKhau VARCHAR(100) NOT NULL,
    MaNV INT NOT NULL UNIQUE,
    Quyen VARCHAR(20) NOT NULL,
    TrangThai BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_TaiKhoan_NhanVien
        FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
GO

CREATE TABLE KhachHang (
    MaKH INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    SDT VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    DiaChi NVARCHAR(200),
    NgayDangKy DATE NOT NULL DEFAULT GETDATE(),
    GhiChu NVARCHAR(300)
)
GO

CREATE TABLE ThuCung (
    MaPet INT IDENTITY(1,1) PRIMARY KEY,
    MaKH INT NOT NULL,
    TenPet NVARCHAR(50) NOT NULL,
    Loai NVARCHAR(30) NOT NULL,
    Giong NVARCHAR(50),
    GioiTinh NVARCHAR(10),
    NgaySinh DATE,
    CanNang DECIMAL(5,2),
    MauLong NVARCHAR(30),
    GhiChu NVARCHAR(300),
    CONSTRAINT FK_ThuCung_KhachHang
        FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    CONSTRAINT CK_ThuCung_CanNang
        CHECK (CanNang IS NULL OR CanNang > 0)
)
GO

CREATE TABLE HoSoSucKhoe (
    MaHoSo INT IDENTITY(1,1) PRIMARY KEY,
    MaPet INT NOT NULL,
    CanNang DECIMAL(5,2),
    TinhTrangSucKhoe NVARCHAR(200),
    TienSuBenh NVARCHAR(300),
    DiUng NVARCHAR(300),
    NgayCapNhat DATE NOT NULL DEFAULT GETDATE(),
    GhiChu NVARCHAR(300),
    CONSTRAINT FK_HoSoSucKhoe_ThuCung
        FOREIGN KEY (MaPet) REFERENCES ThuCung(MaPet),
    CONSTRAINT CK_HoSoSucKhoe_CanNang
        CHECK (CanNang IS NULL OR CanNang > 0)
)
GO

CREATE TABLE TiemChung (
    MaTiem INT IDENTITY(1,1) PRIMARY KEY,
    MaPet INT NOT NULL,
    TenVacXin NVARCHAR(100) NOT NULL,
    MuiTiem INT NOT NULL,
    NgayTiem DATE NOT NULL,
    NgayNhac DATE,
    NoiTiem NVARCHAR(200),
    GhiChu NVARCHAR(300),
    CONSTRAINT FK_TiemChung_ThuCung
        FOREIGN KEY (MaPet) REFERENCES ThuCung(MaPet),
    CONSTRAINT CK_TiemChung_MuiTiem
        CHECK (MuiTiem > 0)
)
GO

CREATE TABLE DichVu (
    MaDV INT IDENTITY(1,1) PRIMARY KEY,
    TenDV NVARCHAR(100) NOT NULL,
    LoaiDV NVARCHAR(50),
    DonGia DECIMAL(12,2) NOT NULL,
    ThoiGianDuKien INT,
    MoTa NVARCHAR(300),
    TrangThai BIT NOT NULL DEFAULT 1,
    CONSTRAINT CK_DichVu_DonGia
        CHECK (DonGia >= 0),
    CONSTRAINT CK_DichVu_ThoiGian
        CHECK (ThoiGianDuKien IS NULL OR ThoiGianDuKien > 0)
)
GO

CREATE TABLE LichChamSoc (
    MaLich INT IDENTITY(1,1) PRIMARY KEY,
    MaPet INT NOT NULL,
    MaNV INT NOT NULL,
    NgayHen DATE NOT NULL,
    GioHen TIME NOT NULL,
    TrangThai NVARCHAR(30) NOT NULL DEFAULT N'Đã đặt',
    GhiChu NVARCHAR(300),
    CONSTRAINT FK_LichChamSoc_ThuCung
        FOREIGN KEY (MaPet) REFERENCES ThuCung(MaPet),
    CONSTRAINT FK_LichChamSoc_NhanVien
        FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
GO

CREATE TABLE ChiTietLichChamSoc (
    MaLich INT NOT NULL,
    MaDV INT NOT NULL,
    SoLuong INT NOT NULL DEFAULT 1,
    DonGia DECIMAL(12,2) NOT NULL,
    ThanhTien AS (SoLuong * DonGia) PERSISTED,
    CONSTRAINT PK_ChiTietLichChamSoc PRIMARY KEY (MaLich, MaDV),
    CONSTRAINT FK_ChiTietLichChamSoc_LichChamSoc
        FOREIGN KEY (MaLich) REFERENCES LichChamSoc(MaLich),
    CONSTRAINT FK_ChiTietLichChamSoc_DichVu
        FOREIGN KEY (MaDV) REFERENCES DichVu(MaDV),
    CONSTRAINT CK_ChiTietLichChamSoc_SoLuong
        CHECK (SoLuong > 0),
    CONSTRAINT CK_ChiTietLichChamSoc_DonGia
        CHECK (DonGia >= 0)
)
GO

CREATE TABLE HoaDon (
    MaHD INT IDENTITY(1,1) PRIMARY KEY,
    MaKH INT NOT NULL,
    MaNV INT NOT NULL,
    NgayLap DATETIME NOT NULL DEFAULT GETDATE(),
    TongTien DECIMAL(12,2) NOT NULL DEFAULT 0,
    PhuongThucTT NVARCHAR(30),
    TrangThai NVARCHAR(30) NOT NULL DEFAULT N'Chưa thanh toán',
    GhiChu NVARCHAR(300),
    CONSTRAINT FK_HoaDon_KhachHang
        FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    CONSTRAINT FK_HoaDon_NhanVien
        FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    CONSTRAINT CK_HoaDon_TongTien
        CHECK (TongTien >= 0)
)
GO

CREATE TABLE ChiTietHoaDon (
    MaHD INT NOT NULL,
    MaDV INT NOT NULL,
    SoLuong INT NOT NULL DEFAULT 1,
    DonGia DECIMAL(12,2) NOT NULL,
    ThanhTien AS (SoLuong * DonGia) PERSISTED,
    CONSTRAINT PK_ChiTietHoaDon PRIMARY KEY (MaHD, MaDV),
    CONSTRAINT FK_ChiTietHoaDon_HoaDon
        FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    CONSTRAINT FK_ChiTietHoaDon_DichVu
        FOREIGN KEY (MaDV) REFERENCES DichVu(MaDV),
    CONSTRAINT CK_ChiTietHoaDon_SoLuong
        CHECK (SoLuong > 0),
    CONSTRAINT CK_ChiTietHoaDon_DonGia
        CHECK (DonGia >= 0)
)
GO

CREATE VIEW vw_ThuCung_KhachHang
AS
SELECT
    TC.MaPet,
    TC.TenPet,
    TC.Loai,
    TC.Giong,
    TC.GioiTinh,
    TC.NgaySinh,
    TC.CanNang,
    KH.MaKH,
    KH.HoTen AS TenKhachHang,
    KH.SDT,
    KH.Email
FROM ThuCung TC
JOIN KhachHang KH ON TC.MaKH = KH.MaKH;
GO

CREATE VIEW vw_LichChamSoc
AS
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
JOIN NhanVien NV ON LC.MaNV = NV.MaNV;
GO

CREATE VIEW vw_HoaDon_ChiTiet
AS
SELECT
    HD.MaHD,
    KH.HoTen AS TenKhachHang,
    NV.HoTen AS TenNhanVien,
    HD.NgayLap,
    DV.TenDV,
    CT.SoLuong,
    CT.DonGia,
    CT.ThanhTien,
    HD.PhuongThucTT,
    HD.TrangThai
FROM HoaDon HD
JOIN KhachHang KH ON HD.MaKH = KH.MaKH
JOIN NhanVien NV ON HD.MaNV = NV.MaNV
JOIN ChiTietHoaDon CT ON HD.MaHD = CT.MaHD
JOIN DichVu DV ON CT.MaDV = DV.MaDV;
GO

CREATE VIEW vw_HoSoSucKhoe_ThuCung
AS
SELECT
    HS.MaHoSo,
    TC.MaPet,
    TC.TenPet,
    TC.Loai,
    TC.Giong,
    KH.HoTen AS TenKhachHang,
    HS.CanNang,
    HS.TinhTrangSucKhoe,
    HS.TienSuBenh,
    HS.DiUng,
    HS.NgayCapNhat,
    HS.GhiChu
FROM HoSoSucKhoe HS
JOIN ThuCung TC ON HS.MaPet = TC.MaPet
JOIN KhachHang KH ON TC.MaKH = KH.MaKH;
GO

CREATE VIEW vw_TiemChung_ThuCung
AS
SELECT
    TC.MaTiem,
    TC.MaPet,
    PET.TenPet,
    PET.Loai,
    PET.Giong,
    KH.HoTen AS TenKhachHang,
    TC.TenVacXin,
    TC.MuiTiem,
    TC.NgayTiem,
    TC.NgayNhac,
    TC.NoiTiem,
    TC.GhiChu
FROM TiemChung TC
JOIN ThuCung PET ON TC.MaPet = PET.MaPet
JOIN KhachHang KH ON PET.MaKH = KH.MaKH;
GO

CREATE VIEW vw_TongHopDichVu_HoaDon
AS
SELECT
    HD.MaHD,
    KH.HoTen AS TenKhachHang,
    NV.HoTen AS TenNhanVien,
    HD.NgayLap,
    COUNT(CT.MaDV) AS SoLoaiDichVu,
    SUM(CT.SoLuong) AS TongSoLuongDichVu,
    SUM(CT.ThanhTien) AS TongTienDichVu,
    HD.PhuongThucTT,
    HD.TrangThai
FROM HoaDon HD
JOIN KhachHang KH ON HD.MaKH = KH.MaKH
JOIN NhanVien NV ON HD.MaNV = NV.MaNV
JOIN ChiTietHoaDon CT ON HD.MaHD = CT.MaHD
GROUP BY
    HD.MaHD,
    KH.HoTen,
    NV.HoTen,
    HD.NgayLap,
    HD.PhuongThucTT,
    HD.TrangThai;
GO

CREATE VIEW vw_LichChamSoc_NhanVien
AS
SELECT
    NV.MaNV,
    NV.HoTen AS TenNhanVien,
    NV.ChucVu,
    LC.MaLich,
    LC.NgayHen,
    LC.GioHen,
    LC.TrangThai,
    PET.MaPet,
    PET.TenPet,
    KH.HoTen AS TenKhachHang,
    LC.GhiChu
FROM NhanVien NV
JOIN LichChamSoc LC ON NV.MaNV = LC.MaNV
JOIN ThuCung PET ON LC.MaPet = PET.MaPet
JOIN KhachHang KH ON PET.MaKH = KH.MaKH;
GO

CREATE VIEW vw_DichVu_DangHoatDong
AS
SELECT
    MaDV,
    TenDV,
    LoaiDV,
    DonGia,
    ThoiGianDuKien,
    MoTa,
    TrangThai
FROM DichVu
WHERE TrangThai = 1;
GO

CREATE VIEW vw_KhachHang_SoLuongThuCung
AS
SELECT
    KH.MaKH,
    KH.HoTen,
    KH.SDT,
    KH.Email,
    KH.DiaChi,
    COUNT(TC.MaPet) AS SoLuongThuCung
FROM KhachHang KH
LEFT JOIN ThuCung TC ON KH.MaKH = TC.MaKH
GROUP BY
    KH.MaKH,
    KH.HoTen,
    KH.SDT,
    KH.Email,
    KH.DiaChi;
GO

CREATE VIEW vw_ThongKeDoanhThuNhanVien
AS
SELECT
    NV.MaNV,
    NV.HoTen AS TenNhanVien,
    NV.ChucVu,
    COUNT(HD.MaHD) AS SoHoaDon,
    SUM(HD.TongTien) AS TongDoanhThu
FROM NhanVien NV
JOIN HoaDon HD ON NV.MaNV = HD.MaNV
GROUP BY
    NV.MaNV,
    NV.HoTen,
    NV.ChucVu;
GO

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
