-- =========================================================
-- INSERT DỮ LIỆU MẪU (TEST DATA)
-- =========================================================

USE QuanLyChamSocThuCung
GO

-- 1. Bảng Nhân Viên (10 bản ghi)
INSERT INTO NhanVien (HoTen, GioiTinh, NgaySinh, SDT, DiaChi, ChucVu, TrangThai) VALUES
(N'Nguyễn Văn An', N'Nam', '1990-05-10', '0901111001', N'Q1, TP.HCM', N'Quản lý', 1),
(N'Trần Thị Bình', N'Nữ', '1992-08-15', '0901111002', N'Q3, TP.HCM', N'Bác sĩ thú y', 1),
(N'Lê Hoàng Cường', N'Nam', '1995-02-20', '0901111003', N'Q7, TP.HCM', N'Kỹ thuật viên grooming', 1),
(N'Phạm Thị Dung', N'Nữ', '1993-11-05', '0901111004', N'Q.Bình Thạnh, TP.HCM', N'Lễ tân', 1),
(N'Hoàng Văn Em', N'Nam', '1996-07-12', '0901111005', N'Q.Tân Bình, TP.HCM', N'Bác sĩ thú y', 1),
(N'Vũ Thị Phương', N'Nữ', '1994-03-25', '0901111006', N'Q.Gò Vấp, TP.HCM', N'Kỹ thuật viên spa', 1),
(N'Đỗ Văn Giang', N'Nam', '1991-09-18', '0901111007', N'Q.Thủ Đức, TP.HCM', N'Bác sĩ phẫu thuật', 1),
(N'Bùi Thị Hạnh', N'Nữ', '1997-01-30', '0901111008', N'Q.10, TP.HCM', N'Lễ tân', 1),
(N'Mai Văn Khánh', N'Nam', '1998-06-14', '0901111009', N'Q.5, TP.HCM', N'Kỹ thuật viên grooming', 1),
(N'Hồ Thị Lan', N'Nữ', '1992-12-08', '0901111010', N'Q.Phú Nhuận, TP.HCM', N'Quản lý kho', 1);
GO

-- 2. Bảng Tài Khoản (10 bản ghi)
INSERT INTO TaiKhoan (TenDangNhap, MatKhau, MaNV, Quyen, TrangThai) VALUES
('admin', '123456', 1, 'Admin', 1),
('bsbinh', '123456', 2, 'BacSi', 1),
('kycuong', '123456', 3, 'KyThuat', 1),
('letan', '123456', 4, 'LeTan', 1),
('bsem', '123456', 5, 'BacSi', 1),
('spaphuong', '123456', 6, 'KyThuat', 1),
('bsgiang', '123456', 7, 'BacSi', 1),
('letan2', '123456', 8, 'LeTan', 1),
('grooming', '123456', 9, 'KyThuat', 1),
('kholan', '123456', 10, 'QuanLyKho', 1);
GO

-- 3. Bảng Khách Hàng (15 bản ghi)
INSERT INTO KhachHang (HoTen, SDT, Email, DiaChi, GhiChu) VALUES
(N'Nguyễn Thị Mai', '0912345001', 'mai.nt@gmail.com', N'Q1, TP.HCM', N'Khách VIP'),
(N'Trần Văn Hùng', '0912345002', 'hung.tv@gmail.com', N'Q3, TP.HCM', NULL),
(N'Lê Thị Hồng', '0912345003', 'hong.lt@gmail.com', N'Q7, TP.HCM', N'Thích chó Poodle'),
(N'Phạm Văn Nam', '0912345004', 'nam.pv@gmail.com', N'Bình Thạnh, TP.HCM', NULL),
(N'Hoàng Thị Cúc', '0912345005', 'cuc.ht@gmail.com', N'Tân Bình, TP.HCM', N'Nuôi mèo Anh Lông Ngắn'),
(N'Vũ Văn Đức', '0912345006', 'duc.vv@gmail.com', N'Gò Vấp, TP.HCM', NULL),
(N'Đỗ Thị Thu', '0912345007', 'thu.dt@gmail.com', N'Thủ Đức, TP.HCM', N'Khách hàng thân thiết'),
(N'Bùi Văn Sơn', '0912345008', 'son.bv@gmail.com', N'Q10, TP.HCM', NULL),
(N'Mai Thị Hoa', '0912345009', 'hoa.mt@gmail.com', N'Q5, TP.HCM', NULL),
(N'Hồ Văn Tài', '0912345010', 'tai.hv@gmail.com', N'Phú Nhuận, TP.HCM', N'Nuôi Hamster'),
(N'Ngô Thị Yến', '0912345011', 'yen.nt@gmail.com', N'Q2, TP.HCM', NULL),
(N'Dương Văn Long', '0912345012', 'long.dv@gmail.com', N'Q4, TP.HCM', NULL),
(N'Lý Thị Thảo', '0912345013', 'thao.lt@gmail.com', N'Q6, TP.HCM', NULL),
(N'Trịnh Văn Minh', '0912345014', 'minh.tv@gmail.com', N'Q8, TP.HCM', NULL),
(N'Hoàng Thị Ngọc', '0912345015', 'ngoc.ht@gmail.com', N'Q11, TP.HCM', NULL);
GO

-- 4. Bảng Thú Cưng (20 bản ghi)
INSERT INTO ThuCung (MaKH, TenPet, Loai, Giong, GioiTinh, NgaySinh, CanNang, MauLong) VALUES
(1, N'Milu', N'Chó', N'Poodle', N'Cái', '2020-03-15', 4.5, N'Nâu'),
(1, N'Bob', N'Chó', N'Poodle', N'Đực', '2021-07-10', 3.8, N'Trắng'),
(2, N'Kiki', N'Mèo', N'Anh Lông Ngắn', N'Cái', '2019-11-20', 5.2, N'Xanh xám'),
(3, N'Tom', N'Chó', N'Corgi', N'Đực', '2022-01-05', 8.5, N'Vàng trắng'),
(4, N'Mimi', N'Mèo', N'Ba Tư', N'Cái', '2020-09-12', 4.0, N'Trắng'),
(5, N'Lucy', N'Mèo', N'Anh Lông Ngắn', N'Cái', '2021-04-18', 4.8, N'Tam thể'),
(6, N'Alex', N'Chó', N'Golden', N'Đực', '2018-06-25', 28.5, N'Vàng'),
(7, N'Bun', N'Chó', N'Phốc Sóc', N'Cái', '2022-08-30', 2.5, N'Cam'),
(8, N'Simba', N'Mèo', N'Main Coon', N'Đực', '2019-02-14', 7.5, N'Vằn'),
(9, N'Chichi', N'Chó', N'Chihuahua', N'Cái', '2021-10-05', 1.8, N'Trắng'),
(10, N'Bông', N'Hamster', N'Winter White', N'Cái', '2023-01-20', 0.05, N'Trắng'),
(11, N'Lu', N'Chó', N'Alaska', N'Đực', '2017-12-10', 35.0, N'Đen trắng'),
(12, N'Nemo', N'Cá', N'Cá Vàng', N'Đực', '2023-05-01', 0.1, N'Cam'),
(13, N'Pinky', N'Chó', N'Poodle', N'Cái', '2020-11-11', 3.5, N'Hồng'),
(14, N'Miu', N'Mèo', N'Mèo Ta', N'Cái', '2021-06-06', 3.2, N'Vàng'),
(15, N'Coco', N'Chó', N'Pug', N'Đực', '2019-08-08', 9.0, N'Nâu đen'),
(2, N'Zoe', N'Chó', N'Husky', N'Cái', '2020-02-28', 20.5, N'Xám trắng'),
(3, N'Tiny', N'Mèo', N'Sphynx', N'Cái', '2022-05-15', 3.5, N'Hồng da'),
(5, N'Kao', N'Mèo', N'Scottish Fold', N'Đực', '2021-09-09', 4.5, N'Trắng'),
(7, N'Sushi', N'Chó', N'Shiba', N'Cái', '2020-04-04', 10.0, N'Cam trắng');
GO

-- 5. Bảng Hồ Sơ Sức Khỏe (15 bản ghi)
INSERT INTO HoSoSucKhoe (MaPet, CanNang, TinhTrangSucKhoe, TienSuBenh, DiUng, GhiChu) VALUES
(1, 4.5, N'Khỏe mạnh', NULL, N'Không', N'Khám định kỳ'),
(2, 3.8, N'Khỏe mạnh', NULL, N'Không', NULL),
(3, 5.2, N'Hơi béo', N'Từng bị tiêu chảy', N'Thức ăn có hải sản', N'Cần giảm cân'),
(4, 8.5, N'Khỏe mạnh', NULL, N'Không', NULL),
(5, 4.0, N'Khỏe mạnh', NULL, N'Bụi bông', NULL),
(6, 4.8, N'Khỏe mạnh', NULL, N'Không', NULL),
(7, 28.5, N'Tốt', N'Viêm khớp nhẹ', N'Không', N'Bổ sung canxi'),
(8, 2.5, N'Khỏe mạnh', NULL, N'Không', NULL),
(9, 7.5, N'Khỏe mạnh', NULL, N'Không', NULL),
(10, 1.8, N'Khỏe mạnh', NULL, N'Không', NULL),
(11, 35.0, N'Tốt', NULL, N'Không', N'Chế độ ăn đặc biệt'),
(12, 0.1, N'Khỏe mạnh', NULL, N'Không', NULL),
(13, 3.5, N'Khỏe mạnh', NULL, N'Không', NULL),
(14, 3.2, N'Khỏe mạnh', NULL, N'Không', NULL),
(15, 9.0, N'Huyết áp cao', N'Từng bị cảm', N'Không', N'Cần theo dõi định kỳ');
GO

-- 6. Bảng Tiêm Chủng (15 bản ghi)
INSERT INTO TiemChung (MaPet, TenVacXin, MuiTiem, NgayTiem, NgayNhac, NoiTiem) VALUES
(1, N'Vaccine 7 bệnh', 1, '2020-06-15', '2020-07-15', N'PK Thú Y ABC'),
(1, N'Vaccine 7 bệnh', 2, '2020-07-15', '2021-07-15', N'PK Thú Y ABC'),
(2, N'Vaccine 7 bệnh', 1, '2021-10-10', '2021-11-10', N'PK Thú Y ABC'),
(3, N'Vaccine 4 bệnh mèo', 1, '2020-02-20', '2021-02-20', N'PK Thú Y XYZ'),
(4, N'Vaccine 7 bệnh', 1, '2022-04-05', '2022-05-05', N'PK Thú Y ABC'),
(5, N'Vaccine 4 bệnh mèo', 1, '2020-12-12', '2021-12-12', N'PK Thú Y XYZ'),
(6, N'Vaccine 4 bệnh mèo', 1, '2021-07-18', '2022-07-18', N'PK Thú Y XYZ'),
(7, N'Vaccine 7 bệnh', 1, '2022-11-30', '2022-12-30', N'PK Thú Y ABC'),
(8, N'Vaccine 4 bệnh mèo', 1, '2019-05-14', '2020-05-14', N'PK Thú Y XYZ'),
(9, N'Vaccine 7 bệnh', 1, '2021-12-05', '2022-01-05', N'PK Thú Y ABC'),
(11, N'Vaccine 7 bệnh', 1, '2018-03-10', '2018-04-10', N'PK Thú Y ABC'),
(11, N'Vaccine 7 bệnh', 2, '2018-04-10', '2019-04-10', N'PK Thú Y ABC'),
(13, N'Vaccine 7 bệnh', 1, '2021-02-11', '2021-03-11', N'PK Thú Y ABC'),
(14, N'Vaccine 4 bệnh mèo', 1, '2021-09-06', '2022-09-06', N'PK Thú Y XYZ'),
(15, N'Vaccine 7 bệnh', 1, '2019-11-08', '2019-12-08', N'PK Thú Y ABC');
GO

-- 7. Bảng Dịch Vụ (10 bản ghi)
INSERT INTO DichVu (TenDV, LoaiDV, DonGia, ThoiGianDuKien, MoTa, TrangThai) VALUES
(N'Tắm và cắt tỉa lông chó nhỏ', N'Grooming', 250000, 60, N'Tắm, sấy, cắt tỉa cơ bản', 1),
(N'Tắm và cắt tỉa lông mèo', N'Grooming', 300000, 60, N'Tắm, sấy, cắt tỉa lông mèo', 1),
(N'Khám sức khỏe tổng quát', N'Khám bệnh', 150000, 30, N'Kiểm tra tổng quát, tư vấn', 1),
(N'Tiêm phòng vaccine', N'Tiêm chủng', 200000, 15, N'Tiêm các loại vaccine phổ biến', 1),
(N'Tẩy giun, sán', N'Điều trị', 80000, 10, N'Tẩy giun định kỳ', 1),
(N'Spa chăm sóc da lông', N'Spa', 400000, 90, N'Tắm thảo dược, massage', 1),
(N'Nhổ răng, lấy cao răng', N'Nha khoa', 500000, 45, N'Vệ sinh răng miệng', 1),
(N'Phẫu thuật triệt sản', N'Phẫu thuật', 1500000, 120, N'Phẫu thuật triệt sản đực/cái', 1),
(N'Khách sạn thú cưng (1 ngày)', N'Lưu trú', 200000, 1440, N'Chăm sóc, cho ăn, dọn dẹp', 1),
(N'Dịch vụ cũ không dùng', N'Khác', 100000, 30, N'Dịch vụ test', 0); -- Dịch vụ ngưng hoạt động để test trigger
GO

-- 8. Bảng Lịch Chăm Sóc (20 bản ghi)
INSERT INTO LichChamSoc (MaPet, MaNV, NgayHen, GioHen, TrangThai, GhiChu) VALUES
(1, 3, '2026-09-20', '09:00:00', N'Hoàn thành', N'Tắm cắt lông'),
(2, 3, '2026-09-20', '10:00:00', N'Hoàn thành', N'Tắm cắt lông'),
(3, 6, '2026-09-21', '14:00:00', N'Hoàn thành', N'Spa mèo'),
(4, 3, '2026-09-22', '08:30:00', N'Đã đặt', N'Cắt tỉa Corgi'),
(5, 6, '2026-09-22', '10:00:00', N'Đã đặt', N'Tắm mèo'),
(7, 9, '2026-09-23', '09:00:00', N'Đã đặt', N'Tắm chó lớn'),
(8, 6, '2026-09-23', '14:00:00', N'Đã đặt', N'Spa Phốc Sóc'),
(11, 9, '2026-09-24', '08:00:00', N'Đã đặt', N'Tắm Alaska'),
(13, 3, '2026-09-24', '10:00:00', N'Đã đặt', N'Tắm Poodle'),
(15, 6, '2026-09-25', '09:00:00', N'Đã đặt', N'Spa Pug'),
(1, 2, '2026-09-22', '15:00:00', N'Đã đặt', N'Khám sức khỏe'),
(3, 2, '2026-09-23', '09:00:00', N'Đã đặt', N'Tư vấn giảm cân'),
(7, 5, '2026-09-24', '10:00:00', N'Đã đặt', N'Khám khớp'),
(15, 7, '2026-09-25', '14:00:00', N'Đã đặt', N'Kiểm tra huyết áp'),
(9, 2, '2026-09-22', '11:00:00', N'Đã đặt', N'Tiêm phòng'),
(11, 5, '2026-09-23', '15:00:00', N'Đã đặt', N'Tiêm nhắc lại'),
(4, 2, '2026-09-25', '09:00:00', N'Đã đặt', N'Khám định kỳ'),
(6, 5, '2026-09-26', '10:00:00', N'Đã đặt', N'Tẩy giun'),
(14, 7, '2026-09-26', '14:00:00', N'Đã đặt', N'Khám tổng quát'),
(20, 2, '2026-09-27', '09:00:00', N'Đã đặt', N'Tiêm phòng Shiba');
GO

-- 9. Bảng Chi Tiết Lịch Chăm Sóc (20 bản ghi)
INSERT INTO ChiTietLichChamSoc (MaLich, MaDV, SoLuong, DonGia) VALUES
(1, 1, 1, 250000),
(2, 1, 1, 250000),
(3, 6, 1, 400000),
(4, 1, 1, 250000),
(5, 2, 1, 300000),
(6, 1, 1, 250000),
(7, 6, 1, 400000),
(8, 1, 1, 250000),
(9, 1, 1, 250000),
(10, 6, 1, 400000),
(11, 3, 1, 150000),
(12, 3, 1, 150000),
(13, 3, 1, 150000),
(14, 3, 1, 150000),
(15, 4, 1, 200000),
(16, 4, 1, 200000),
(17, 3, 1, 150000),
(18, 5, 1, 80000),
(19, 3, 1, 150000),
(20, 4, 1, 200000);
GO

-- 10. Bảng Hóa Đơn (15 bản ghi)
INSERT INTO HoaDon (MaKH, MaNV, PhuongThucTT, TrangThai, GhiChu) VALUES
(1, 4, N'Tiền mặt', N'Đã thanh toán', N'Thanh toán đầy đủ'),
(1, 4, N'Chuyển khoản', N'Đã thanh toán', NULL),
(2, 8, N'Tiền mặt', N'Đã thanh toán', NULL),
(3, 4, N'Ví điện tử', N'Đã thanh toán', N'Khách VIP giảm 5%'),
(4, 8, N'Tiền mặt', N'Chưa thanh toán', N'Khách nợ'),
(5, 4, N'Chuyển khoản', N'Đã thanh toán', NULL),
(6, 8, N'Tiền mặt', N'Đã thanh toán', NULL),
(7, 4, N'Ví điện tử', N'Đã thanh toán', NULL),
(8, 8, N'Tiền mặt', N'Đã thanh toán', NULL),
(9, 4, N'Chuyển khoản', N'Đã thanh toán', NULL),
(10, 8, N'Tiền mặt', N'Đã thanh toán', NULL),
(11, 4, N'Tiền mặt', N'Đã thanh toán', NULL),
(12, 8, N'Chuyển khoản', N'Đã thanh toán', NULL),
(13, 4, N'Ví điện tử', N'Đã thanh toán', NULL),
(14, 8, N'Tiền mặt', N'Đã thanh toán', NULL);
GO

-- 11. Bảng Chi Tiết Hóa Đơn (20 bản ghi)
INSERT INTO ChiTietHoaDon (MaHD, MaDV, SoLuong, DonGia) VALUES
(1, 1, 1, 250000),
(1, 5, 1, 80000),
(2, 2, 1, 300000),
(3, 3, 1, 150000),
(3, 4, 1, 200000),
(4, 6, 1, 400000),
(5, 1, 1, 250000),
(6, 2, 1, 300000),
(7, 3, 1, 150000),
(8, 6, 1, 400000),
(9, 1, 1, 250000),
(10, 2, 1, 300000),
(11, 7, 1, 500000),
(12, 8, 1, 1500000),
(13, 9, 3, 200000),
(14, 1, 1, 250000),
(14, 5, 1, 80000),
(2, 3, 1, 150000),
(4, 4, 1, 200000),
(6, 5, 1, 80000);
GO

-- Cập nhật lại TongTien cho các hóa đơn (để dữ liệu thực tế hơn)
UPDATE HoaDon
SET TongTien = (SELECT SUM(ThanhTien) FROM ChiTietHoaDon WHERE ChiTietHoaDon.MaHD = HoaDon.MaHD)
WHERE MaHD IN (SELECT MaHD FROM HoaDon);
GO

PRINT N'Đã insert dữ liệu test thành công