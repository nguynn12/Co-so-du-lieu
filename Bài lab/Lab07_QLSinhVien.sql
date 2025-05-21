/*
	Học phần: Cơ sở dữ liệu
	Lab07: Quản lý sinh viên
	SV thực hiện:	
	Mã SV:			
	Lớp:			
	Thời gian:		
*/

create database Lab07_QLSinhVien
go

use Lab07_QLSinhVien
go

create table KHOA
(
	MSKhoa char(2) primary key,
	TenKhoa nvarchar(30) not null unique,
	TenTat char(4) not null unique,
)
go

create table TINH
(
	MSTinh char(2) primary key,
	TenTinh varchar(30) not null unique
)
go

create table MONHOC
(
	MSMH char(4) primary key,
	TenMH varchar(30) not null unique,
	HeSo tinyint
)
go

create table LOP
(
	MSLop char(4) primary key,
	TenLop varchar(30) not null unique,
	MSKhoa char(2) references KHOA(MSKhoa),
	NienKhoa int
)
go

create table SINHVIEN
(
	MSSV char(7) primary key,
	Ho varchar(30) not null,
	Ten varchar(10) not null,
	NgaySinh datetime,
	MSTinh char(2) references TINH(MSTinh),
	NgayNhapHoc datetime not null,
	MSLop char(4) references LOP(MSLop),
	Phai varchar(5) not null,
	DiaChi varchar(50),
	DienThoai varchar(10)
)
go

create table BANGDIEM
(
	MSSV char(7) references SINHVIEN(MSSV),
	MSMH char(4) references MONHOC(MSMH),
	LanThi tinyint,
	Diem float
)
go

insert into KHOA values ('01', N'Công nghệ thông tin', 'CNTT')
insert into KHOA values ('02', N'Điện tử viễn thông', 'DTVT')
insert into KHOA values ('03', N'Quản trị kinh doanh', 'QTKD')
insert into KHOA values ('04', N'Công nghệ sinh học', 'CNSH')
select * from KHOA

insert into TINH values ('01', 'An Giang')
insert into TINH values ('02', 'TPHCM')
insert into TINH values ('03', 'Dong Nai')
insert into TINH values ('04', 'Long An')
insert into TINH values ('05', 'Hue')
insert into TINH values ('06', 'Ca Mau')
select * from TINH

insert into MONHOC values ('TA01', 'Nhap mon tin hoc', 2)
insert into MONHOC values ('TA02', 'Lap trinh co ban', 3)
insert into MONHOC values ('TB01', 'Cau truc du lieu', 2)
insert into MONHOC values ('TB02', 'Co so du lieu', 2)
insert into MONHOC values ('QA01', 'Kinh te vi mo', 2)
insert into MONHOC values ('QA02', 'Quan tri chat luong', 3)
insert into MONHOC values ('VA01', 'Dien tu co ban', 2)
insert into MONHOC values ('VA02', 'Mach so', 3)
insert into MONHOC values ('VB01', 'Truyen so lieu', 3)
insert into MONHOC values ('XA01', 'Vat ly dai cuong', 2)
select * from MONHOC

insert into LOP values ('98TH', 'Tin hoc khoa 1998', '01', 1998)
insert into LOP values ('98VT', 'Vien thong khoa 1998', '02', 1998)
insert into LOP values ('99TH', 'Tin hoc khoa 1999', '01', 1999)
insert into LOP values ('99VT', 'Vien thong khoa 1999', '02', 1999)
insert into LOP values ('99QT', 'Quan tri khoa 1999', '03', 1999)
select * from LOP

set dateformat dmy
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values 
('98TH001', 'Nguyen Van', 'An', '06/08/80', '01', '03/09/98', '98TH', 'Yes', '12 Tran Hung Dao, Q.1', '8234512')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('98TH002', 'Le Thi', 'An', '17/10/79', '01', '03/09/98', '98TH', 'No', '23 CMT8, Q. Tan Binh', '0303234342')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('98VT001', 'Nguyen Duc', 'Binh', '25/11/81', '02', '03/09/98', '98VT', 'Yes', '245 Lac Long Quan, Q.11', '8654323')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('98VT002', 'Tran Ngoc', 'Anh', '19/08/80', '02', '03/09/98', '98VT', 'No', '242 Tran Hung Dao, Q.1', NULL)
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99TH001', 'Ly Van Hung', 'Dung', '27/09/81', '03', '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', '7653213')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99TH002', 'Van Minh', 'Hoang', '01/01/81', '04', '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', '8341234')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99TH003', 'Nguyen', 'Tuan', '12/01/80', '03', '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5', NULL)
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99TH004', 'Tran Van', 'Minh', '25/06/81', '04', '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', '7236754')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99TH005', 'Nguyen Thai', 'Minh', '01/01/80', '04', '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', NULL)
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99VT001', 'Le Ngoc', 'Mai', '21/06/82', '01', '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', '0903124534')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99QT001', 'Nguyen Thi', 'Oanh', '19/08/73', '04', '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', '0901656324')
insert into SINHVIEN(MSSV, Ho, Ten, NgaySinh, MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai) values
('99QT002', 'Le My', 'Hanh', '20/05/76', '04', '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', NULL)
select * from SINHVIEN

insert into BANGDIEM values ('98TH001', 'TA01', 1, 8.5)
insert into BANGDIEM values ('98TH001', 'TA02', 1, 8)
insert into BANGDIEM values ('98TH002', 'TA01', 1, 4)
insert into BANGDIEM values ('98TH002', 'TA01', 2, 5.5)
insert into BANGDIEM values ('98TH001', 'TB01', 1, 7.5)
insert into BANGDIEM values ('98TH002', 'TB01', 1, 8)
insert into BANGDIEM values ('98VT001', 'VA01', 1, 4)
insert into BANGDIEM values ('98VT001', 'VA01', 2, 5)
insert into BANGDIEM values ('98VT002', 'VA02', 1, 7.5)
insert into BANGDIEM values ('99TH001', 'TA01', 1, 4)
insert into BANGDIEM values ('99TH001', 'TA01', 2, 6)
insert into BANGDIEM values ('99TH001', 'TB01', 1, 6.5)
insert into BANGDIEM values ('99TH002', 'TB01', 1, 10)
insert into BANGDIEM values ('99TH002', 'TB02', 1, 9)
insert into BANGDIEM values ('99TH003', 'TA02', 1, 7.5)
insert into BANGDIEM values ('99TH003', 'TB01', 1, 3)
insert into BANGDIEM values ('99TH003', 'TB01', 2, 6)
insert into BANGDIEM values ('99TH003', 'TB02', 1, 8)
insert into BANGDIEM values ('99TH004', 'TB02', 1, 2)
insert into BANGDIEM values ('99TH004', 'TB02', 2, 4)
insert into BANGDIEM values ('99TH004', 'TB02', 3, 3)
insert into BANGDIEM values ('99QT001', 'QA01', 1, 7)
insert into BANGDIEM values ('99QT001', 'QA02', 1, 6.5)
insert into BANGDIEM values ('99QT002', 'QA01', 1, 8.5)
insert into BANGDIEM values ('99QT002', 'QA02', 1, 9)
select * from BANGDIEM


------------------------------- TRUY VẤN ĐƠN GIẢN -------------------------------


-- Câu 1. Liệt kê MSSV, Họ, Tên, Địa chỉ của tất cả các sinh viên.
select	MSSV,
		Ho,
		Ten,
		DiaChi

from	SINHVIEN


-- Câu 2. Liệt kê MSSV, Họ, Tên, MS Tỉnh của tất cả các sinh viên. 
-- Sắp xếp theo MS tỉnh, cùng tỉnh sắp xếp theo Họ tên.
select	MSSV,
		Ho,
		Ten,
		MSTinh

from	SINHVIEN

order by MSTinh, Ho, Ten


-- Câu 3. Liệt kê các sinh viên nữ của tỉnh Long An.
select	*

from	SINHVIEN

where	Phai = 'No' and
		MSTinh = '04'


-- Câu 4. Liệt kê các sinh viên có sinh nhật trong tháng Giêng.
select	*

from	SINHVIEN

where	MONTH(NgaySinh) = 1


-- Câu 5. Liệt kê các sinh viên có sinh nhật vào ngày 1/1.
select	*

from	SINHVIEN

where	DAY(NgaySinh) = 1 and
		MONTH(NgaySinh) = 1

		
-- Câu 6. Liệt kê các sinh viên có số điện thoại.
select	*

from	SINHVIEN

where	DienThoai is not null


-- Câu 7. Liệt kê các sinh viên có số điện thoại di động.
select	*

from	SINHVIEN

where	DienThoai like '0%'


-- Câu 8. Liệt kê các sinh viên tên 'Minh' học lớp '99TH'.
select	*

from	SINHVIEN

where	Ten = 'Minh' and
		MSLop = '99TH'


-- Câu 9. Liệt kê các sinh viên có địa chỉ ở đường 'Trần Hưng Đạo'.
select	*

from	SINHVIEN

where	DiaChi like '%Tran Hung Dao%'


-- Câu 10. Liệt kê các sinh viên có tên lót chữ 'Văn'
select	*

from	SINHVIEN

where	Ho like '% Van' and
		Ho not like 'Van%'


-- Câu 11. Liệt kê MSSV, Họ_Tên (ghép), Tuổi của các sinh viên ở tỉnh Long An.
-- Giả sử lấy năm 2008 làm năm hiện tại để phù hợp với yêu cầu của bài
select	MSSV,
		CONCAT(Ho, ' ', Ten) as HoTen,
		2008 - YEAR(NgaySinh) as Tuoi

from	SINHVIEN

where	MSTinh = '04'

-- Câu 12. Liệt kê các sinh viên nam từ 23 đến 28 tuổi
-- Giả sử lấy năm 2008 là năm hiện tại để phù hợp với yêu cầu của bài
select	*

from	SINHVIEN

where	Phai = 'Yes' and
		2008 - YEAR(NgaySinh) >= 23 and
		2008 - YEAR(NgaySinh) <= 28


-- Câu 13. Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tưởi trở lên.
-- Giả sử lấy năm 2008 là năm hiện tại để phù hợp với yêu cầu của bài
select	*

from	SINHVIEN

where	(2008 - YEAR(NgaySinh) >= 32 and Phai = 'Yes') or
		(2008 - YEAR(NgaySinh) >= 27 and Phai = 'No')


-- Câu 14. Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi, hoặc đxa trên 15 tuổi.
-- Giả sử lấy năm 2008 là năm hiện tại để phù hợp với yêu cầu của bài
select	*

from	SINHVIEN

where	2008 - YEAR(NgayNhapHoc) <= 18 or
		2008 - YEAR(NgayNhapHoc) >= 25


-- Câu 15. Liệt kê danh sách sinh viên khóa 99.
select	*

from	SINHVIEN

where	MSSV like '99%'


-- Câu 16. Liệt kê MSSV, Điểm thi lần 1 môn 'Cơ sở dữ liệu' của lớp '99TH'.
select	SINHVIEN.MSSV,
		Diem

from	SINHVIEN
		join BANGDIEM on SINHVIEN.MSSV = BANGDIEM.MSSV

where	LanThi = 1 and
		MSMH = 'TB02' and
		MSLop = '99TH'


-- Câu 17. Liệt kê MSSV, Họ tên của các sinh viên lớp '99TH' thi không đạt lần 1 môn 'Cơ sở dữ liệu'.
select	SINHVIEN.MSSV,
		CONCAT(Ho, ' ', Ten) as HoTen

from	SINHVIEN
		join BANGDIEM on SINHVIEN.MSSV = BANGDIEM.MSSV

where	MSLop = '99TH' and
		MSMH = 'TB02' and
		LanThi = 1 and
		Diem < 5


-- Câu 18. Liệt kê tất cả điểm thi của sinh viên '99TH001' theo mẫu: MSMH, Tên MH, Lần thi, Điểm.
select	MONHOC.MSMH,
		MONHOC.TenMH as [Tên MH],
		LanThi as [Lần thi],
		Diem as Điểm

from	SINHVIEN
		join BANGDIEM on SINHVIEN.MSSV = BANGDIEM.MSSV
		join MONHOC on BANGDIEM.MSMH = MONHOC.MSMH

where	SINHVIEN.MSSV = '99TH001'


-- Câu 19. Liệt kê MSSV, Họ tên, MSLớp của các sinh viên có điểm thi lần 1 ≥ 8 môn 'Cơ sở dữ liệu'.
select	SINHVIEN.MSSV,
		CONCAT(Ho, ' ', Ten) as HoTen,
		MSLop

from	SINHVIEN
		join BANGDIEM on SINHVIEN.MSSV = BANGDIEM.MSSV

where	MSMH = 'TB02' and
		LanThi = 1 and
		Diem >= 8


-- Câu 20. Liệt kê các tỉnh không có sinh viên theo học.
select	*

from	TINH

where	MSTinh not in

		(select distinct	
				MSTinh

		from	SINHVIEN)


-- Câu 21. Liệt kê các sinh viên chưa có điểm thi môn nào.
select	*

from	SINHVIEN

where	MSSV not in

		(select distinct	
				MSSV

		from	BANGDIEM)


------------------------------- TRUY VẤN GOM NHÓM -------------------------------


-- Câu 22. Thống kê số lượng sinh viên mỗi lớp theo mẫu: MSLop, TenLop, SoLuongSV.
select	SINHVIEN.MSLop,
		TenLop,
		COUNT(*) as SoLuongSV

from	SINHVIEN
		join LOP on LOP.MSLop = SINHVIEN.MSLop

group by SINHVIEN.MSLop, TenLop


-- Câu 23. Thống kê số lượng sinh viên mỗi tỉnh theo mẫu: MSTinh, Tên Tỉnh, Số SV Nam, Số SV Nữ, Tổng cộng
select	SINHVIEN.MSTinh,
		TenTinh as [Tên tỉnh],
		COUNT(case when Phai = 'Yes' then 1
			end) as [Số SV Nam],
		COUNT(case when Phai = 'No' then 1 
			end) as [Số SV Nữ],
		COUNT(*) as [Tổng cộng]

from	SINHVIEN
		join TINH on SINHVIEN.MSTinh = TINH.MSTinh

group by SINHVIEN.MSTinh, TenTinh


-- Câu 24. Thống kê kết quả thi lần 1, môn “Cơ sở dữ liệu”, ở các lớp theo mẫu sau:
-- MSLop, TenLop, Số SV đạt, Tỉ lệ đạt (%), Số SV không đạt, Tỉ lệ không đạt
select	SINHVIEN.MSLop,
		TenLop,
		COUNT(case when Diem >= 5 then 1
			end) as [Số SV đạt],

		CAST(
			(COUNT(case when Diem >= 5 then 1 end) * 100.0 / COUNT(*)) 
			as DECIMAL(5, 2)
			) as [Tỉ lệ đạt],

		COUNT(case when Diem < 5 then 1
			end) as [Số SV không đạt],

		CAST(
			(COUNT(case when Diem < 5 then 1 end) * 100.0 / COUNT(*))
			as DECIMAL(5, 2)
			) as [Tỉ lệ không đạt]

from	SINHVIEN
		join BANGDIEM on BANGDIEM.MSSV = SINHVIEN.MSSV
		join MONHOC on BANGDIEM.MSMH = MONHOC.MSMH
		join LOP on SINHVIEN.MSLop = LOP.MSLop

where	LanThi = 1 and
		MONHOC.MSMH = 'TB02'

group by SINHVIEN.MSLop, TenLop


-- Câu 25. Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau 
-- (điểm in ra của mỗi môn là điểm cao nhất trong các lần thi của môn đó): MSSV, MSMH, Tên MH, Hệ số, Điểm, Điểm x hệ số.
select	MSSV,
		BANGDIEM.MSMH,
		TenMH as [Tên MH],
		HeSo as [Hệ số],
		MAX(Diem) as Điểm,
		MAX(Diem) * HeSo as [Điểm x hệ số]

from	BANGDIEM
		join MONHOC on BANGDIEM.MSMH = MONHOC.MSMH

group by MSSV, BANGDIEM.MSMH, TenMH, HeSo

order by MSSV


-- Câu 26. Lập bảng tổng kết theo mẫu sau: MSSV, Họ, Tên, Điểm TB.
select	A.MSSV,
		Ho as Họ,
		Ten as Tên,
		CAST(
			SUM(A.Diem * A.HeSo) / SUM(A.HeSo) 
			as DECIMAL(5, 2)
			) as ĐTB

from	(select	MSSV,
				BANGDIEM.MSMH,
				TenMH,
				HeSo,
				MAX(Diem) as Diem
		
		from	BANGDIEM
				join MONHOC on BANGDIEM.MSMH = MONHOC.MSMH
		
		group by MSSV, BANGDIEM.MSMH, TenMH, HeSo)A
		
		join SINHVIEN on A.MSSV = SINHVIEN.MSSV

group by A.MSSV, Ho, Ten

order by A.MSSV


-- Câu 27. Thống kê số lượng sinh viên tỉnh 'Long An' đang theo học ở các khoa, theo mẫu sau: 
-- Năm học,	MSKhoa,	TênKhoa, Số lượng SV
select	NienKhoa as [Năm học],
		LOP.MSKhoa,
		TenKhoa,
		COUNT(*) as [Số lượng SV]

from	SINHVIEN
		join TINH on SINHVIEN.MSTinh = TINH.MSTinh
		join LOP on SINHVIEN.MSLop = LOP.MSLop
		join KHOA on KHOA.MSKhoa = Lop.MSKhoa

where	TINH.MSTinh = '04'

group by NienKhoa, LOP.MSKhoa, TenKhoa
go


-- Câu 28. Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau 
-- (điểm in ra lấy điểm cao nhất trong các lần thi).
create proc USP_BangDiemSV
	@mssv char(7)
as
	if exists(select * from SINHVIEN where MSSV = @mssv)
		
		begin
			select	BANGDIEM.MSMH,
					TenMH as [Tên MH],
					HeSo as [Hệ số],
					MAX(Diem) as Điểm
			
			from	BANGDIEM
					join MONHOC on BANGDIEM.MSMH = MONHOC.MSMH

			where	MSSV = @mssv
			
			group by MSSV, BANGDIEM.MSMH, TenMH, HeSo
		end

	else
		print N'Không có sinh viên ' + @mssv + ' trong CSDL!'
go
-- exec USP_BangDiemSV '98TH001'


-- Câu 29.
create proc USP_XepLoai
	@mslop char(4)
as
	if exists(select * from LOP where MSLop = @mslop)

		begin
			declare @xeploai nvarchar(30)

			select	SINHVIEN.MSSV,
					Ho,
					Ten,
					CAST(SUM(A.Diem * A.HeSo) / SUM(A.HeSo)
						as DECIMAL(5, 2)) as DTB,

					case when SUM(A.Diem * A.HeSo) / SUM(A.HeSo) < 4.0 then N'Kém' 
						 when SUM(A.Diem * A.HeSo) / SUM(A.HeSo) between 4.0 and 5.4 then N'Yếu'
						 when SUM(A.Diem * A.HeSo) / SUM(A.HeSo) between 5.5 and 6.9 then N'Trung bình'
						 when SUM(A.Diem * A.HeSo) / SUM(A.HeSo) between 7.0 and 8.4 then N'Khá'
						 when SUM(A.Diem * A.HeSo) / SUM(A.HeSo) between 8.5 and 8.9 then N'Giỏi'
						 when SUM(A.Diem * A.HeSo) / SUM(A.HeSo) between 9.0 and 10 then N'Xuất sắc'
					end as XepLoai
			from	SINHVIEN
			
					join	(select	BANGDIEM.MSSV,
									BANGDIEM.MSMH,
									LanThi,
									HeSo,
									MAX(Diem) as Diem
						
							from	SINHVIEN
									join BANGDIEM on SINHVIEN.MSSV = BANGDIEM.MSSV
									join MONHOC on BANGDIEM.MSMH = MONHOC.MSMH
						
							group by BANGDIEM.MSSV, BANGDIEM.MSMH, LanThi, HeSo)A on A.MSSV = SINHVIEN.MSSV
						
			where	MSLop = @mslop

			group by SINHVIEN.MSSV, Ho, Ten
		end

	else
		print N'Không có lớp ' + @mslop + N' trong CSDL!'
go
-- exec USP_XepLoai '98TH'


-- Câu 30.
select	* into SinhVienTinh

from	SINHVIEN

where	MSTinh <> '02'

select * from SinhVienTinh

alter table SinhVienTinh alter column HBONG int


-- Câu 31.
update SinhVienTinh set HBONG = 1000


-- Câu 32.
update	SinhVienTinh
set		HBONG = HBONG/0.1
where	Phai = 'No'


-- Câu 33.
delete from SinhVienTinh where MSTinh = '04'
