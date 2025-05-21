/*	
	Học phần: Cơ sở dữ liệu
	Lab03: Quản lý nhập xuất hàng hóa
	SV thực hiện:
	Mã SV:
	Lớp:
	Thời gian:
*/

create database Lab03_QLNhapXuatHangHoa
go

use Lab03_QLNhapXuatHangHoa
go

create table HANGHOA
(
	MAHH varchar(5) primary key,
	TENHH varchar(30) not null,
	DVT nvarchar(10) not null,
	SOLUONGTON tinyint check(SOLUONGTON > 0)
)
go

create table DOITAC
(
	MADT char(5) primary key,
	TENDT nvarchar(30) not null,
	DIACHI nvarchar(50) not null,
	DIENTHOAI char(10) not null
)
go

create table KHANANGCC
(
	MADT char(5) references DOITAC(MADT),
	MAHH varchar(5) references HANGHOA(MAHH)
	primary key(MADT, MAHH)
)
go

create table HOADON
(
	SOHD char(5) primary key,
	NGAYLAPHD datetime not null,
	MADT char(5) references DOITAC(MADT),
	TONGTG float
)
go

create table CT_HOADON
(
	SOHD char(5) references HOADON(SOHD),
	MAHH varchar(5) references HANGHOA(MAHH),
	DONGIA int not null,
	SOLUONG tinyint not null
	primary key(SOHD, MAHH)
)
go

insert into HANGHOA values('CPU01', 'CPU INTEL,CELERON 600 BOX', N'CÁI', 5)
insert into HANGHOA values('CPU02', 'CPU INTEL,PIII 700', N'CÁI', 10)
insert into HANGHOA values('CPU03', 'CPU AMD K7 ATHL,ON 600', N'CÁI', 8)
insert into HANGHOA values('HDD01', 'HDD 10.2 GB QUANTUM', N'CÁI', 10)
insert into HANGHOA values('HDD02', 'HDD 13.6 GB SEAGATE', N'CÁI', 15)
insert into HANGHOA values('HDD03', 'HDD 20 GB QUANTUM', N'CÁI', 6)
insert into HANGHOA values('KB01', 'KB GENIUS', N'CÁI', 12)
insert into HANGHOA values('KB02', 'KB MITSUMIMI', N'CÁI', 5)
insert into HANGHOA values('MB01', 'GIGABYTE CHIPSET INTEL', N'CÁI', 10)
insert into HANGHOA values('MB02', 'ACOPR BX CHUPSET VIA', N'CÁI', 10)
insert into HANGHOA values('MB03', 'INTEL PHI CHIPSET INTEL', N'CÁI', 10)
insert into HANGHOA values('MB04', 'ECS CHIPSET SIS', N'CÁI', 10)
insert into HANGHOA values('MB05', 'ECS CHIPSET VIA', N'CÁI', 10)
insert into HANGHOA values('MNT01', 'SAMSUNG 14" SYNCMASTER', N'CÁI', 5)
insert into HANGHOA values('MNT02', 'LG 14"', N'CÁI', 5)
insert into HANGHOA values('MNT03', 'ACER 14"', N'CÁI', 8)
insert into HANGHOA values('MNT04', 'PHILIPS 14"', N'CÁI', 6)
insert into HANGHOA values('MNT05', 'VIEWSONIC 14"', N'CÁI', 7)
select * from HANGHOA

insert into DOITAC values('CC001', N'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
insert into DOITAC values('CC002', N'Cty Hoàng Long', N'15A TTT Q1 - TP.HCM', '08.8250898')
insert into DOITAC values('CC003', N'Cty Hợp Nhất', N'152 BTX Q1 - TP.HCM', '08.8252376')
insert into DOITAC values('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi Tp. Đà Lạt', '063.831129')
insert into DOITAC values('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ. N.Trang', '058590270')
insert into DOITAC values('K0003', N'Trần Nhật Duật', N'Lê Lợi TP.Huế', '054.848376')
insert into DOITAC values('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi Nghĩa - TP. Đà Lạt', '063.823409')
select * from DOITAC

insert into KHANANGCC values('CC001', 'CPU01')
insert into KHANANGCC values('CC001', 'HDD03')
insert into KHANANGCC values('CC001', 'KB01')
insert into KHANANGCC values('CC001', 'MB02')
insert into KHANANGCC values('CC001', 'MB04')
insert into KHANANGCC values('CC001', 'MNT01')
insert into KHANANGCC values('CC002', 'CPU01')
insert into KHANANGCC values('CC002', 'CPU02')
insert into KHANANGCC values('CC002', 'CPU03')
insert into KHANANGCC values('CC002', 'KB02')
insert into KHANANGCC values('CC002', 'MB01')
insert into KHANANGCC values('CC002', 'MB05')
insert into KHANANGCC values('CC002', 'MNT03')
insert into KHANANGCC values('CC003', 'HDD01')
insert into KHANANGCC values('CC003', 'HDD02')
insert into KHANANGCC values('CC003', 'HDD03')
insert into KHANANGCC values('CC003', 'MB03')
select * from KHANANGCC

set dateformat dmy
insert into HOADON values('N0001', '25/01/2006', 'CC001')
insert into HOADON values('N0002', '01/05/2006', 'CC002')
insert into HOADON values('X0001', '12/05/2006', 'K0001')
insert into HOADON values('X0002', '16/06/2006', 'K0002')
insert into HOADON values('X0003', '20/04/2006', 'K0001')
select * from HOADON

insert into CT_HOADON values('N0001', 'CPU01', 63, 10)
insert into CT_HOADON values('N0001', 'HDD03', 97, 7)
insert into CT_HOADON values('N0001', 'KB01', 3, 5)
insert into CT_HOADON values('N0001', 'MB02', 57, 5)
insert into CT_HOADON values('N0001', 'MNT01', 112, 3)
insert into CT_HOADON values('N0002', 'CPU02', 115, 3)
insert into CT_HOADON values('N0002', 'KB02', 5, 7)
insert into CT_HOADON values('N0002', 'MNT03', 111, 5)
insert into CT_HOADON values('X0001', 'CPU01', 67, 2)
insert into CT_HOADON values('X0001', 'HDD03', 100, 2)
insert into CT_HOADON values('X0001', 'KB01', 5, 2)
insert into CT_HOADON values('X0001', 'MB02', 62, 1)
insert into CT_HOADON values('X0002', 'CPU01', 67, 1)
insert into CT_HOADON values('X0002', 'KB02', 7, 3)
insert into CT_HOADON values('X0002', 'MNT01', 115, 2)
insert into CT_HOADON values('X0003', 'CPU01', 67, 1)
insert into CT_HOADON values('X0003', 'MNT03', 115, 2)
select * from CT_HOADON


-- Câu 1. Liệt kê các mặt hàng thuộc loại đĩa cứng.
select	*

from	HANGHOA

where	MAHH like 'HDD%'


-- Câu 2. Liệt kê các mặt hàng có số lượng tồn trên 10.
select	*

from	HANGHOA

where	SOLUONGTON >= 10


-- Câu 3. Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh.
select	*

from	DOITAC

where	MADT like 'CC%' and
		DIACHI like '%HCM%'


-- Câu 4. Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm:
-- SOHD, NGAYLAPHD, tên, địa chỉ, và điện thoại của nhà cung cấp; số mặt hàng.
select	CT_HOADON.SOHD as SOHD, 
		NGAYLAPHD,
		TENDT,
		DIACHI,
		DIENTHOAI,
		SOLUONG as SoMatHang

from	DOITAC
		join HOADON on DOITAC.MADT = HOADON.MADT
		join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD

where	MONTH(NGAYLAPHD) = 5 and
		YEAR(NGAYLAPHD) = 2006 and
		HOADON.SOHD like 'N%'


-- Câu 5. Cho biết tên các nhà cung cấp có cung cấp đĩa cứng.
select distinct TENDT

from	KHANANGCC
		join DOITAC on KHANANGCC.MADT = DOITAC.MADT

where	KHANANGCC.MAHH like 'HDD%'


-- Câu 6. Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng.
select	DOITAC.TENDT,
		COUNT(*) as SoLoai

from	KHANANGCC
		join DOITAC on KHANANGCC.MADT = DOITAC.MADT

where	KHANANGCC.MAHH like 'HDD%'

group by	DOITAC.TENDT

having	COUNT(*) =
				
		(select	COUNT(*)
		
		from	HANGHOA

		where	HANGHOA.MAHH like 'HDD%')


-- Câu 7. Cho biết tên nhà cung cấp không cung cấp đĩa cứng.
select 	distinct TENDT

from	KHANANGCC
		join DOITAC on KHANANGCC.MADT = DOITAC.MADT

where	DOITAC.MADT not in

		(select distinct MADT

		from	KHANANGCC

		where	MAHH like 'HDD%')


-- Câu 8. Cho biết thông tin của mặt hàng chưa bán được.
select	*

from	HANGHOA

where	MAHH not in

		(select distinct MAHH

		from	CT_HOADON

		where	SOHD like 'X%')
				

-- Câu 9. Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng).
select	TENHH,
		SUM(SOLUONG) as TongSoLuong

from	HANGHOA
		join CT_HOADON on HANGHOA.MAHH = CT_HOADON.MAHH

where	SOHD like 'X%'

group by TENHH

having	SUM(SOLUONG) >= all

		(select	SUM(SOLUONG)

		from	CT_HOADON

		where	SOHD like 'X%'
		
		group by MAHH)


-- Câu 10. Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất.
select	TENHH,
		SUM(SOLUONG) as TongSoLuong

from	HANGHOA
		join CT_HOADON on HANGHOA.MAHH = CT_HOADON.MAHH

where	SOHD like 'N%'

group by TENHH

having	SUM(SOLUONG) <= all

		(select	SUM(SOLUONG)

		from	CT_HOADON

		where	SOHD like 'N%'

		group by MAHH)


-- Câu 11. Cho biết hóa đơn nhập nhiều mặt hàng nhất.
select	HOADON.SOHD,
		HOADON.MADT,
		COUNT(*) as SoMatHang

from	HOADON
		join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD
		join DOITAC on DOITAC.MADT = HOADON.MADT

where	HOADON.SOHD like 'N%'

group by HOADON.SOHD, HOADON.MADT

having	COUNT(*) >= all

		(select	COUNT(*)

		from	HOADON
				join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD
		
		where	HOADON.SOHD like 'N%'

		group by HOADON.SOHD)


-- Câu 12. Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006.
select	MAHH,
		TENHH

from	HANGHOA
		
where	MAHH not in
		
		(select	MAHH

		from	HOADON
				join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD

		where	MONTH(NGAYLAPHD) = 01 and
				YEAR(NGAYLAPHD) = 2006 and
				HOADON.SOHD like 'N%')


-- Câu 13. Cho biết tên các mặt hàng không bán được trong tháng 6/2006.
select	MAHH,
		TENHH

from	HANGHOA

where	MAHH not in

		(select MAHH

		from	HOADON
				join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD

		where	MONTH(NGAYLAPHD) = 6 and
				YEAR(NGAYLAPHD) = 2006 and
				HOADON.SOHD like 'X%')


-- Câu 14. Cho biết cửa hàng bán bao nhiêu mặt hàng.
select	COUNT(*) as SoLuongHangHoa

from	HANGHOA


-- Câu 15. Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp.
select	DOITAC.MADT,
		TENDT,
		DIACHI,
		DIENTHOAI,
		COUNT(*) as SoLuongCungCap

from	KHANANGCC
		join DOITAC on KHANANGCC.MADT = DOITAC.MADT

group by DOITAC.MADT, TENDT, DIACHI, DIENTHOAI


-- Câu 16. Cho biết thông tin của khách hàng có giao dịch với của hàng nhiều nhất.
select	DOITAC.MADT,
		TENDT,
		DIACHI,
		DIENTHOAI,
		COUNT(*) as SoLanGiaoDich

from	DOITAC
		join HOADON on DOITAC.MADT = HOADON.MADT

where	HOADON.MADT like 'K%'

group by DOITAC.MADT, TENDT, DIACHI, DIENTHOAI

having	COUNT(*) >= ALL

		(select	COUNT(*)
		
		from	HOADON 
		
		where	MADT like 'K%'
		
		group by MADT)


-- Câu 17. Tính tổng doanh thu năm 2006.
select	SUM(DONGIA * SOLUONG) as TongDoanhThu

from	HOADON
		join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD

where	HOADON.SOHD like 'X%' and
		YEAR(NGAYLAPHD) = 2006


-- Câu 18. Cho biết loại mặt hàng bán chạy nhất.
select	HANGHOA.MAHH,
		TENHH,
		SUM(SOLUONG) as SoLuongBan

from	HANGHOA
		join CT_HOADON on HANGHOA.MAHH = CT_HOADON.MAHH
		join HOADON on HOADON.SOHD = CT_HOADON.SOHD

where	HOADON.SOHD like 'X%'

group by HANGHOA.MAHH, TENHH

having	SUM(SOLUONG) >= all

		(select	SUM(SOLUONG)
		
		from	CT_HOADON
				join HOADON on CT_HOADON.SOHD = HOADON.SOHD
		
		where	HOADON.SOHD like 'X%'
		
		group by MAHH)


-- Câu 19. Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: 
-- mahh, tenhh, dvt, tổng số lượng, tổng thành tiền.
select	HANGHOA.MAHH,
		TENHH,
		DVT,
		SUM(SOLUONG) as TongSoLuong,
		SUM(SOLUONG * DONGIA) as TongThanhTien

from	HANGHOA
		join CT_HOADON on HANGHOA.MAHH = CT_HOADON.MAHH
		join HOADON on HOADON.SOHD = CT_HOADON.SOHD

where	MONTH(NGAYLAPHD) = 5 and
		YEAR(NGAYLAPHD) = 2006

group by HANGHOA.MAHH, TENHH, DVT


-- Câu 20. Liệt kê thông tin của mặt hàng có nhiều người mua nhất.
select	HANGHOA.MAHH,
		TENHH,
		DVT,
		COUNT(*) as SoLuongMua

from	HANGHOA	
		join CT_HOADON on HANGHOA.MAHH = CT_HOADON.MAHH
		join HOADON on HOADON.SOHD = CT_HOADON.SOHD

where	HOADON.SOHD like 'X%'

group by HANGHOA.MAHH, TENHH, DVT

having	COUNT(*) >= all

		(select	COUNT(*)
		
		from	HOADON
				join CT_HOADON on CT_HOADON.SOHD = HOADON.SOHD
		
		where	HOADON.SOHD like 'X%'
		
		group by MAHH)


-- Câu 21. Tính và cập nhật tổng trị giá của các hóa đơn.
update	HOADON

set		TONGTG = A.TONGTG

from	(select	HOADON.SOHD,
				SUM(SOLUONG * DONGIA) as TONGTG

		from	HOADON
				join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD
				
		group by HOADON.SOHD) A

where	HOADON.SOHD = A.SOHD
	
select * from HOADON
go

-- A. Hàm
-- a. Tính tổng số lượng nhập trong một khoảng thời gian của một mặt hàng cho trước.
create function FN_TongLuongNhap
(	@mahh char(5),
	@batdau datetime,
	@ketthuc datetime) returns int
as 
	begin
		declare @tongsoluong int = 0

		select	@tongsoluong = SUM(SOLUONG)

		from	CT_HOADON
				join HOADON on HOADON.SOHD = CT_HOADON.SOHD
				join HANGHOA on HANGHOA.MAHH = CT_HOADON.MAHH

		where	HOADON.SOHD like 'N%' and
				NGAYLAPHD between @batdau and @ketthuc and
				CT_HOADON.MAHH = @mahh

		return	@tongsoluong
	end
go
-- print dbo.FN_TongLuongNhap('CPU01', '24/01/2006', '31/01/2006')


-- b. Tính tổng số lượng xuất trong một khoảng thời gian của một mặt hàng cho trước.
create function FN_TongLuongXuat
(	@mahh char(5),
	@batdau datetime,
	@ketthuc datetime) returns int
as 
	begin
		declare @tongsoluong int = 0

		select	@tongsoluong = SUM(SoLuong)

		from	CT_HOADON
				join HOADON on HOADON.SOHD = CT_HOADON.SOHD
				join HANGHOA on HANGHOA.MAHH = CT_HOADON.MAHH

		where	HOADON.SOHD like 'X%' and
				NGAYLAPHD between @batdau and @ketthuc and
				CT_HOADON.MAHH = @mahh

		return	@tongsoluong
	end
go
-- print dbo.FN_TongLuongXuat('CPU01', '11/05/2006', '17/06/2006')


-- c. Tính tổng doanh thu trong một tháng cho trước.
create function FN_TongDoanhThuThang(@thang datetime) returns int
as
	begin
		declare @doanhthu int = 0

		select	@doanhthu = SUM(DONGIA * SOLUONG)

		from	HOADON
				join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD

		where	HOADON.SOHD like 'X%' and
				MONTH(NGAYLAPHD) = @thang
		
		return	@doanhthu
	end
go
-- print dbo.FN_TongDoanhThuThang(5)


-- d. Tính tổng doanh thu của một mặt hàng trong một khoảng thời gian cho trước.
create function FN_TongDoanhThuMH
(	@mahh varchar(5),
	@batdau datetime,
	@ketthuc datetime) returns int
as
	begin
		declare @doanhthu int = 0

		select	@doanhthu = SUM(DONGIA * SOLUONG)

		from	HOADON
				join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD

		where	HOADON.SOHD like 'X%' and
				NGAYLAPHD between @batdau and @ketthuc and
				MAHH = @mahh
			
		return	@doanhthu
	end
go
-- print dbo.FN_TongDoanhThuMH('CPU01', '20/04/2006', '30/04/2006')


-- e. Tính tổng số tiền nhập hàng trong một khoảng thời gian cho trước.
create function FN_TongTienNhap
(	@batdau datetime,
	@ketthuc datetime) returns int
as 
	begin
		declare @tongtien int = 0

		select	@tongtien = SUM(SOLUONG * DONGIA)

		from	CT_HOADON
				join HOADON on HOADON.SOHD = CT_HOADON.SOHD
				join HANGHOA on HANGHOA.MAHH = CT_HOADON.MAHH

		where	HOADON.SOHD like 'N%' and
				NGAYLAPHD between @batdau and @ketthuc

		return	@tongtien
	end
go
-- print dbo.FN_TongTienNhap('25/01/2006', '31/01/2006')


-- f. Tính tổng số tiền của một hóa đơn cho trước.
create function FN_TongTienHoaDon(@sohd char(5)) returns int
as
	begin
		declare @tongtien int = 0
		
		select	@tongtien = SUM(SOLUONG * DONGIA)

		from	CT_HOADON
				join HOADON on CT_HOADON.SOHD = HOADON.SOHD

		where	HOADON.SOHD = @sohd

		return	@tongtien
	end
go
-- print dbo.FN_TongTienHoaDon('X0001')


-- B. Thủ tục
-- a. Cập nhật số lượng tồn của một mặt hàng khi nhập hàng hoặc khi xuất hàng.
create proc USP_CapNhatSLTon
	@mahh varchar(5)
as
	if	exists(select * from HANGHOA where MAHH = @mahh)

		begin
			declare @tongnhap int = 0, @tongxuat int = 0 
			
			select	@tongnhap = SUM(SoLuong)
			from	CT_HOADON
					join HOADON on CT_HOADON.SOHD = HOADON.SOHD
			where	CT_HOADON.MAHH = @mahh and
					HOADON.SOHD like 'N%'

			select	@tongxuat = SUM(SoLuong)
			from	CT_HOADON
					join HOADON on CT_HOADON.SOHD = HOADON.SOHD
			where	CT_HOADON.MAHH = @mahh and
					HOADON.SOHD like 'X%'
			
			update	HANGHOA
			set		SOLUONGTON = SOLUONGTON + @tongnhap - @tongxuat
			where	MAHH = @mahh
		end

	else
		print N'Không có hàng hóa ' + @mahh + ' trong CSDL!'
go 
-- select * from HANGHOA
-- exec USP_CapNhatSLTon 'CPU01'


-- b. Cập nhật tổng trị giá của một hóa đơn.
create proc USP_CapNhatTGHD
	@sohd char(5)
as
	if	exists(select * from HOADON where SOHD = @sohd)
		
		begin
			update	HOADON
			set		TONGTG = TG.TongTG
			from	(select	SOHD = @sohd,
							SUM(SOLUONG * DONGIA) as TongTG
							
					from	CT_HOADON

					group by SOHD) TG
			where	HOADON.SOHD = @sohd
		end

	else
		print N'Không có hóa đơn ' + @sohd + ' trong CSDL!'
go
-- exec USP_CapNhatTGHD 'N0001'


-- c. In đầy đủ thông tin của một hóa đơn.
create proc USP_In4HoaDon
	@sohd char(5)
as
	if	exists(select * from HOADON where SOHD = @sohd)

		begin
			select	HOADON.SOHD,
					HOADON.NGAYLAPHD,
					HOADON.MADT,
					DOITAC.TENDT,
					HANGHOA.TENHH,
					HANGHOA.DVT,
					CT_HOADON.SOLUONG,
					CT_HOADON.DONGIA,
					CT_HOADON.SOLUONG * CT_HOADON.DONGIA as THANHTIEN,
					HOADON.TONGTG
			from	HOADON
					join DOITAC on HOADON.MADT = DOITAC.MADT
					join CT_HOADON on HOADON.SOHD = CT_HOADON.SOHD
					join HANGHOA on HANGHOA.MAHH = CT_HOADON.MAHH
			where	HOADON.SOHD = @sohd
		end

	else
		print N'Không có hóa đơn ' + @sohd + ' trong CSDL!'
go
-- exec USP_In4HoaDon 'N0001'