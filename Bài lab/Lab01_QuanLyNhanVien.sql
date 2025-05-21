/*
	Học phần: Cơ sở dữ liệu
	Lab01: Quản lý nhân viên
	Sinh viên thực hiện:
	Mã Sinh viên:
	Thời gian: 
*/

create database Lab01_QuanLyNhanVien
go

use Lab01_QuanLyNhanVien
go

-- Tạo bảng
-- Cấu trúc: create table <tên bảng> 
--			( 
--			tên thuộc tính <kiểu dữ liệu> <ràng buộc>
--			.....
--			)
create table ChiNhanh
(
--	Nếu chỉ có 1 thuộc tính làm khóa thì thêm chữ
--	"primary key" vào phía sau

--	Chuỗi để trong dấu nháy đơn
--	char(số ký tự): Kiểu dữ liệu chuỗi trong đó, mặc định chuỗi đó phải đủ số ký tự
--	Nếu nhập thiếu, thì hệ thống tự động thêm dấu cách để lấp đầy số ký tự
--	char(5), '123ab', '12a  '

--	varchar(số ký tự): Kiểu dữ liệu chuỗi trong đó, số ký tự có thể thay đổi trong phạm vi.
--	Nếu nhập thiếu, thì hệ thống để đó, không thay đổi
--	varchar(5), '123ab', '12a'

--	nchar(số ký tự), nvarchar(số ký tự): Nhập ký tự có chứa dấu.
--	nchar(5): 'bàn  '
--	nvarchar(5): 'bàn'

	MSCN char(2) primary key,
	TenCN nvarchar(30) not null unique
)
go

create table NhanVien
(
	MANV char(4) primary key,
	Ho nvarchar(30) not null,
	Ten nvarchar(20) not null,
	NgaySinh datetime,
	NgayVaoLam datetime,
	-- Thuộc tính này tham chiếu đến thuộc tính khác:
	-- Tên và kiểu dữ liệu của thuộc tính tham chiếu phải giống với thuộc tính nó tham chiếu đến

	-- <tên thuộc tính> <kiểu dữ liệu> references <tên của bảng tham chiếu>(<tên thuộc tính tham chiếu>)
	MSCN char(2) references ChiNhanh(MSCN)
)
go

create table KyNang
(
	MSKN char(2) primary key,
	TenKN varchar(30) not null unique
)
go

create table NhanVienKyNang
(
	MANV char(4) references NhanVien(MANV),
	MSKN char(2) references KyNang(MSKN),
	MucDo tinyint check(MucDo >= 1 and MucDo <= 9),
	--MucDo tinyint check(MucDo between 1 and 9)

	--Nếu có trên 2 thuộc tính làm khóa chính, thì
	--primary key(<thuộc tính 1>, <thuộc tính 2>, ...)
	primary key(MANV, MSKN)
)
go

--	Thêm dữ liệu: insert
--	1. insert into <tên bảng> values(<thuộc tính 1>, <thuộc tính 2>, ...)
--	Bảng có bao nhiêu thuộc tính thì, sau chữ "values" phải để bấy nhiêu thuộc tính
--	VD: insert into ChiNhanh values('04', N'Quận 3') Thỏa mãn
--	VD: insert into ChiNhanh values(N'Quận 3')	Lỗi cú pháp

--	2. insert into <tên bảng>(<thuộc tính 1>, <thuộc tính 2>, ...) values(<thuộc tính 1>, <thuộc tính 2>, ...)
--	Bảng đề nghị bao nhiêu thuộc tính trong này, thì ta cũng để bấy nhiêu thuộc tính

--	VD: Trong bảng có đầy đủ 5 thuộc tính, nhưng khi insert ta chỉ để đúng 3 thuộc tính, thì khi insert
--	các thuộc tính không có trong <tên bảng>(<thuộc tính 1>, <thuộc tính 2>, ...) thì hệ thống để mặc định là NULL 
--	insert into NhanVien(MANV, Ho, Ten) values ('0009', N'Nguyễn Hoàng', N'Anh'). Khi đó, 
--	NgaySinh, NgayVaoLam, MSCN đều bằng NULL.

--	VD: Trong bảng có đầy đủ 5 thuộc tính, insert ta để đủ 5 thuộc tính, thì khi insert các thuộc tính 
--	để trống phải nhập NULL 
--	insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0009', N'Nguyễn Hoàng', N'Anh', NULL , NULL, NULL)

--	Với điều kiện, khi tạo bảng, ta chỉ định thuộc tính nào "not null" thì khi nhập không được để trống.

--	Kiểu dữ liệu chuỗi để trong dấu nháy đơn ''
insert into ChiNhanh values ('01', N'Quận 1')
insert into ChiNhanh(MSCN, TenCN) values ('02', N'Quận 5')
insert into ChiNhanh(MSCN, TenCN) values ('03', N'Quận Bình Thạnh')
select * from ChiNhanh

-- Đặt định dạng ngày tháng
set dateformat dmy;
--	ngày/tháng/năm
--	d(day): ngày
--	m(month): tháng
--	y(year): năm

--	Kiểu dữ liệu có dấu, khi nhập phải thêm N hoa: N'<dữ liệu>'
--	Kiểu dữ liệu ngày tháng để trong dấu nháy kép
insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0001', N'Lê Văn', N'Minh', '10/06/1960', '02/05/1986', '01')
insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0002', N'Nguyễn Thị', N'Mai', '20/04/1970', '04/07/2001', '01')
insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0003', N'Lê Anh', N'Tuấn', '25/06/1975', '01/09/1982', '02')
insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0004', N'Vương Tuấn', N'Vũ', '25/03/1960', '12/01/1986', '02')
insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0005', N'Lý Anh', N'Hân', '01/12/1980', '15/05/2004', '02')
insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0006', N'Phan Lê', N'Tuấn', '04/06/1976', '25/10/2002', '03')
insert into NhanVien(MANV, Ho, Ten, NgaySinh, NgayVaoLam, MSCN) values ('0007', N'Lê Tuấn', N'Tú', '15/08/1975', '15/08/2000', '03')
select * from NhanVien

insert into KyNang(MSKN, TenKN) values ('01', 'Word')
insert into KyNang(MSKN, TenKN) values ('02', 'Excel')
insert into KyNang(MSKN, TenKN) values ('03', 'Access')
insert into KyNang(MSKN, TenKN) values ('04', 'Power Point')
insert into KyNang(MSKN, TenKN) values ('05', 'SPSS')
select * from KyNang order by MSKN 

insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0001', '01', 3)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0001', '02', 1)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0002', '01', 2)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0002', '03', 2)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0003', '02', 1)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0003', '03', 2)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0004', '01', 5)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0004', '02', 4)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0004', '03', 1)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0004', '04', 3)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0004', '05', 4)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0005', '02', 4)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0005', '04', 4)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0006', '05', 4)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0006', '02', 4)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0006', '03', 2)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0007', '03', 4)
insert into NhanVienKyNang(MANV, MSKN, MucDo) values ('0007', '04', 3)
select * from NhanVienKyNang

--	Giả sử nhập nhầm, thiếu dữ liệu
--	Sửa dữ liệu:
--	update <tên bảng> set <tên thuộc tính> = <biểu thức> where <điều kiện>

update	NhanVienKyNang
set		MucDo = 1
where	MANV = '0001' and
		MSKN = '02'

------------------------------ CAU 1 ------------------------------
-- TRUY VẤN DỮ LIỆU

--	select: Dùng để lấy ra thuộc tính của bảng (6th)
--	from:	Dữ liệu lấy từ bảng (1st)
--	where:	Điều kiện để select lấy ra (2nd)
--	group by: Gom nhóm theo thuộc tính, trong group by có bao nhiêu thuộc tính,
--			thì select phải có bấy nhiêu thuộc tính (3rd)
--	having:	Điều kiện (dựa trên các lệnh tính toán (SUM, AVG, COUNT, ...)) sau khi đã gom nhóm (4th)
--	order by: Sắp xếp theo thuộc tính hoặc theo alphabet (từ trên xuống dưới) (5th)


------ Câu 1a ------
select	MANV,
		CONCAT(Ho,' ', Ten) as HoTen,
		--Ho + ' ' + Ten as HoTen
		--Ho + ' ' + Ten + '1' as HoTen,
		--Ho + ' ' + Ten + CAST(1 as nvarchar) as HoTen,
		YEAR(GETDATE()) - YEAR(NgayVaoLam) as SoNamLamViec

from	NhanVien


------ Câu 1b ------
-- Cách nối 1. Dùng bí danh (khác với thuộc tính)

select	Ho + ' ' + Ten as HoTen,
		NgaySinh,
		NgayVaoLam,
		TenCN

from	NhanVien NV, ChiNhanh CN

where	NV.MSCN = CN.MSCN


-- Cách nối 2. Dùng join 
select	Ho + ' ' + Ten as HoTen,
		NgaySinh,
		NgayVaoLam,
		TenCN

from	NhanVien
		join ChiNhanh on NhanVien.MSCN = ChiNhanh.MSCN


------ Câu 1c ------
select	Ho + ' ' + Ten as HoTen,
		TenKN,
		MucDo

from	NhanVien NV, NhanVienKyNang NVKN, KyNang KN

where	NV.MANV = NVKN.MANV and
		NVKN.MSKN = KN.MSKN and
		TenKN = 'Word'


select	Ho + ' ' + Ten as HoTen,
		TenKN,
		MucDo

from	NhanVien
		join NhanVienKyNang on NhanVien.MANV = NhanVienKyNang.MANV
		join KyNang on NhanVienKyNang.MSKN = KyNang.MSKN

where	TenKN = 'Word'

------ Câu 1d ------
select	TenKN,
		MucDo

from	NhanVien NV, KyNang KN, NhanVienKyNang NVKN

where	NV.MANV = NVKN.MANV and
		KN.MSKN = NVKN.MSKN and
		Ho = N'Lê Anh' and
		Ten = N'Tuấn'


select	TenKN,
		MucDo

from	NhanVien
		join NhanVienKyNang on NhanVien.MANV = NhanVienKyNang.MANV
		join KyNang on NhanVienKyNang.MSKN = KyNang.MSKN

where	Ho = N'Lê Anh' and
		Ten = N'Tuấn'

--where	CONCAT(Ho, ' ', Ten) = N'Lê Anh Tuấn'

------------------------------ CAU 2 ------------------------------


------ Câu 2a ------
select	NhanVienKyNang.MANV,
		Ho + ' ' + Ten as HoTen,
		NhanVien.MSCN,
		TenCN,
		MucDo

from	NhanVien
		join ChiNhanh on NhanVien.MSCN = ChiNhanh.MSCN
		join NhanVienKyNang on Nhanvien.MANV = NhanVienKyNang.MANV
		join KyNang on NhanVienKyNang.MSKN = KyNang.MSKN

where	KyNang.MSKN = '02' and
-- Mức độ của nhân viên (trong truy vấn ban đầu) thuộc truy vấn con
-- MucDo này là thuộc tính của truy vấn ban đầu 
		MucDo in 
-- Truy vấn con: Lấy mức độ cao nhất của những nhân viên làm Excel
		(select	MAX(MucDo) as MucDo
		-- MucDo này là thuộc tính của truy vấn con
		
		from	NhanVienKyNang
				join KyNang on NhanVienKyNang.MSKN = KyNang.MSKN
		
		where	KyNang.MSKN = '02')

-- a > b (= in, exists, not in, not exists, >, <)
------ Câu 2b ------
select	NhanVienKyNang.MANV,
		Ho + ' ' + Ten as HoTen,
		TenCN

from	NhanVien
		join ChiNhanh on NhanVien.MSCN = ChiNhanh.MSCN
		join NhanVienKyNang on Nhanvien.MANV = NhanVienKyNang.MANV
		join KyNang on NhanVienKyNang.MSKN = KyNang.MSKN
-- Điều kiện 1: Nhân viên biết Word
where	TenKN = 'Word' and

-- MANV là thuộc tính của truy vấn ban đầu
		NhanVienKyNang.MANV in
-- Điều kiện 2: Nhân viên biết Excel

		(select MANV
		-- MANV là thuộc tính của truy vấn con 

		from	NhanVienKyNang

		where	MSKN = '02')
-- 1, 3, 4, 5, 6

------ Câu 2c ------
select	NVKN.MANV,
		Ho + ' ' + Ten as HoTen,
		TenCN,
		TenKN,
		MucDo

from	NhanVien
		join ChiNhanh on NhanVien.MSCN = ChiNhanh.MSCN
		join NhanVienKyNang NVKN on Nhanvien.MANV = NVKN.MANV
		join KyNang on NVKN.MSKN = KyNang.MSKN

where	MucDo = 

		(select	MAX(MucDo)

		from	NhanVienKyNang
		
		where	NhanVienKyNang.MSKN = KyNang.MSKN)


------ Câu 2d ------
-- Truy vấn in ra số lượng người trong một chi nhánh.
select	ChiNhanh.MSCN,
		TenCN,
		COUNT(*) as SoLuong

from	ChiNhanh
		join NhanVien on NhanVien.MSCN = ChiNhanh.MSCN

group by ChiNhanh.MSCN, TenCN


-- Điều kiện: Số lượng người trong chi nhánh = Số lượng người
-- biết word trong chi nhánh đó.
having	COUNT(*) = 

		-- Truy vấn in ra những người biết word, nối với truy
		-- vấn ban đầu.
		(select	COUNT(*) as SoLuongBietWord
		
		from	NhanVienKyNang
				join NhanVien on NhanVienKyNang.MANV = NhanVien.MANV
				join KyNang on KyNang.MSKN = NhanVienKyNang.MSKN
		
		where	KyNang.MSKN = '01' and
				ChiNhanh.MSCN = Nhanvien.MSCN)
		

-- Ngoài lề --
-- Truy vấn in ra số lượng người biết word
select	ChiNhanh.MSCN,
		COUNT(*) as SoLuongBietWord

from	NhanVienKyNang
		join NhanVien on NhanVienKyNang.MANV = NhanVien.MANV
		join ChiNhanh on NhanVien.MSCN = ChiNhanh.MSCN

where	MSKN = '01'

group by ChiNhanh.MSCN
				
	

------ Câu 3a ------
select	TenCN,
		COUNT(*) as SoNV

from	NhanVien NV, ChiNhanh CN

where	NV.MSCN = CN.MSCN

group by NV.MSCN, TenCN


------ Câu 3b ------
select	TenKN,
		COUNT(*) as SoNguoiDung

from	KyNang KN, NhanVien NV, NhanVienKyNang NVKN

where	NV.MANV = NVKN.MANV and
		KN.MSKN = NVKN.MSKN

group by TenKN


------ Câu 3c ------
select	TenKN,
		COUNT(MANV) as SoLuong

from	KyNang KN, NhanVienKyNang NVKN

where	KN.MSKN = NVKN.MSKN

group by TenKN

having	COUNT(MANV) >= 3


------ Câu 3d ------
select	TenCN,
		COUNT(*) as SoNV

from	NhanVien NV, ChiNhanh CN

where	NV.MSCN = CN.MSCN

group by NV.MSCN, TenCN

having	COUNT(*) >= all

		(select	COUNT(*)
		
		from	NhanVien NV, ChiNhanh CN
		
		where	NV.MSCN = CN.MSCN
		
		group by NV.MSCN, TenCN)


------ Cau 3e ------
select	TenCN,
		COUNT(*) as SoNV

from	NhanVien NV, ChiNhanh CN

where	NV.MSCN = CN.MSCN

group by NV.MSCN, TenCN

having	COUNT(*) <= all

		(select	COUNT(*)
		
		from	NhanVien NV, ChiNhanh CN
		
		where	NV.MSCN = CN.MSCN
		
		group by NV.MSCN, TenCN)


------ Cau 3f ------
select	NhanVienKyNang.MANV,
		COUNT(*) as SoLuongKyNang

from	NhanVienKyNang
		join NhanVien on NhanVien.MANV = NhanVienKyNang.MANV

group by NhanVienKyNang.MANV


------ Cau 3g ------
select	Ho + ' ' + Ten as HoTen,
		TenCN,
		COUNT(*) as SoLuongKyNang

from	NhanVienKyNang
		join NhanVien on NhanVien.MANV = NhanVienKyNang.MANV
		join ChiNhanh on NhanVien.MSCN = ChiNhanh.MSCN

group by Ho, Ten, TenCN

having	COUNT(*) >= all

		(select	COUNT(*)

		from	NhanVienKyNang
				join NhanVien on NhanVien.MANV = NhanVienKyNang.MANV
		
		group by NhanVienKyNang.MANV)


-- Câu 4.

-- Câu 4a.
insert into KyNang values('06', 'PhotoShop')
select * from KyNang

-- Câu 4b.
insert into NhanVienKyNang values('0001', '06', 3)
insert into NhanVienKyNang values('0005', '06', 2)
select * from NhanVienKyNang

--Lệnh cập nhật

-- update <tên bảng> 
-- set <tên thuộc tính> 
-- where <điều kiện>

-- Câu 4c.

update	NhanVienKyNang
set		MucDo = MucDo + 1
where	MSKN = '01'

select	*
from	NhanVienKyNang
where	MSKN = '01'


-- Câu 4d.
create table NhanVienChiNhanh1
(
	MANV char(4),
	HoTen nvarchar(30),
	SoKyNang tinyint
)

select * from NhanVienChiNhanh1


-- Câu 4e.
insert into NhanVienChiNhanh1

select	NhanVien.MANV,
		Ho + ' ' + Ten as HoTen,
		COUNT(*) as SoLuong

from	NhanVien
		join NhanVienKyNang on NhanVien.MANV = NhanVienKyNang.MANV

where	MSCN = '01'
group by NhanVien.MANV, Ho, Ten
