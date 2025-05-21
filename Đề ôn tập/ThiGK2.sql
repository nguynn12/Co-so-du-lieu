create database ThiGiuaHocKy
go

use ThiGiuaHocKy
go

-- Cau 4
create table HangHoa
(	
	MSHH char(4) primary key,
	TenHH nvarchar(20) not null unique
) 
go

create table KhachHang
(
	MSKH char(4) primary key,
	TenKH nvarchar(30) not null,
	--check: Ràng buộc toàn vẹn miền giá trị
	NoDau int check(NoDau >= 0)
)
go

create table HoaDon
(
	MSHD char(4) primary key,
	NgayHD datetime not null,
	MSKH char(4) references KhachHang(MSKH)
)
go

create table CTHoaDon
(
	MSHD char(4) references HoaDon(MSHD),
	MSHH char(4) references HangHoa(MSHH),
	SoLuong int check(SoLuong > 0),
	DonGia int check(DonGia > 0),
	primary key(MSHD, MSHH)
)
go

create table PhieuThu
(
	MSPT char(4) primary key,
	NgayThu datetime not null,
	MSKH char(4) references KhachHang(MSKH),
	SoTien int check(SoTien > 0)
)
go


-- Cau 5
create proc USP_ThemHangHoa
	@mshh char(4),
	@tenhh nvarchar(20)
as
	if	exists(select * from HangHoa where MSHH = @mshh)
		print N'Đã có hàng hóa ' + @mshh + N' trong CSDL!'

	else
		begin
			insert into HangHoa values(@mshh, @tenhh)
			print N'Thêm hàng hóa thành công!'
		end
go

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
		print N'Đã có khách hàng ' + @mskh + N' trong CSDL!'

	else
		begin
			insert into KhachHang values(@mskh, @tenkh, @nodau)
			print N'Thêm khách hàng thành công!'
		end
go

exec USP_ThemKhachHang 'K001', N'Nguyễn Văn Minh', 1000
exec USP_ThemKhachHang 'K002', N'Lê Ngọc Dung', 2500
exec USP_ThemKhachHang 'K003', N'Trần Tấn Lực',  0
exec USP_ThemKhachHang 'K004', N'Lê Thị Mai', 800
select * from KhachHang
go

create proc USP_ThemHoaDon
	@mshd char(4), --Khóa chính 
	@ngayhd datetime,
	@mskh char(4) --Khóa ngoại
as
	-- Kiểm tra khóa ngoại trước mới kiểm tra khóa chính
	-- Nghĩa là, nếu khóa ngoại không tồn tại thì báo lỗi
	if	exists(select * from KhachHang where MSKH = @mskh)

	-- Nếu khóa ngoại tồn tại, thì kiểm tra khóa chính
		begin
			if	exists(select * from HoaDon where MSHD = @mshd)
				print N'Đã có hóa đơn ' + @mshd + N' trong CSDL!'

			else
				begin
					insert into HoaDon values(@mshd, @ngayhd, @mskh)
					print N'Thêm hóa đơn thành công!'
				end
		end

	-- Nếu khóa ngoại không tồn tại, báo lỗi 
	else
		print N'Không có khách hàng ' + @mskh + N' nên không thêm được!'
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
			if	exists(select * from CTHoaDon where MSHD = @mshd and MSHH = @mshh)
				print N'Đã tồn tại chi tiết hóa đơn với MSHD ' + @mshd +
				N' MSHH ' + @mshh + N' trong CSDL!'

			else
				begin
					insert into CTHoaDon values(@mshd, @mshh, @soluong, @dongia)
					print N'Thêm chi tiết hóa đơn thành công!'
				end
		end
		
	else
		if not exists(select * from HangHoa where MSHH = @mshh)
			print N'Không tồn tại hàng hóa ' + @mshh + N' nên không thêm được!'

		if not exists(select * from HoaDon where MSHD = @mshd)
			print N'Không tồn tại hóa đơn ' + @mshd + N' nên không thêm được!'
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
	if	exists(select * from KhachHang where MSKH = @mskh)

		begin
			if	exists(select * from PhieuThu where MSPT = @mspt)
				print N'Đã có phiếu thu ' + @mspt + N' trong CSDL!'

			else
				begin
					insert into PhieuThu values(@mspt, @ngaythu, @mskh, @sotien)
					print N'Thêm phiếu thu thành công!'
				end
		end

	else
		print N'Không có khách hàng ' + @mskh + N' nên không thêm được!'
go

exec USP_ThemPhieuThu 'T001', '01/01/2017', 'K001', '1000'
exec USP_ThemPhieuThu 'T002', '04/01/2017', 'K002', '500'
exec USP_ThemPhieuThu 'T003', '10/01/2017', 'K001', '800'
exec USP_ThemPhieuThu 'T004', '15/01/2017', 'K001', '700'
exec USP_ThemPhieuThu 'T005', '02/02/2017', 'K002', '1000'
select * from PhieuThu
go


-- Cau 7a
select	HangHoa.MSHH,
		TenHH,
		SUM(SoLuong * DonGia) as [Tổng tiền hàng]

from	HangHoa
		join CTHoaDon on HangHoa.MSHH = CTHoaDon.MSHH
		join HoaDon on CTHoaDon.MSHD = HoaDon.MSHD

where	NgayHD between '01/01/2017' and '31/01/2017'

group by HangHoa.MSHH, TenHH


-- Cau 7b
-- Bước 1: TÌm những mã hàng hóa bán được trong tháng 1/2017
select distinct
		MSHH

from	CTHoaDon 
		join HoaDon on CTHoaDon.MSHD = HoaDon.MSHD

where	NgayHD between '01/01/2017' and '31/01/2017'

-- Bước 2: Tìm những mã hàng hóa không thuộc trong những
-- hàng hóa bán được

select	MSHH,
		TenHH

from	HangHoa

-- Lọc ra những MSHH không thuộc (not in) đám bán được
where	MSHH not in 

		(select distinct
				MSHH

		from	CTHoaDon 
				join HoaDon on CTHoaDon.MSHD = HoaDon.MSHD

		where	NgayHD between '01/01/2017' and '31/01/2017')


-- Cau 7c
select	MSKH,
		TenKH,
		NoDau

from	KhachHang

-- Bước 1: Tính tổng tiền hàng (là tiền của hàng hóa
-- mà khách hàng phải trả)

select	MSKH,
		SUM(SoLuong * DonGia) as TienHang

from	CTHoaDon
		join HoaDon on CTHoaDon.MSHD = HoaDon.MSHD

group by MSKH



-- Bước 2: Tính tổng tiền đã trả
select	MSKH,
		SUM(SoTien) as TienDaTra
		
from	PhieuThu

group by MSKH

-- Hiển thị tất cả các khách hàng (left join)
select	KhachHang.MSKH,
		TenKH,
		NoDau,
		COALESCE(TIENHANG.TienHang, 0) as [Tổng tiền hàng],
		COALESCE(TIENDATRA.TienDaTra, 0) as [Tổng tiền đã trả],

		NoDau + COALESCE(TIENHANG.TienHang, 0) - 
		COALESCE(TIENDATRA.TienDaTra, 0)as [Còn nợ]

from	KhachHang
		left join	(select	MSKH,
							SUM(SoLuong * DonGia) as TienHang

					from	CTHoaDon
							join HoaDon on CTHoaDon.MSHD = HoaDon.MSHD

					group by MSKH)TIENHANG on KhachHang.MSKH = TIENHANG.MSKH

		
		left join	(select	MSKH,
							SUM(SoTien) as TienDaTra
		
					from	PhieuThu

					group by MSKH)TIENDATRA on KhachHang.MSKH = TIENDATRA.MSKH

go


-- Cau 8
create function FN_TongTriGiaHD(@mshd char(4)) returns int
as
	begin
		declare @tong int = 0

		select	@tong = SUM(SoLuong * DonGia)

		from	CTHoaDon

		where	MSHD = @mshd

		return @tong
	end
go

print dbo.FN_TongTriGiaHD('0001')
go


-- Cau 9
create trigger TR_HoaDon_INS_UPD
on HoaDon for insert, update
as
	if update(MSHD)
		
		begin
			if	exists(select *
				from	inserted i
				left join CTHoaDon on i.MSHD = CTHoaDon.MSHD
				where	CTHoaDon.MSHD is null)

				begin
					raiserror(N'Mỗi hóa đơn có ít nhất một chi tiết hóa đơn!', 15, 1)
					rollback tran
				end
		end
go

create trigger TR_CTHoaDon_DEL_UPD
on CTHoaDon for delete, update
as
	if update(MSHD)
		
		begin
			if	exists(select *
				from	HoaDon
				left join CTHoaDon on HoaDon.MSHD = CTHoaDon.MSHD
				where	CTHoaDon.MSHD is null and
						HoaDon.MSHD in
									(select	MSHD
									from	deleted))
			begin
				raiserror('Không thể xóa chi tiết hóa đơn cuối cùng của một hóa đơn!', 15, 1)
				rollback tran
			end
		end
go

