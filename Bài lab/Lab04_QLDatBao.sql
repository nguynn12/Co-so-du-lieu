/*
	Học phần: Cơ sở dữ liệu
	Lab04: Quản lý đặt báo
	SV thực hiện:
	Mã SV:
	Lớp:
	Thời gian:
*/

create database Lab04_QuanLyDatBao
go

use Lab04_QuanLyDatBao
go

create table BAO_TCHI
(	
	MaBaoTC char(4) primary key,
	Ten nvarchar(30) not null,
	DinhKy nvarchar(30) not null,
	SoLuong int check(SoLuong > 0),
	Giaban int check(GiaBan > 0)
)
go

create table PHATHANH
(
	MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
	SoBaoTC int check(SoBaoTC > 0),
	NgayPH datetime
	primary key(MaBaoTC, SoBaoTC)
)
go

create table KHACHHANG
(
	MaKH char(4) primary key,
	TenKH nvarchar(30) not null,
	DiaChi varchar(30) not null
)
go

create table DATBAO
(
	MaKH char(4) references KHACHHANG,
	MaBaoTC char(4) references BAO_TCHI,
	SLMua int check (SLMua > 0),
	NgayDM datetime,
	primary key(MaKh, MaBaoTC)
)
go

create proc USP_ThemBAO_TCHI
	@mabaotc char(4),
	@ten nvarchar(30),
	@dinhky nvarchar(30),
	@soluong int,
	@giaban int
as
	if	exists(select * from BAO_TCHI where MaBaoTC = @mabaotc)
		print N'Đã có báo, tạp chí ' + @mabaotc + ' trong CSDL!'

	else
		begin
			insert into BAO_TCHI values(@mabaotc, @ten, @dinhky, @soluong, @giaban)
			print N'Thêm báo, tạp chí thành công!'
		end
go

exec USP_ThemBAO_TCHI'TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500
exec USP_ThemBAO_TCHI'KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000
exec USP_ThemBAO_TCHI'TN01', N'Thanh niên', N'Nhật báo', 1000, 2000
exec USP_ThemBAO_TCHI'PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000
exec USP_ThemBAO_TCHI'PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000
select * from BAO_TCHI
go

create proc USP_ThemPHATHANH
	@mabaotc char(4),
	@sobaotc int,
	@ngayph datetime
as	
	if	exists(select * from BAO_TCHI where MaBaoTC = @mabaotc)

		begin
			if	exists(select * from PHATHANH where MaBaoTC = @mabaotc and SoBaoTC = @sobaotc)
				print N'Đã có lần phát hành với MaBaoTC ' + @mabaotc + ' và SoBaoTC ' + @sobaotc + ' trong CSDL!'

			else
				begin
					insert into PHATHANH values(@mabaotc, @sobaotc, @ngayph)
					print N'Thêm lần phát hành thành công!'
				end
		end

	else
		print N'Không tồn tại ' + @mabaotc + ' nên không thêm được lần phát hành!'
go

set dateformat dmy
exec USP_ThemPHATHANH 'TT01', 123, '15/12/2005'
exec USP_ThemPHATHANH 'KT01', 70, '15/12/2005'
exec USP_ThemPHATHANH 'TT01', 124, '16/12/2005'
exec USP_ThemPHATHANH 'TN01', 256, '17/12/2005'
exec USP_ThemPHATHANH 'PN01', 45, '23/12/2005'
exec USP_ThemPHATHANH 'PN02', 111, '18/12/2005'
exec USP_ThemPHATHANH 'PN02', 112, '19/12/2005'
exec USP_ThemPHATHANH 'TT01', 125, '17/12/2005'
exec USP_ThemPHATHANH 'PN01', 46, '30/12/2005'
select * from PHATHANH
go

create proc USP_ThemKHACHHANG
	@makh char(4),
	@tenkh nvarchar(30),
	@diachi varchar(30)
as
	if	exists(select * from KHACHHANG where MaKH = @makh)
		print N'Đã có khách hàng ' + @makh + ' trong CSDL!'

	else
		begin
			insert into KHACHHANG values(@makh, @tenkh, @diachi)
			print N'Thêm khách hàng thành công!'
		end
go


exec USP_ThemKHACHHANG 'KH01', N'LAN', '2 NCT'
exec USP_ThemKHACHHANG 'KH02', N'NAM', '32 THĐ'
exec USP_ThemKHACHHANG 'KH03', N'NGỌC', '16 LHP'
select * from KHACHHANG
go

create proc USP_ThemDATBAO
	@makh char(4),
	@mabaotc char(4),
	@slmua int,
	@ngaydm datetime
as
	if	exists(select * from KHACHHANG where MaKH = @makh) and
		exists(select * from BAO_TCHI where MaBaoTC = @mabaotc)

		begin
			if	exists(select * from DATBAO where MaKH = @makh and MaBaoTC = @mabaotc)
				print N'Đã có lần đặt báo với ' + @makh + ' và MaBaoTC ' + @mabaotc + ' trong CSDL!'

			else
				begin
					insert into DATBAO values(@mabaotc, @slmua, @ngaydm)
					print N'Thêm lần đặt báo thành công!'
				end
		end

	else
		if	not exists(select * from KHACHHANG where MaKH = @makh)
			print N'Không có khách hàng ' + @makh + ' nên không thêm được lần đặt báo!'

		if	not exists(select * from BAO_TCHI where MaBaoTC = @mabaotc)
			print N'Không có báo, tạp chí ' + @mabaotc + ' nên không thêm được lần đặt báo!'
go

set dateformat dmy
exec USP_ThemDATBAO 'KH01', 'TT01', 100, '12/01/2000'
exec USP_ThemDATBAO 'KH02', 'TN01', 150, '01/05/2001'
exec USP_ThemDATBAO 'KH01', 'PN01', 200, '25/06/2001'
exec USP_ThemDATBAO 'KH03', 'KT01', 50, '17/03/2002'
exec USP_ThemDATBAO 'KH03', 'PN02', 200, '26/08/2003'
exec USP_ThemDATBAO 'KH02', 'TT01', 250, '15/01/2004'
exec USP_ThemDATBAO 'KH01', 'KT01', 300, '14/10/2004'
select * from DATBAO


-- Câu 1. Cho biết các tờ báo, tạp chí có định kỳ phát hành hàng tuần (Tuần báo).
select	*

from	BAO_TCHI

where	DinhKy = N'Tuần báo'


-- Câu 2. Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ.
select	*

from	BAO_TCHI

where	MaBaoTC like 'PN%'


-- Câu 3. Cho biết tên các khách hàng có đặt mua báo phụ nữ, không liệt kê khách hàng trùng.
select distinct	
		KHACHHANG.MaKH as MaKH,
		TenKH,
		DiaChi

from	DATBAO
		join KHACHHANG on DATBAO.MaKH = KHACHHANG.MaKH
		join BAO_TCHI on BAO_TCHI.MaBaoTC =	DATBAO.MaBaoTC

where	BAO_TCHI.MaBaoTC like 'PN%'


-- Câu 4. Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ.
select distinct	
		KHACHHANG.MaKH as MaKH,
		TenKH,
		DiaChi
		--COUNT(*) as SoLuongBao

from	DATBAO	
		join KHACHHANG on KHACHHANG.MaKH = DATBAO.MaKH
		join BAO_TCHI on BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC

where	Bao_TCHI.MaBaoTC like 'PN%'

group by	KHACHHANG.MaKH, TenKH, DiaChi 

having	COUNT(*) =
		
		(select	COUNT(*)

		from	BAO_TCHI

		where	MaBaoTC like 'PN%')


-- Câu 5. Cho biết các khách hàng không đặt mua báo thanh niên.
select	*

from	KHACHHANG

where	MaKH not in
		
		(select	MAKH

		from	DATBAO
				join BAO_TCHI on BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC

		where	BAO_TCHI.MaBaoTC like 'TN%')


-- Câu 6. Cho biết số tờ báo mà mỗi khách hàng đã đặt mua.
select 	DATBAO.MaKH,
		TenKH,
		DiaChi,
		SUM(SLMua) as SLMua

from	DATBAO
		join KHACHHANG on KHACHHANG.MaKH = DATBAO.MaKH

group by DATBAO.MaKH, TenKH, DiaChi


-- Câu 7. Cho biết số khách đặt mua báo trong năm 2004.
select	COUNT(distinct MaKH) as SoLuong

from	DATBAO

where	YEAR(NgayDM) = 2004


-- Câu 8. Cho biết thông tin đặt mua báo của các khách hàng, trong đó SoTien = SLMua x DonGia
select	TenKH,
		Ten,
		DinhKy,
		SUM(SLMua) as SLMua,
		SUM(SLMua * Giaban) as SoTien

from	DATBAO
		join BAO_TCHI on DATBAO.MaBaoTC = BAO_TCHI.MaBaoTC
		join KHACHHANG on KHACHHANG.MaKH = DATBAO.MaKH

group by TenKH, Ten, DinhKy


-- Câu 9. Cho biết các tờ báo, tạp chí và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
select	Ten,
		DinhKy,
		SUM(SLMua) as SLMua

from	BAO_TCHI
		join DATBAO on BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC

group by Ten, DinhKy


-- Câu 10. Cho biết tên các tờ báo dành cho học sinh, sinh viên.
select	*

from	BAO_TCHI

where	MaBaoTC like 'HS%'

		
-- Câu 11. Cho biết những tờ báo không có người đặt mua.
select	*

from	BAO_TCHI

where	MaBaoTC not in

		(select distinct MaBaoTC

		from DATBAO)


-- Câu 12. Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
select	Ten,
		DinhKy,
		SUM(SLMua) as SLMua

from	DATBAO
		join BAO_TCHI on BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC

group by Ten, DinhKy

having	SUM(SLMua) >= all

		(select	SUM(SLMua)
		
		from	DATBAO
		
		group by MaBaoTC)


-- Câu 13. Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
select	KHACHHANG.MaKH,
		TenKH,
		SUM(SLMua) as SLMua

from	KHACHHANG
		join DATBAO	on KHACHHANG.MaKH = DATBAO.MaKH

group by KHACHHANG.MaKH, TenKH

having	SUM(SLMua) >= all

		(select	SUM(SLMua)

		from	DATBAO
			
		group by MaKH)


-- Câu 14. Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
select	A.MaBaoTC,
		Ten,
		DinhKy,
		A.Thang,
		A.Nam,
		A.SoLanPhatHanh

from	(select	MaBaoTC, 
				MONTH(NgayPH) as Thang,
				YEAR(NgayPH) as Nam, 
				COUNT(*) SoLanPhatHanh
		
		from	PHATHANH
		
		group by MaBaoTC, MONTH(NgayPH), YEAR(NgayPH)
		
		having COUNT(*) = 2) as A

		join BAO_TCHI on BAO_TCHI.MaBaoTC = A.MaBaoTC


-- Câu 15. Cho biết các tờ báo tạp chí có từ 3 khách hàng đặt mua trở lên.
select	DATBAO.MaBaoTC,
		Ten,
		DinhKy,
		COUNT(*) as SoLuongDatMua

from	DATBAO
		join BAO_TCHI on DATBAO.MaBaoTC = BAO_TCHI.MaBaoTC

group by DATBAO.MaBaoTC, Ten, DinhKy

having COUNT(*) >= 3
go


-- A. Hàm
-- a. Tính tổng số tiền mua báo/tạp chí của một khách hàng cho trước.
create function FN_TongSoTienMua(@makh char(4)) returns int
as
	begin
		declare @tongsotien int = 0

		select	@tongsotien = SUM(SLMua * GiaBan) 

		from	DATBAO
				join BAO_TCHI on DATBAO.MaBaoTC = BAO_TCHI.MaBaoTC

		where	MAKH = @makh

		return	@tongsotien
	end
go
-- print dbo.FN_TongSoTienMua('KH01')


-- b. Tính tổng số tiền thu được của một tờ báo/tạp chí cho trước.
create function FN_TongTienThuBaoTC(@mabaotc char(4)) returns int
as
	begin
		declare @tongtienthu int = 0

		select	@tongtienthu = SUM(SLMua * GiaBan)

		from	DATBAO
				join BAO_TCHI on DATBAO.MaBaoTC = BAO_TCHI.MaBaoTC

		where	DATBAO.MaBaoTC = @mabaotc

		return	@tongtienthu
	end
go
--  print dbo.FN_TongTienThuBaoTC('TT01')


-- B. Thủ tục 
-- a. In danh mục báo tạp chí phải giao cho một khách hàng cho trước.
create proc USP_InBaoTCPhaiGiao
	@makh char(4)
as
	if	exists(select * from KHACHHANG where MaKH = @makh)
		begin
			select	BAO_TCHI.*

			from	BAO_TCHI
					join DATBAO on BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC
			where	MaKH = @makh
		end
	
	else
		print N'Không có khách hàng ' + @makh + ' trong CSDL!'
go
-- exec USP_InBaoTCPhaiGiao 'KH01'


-- b. In danh sách khách hàng đặt mua báo/tạp chí cho trước.
create proc USP_InKhachHangDatMua
	@mabaotc char(4)
as
	if	exists(select * from BAO_TCHI where MaBaoTC = @mabaotc)
		begin
			select	KHACHHANG.*

			from	DATBAO
					join BAO_TCHI on BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC
					join KHACHHANG on KHACHHANG.MaKH = DATBAO.MaKH

			where	BAO_TCHI.MaBaoTC = @mabaotc

		end

	else
		print N'Không có báo, tạp chí ' + @mabaotc + ' trong CSDL!'
go
-- exec USP_InKhachHangDatMua 'TT01'