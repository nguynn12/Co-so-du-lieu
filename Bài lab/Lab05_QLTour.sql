/*
	Học phần: Cơ sở dữ liệu
	Lab05: Quản lý tour du lịch
	SV thực hiện:
	Mã SV:
	Lớp:
	Thời gian:
*/

create database Lab05_QLTour
go

use Lab05_QLTour
go

create table Tour
(
	MaTour char(4) primary key,
	TongSoNgay tinyint check(TongSoNgay > 0)
)
go

create table ThanhPho
(
	MaTP char(2) primary key,
	TenTP nvarchar(30) not null unique
)
go

create table Tour_TP
(
	MaTour char(4) references Tour(MaTour),
	MaTP char(2) references ThanhPho(MaTP),
	SoNgay tinyint check(SoNgay > 0),
	primary key(MaTour, MaTP)
)
go

create table Lich_TourDL
(
	MaTour char(4) references Tour(MaTour),
	NgayKH datetime,
	TenHDV nvarchar(10) not null,
	SoNguoi tinyint check(SoNguoi > 0),
	TenKH nvarchar(20) not null,
	primary key(MaTour, NgayKH)
)
go

create proc USP_ThemTour
	@matour char(4),
	@tongsongay tinyint
as
	if exists(select * from Tour where MaTour = @matour)
		print N'Đã có tour ' + @matour + ' trong CSDL!'

	else
		begin
			insert into Tour values(@matour, @tongsongay)
			print N'Thêm tour thành công!'
		end
go

exec USP_ThemTour 'T001', 3
exec USP_ThemTour 'T002', 4
exec USP_ThemTour 'T003', 5
exec USP_ThemTour 'T004', 7
select * from Tour
go

create proc USP_ThemThanhPho
	@matp char(2),
	@ten nvarchar(30)
as
	if exists(select * from ThanhPho where MaTP = @matp)
		print N'Đã có thành phố ' + @matp + ' trong CSDL!'

	else
		begin
			insert into ThanhPho values(@matp, @ten)
			print N'Thêm thành phố thành công!'
		end
go

exec USP_ThemThanhPho '01', N'Đà Lạt'
exec USP_ThemThanhPho '02', N'Nha Trang'
exec USP_ThemThanhPho '03', N'Phan Thiết'
exec USP_ThemThanhPho '04', N'Huế'
exec USP_ThemThanhPho '05', N'Đà Nẵng'
select * from ThanhPho
go

create proc USP_ThemTour_TP
	@matour char(4),
	@matp char(2),
	@songay tinyint
as
	if  exists(select * from Tour where MaTour = @matour) and
		exists(select * from ThanhPho where MaTP = @matp)

		begin
			if exists(select * from Tour_TP where MaTour = @matour and MaTP = @matp)
				print N'Đã có Tour_TP có MaTour ' + @matour + ' và MaTP ' + @matp + ' trong CSDL!'
				
			else
				begin
					insert into Tour_TP values(@matour, @matp, @songay)
					print N'Thêm Tour_TP thành công!'
				end
		end

	else
		if not exists(select * from Tour where MaTour = @matour)
			print N'Không có tour ' + @matour + ' nên không thêm Tour_TP được!'

		if not exists(select * from ThanhPho where MaTP = @matp)
			print N'Không có thành phố ' + @matp + ' nên không thêm Tour_TP được!'
go

exec USP_ThemTour_TP 'T001', '01', 2
exec USP_ThemTour_TP 'T001', '03', 1
exec USP_ThemTour_TP 'T002', '01', 2
exec USP_ThemTour_TP 'T002', '02', 2
exec USP_ThemTour_TP 'T003', '02', 2
exec USP_ThemTour_TP 'T003', '01', 1
exec USP_ThemTour_TP 'T003', '04', 2
exec USP_ThemTour_TP 'T004', '01', 1
exec USP_ThemTour_TP 'T004', '02', 2
exec USP_ThemTour_TP 'T004', '05', 2
exec USP_ThemTour_TP 'T004', '04', 2
select * from Tour_TP
go

create proc USP_ThemLich_TourDL
	@matour char(4),
	@ngaykh datetime,
	@tenhdv nvarchar(10),
	@songuoi tinyint,
	@tenkh nvarchar(20)
as
	if exists(select * from Tour where MaTour = @matour)
		
		begin
			if exists(select * from Lich_TourDL where MaTour = @matour and NgayKH = @ngaykh)
				print N'Đã có Lich_TourDL với MaTour ' + @matour + ' và NgayKH ' + @ngaykh + ' trong CSDL!'

			else
				begin
					insert into Lich_TourDL values(@matour, @ngaykh, @tenhdv, @songuoi, @tenkh)
					print N'Thêm Lich_TourDL thành công!'
				end
		end

	else
		print N'Không tồn tại Tour ' + @matour + ' nên không thêm được Lich_TourDL!'
go

set dateformat dmy
exec USP_ThemLich_TourDL 'T001', '14/02/2017', N'Vân', 20, N'Nguyễn Hoàng'
exec USP_ThemLich_TourDL 'T002', '14/02/2017', N'Nam', 30, N'Lê Ngọc'
exec USP_ThemLich_TourDL 'T002', '06/03/2017', N'Hùng', 20, N'Lý Dũng'
exec USP_ThemLich_TourDL 'T003', '18/02/2017', N'Dũng', 20, N'Lý Dũng'
exec USP_ThemLich_TourDL 'T004', '18/02/2017', N'Hùng', 30, N'Dũng Nam'
exec USP_ThemLich_TourDL 'T003', '10/03/2017', N'Nam', 45, N'Nguyễn An'
exec USP_ThemLich_TourDL 'T002', '28/04/2017', N'Vân', 25, N'Ngọc Dung'
exec USP_ThemLich_TourDL 'T004', '29/04/2017', N'Dũng', 35, N'Lê Ngọc'
exec USP_ThemLich_TourDL 'T001', '30/04/2017', N'Nam', 25, N'Trần Nam'
exec USP_ThemLich_TourDL 'T003', '15/06/2017', N'Vân', 20, N'Trịnh Bá'
select * from Lich_TourDL
go


-- Câu a. Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày.
select	Lich_TourDL.*,
		TongSoNgay

from	Tour
		join Lich_TourDL on Lich_TourDL.MaTour = Tour.MaTour

where	TongSoNgay >= 3 and
		TongSoNgay <= 5 


-- Câu b. Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017.
select	Lich_TourDL.*,
		TongSoNgay

from	Tour
		join Lich_TourDL on Lich_TourDL.MaTour = Tour.MaTour

where	MONTH(NgayKH) = 2 and
		YEAR(NgayKH) = 2017 


-- Câu c. Cho biết các tour không đi qua thành phố 'Nha Trang'
select	Lich_TourDL.*,
		TongSoNgay,
		TenTP

from	Lich_TourDL
		join Tour on Tour.MaTour = Lich_TourDL.MaTour
		join Tour_TP on Tour_TP.MaTour = Tour.MaTour
		join ThanhPho on ThanhPho.MaTP = Tour_TP.MaTP

where	ThanhPho.MaTP <> 02


-- Câu d. Cho biết số lượng thành phố mà mỗi tour du lịch đi qua.
select	Tour_TP.MaTour,
		COUNT(*) as SoLuongThanhPho

from	Tour_TP
		join ThanhPho on ThanhPho.MaTP = Tour_TP.MaTP
		join Tour on Tour_TP.MaTour = Tour.MaTour

group by Tour_TP.MaTour


-- Câu e. Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn.
select	TenHDV,
		COUNT(*) as SoLuongTour

from	Lich_TourDL
		join Tour on Lich_TourDL.MaTour = Tour.MaTour

group by TenHDV


-- Câu f. Cho biết tên thành phố có nhiều tour du lịch đi qua nhất.
select	Tour_TP.MaTP,
		TenTP,
		COUNT(*) as SoLuongTour

from	Tour_TP
		join ThanhPho on ThanhPho.MaTP = Tour_TP.MaTP

group by Tour_TP.MaTP, TenTP

having	COUNT(*) >= all

		(select	COUNT(*) as SoLuongThanhPho
		
		from	Tour_TP
				join ThanhPho on ThanhPho.MaTP = Tour_TP.MaTP
				join Tour on Tour_TP.MaTour = Tour.MaTour
		
		group by Tour_TP.MaTP)


-- Câu g. Cho biết thông tin của tour du lịch đi qua tất cả các thành phố.
select	*

from	Tour T

where	not exists

		(select	*
		
		from	ThanhPho TP
		
		where	not exists
		
				(select	*
				
				from	Tour_TP TTP
				
				where	TTP.MaTour = T.MaTour and
						TP.MaTP = TTP.MaTP))


-- Câu h. Lập danh sách các tour đi qua thành phố 'Đà Lạt', thông tin cần hiển thị bao gồm: Mã tour, Songay.
select	Tour_TP.MaTour,
		SoNgay

from	Tour_TP
		join Tour on Tour.MaTour = Tour_TP.MaTour

where	MaTP = '01'


-- Câu i. Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất.
select	Lich_TourDL.MaTour,
		TongSoNgay,
		SUM(SoNguoi) as SoLuongKhach

from	Lich_TourDL
		join Tour on Lich_TourDL.MaTour = Tour.MaTour

group by Lich_TourDL.MaTour, TongSoNgay

having	SUM(SoNguoi) >= all

		(select	SUM(SoNguoi)

		from	Lich_TourDL

		group by MaTour)


-- Câu j. Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua.
select	*

from	ThanhPho TP

where	not exists

		(select	*

		from	Tour T

		where	not exists

				(select	*

				from	Tour_TP TTP

				where	TTP.MaTour = T.MaTour and
						TP.MaTP = TTP.MaTP))