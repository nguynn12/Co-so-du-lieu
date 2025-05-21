﻿/*	Học phần: Cơ sở dữ liêu
	Lab01:	Quản lý nhân viên
	SV thực hiện:	????
	mã SV:			???
	Lớp:			CTK47B
	Thời gian:		13/02/2025 - 27/02/2025
*/
-------------ĐỊNH NGHĨA CƠ SƠ DŨ LIỆU--------------
Create database	Lab01_QLNV --Lệnh tạo CSDL trống
go
Use Lab01_QLNV --Lệnh gọi sử dụng CSDL Lab01_QLNV
go
---Tạo bảng ChiNhanh
Create table ChiNhanh
(MSCN	char(2) Primary key,	--Khai báo khóa chính chỉ gồm 1 thuộc tính
TenCN	nvarchar(30) not null unique
)
go
---Tạo bảng NhanVien
Create table NhanVien
(MaNV	char(4) Primary key,
Ho		nvarchar(20) not null,
Ten		nvarchar(10) not null,
NgaySinh	DateTime	not null,
NgayVaoLam	DateTime	not null,
MSCN	char(2) references	ChiNhanh(MSCN) -- khai báo khóa ngoại
)
---Tạo bảng KyNang
Create table KyNang
(MSKN	char(2) Primary key,	--Khai báo khóa chính chỉ gồm 1 thuộc tính
TenKN	nvarchar(30) not null unique
)
go
---Tạo bảng NhanVienKyNang
Create table NhanVienKyNang
(MaNV char(4) references NhanVien(MaNV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo >= 1 and MucDo <=9), --kiểm tra mức độ thành thạo nằm trong phạm vi từ 1 đến 9
Primary key (MaNV, MSKN)		--Khai báo khóa chính gồm nhiều thuộc tính
)
go
---Xem các bảng 
Select * from ChiNhanh
Select * from NhanVien
Select * from KyNang
Select * from NhanVienKyNang
--------------NHẬP DỮ LIỆU CHO CÁC BẢNG-----------
---Nhập dữ liệu cho bảng ChiNhanh
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình Thạnh')
---Nhập bảng NhanVien
Set Dateformat dmy
go
insert into NhanVien values('0001', N'Lê Văn', N'Minh', '10/06/1960', '02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
---xem bảng NhanVien
Select * from	NhanVien
--Nhập bảng Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05',N'SPSS')
--xem bảng KyNang
select * from KyNang
--Nhập bảng nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0004','04',3)
insert into NhanVienKyNang values('0004','05',4)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)
---Xem bảng NhanVienKyNang
select * from NhanVienKyNang
-------------------TRUY VẤN DỮ LIỆU---------------------
-----1. Phép chọn
--q1: Cho biết các nhân viên làm việc tại chi nhánh có mã số CN là '01'
Select	*
From	NhanVien
Where	MSCN = '01'
--q2: Cho biết các nhân viên sinh sau năm 1975
Select	*
From	NhanVien
Where	year(NgaySinh) > 1975
--q3: Liệt kê các nhân viên có họ Lê.
--Cách 1:
Select	*
From	NhanVien
Where	left(Ho,2) = N'Lê'
--Cách 2:
Select	*
From	NhanVien
Where	Ho like N'Lê %'
--q4: Cho biết các nhân viên có họ Lê làm việc tại chi nhánh có mã số chi nhánh là '02'
Select	*
From	NhanVien
Where	mscn = '02' and Ho like N'Lê %'

---2. Phép chiếu
--q5: cho biết các thông tin sau của nhân viên: mã NV, họ, tên, mscn, ngày vào làm
Select	MaNV, Ho, Ten, MSCN, NgayVaoLam
From	NhanVien
--q5': cho biết các thông tin sau của nhân viên: mã NV, Họ tên, mscn, ngày vào làm
Select	MaNV, Ho+' '+Ten as HoTen, MSCN,convert(char(10), NgayVaoLam, 103) as NgayVL
From	NhanVien
--q6: Cho biết các thông tin sau của nhân viên làm việc tại chi nhánh 03: Mã NV, HoTen, MSCN, Số năm công tác
Select	MaNV, Ho+' '+Ten as HoTen, MSCN, year(getdate())-year(NgayVaoLam) as SoNamCT
From	NhanVien
Where	MSCN = '03'

----3. Truy vấn dữ liệu trên nhiều bảng | nhiều quan hệ
--Phép tích
Select	*
From	NhanVien, ChiNhanh
Order by	MaNV
--Phép kết | Phép nối (Join operation)
Select	*
From	NhanVien, ChiNhanh
Where	NhanVien.MSCN = ChiNhanh.MSCN
---Sử dụng bí danh
Select	*
From	NhanVien nv, ChiNhanh cn
Where	MSCN = MSCN

--Q1b) Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp xếp theo tên chi nhánh).
Select	Ho+' '+Ten as HoTen, convert(char(10), NgaySinh, 103) as NgaySinh, 
		convert(char(10), NgayVaoLam, 103) as NgayVL, TenCN
From	NhanVien A, ChiNhanh B
Where	A.MSCN = B.MSCN
Order by	TenCN, Ten, Ho
--
Select	Ho+' '+Ten as HoTen, convert(char(10), NgaySinh, 103) as NgaySinh, 
		convert(char(10), NgayVaoLam, 103) as NgayVL, TenCN
From	NhanVien A, ChiNhanh B
Where	A.MSCN = B.MSCN
Order by	TenCN, Ten desc, Ho

--Q1c) Liệt kê các nhân viên (HoTen, TenKN, MucDo) của những nhân viên biết sử dụng ‘Word’. 
Select	Ho+' '+Ten As HoTen, TenKN, MucDo
From	NhanVien A, NhanVienKyNang B, KyNang C
Where	A.MaNV = B.MaNV and B.MSKN = C.MSKN and TenKN = 'Word'
--Q1d) Liệt kê các kỹ năng (TenKN, MucDo) mà nhân viên ‘Lê Anh Tuấn’ biết sử dụng.
--cách 1
Select	TenKN, MucDo
From	NhanVien A, NhanVienKyNang B, KyNang C
Where	A.MaNV = B.MaNV and B.MSKN = C.MSKN and Ho = N'Lê Anh' and Ten = N'Tuấn'
--cách 2
Select	TenKN, MucDo
From	NhanVien A, NhanVienKyNang B, KyNang C
Where	A.MaNV = B.MaNV and B.MSKN = C.MSKN and Ho+' '+Ten = N'Lê Anh Tuấn'

---4. Gom nhóm và hàm kết hợp
--q7: Cho biết số nhân viên của từng chi nhánh 
Select		MSCN, COUNT(MaNV) As SoNV
From		NhanVien
Group by	MSCN

--Q3a) Với mỗi chi nhánh, hãy cho biết các thông tin sau TenCN, SoNV (số nhân viên của chi nhánh đó). 
Select		A.MSCN, TenCN, COUNT(MaNV) As SoNV
From		NhanVien A, ChiNhanh B
Where		A.MSCN = B.MSCN
Group by	A.MSCN,TenCN
--Q3b) Với mỗi kỹ năng, hãy cho biết TenKN, SoNguoiDung (số nhân viên biết sử dụng kỹ năng đó). 
Select		TenKN, count(MaNV) as SoNguoiDung
From		KyNang A, NhanVienKyNang B
Where		A.MSKN = B.MSKN
Group by	TenKN

--Q3c) Cho biết TenKN có từ 3 nhân viên trong công ty sử dụng trở lên. 
Select		TenKN, count(MaNV) as SoNguoiDung
From		KyNang A, NhanVienKyNang B
Where		A.MSKN = B.MSKN		--điều kiện nối bảng & điều kiện chọn của bộ 
Group by	TenKN
Having		count(MaNV) >=3		--điều kiện chọn của nhóm (thường dùng hàm count | sum)

--Q3f) Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được.  
Select		B.MaNV, Ho+' '+Ten as HoTen, TenCN, count(MSKN) as SoKyNang
From		ChiNhanh A, NhanVien B, NhanVienKyNang C
Where		A.MSCN = B.MSCN and B.MaNV = C.MaNV
Group by	B.MaNV, Ho, Ten, TenCN
----5. Truy vấn lồng nhau
--Q2b)  Liệt kê MANV, HoTen, TenCN của các nhân viên vừa biết ‘Word’ vừa biết ‘Excel’ (dùng truy vấn lồng). 
--(Phép giao)
Select	B.MaNV, Ho+' '+Ten As HoTen, TenCN
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Word'
		and B.MANV in (	Select E.MaNV
						From	NhanVienKyNang E, KyNang F
						Where	E.MSKN = F.MSKN and TenKN = 'Excel'
					)
--q8: Cho biết các nhân viên không sử dụng Access (Phép hiệu)
--Cách 1: dùng not in
Select	*
From	NhanVien
Where	MaNV not in (	Select E.MaNV
						From	NhanVienKyNang E, KyNang F
						Where	E.MSKN = F.MSKN and TenKN = 'Access'
					)
--cách 2: dùng hàm not exists
Select	*
From	NhanVien A
Where	not exists (Select *
					From	NhanVienKyNang E, KyNang F
					Where	E.MSKN = F.MSKN and TenKN = 'Access' and E.MANV = A.MANV
					)
--cách 3: sử dụng phép kết ngoài
Select	*
From	NhanVien A left join	 (	Select E.MaNV
									From	NhanVienKyNang E, KyNang F
									Where	E.MSKN = F.MSKN and TenKN = 'Access'
								) as NVSuDungAccess
		on A.MaNV = NVSuDungAccess.MANV
Where	NVSuDungAccess.MANV is Null

---Bài toán tìm Min | Max
--Q2a) Liệt kê MANV, HoTen, MSCN, TenCN của các nhân viên có mức độ thành thạo về ‘Excel’ cao nhất trong công ty.
--Cách 1: dùng hàm Max
Select	B.MaNV, Ho+' '+Ten As HoTen, A.MSCN, TenCN, TenKN, MucDo
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Excel'
		and C.MucDo = (	Select Max(E.MucDo)
						From	NhanVienKyNang E, KyNang F
						Where	E.MSKN = F.MSKN and TenKN = 'Excel'
						)
--Cách 2: dùng phép so sánh với tập hợp >=all
Select	B.MaNV, Ho+' '+Ten As HoTen, A.MSCN, TenCN, TenKN, MucDo
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Excel'
		and C.MucDo >=all (	Select E.MucDo
							From	NhanVienKyNang E, KyNang F
							Where	E.MSKN = F.MSKN and TenKN = 'Excel'
						)
--cách 3: dùng top (không chắc đúng trong trường hợp tổng quát --> không khuyến khích sử dụng)
Select	top 3 B.MaNV, Ho+' '+Ten As HoTen, A.MSCN, TenCN, TenKN, MucDo
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Excel'
Order by C.MucDo desc

--Q2c) Với từng kỹ năng, hãy liệt kê các thông tin (MANV, HoTen, TenCN, TenKN, MucDo) của những nhân viên thành thạo kỹ năng đó nhất.
Select	B.MaNV, Ho+' '+Ten As HoTen, A.MSCN, TenCN, TenKN, MucDo
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN 
		and C.MucDo = (	Select Max(E.MucDo)
						From	NhanVienKyNang E
						Where	E.MSKN = D.MSKN 
						)
Order by TenKN, Ten, Ho
--Q3d) Cho biết TenCN có nhiều nhân viên nhất. 
Select		A.MSCN, TenCN, COUNT(MaNV) As SoNV
From		NhanVien A, ChiNhanh B
Where		A.MSCN = B.MSCN
Group by	A.MSCN,TenCN
Having		COUNT(MaNV) >= all(	Select	count(MaNV)
								From	NhanVien
								Group by	MSCN
								)
--Q3e) Cho biết TenCN có ít nhân viên nhất. 
Select		A.MSCN, TenCN, COUNT(MaNV) As SoNV
From		NhanVien A, ChiNhanh B
Where		A.MSCN = B.MSCN
Group by	A.MSCN,TenCN
Having		COUNT(MaNV) <= all(	Select	count(MaNV)
								From	NhanVien
								Group by	MSCN
								)

--q9) Cho biết các nhân viên sử dụng được mọi kỹ năng (Phép chia)
--Cách 1: Sử dụng phép đếm
Select A.MaNV, Ho, Ten
From	NhanVien A, NhanVienKyNang B
Where	A.MANV = B.MANV
Group by A.MaNV, Ho, Ten
having	count(MSKN) = (	Select count(MSKN)
						From	KyNang
					  )
--Cách 2: Phát biểu tương đương "Cho biết các nhân viên không có kỹ năng nào mà nhân biên đó không sử dụng được."
Select *
From	NhanVien A
Where	not exists(	Select *
					From KyNang B
					Where not exists(Select *
									 From NhanVienKyNang C
									 Where C.MSKN = B.MSKN and C.MANV = A.MANV
									 )
					)
--Q2d) Liệt kê các chi nhánh (MSCN, TenCN) mà mọi nhân viên trong chi nhánh đó đều biết ‘Word’. (Phép chia)
Select	A.MSCN, TenCN, count(B.MaNV) as SoNVDungWord
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Word'
Group by A.MSCN, TenCN
Having	count(B.MaNV) = (	Select count(MaNV)
							From NhanVien
							Where	MSCN = A.MSCN
						)

------Cập nhật dữ liệu------
--Q4a) Thêm bộ <’06’, ‘PhotoShop’> vào bảng KyNang 
insert into KyNang values('06', 'Photoshop')
--xem bảng KyNang
Select * From KyNang
--Q4b) Thêm các bộ sau vào bảng NhanVienKyNang  <’0001’,’06’,3> ;  <’0005’, ‘06’, 2> 
insert into NhanVienKyNang values('0001','06', 3)
insert into NhanVienKyNang values('0005','06', 2)
--xem bảng NhanVienKyNang
Select * From NhanVienKyNang
--Q4c) Cập nhật cho các nhân viên có sử dụng kỹ năng ‘Word’có mức độ tăng thêm một bậc
---Xem thông tin các nhân viên sử dụng Word
select * 
from NhanVienKyNang 
where MSKN ='01'
--Cập nhật mức độ của người sử dụng Word lên 1 bậc
update	NhanVienKyNang
set MucDo = MucDo + 1
where	MSKN = '01'
--Q4d) Tạo bảng mới NhanVienChiNhanh1(MANV, HoTen, SoKyNang) (dùng lệnh Create table)
Create table NhanVienCN1
(MaNV	char(4) primary key,
HoTen	nvarchar(30),
SoKyNang	tinyint
)
--xem bảng NhanVienCN1
Select *
From NhanVienCN1
--Q4e) Thêm vào bảng trên các thông tin như đã liệt kê của các nhân viên thuộc chi nhánh 1 (dùng câu lệnh Insert Into cho nhiều bộ). 
insert into NhanVienCN1
Select	A.MaNV, Ho+' '+ Ten, count(MSKN)
From	NhanVien A, NhanVienKyNang B
Where	A.MaNV = B.MaNV	 and MSCN = '01'
Group by	A.MaNV, Ho, Ten
