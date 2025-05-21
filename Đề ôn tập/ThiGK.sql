create database QLBanHang
go

use QLBanHang
go

create table HangHoa
(
	MSHH char(4) primary key,
	TenHH nvarchar(30) not null unique
)
go

create table KhachHang
(
	MSKH char(4) primary key,
	TenKH nvarchar(30) not null,
	NoDau int check(NoDau >= 0)
)
go

create table HoaDon
(	
	MSHD char(4) primary key,
	NgayHD datetime,
	MSKH char(4) references KhachHang(MSKH)
)
go

create table CTHoaDon
(
	MSHD char(4) references HoaDon(MSHD),
	MSHH char(4) references HangHoa(MSHH),
	SoLuong int check(SoLuong > 0),
	DonGia int check(DonGia > 0)
	primary key(MSHH, MSHD)
)
go

create table PhieuThu
(
	MSPT char(4) primary key,
	NgayThu datetime,
	MSKH char(4) references KhachHang(MSKH),
	SoTien int check(SoTien > 0)
)
go

-- exists: Tồn tại (Nếu sau exists, chạy lệnh có trả về dữ liệu - True)
-- Nếu không là false (không trả về dữ liệu)

-- not exists: Không tồn tại, chạy lệnh không trả về dữ liệu - True
-- Nếu không là false (trả về dữ liệu)

create proc USP_ThemHangHoa 
	@mshh char(4), 
	@tenhh nvarchar(30)
as
	-- Ràng buộc khóa chính
	if	exists(select * from HangHoa where MSHH = @mshh)
		print N'Đã có hàng hóa ' + @mshh + ' trong CSDL!'

	else
		begin
			insert into HangHoa values(@mshh, @tenhh)
			print N'Nhập hàng hóa thành công!'
		end
go

-- Gọi thủ tục 
exec USP_ThemHangHoa 'H001', N'Bánh'
exec USP_ThemHangHoa 'H002', N'Kẹo'
exec USP_ThemHangHoa 'H003', N'Đường'
exec USP_ThemHangHoa 'H004', N'Sữa'
select * from HangHoa
go

create proc USP_ThemKhachHang
	@mskh char(4),
	@tenkh nvarchar(30),
	@nodau int
as
	if	exists(select * from KhachHang where MSKH = @mskh)
		print N'Đã có khách hàng ' + @mskh + ' trong CSDL!'

	else
		begin
			insert into KhachHang values(@mskh, @tenkh, @nodau)
			print N'Thêm khách hàng thành công!'
		end
go

exec USP_ThemKhachHang 'K001', N'Nguyễn Văn Minh', 1000
exec USP_ThemKhachHang 'K002', N'Lê Ngọc Dung', 2500
exec USP_ThemKhachHang 'K003', N'Trần Tấn Lực', 0
exec USP_ThemKhachHang 'K004', N'Lê Thị Mai', 800
select * from KhachHang
go

create proc USP_ThemHoaDon
	@mshd char(4),
	@ngayhd datetime,
	@mskh char(4)
as
	-- Ràng buộc khóa ngoại (Kiểm tra khóa ngoại trước)
	if exists(select * from KhachHang where MSKH = @mskh)

		begin
			-- Ràng buộc khóa chính
			if exists(select * from HoaDon where MSHD = @mshd)
				print N'Đã có hóa đơn ' + @mshd + ' trong CSDL!'

			else
				begin
					insert into HoaDon values(@mshd, @ngayhd, @mskh)
					print N'Nhập hóa đơn thành công!'
				end
		end

	else
		print N'Không tồn tại khách hàng ' + @mskh + ' nên không thêm được hóa đơn!'
go

set dateformat dmy
exec USP_ThemHoaDon '0001', '01/01/2017', 'K001'
exec USP_ThemHoaDon '0002', '01/01/2017', 'K003'
exec USP_ThemHoaDon '0003', '10/01/2017', 'K001'
exec USP_ThemHoaDon '0004', '12/01/2017', 'K001'
exec USP_ThemHoaDon '0005', '01/02/2017', 'K003'
select * from HoaDon
go

create proc USP_ThemCTHoaDon
	@mshd char(4),
	@mshh char(4),
	@soluong int,
	@dongia int
as
	if	exists(select * from HangHoa where MSHH = @mshh) and
		exists(select * from HoaDon where MSHD = @mshd)
		
		begin
			if exists (select * from CTHoaDon where MSHH = @mshh and MSHD = @mshd)
				print N'Đã có MSHH ' + @mshh + ' và MSHD ' + @mshd + ' trong CSDL!'

			else
				begin
					insert into CTHoaDon values(@mshd, @mshh, @soluong, @dongia)
					print N'Thêm chi tiết hóa đơn thành công!'
				end
		end

	else
		
		if not exists(select * from HangHoa where MSHH = @mshh)
			print N'Không có hàng hóa ' + @mshh + ' nên không thêm được!'

		if not exists(select * from HoaDon where MSHD = @mshd)
			print N'Không có hóa đơn ' + @mshd + ' nên không thêm được!'
go

exec USP_ThemCTHoaDon '0001', 'H001', 10, 50
exec USP_ThemCTHoaDon '0001', 'H002', 5, 30
exec USP_ThemCTHoaDon '0001', 'H003', 10, 100
exec USP_ThemCTHoaDon '0002', 'H002', 20, 30
exec USP_ThemCTHoaDon '0002', 'H003', 20, 100
exec USP_ThemCTHoaDon '0003', 'H001', 15, 50
exec USP_ThemCTHoaDon '0003', 'H002', 10, 40
exec USP_ThemCTHoaDon '0004', 'H001', 5, 60
exec USP_ThemCTHoaDon '0004', 'H003', 20, 90
exec USP_ThemCTHoaDon '0005', 'H002', 10, 40
select * from CTHoaDon
go

create proc USP_ThemPhieuThu
	@mspt char(4),
	@ngaythu datetime,
	@mskh char(4),
	@sotien int
as
	if exists(select * from KhachHang where MSKH = @mskh)
		
		begin
			if exists(select * from PhieuThu where MSPT = @mspt)
				print N'Đã có phiếu thu ' + @mspt + ' trong CSDL!'

			else
				begin
					insert into PhieuThu values(@mspt, @ngaythu, @mskh, @sotien)
					print N'Nhập phiếu thu thành công!'
				end
		end

	else
		print N'Không tồn tại khách hàng ' + @mskh + ' nên không thêm được!'
go

exec USP_ThemPhieuThu 'T001', '01/01/2017', 'K001', 1000
exec USP_ThemPhieuThu 'T002', '04/01/2017', 'K002', 500
exec USP_ThemPhieuThu 'T003', '10/01/2017', 'K001', 800
exec USP_ThemPhieuThu 'T004', '15/01/2017', 'K001', 700
exec USP_ThemPhieuThu 'T005', '02/02/2017', 'K002', 1000
select * from PhieuThu
go


-- Câu 7a.
select	CTHoaDon.MSHH,
		TenHH,
		SUM(SoLuong * DonGia) as TongTienHang

from	HangHoa
		join CTHoaDon on HangHoa.MSHH = CTHoaDon.MSHH
		join HoaDon on CTHoaDon.MSHD = HoaDon.MSHD

where	NgayHD >= '2017-01-01' and NgayHD <= '2017-01-31'

group by CTHoaDon.MSHH, TenHH


-- Câu 7b.
select	MSHH,
		TenHH

from	HangHoa

where	MSHH not in

		(select  distinct
				CTHoaDon.MSHH

		from	CTHoaDon
				join HoaDon on CTHoaDon.MSHD = HoaDon.MSHD

		where	NgayHD >= '2017-01-01' and NgayHD <= '2017-01-31')


-- Câu 7c.
select	KhachHang.MSKH,
		TenKH,
		NoDau,
		COALESCE(A.TongTienHang, 0) as TongTienHang,
		COALESCE(B.TienDaTra, 0) as TongTienDaTra,

		NoDau + COALESCE(A.TongTienHang, 0) - 
		COALESCE(B.TienDaTra, 0) as ConNo

from	KhachHang
		left join	(select	MSKH,
							SUM(SoLuong * DonGia) as TongTienHang

					from	HoaDon
							join CTHoaDon on HoaDon.MSHD = CTHoaDon.MSHD

					group by MSKH) as A on A.MSKH = KhachHang.MSKH

		left join	(select	MSKH,
							SUM(SoTien) as TienDaTra

					from	PhieuThu

					group by MSKH) as B on B.MSKH = KhachHang.MSKH

go
-- Câu 8.
-- Tạo hàm: create function FN_<tên hàm>(biến 1, biến 2, ...) returns <kiểu dữ liệu>
create function FN_TongTGHoaDon(@mshd char(4)) returns int
as
	begin
	-- Khai báo biến: declare <tên biến> <kiểu dữ liệu>
		declare @tongtrigia int

			if exists(select * from HoaDon where MSHD = @mshd)
				
				begin
					select	@mshd = HoaDon.MSHD,
							@tongtrigia = SUM(SoLuong * DonGia)

					from	HoaDon
							join CTHoaDon on HoaDon.MSHD = CTHoaDon.MSHD

					where	HoaDon.MSHD = @mshd

					group by HoaDon.MSHD
				end

		return @tongtrigia
	end
go

print dbo.FN_TongTGHoaDon('0001')
go

-- Câu 9.
-- Khai báo trigger:
--create trigger TR_<tên trigger> on <Bảng bị ảnh hưởng> <for/instead> <insert/delete/update>
create trigger TR_HoaDon_INS_UPD
on HoaDon for insert, update
as
	if update(MSHD) 

		begin
			if exists (select *
				from	inserted i
				left join CTHoaDon on CTHoaDon.MSHD = i.MSHD
				where	CTHoaDon.MSHD = NULL)

			begin
				raiserror (N'Mỗi hóa đơn có ít nhất một chi tiết hóa đơn', 15, 1)
				rollback tran
			end
		end
go

create trigger TR_CTHoaDon_DEL_UPD
on CTHoaDon for delete, update
as
	