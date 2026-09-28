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
