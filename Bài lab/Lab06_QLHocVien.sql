/*
	Học phần: Cơ sở dữ liệu
	Lab06: Quản lý học viên
	SV thực hiện:	
	Mã SV:			
	Lớp:			
	Thời gian:		
*/

create database Lab06_QLHocVien
go

use Lab06_QLHocVien
go

create table CaHoc
(
	Ca tinyint primary key,
	GioBatDau datetime,
	GioKetThuc datetime
)
go

create table GiaoVien
(
	MSGV char(4) primary key,
	HoGV nvarchar(30) not null,
	TenGV nvarchar(10) not null,
	DienThoai varchar(11)
)
go

create table Lop
(
	MaLop char(4) primary key,
	TenLop varchar(20) not null,
	NgayKG datetime,
	HocPhi int check(HocPhi > 0),
	Ca tinyint references CaHoc(Ca),
	SoTiet tinyint,
	SoHV tinyint check(SoHV <= 30),
	MSGV char(4) references GiaoVien(MSGV)
)
go

create table HocVien
(
	MSHV char(6) primary key,
	Ho nvarchar(30) not null,
	Ten nvarchar(10) not null,
	NgaySinh datetime,
	Phai nvarchar(10) not null,
	MaLop char(4) references Lop(MaLop)
)
go

create table HocPhi
(
	SoBL char(4) primary key,
	MSHV char(6) references HocVien(MSHV),
	NgayThu datetime,
	SoTien int not null,
	NoiDung varchar(50),
	NguoiThu nvarchar(10) not null
)
go


-- Câu 5a.
create proc USP_ThemCaHoc
	@ca tinyint, 
	@giobd datetime, 
	@giokt datetime
as
	if	exists(select * from	CaHoc where	Ca = @ca)
		print N'Đã có ca học ' + CAST(@ca as nvarchar) + N' trong CSDL!'
	
	else
		begin
			insert into CaHoc values(@ca, @giobd, @giokt)
			print N'Thêm ca học thành công!'
		end
go

exec USP_ThemCaHoc 1, '7:30', '10:45'
exec USP_ThemCaHoc 2, '13:30', '16:45'
exec USP_ThemCaHoc 3, '17:30', '20:45'
select * from CaHoc
go

create proc USP_ThemGiaoVien
	@msgv char(4), 
	@hogv nvarchar(30), 
	@tengv nvarchar(10), 
	@dienthoai varchar(11)
as
	if	exists(select * from	GiaoVien where	MSGV = @msgv)
		print N'Đã có giáo viên có mã số ' + @msgv + N' trong CSDL!'

	else
		begin
			insert into GiaoVien values(@msgv, @hogv, @tengv, @dienthoai)
			print N'Thêm giáo viên thành công!'
		end
go

exec USP_ThemGiaoVien 'G001', N'Lê Hoàng', N'Anh', '858936'
exec USP_ThemGiaoVien 'G002', N'Nguyễn Ngọc', N'Lan', '845623'
exec USP_ThemGiaoVien 'G003', N'Trần Minh', N'Hùng', '823456'
exec USP_ThemGiaoVien 'G004', N'Võ Thanh', N'Trung', '841256'
select * from GiaoVien
go

create proc USP_ThemLop
	@malop char(4),
	@tenlop varchar(20),
	@ngaykg datetime,
	@hocphi int, 
	@ca tinyint,
	@sotiet tinyint,
	@sohv tinyint,
	@msgv char(4)
as
	if	exists(select * from CaHoc where Ca = @ca) and 
		exists(select * from GiaoVien where MSGV = @msgv)

		begin
			if exists(select * from	Lop where MaLop = @malop)
				print N'Đã có lớp ' + @malop + N' trong CSDL'

			else
				begin
					insert into Lop values(@malop, @tenlop, @ngaykg, @hocphi, @ca, @sotiet, @sohv, @msgv)
					print N'Thêm lớp học thành công'
				end
		end

	else
		if not exists(select * from	CaHoc where	Ca = @ca)
			print N'Không có ca học ' + CAST(@ca as nvarchar) + N' trong CSDL nên không thêm được lớp học!'

		if not exists (select * from GiaoVien where	MSGV = @msgv)
			print N'Không có giáo viên có mã số ' + @msgv + N' trong CSDL nên không thêm được lớp học!'
go

set dateformat dmy
exec USP_ThemLop 'E114', 'Excel 3-5-7', '02/01/2008', 120000, 1, 45, 0, 'G003'
exec USP_ThemLop 'E115', 'Excel 2-4-6', '22/01/2008', 120000, 3, 45, 0, 'G001'
exec USP_ThemLop 'W123', 'Word 2-4-6', '18/02/2008', 100000, 3, 30, 0, 'G001'
exec USP_ThemLop 'W124', 'Word 3-5-7', '01/03/2008', 100000, 1, 30, 0, 'G002'
exec USP_ThemLop 'A075', 'Access 2-4-6', '18/12/2008', 150000, 3, 60, 0, 'G003'
select * from Lop
go

create proc USP_ThemHocVien
	@mshv char(6),
	@ho nvarchar(30),
	@ten nvarchar(10),
	@ngaysinh datetime,
	@phai nvarchar(10),
	@malop char(4)
as
	if	exists(select * from Lop where Malop = @malop)

		begin
			if exists(select * from	HocVien where MSHV = @mshv)
				print N'Đã có học viên ' + @mshv + ' trong CSDL!'

			else
				begin
					insert into HocVien values (@mshv, @ho, @ten, @ngaysinh, @phai, @malop)
					update Lop set SoHV = SoHV + 1 where MaLop = @malop
				end
		end

	else
		print N'Lớp ' + @malop + ' không tồn tại trong CSDL, không thêm học viên được!'
go

set dateformat dmy
exec USP_ThemHocVien 'A07501', N'Lê Văn', N'Minh', '10/06/1998', N'Nam', 'A075'
exec USP_ThemHocVien 'A07502', N'Nguyễn Thị', N'Mai', '20/04/1998', N'Nữ', 'A075'
exec USP_ThemHocVien 'A07503', N'Lê Ngọc', N'Tuấn', '10/06/1994', N'Nam', 'A075'
exec USP_ThemHocVien 'E11401', N'Vương Tuấn', N'Vũ', '25/03/1999', N'Nam', 'E114'
exec USP_ThemHocVien 'E11402', N'Lý Ngọc', N'Hân', '01/12/1995', N'Nữ', 'E114'
exec USP_ThemHocVien 'E11403', N'Trần Mai', N'Linh', '04/06/1990', N'Nữ', 'E114'
exec USP_ThemHocVien 'W12301', N'Nguyễn Ngọc', N'Tuyết', '12/05/1996', N'Nữ', 'W123'
select * from HocVien
go

create proc USP_ThemHocPhi
	@sobl char(4),
	@mshv char(6),
	@ngaythu datetime,
	@sotien int,
	@noidung varchar(50),
	@nguoithu nvarchar(10)
as
	if	exists(select * from HocVien where MSHV = @mshv)

		begin
			if exists(select * from HocPhi where SoBL = @sobl)
				print N'Đã có biên lai ' + @sobl + ' trong CSDL!'

			else
				begin
					insert into HocPhi values(@sobl, @mshv, @ngaythu, @sotien, @noidung, @nguoithu)
					print N'Thêm biên lai học phí thành công!'
				end
		end

	else
		print N'Học viên ' + @mshv + ' không tồn tại trong CSDL nên không thể thêm biên lai cho học viên này!'
go

set dateformat dmy
exec USP_ThemHocPhi '0001', 'E11401', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec USP_ThemHocPhi '0002', 'E11402', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec USP_ThemHocPhi '0003', 'E11403', '02/01/2008', 80000, 'HP Excel 3-5-7', N'Vân'
exec USP_ThemHocPhi '0004', 'W12301', '18/02/2008', 100000, 'HP Word 2-4-6', N'Lan'
exec USP_ThemHocPhi '0005', 'A07501', '16/12/2008', 150000, 'HP Acess 2-4-6', N'Lan'
exec USP_ThemHocPhi '0006', 'A07502', '16/12/2008', 100000, 'HP Acess 2-4-6', N'Vân'
exec USP_ThemHocPhi '0007', 'A07503', '18/12/2008', 150000, 'HP Acess 2-4-6', N'Vân'
exec USP_ThemHocPhi '0008', 'A07502', '15/01/2009', 50000, 'HP Acess 2-4-6', N'Vân'
select * from HocPhi
go


-- Câu 4a.
create trigger TR_GioHoc_CaHoc_FOR_INS_UPD
on CaHoc for insert, update 
as
	if	update(GioBatDau) or update(GioKetThuc)

		if exists (select * 
				from	inserted i
				where	i.GioBatDau > i.GioKetThuc)

		begin
			raiserror(N'Giờ kết thúc không thể nhỏ hơn giờ bắt đầu!', 15, 1)
			rollback tran
		end
go


-- Câu 4b. 
create trigger TR_SiSo_Lop_FOR_INS_UPD
on Lop for insert, update
as
	if	update(MaLop) or update(SoHV)
		
		begin
			if exists (select * 
					from	inserted i
					where	i.SoHV > 30)

			begin
				raiserror(N'Sĩ số của lớp học không quá 30!', 15, 1)
				rollback tran
			end

			if exists (select *
					from	inserted l
					where	l.SoHV <>
					
						(select	COUNT(MSHV)
						from	HocVien
						where	HocVien.MaLop = l.MaLop))

			begin
				raiserror(N'Sĩ số của lớp phải bằng số học viên!', 15, 1)
				rollback tran
			end
		end
go

create trigger TR_SiSo_HocVien_FOR_INS_DEL_UPD
on HocVien for insert, delete, update
as
	if	update(MaLop)

		begin
			if exists(select *
				from	Lop
				where	SoHV > 30)
				
			begin
				raiserror(N'Sĩ số của lớp học không quá 30!', 15, 1)
				rollback tran
			end
		end
go



-- Câu 4c.
create trigger TR_TienHP_HocPhi_FOR_INS_UPD
on HocPhi for insert, update
as
	if	update(MSHV) or update(SoTien)

		begin
			if exists(select *
				from	inserted i
						join HocVien on i.MSHV = HocVien.MSHV
						join Lop on HocVien.MaLop = Lop.MaLop
				where	i.SoTien > Lop.HocPhi)
							
			begin
				raiserror(N'Số tiền thu không được vượt quá học phí!', 15, 1)
				rollback tran
			end
		end
go

create trigger TR_TienHP_HocVien_FOR_UPD
on HocVien for update
as
	if	update(MSHV) or update(MaLop)

		begin
			if exists(select *
				from	inserted i
						join HocPhi on i.MSHV = HocPhi.MSHV
						join Lop on Lop.MaLop = i.MaLop
				where	HocPhi.SoTien > Lop.HocPhi)
							
			begin
				raiserror(N'Số tiền học phí vượt quá lớp mới!', 15, 1)
				rollback tran
			end
		end
go

create trigger TR_TienHP_Lop_FOR_DEL_UPD
on Lop for delete, update
as
	if	update(MaLop) or update(HocPhi)

		begin
			if exists(select *
				from	inserted i
						join HocVien on i.MaLop = HocVien.MaLop
						join HocPhi on HocVien.MSHV = HocPhi.MSHV
				where	HocPhi.SoTien > i.HocPhi)
							
			begin
				raiserror(N'Số tiền học phí vượt quá lớp mới!', 15, 1)
				rollback tran
			end
		end
go


-- KIỂM TRA RÀNG BUỘC TOÀN VẸN
-- Câu 4a.
select * from CaHoc
insert into CaHoc values (4, '20:45', '17:30') -- Vi phạm 
insert into CaHoc values (4, '17:30', '20:30') -- Thỏa mãn

update CaHoc set GioBatDau = '22:00' where Ca = 4 -- Vi phạm
update CaHoc set GioBatDau = '16:00' where Ca = 4 -- Thỏa mãn
delete from CaHoc where Ca = 4


-- Câu 4b.
select * from Lop
set dateformat dmy
insert into Lop values('P001', 'Photoshop', '1/11/2018', 250000, 1, 100, 2, 'G004') -- Vi phạm 
insert into Lop values('P001', 'Photoshop', '1/11/2018', 250000, 1, 100, 0, 'G004') -- Thỏa mãn
delete from Lop where MaLop = 'P001'

set dateformat dmy
exec USP_ThemHocVien 'P45301', N'Nguyễn Hoàng', N'Anh', '14/06/1995', N'Nữ', 'P001'
select * from HocVien


-- Câu 4c.


go
-- Câu 5b.
create proc USP_CapNhatThongTinHV
	@mshv char(6),
	@ho nvarchar(30),
	@ten nvarchar(10),
	@ngaysinh datetime,
	@phai nvarchar(10),
	@malop char(4)
as
	if	exists(select * from HocVien where MSHV = @mshv) and
		exists(select * from Lop where MaLop = @malop)

		begin
			update	HocVien set	Ho = @ho,
								Ten = @ten,
								NgaySinh = @ngaysinh,
								Phai = @phai,
								MaLop = @malop
			where	MSHV = @mshv

			print N'Cập nhật dữ liệu của học viên có mã số ' + @mshv + ' thành công!'
			select * from HocVien where MSHV = @mshv
		end

	else
		begin
			if	not exists(select * from HocVien where MSHV = @mshv)
				print N'Không tìm thấy học viên có mã số ' + @mshv + ' trong CSDL!'

			if	not exists(select * from Lop where MaLop = @malop)
				print N'Không có lớp học có mã số ' + @malop + ' trong CSDL!'
		end
go


-- Câu 5c.
create proc USP_XoaHocVien
	@mshv char(6) 
as
	if	exists(select * from HocVien where MSHV = @mshv)
		
		begin
			delete from HocVien where MSHV = @mshv
			delete from HocPhi where MSHV = @mshv
			print N'Đã xóa học viên có mã số ' + @mshv + ' ra khỏi CSDL!'
		end

	else
		print N'Không tồn tại học viên có mã số ' + @mshv + ' trong CSDL!'
go


-- Câu 5d.
create proc USP_CapNhatThongTinLop
	@malop char(4),
	@tenlop varchar(20),
	@ngaykg datetime,
	@hocphi int, 
	@ca tinyint,
	@sotiet tinyint,
	@sohv tinyint,
	@msgv char(4)
as
	if exists(select * from Lop where MaLop = @malop)
		
		begin
			if	exists(select * from CaHoc where Ca = @ca) and
				exists(select * from GiaoVien where MSGV = @msgv)

				begin
					update	Lop set	MaLop = @malop,
									TenLop = @tenlop,
									NgayKG = @ngaykg,
									HocPhi = @hocphi,
									Ca = @ca,
									SoTiet = @sotiet,
									SoHV = @sohv,
									MSGV = @msgv
					where	MaLop = @malop
					print N'Cập nhật dữ liệu của lớp có mã lớp ' + @malop + ' thành công!'
				end

			else
					if not exists(select * from CaHoc where Ca = @ca)
						print N'Không có ca học ' + CAST(@ca as nvarchar) + ' trong CSDL!'

					if not exists(select * from GiaoVien where MSGV = @msgv)
						print N'Không có giáo viên ' + @msgv + ' trong CSDL!'
		end

		else
			print N'Không tồn tại lớp ' + @malop + N' trong CSDL!'
go


select * from Lop

exec USP_CapNhatThongTinLop A


-- Câu 5e.
create proc USP_XoaLopNeuKoCoHV
	@malop char(4)
as
	if	exists(select * from Lop where MaLop = @malop)
	
		begin
			if exists (select * from Lop where SoHV = 0)

				begin
					delete from Lop where MaLop = @malop
					print N'Đã xóa lớp có mã số ' + @malop + ' ra khỏi CSDL!'
				end

			else
				print N'Không xóa được vì lớp này vẫn còn học viên!'
		end

	else
		print N'Không tồn tại lớp có mã số ' + @malop + ' trong CSDL nên không xóa được!'
go


-- Câu 5f.
create proc USP_LapDSHV
	@malop char(4)
as 
	if	exists(select * from Lop where MaLop = @malop)

		begin
			select	*
			from	Lop
			where	MaLop = @malop
		end

	else
		print N'Không tồn tại lớp có mã số ' + @malop + ' trong CSDL!'
go


-- Câu 5g.
create proc USP_DSHVNoHP
	@malop char(4)
as
	if	exists(select * from Lop where MaLop = @malop)

		begin
			select	Ho,
					Ten,
					TenLop,
					HocPhi,
					COALESCE(SUM(SoTien), 0) as TongSoTien
			from	HocVien
					join Lop on HocVien.MaLop = Lop.MaLop
					left join HocPhi on HocVien.MSHV = HocPhi.MSHV
			where	Lop.MaLop = @malop
			group by Ho, Ten, TenLop, HocPhi
			having	COALESCE(SUM(SoTien), 0) < HocPhi
		end

	else
		print N'Không tồn tại lớp có mã số ' + @malop + ' trong CSDL!'
go


-- Câu 6a.
create function FN_TongSoTien1Lop(@malop char(4)) returns int
as
	begin
		declare @tongtien int

		if exists(select * from Lop where MaLop = @malop)
			begin
				select	@tongtien = SUM(SoTien)
				from	HocPhi
						join HocVien on HocPhi.MSHV = HocVien.MSHV
				where	MaLop = @malop
			end

		return @tongtien
	end
go


-- Câu 6b.
create function FN_TongHPInTGRange(@tgbd datetime, @tgkt datetime) returns int
as
	begin
		declare @tongtien int

		select @tongtien = SUM(SoTien)
		from	HocPhi
		where	NgayThu between @tgbd and @tgkt

		return @tongtien
	end	
go



-- Câu 6c.
create function FN_HVNopDuHPChua(@mshv char(6)) returns nvarchar(50)
as
	begin
		declare @hocphi int, @tongdadong int = 0, @ketqua nvarchar(50)

		select	@hocphi = HocPhi
		from	Lop
				join HocVien on HocVien.MaLop = Lop.MaLop
		where	MSHV = @mshv

		select	@tongdadong = SUM(SoTien)
		from	HocPhi
		where	MSHV = @mshv

		if @tongdadong = @hocphi
			set @ketqua = N'Học viên đã đóng đủ học phí!'
		else
			set @ketqua = N'Học viên chưa đóng đủ học phí!'

		return @ketqua
	end
go

print dbo.FN_HVNopDuHPChua('E11403')