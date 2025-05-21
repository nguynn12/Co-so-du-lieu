/*
	Học phần: Cơ sở dữ liệu
	Lab02: Quản lý sản xuất
	SV thực hiện:
	Mã SV:
	Lớp:
	Thời gian:
*/

create database Lab02_QuanLySanXuat
go

use Lab02_QuanLySanXuat
go

create table ToSanXuat
(
	MaTSX char(4) primary key,
	TenTSX nvarchar(10) not null unique
)
go

create table CongNhan
(
	MACN char(5) primary key,
	Ho nvarchar(30) not null,
	Ten nvarchar(20) not null,
	Phai nvarchar(5) not null,
	NgaySinh datetime,
	MaTSX char(4) references ToSanXuat(MaTSX)
)
go

create table SanPham
(
	MaSP char(5) primary key,
	TenSP nvarchar(30) not null unique,
	DVT nvarchar(10) not null,
	TienCong int check(TienCong > 0)
)
go

create table ThanhPham
(
	MACN char(5) references CongNhan(MACN),
	MaSP char(5) references SanPham(MaSP),
	Ngay datetime not null,
	SoLuong int check(SoLuong > 0),
	primary key(MaCN, MaSP, Ngay)
)
go

insert into ToSanXuat values('TS01', N'Tổ 1')
insert into ToSanXuat values('TS02', N'Tổ 2')
select * from ToSanXuat

set dateformat dmy
insert into CongNhan values('CN001', N'Nguyễn Trường', N'An', N'Nam', '12/05/1981', 'TS01')
insert into CongNhan values('CN002', N'Lê Thị Hồng', N'Gấm', N'Nữ', '04/06/1980', 'TS01')
insert into CongNhan values('CN003', N'Nguyễn Công', N'Thành', N'Nam', '04/05/1981', 'TS02')
insert into CongNhan values('CN004', N'Võ Hữu', N'Hạnh', N'Nam', '15/02/1980', 'TS02')
insert into CongNhan values('CN005', N'Lý Thanh', N'Hân', N'Nữ', '03/12/1981', 'TS01')
select * from CongNhan

insert into SanPham values('SP001', N'Nồi đất', N'cái', 10000)
insert into SanPham values('SP002', N'Chén', N'cái', 2000)
insert into SanPham values('SP003', N'Bình gốm nhỏ', N'cái', 20000)
insert into SanPham values('SP004', N'Bình gốm lớn', N'cái', 25000)
select * from SanPham

set dateformat dmy
insert into ThanhPham values('CN001', 'SP001', '01/02/2007', 10)
insert into ThanhPham values('CN002', 'SP001', '01/02/2007', 5)
insert into ThanhPham values('CN003', 'SP002', '10/01/2007', 50)
insert into ThanhPham values('CN004', 'SP003', '12/01/2007', 10)
insert into ThanhPham values('CN005', 'SP002', '12/01/2007', 100)
insert into ThanhPham values('CN002', 'SP004', '13/02/2007', 10)
insert into ThanhPham values('CN001', 'SP003', '14/02/2007', 15)
insert into ThanhPham values('CN003', 'SP001', '15/01/2007', 20)
insert into ThanhPham values('CN003', 'SP004', '14/02/2007', 15)
insert into ThanhPham values('CN004', 'SP002', '30/01/2007', 100)
insert into ThanhPham values('CN005', 'SP003', '01/02/2007', 50)
insert into ThanhPham values('CN001', 'SP001', '20/02/2007', 30)
select * from ThanhPham


-- Câu 1. Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: 
-- TenTSX, HoTen, NgaySinh, Phai (xếp thứ tự tăng dần của tên tổ sản xuất, Tên của công nhân).
select	TenTSX,
		CONCAT(Ho, ' ', Ten) as HoTen,
		NgaySinh,
		Phai

from	CongNhan
		join ToSanXuat on CongNhan.MATSX = ToSanXuat.MATSX

order by TenTSX, Ten


-- Câu 2. Liệt kê các thành phẩm mà công nhân ‘Nguyễn Trường An’ đã làm được gồm các thông tin: 
-- TenSP, Ngay, SoLuong, ThanhTien (xếp theo thứ tự tăng dần của ngày).
select	TenSP,
		Ngay,
		SoLuong,
		SoLuong * TienCong as ThanhTien

from	CongNhan
		join ThanhPham on CongNhan.MaCN = ThanhPham.MACN
		join SanPham on SanPham.MaSP = ThanhPham.MaSP

where	Ho = N'Nguyễn Trường' and
		Ten = N'An'

order by Ngay


-- Câu 3. Liệt kê các nhân viên không sản xuất sản phẩm ‘Bình gốm lớn’.
select	*

from	CongNhan

where	CongNhan.MaCN not in
		
		(select	MACN

		from	ThanhPham
				join SanPham on ThanhPham.MASP = SanPham.MaSP

		where	TenSP = N'Bình gốm lớn')
				

-- Câu 4. Liệt kê thông tin các công nhân có sản xuất cả ‘Nồi đất’ và ‘Bình gốm nhỏ’.
select distinct
		CONCAT(CongNhan.Ho, ' ', CongNhan.Ten) as HoTen,
		NgaySinh,
		Phai

from	CongNhan
		join ThanhPham on CongNhan.MaCN = ThanhPham.MACN
		join SanPham on SanPham.MaSP = ThanhPham.MaSP

where	TenSP = N'Nồi đất' and
		CongNhan.MACN in

		(select MaCN

		from	ThanhPham
				join SanPham on ThanhPham.MaSP = SanPham.MaSP

		where	TenSP = N'Bình gốm nhỏ')

		
-- Câu 5. Thống kê Số lượng công nhân theo từng tổ sản xuất.
select	ToSanXuat.MaTSX as MaTSX,
		TenTSX,
		COUNT(*) as SoLuongCongNhan

from	ToSanXuat
		join CongNhan on ToSanXuat.MaTSX = CongNhan.MaTSX

group by ToSanXuat.MaTSX, ToSanXuat.TenTSX


-- Câu 6. Tổng số lượng thành phẩm theo từng loại mà mỗi công nhân làm được 
-- (Ho, Ten, TenSP, TongSLThanhPham, TongThanhTien).
select	Ho,
		Ten,
		TenSP,
		SUM(SoLuong) as TongSLThanhPham,
		SUM(SoLuong * TienCong) as TongThanhTien

from	SanPham
		join ThanhPham on SanPham.MaSP = ThanhPham.MaSP
		join CongNhan on ThanhPham.MaCN = CongNhan.MACN

group by SanPham.MaSP, TenSP, Ho, Ten, SanPham.TenSP


-- Câu 7. Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007.
select	SUM(SoLuong * TienCong) as TongTienCong

from	ThanhPham
		join SanPham on ThanhPham.MASP = SanPham.MaSP

where	MONTH(Ngay) = 01 and
		YEAR(Ngay) = 2007


-- Câu 8. Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007.
select	TenSP,
		SUM(SoLuong) as SoLuong

from	SanPham
		join ThanhPham on ThanhPham.MASP = SanPham.MaSP

where	MONTH(Ngay) = 2 and
		YEAR(Ngay) = 2007

group by SanPham.MaSP, TenSP

having	SUM(SoLuong) >= all

		(select SUM(SoLuong)

		from	SanPham
				join ThanhPham on ThanhPham.MaSP = SanPham.MaSP

		where	MONTH(Ngay) = 2 and
				YEAR(Ngay) = 2007

		group by SanPham.MaSP)


-- Câu 9. Cho biết công nhân sản xuất được nhiều ‘Chén’ nhất.
select	CONCAT(Ho, ' ', Ten) as HoTen,
		Phai,
		SUM(SoLuong) as TongSoLuong

from	CongNhan
		join ThanhPham on ThanhPham.MACN = CongNhan.MACN
		join SanPham on SanPham.MaSP = ThanhPham.MaSP

where	TenSP = N'Chén'

group by CongNhan.Ho, CongNhan.Ten, CongNhan.Phai, CongNhan.MACN, SanPham.MaSP

having	SUM(SoLuong) >= all

		(select	SUM(SoLuong)
		
		from	ThanhPham
				join SanPham on ThanhPham.MaSP = SanPham.MaSP
		
		where	TenSP = N'Chén'
		
		group by ThanhPham.MACN)


-- Câu 10. Tiền công tháng 2/2006 của công nhân viên có mã số ‘CN002’.
select	SUM(TienCong * SoLuong) as TienCong

from	CongNhan
		join ThanhPham on ThanhPham.MACN = CongNhan.MACN
		join SanPham on SanPham.MaSP = ThanhPham.MaSP

where	ThanhPham.MACN = 'CN002' and
		MONTH(Ngay) = 2 and
		YEAR(Ngay) = 2007


-- Câu 11. Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên.
select	CONCAT(Ho, ' ', Ten) as HoTen,
		COUNT(DISTINCT MaSP) as SoLuongSP

from	CongNhan
		join ThanhPham on ThanhPham.MACN = CongNhan.MACN

group by Ho, Ten, CongNhan.MACN

having	COUNT(DISTINCT MaSP) >= 3


-- Câu 12. Cập nhật giá tiền công của các loại bình gốm thêm 1000.
update SanPham

set TienCong = TienCong + 1000

where TenSP like N'Bình gốm %'


-- Câu 13. 13)	Thêm bộ <’CN006’, ‘Lê Thị’, ‘Lan’, ‘Nữ’,’TS02’ > vào bảng CongNhan.
insert into CongNhan values ('CN006', N'Lê Thị', N'Lan', N'Nữ', NULL, 'TS02')
go


-- A. Hàm
-- a. Tính tổng số công nhân của một tổ sản xuất cho trước.
create function FN_TongSoCN(@matsx char(4)) returns int
as
	begin
		declare @tong int

		select	@tong = COUNT(*)

		from	CongNhan
				join ToSanXuat on CongNhan.MaTSX = ToSanXuat.MaTSX

		where	CongNhan.MaTSX = @matsx
		group by CongNhan.MaTSX

		return @tong
	end
go
-- print dbo.FN_TongSoCN('TS02')


-- b. Tính tổng sản lượng sản xuất trong một tháng của một loại sản phẩm cho trước.
create function FN_TongSLSanXuat
(	@masp char(5),
	@thang datetime,
	@nam datetime) returns int
as
	begin
		declare @sanluong int

		select	@sanluong = SUM(SoLuong)

		from	ThanhPham
				join SanPham on ThanhPham.MaSP = SanPham.MaSP

		where	SanPham.MaSP = @masp and
				MONTH(Ngay) = @thang and
				YEAR(Ngay) = @nam

		return	COALESCE(@sanluong, 0)
	end
go
-- print dbo.FN_TongSLSanXuat('SP001', 2, 2007)


-- c. Tính tổng tiền công tháng của một công nhân cho trước.
create function FN_TongTienCong 
(	@macn char(5), 
	@thang datetime,
	@nam datetime) returns int
as
	begin
		declare @tiencong int

		select	@tiencong = SUM(SoLuong * TienCong)

		from	ThanhPham
				join SanPham on ThanhPham.MaSP = SanPham.MaSP

		where	MACN = @macn and
				MONTH(Ngay) = @thang and
				YEAR(Ngay) = @nam

		return	COALESCE(@tiencong, 0)
	end
go
-- print dbo.FN_TongTienCong('CN001', 2, 2007) 


-- d. Tính tổng thu nhập trong năm của một tổ sản xuất cho trước.
create function FN_ThuNhapTSX
(	@matsx char(4),
	@nam datetime) returns int
as
	begin
		declare @thunhap int

		select	@thunhap = SUM(TienCong * SoLuong) 

		from	ThanhPham
				join CongNhan on ThanhPham.MACN = CongNhan.MACN
				join ToSanXuat on CongNhan.MaTSX = ToSanXuat.MaTSX
				join SanPham on SanPham.MaSP = ThanhPham.MaSP

		where	ToSanXuat.MaTSX = @matsx and
				YEAR(Ngay) = @nam

		return	@thunhap
	end
go
-- print dbo.FN_ThuNhapTSX('TS01', 2007)


-- e. Tính tổng sản lượng sản xuất trong một tháng của một loại sản phẩm cho trước.
create function FN_TongSLSanXuatInRange
(	@masp char(5),
	@batdau datetime,
	@ketthuc datetime) returns int
as
	begin
		declare @sanluong int

		select	@sanluong = SUM(SoLuong)

		from	ThanhPham
				join SanPham on ThanhPham.MaSP = SanPham.MaSP

		where	SanPham.MaSP = @masp and
				Ngay between @batdau and @ketthuc

		return	COALESCE(@sanluong, 0)
	end
go
-- print dbo.FN_TongSLSanXuatInRange('SP001', '01/02/2007', '20/02/2007')


-- B. Thủ tục
-- a. In danh sách các công nhân của một tổ sản xuất cho trước.
create proc USP_InDanhSach
	@matsx char(4)
as
	if exists(select * from ToSanXuat where MaTSX = @matsx)
		select	* 
		from	CongNhan 
		where	MaTSX = @matsx

	else
		print N'Không có tổ sản xuất ' + @matsx + ' trong CSDL!'
go
-- exec USP_InDanhSach 'TS01'


-- b. In bảng chấm công sản xuất trong tháng của một công nhân cho trước
create proc USP_InBangChamCong
	@macn char(5),
	@thang  datetime
as
	if exists(select * from CongNhan where MACN = @macn)
		
		begin
			select	TenSP,
					DVT,
					SoLuong,
					TienCong as DonGia,
					SoLuong * TienCong as ThanhTien

			from	CongNhan
					join ThanhPham on CongNhan.MACN = ThanhPham.MACN
					join SanPham on ThanhPham.MaSP = SanPham.MaSP
			
			where	CongNhan.MACN = @macn and
					MONTH(Ngay) = @thang
		end

	else
		print N'Không có công nhân ' + @macn + ' trong CSDL!'
go
-- exec USP_InBangChamCong 'CN005', 2