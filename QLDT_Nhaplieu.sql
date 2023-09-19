
USE master
GO 


IF DB_ID('QLDT') IS NOT NULL
	DROP DATABASE QLDT
GO

CREATE DATABASE QLDT 
GO

USE QLDT
GO

CREATE TABLE GIAOVIEN
(
	MAGV CHAR(5),
	HOTEN NCHAR(40), 
	LUONG FLOAT,
	PHAI NCHAR(5),
	NGSINH DATETIME, 
	DIACHI NVARCHAR(100),
	GVQLCM CHAR(5),
	MABM NCHAR(5)

	CONSTRAINT PK_GV
	PRIMARY KEY(MAGV)
)

CREATE TABLE BOMON 
(
	MABM NCHAR(5),
	TENBM NCHAR(40),
	PHONG CHAR(5),
	DIENTHOAI CHAR(12),
	TRUONGBM CHAR(5),
	MAKHOA CHAR(5), 
	NGAYNHANCHUC DATETIME

	CONSTRAINT PK_BM
	PRIMARY KEY(MABM) 
)

CREATE TABLE KHOA
(
	MAKHOA CHAR(5),
	TENKHOA NCHAR(40),
	NAMTL INT,
	PHONG CHAR(5), 
	DIENTHOAI CHAR(12),
	TRUONGKHOA CHAR(5),
	NGAYNHANCHUC DATETIME
	
	CONSTRAINT PK_KHOA
	PRIMARY KEY(MAKHOA)
)

CREATE TABLE THAMGIADT
(
	MAGV CHAR(5),
	MADT CHAR(5),
	STT INT,
	PHUCAP FLOAT,
	KETQUA NCHAR(10)

	CONSTRAINT PK_TG
	PRIMARY KEY (MAGV, MADT, STT)
)

CREATE TABLE CONGVIEC
(
	MADT CHAR(5),
	SOTT INT, 
	TENCV NCHAR(40),
	NGAYBD DATETIME,
	NGAYKT DATETIME

	CONSTRAINT PK_CV
	PRIMARY KEY(MADT, SOTT)
)

CREATE TABLE DETAI
(
	MADT CHAR(5),
	TENDT NCHAR(40),
	CAPQL NCHAR(40),
	KINHPHI INT,
	NGAYBD DATETIME,
	NGAYKT DATETIME,
	MACD CHAR(5),
	GVCNDT CHAR(5)

	CONSTRAINT PK_DT
	PRIMARY KEY (MADT)
)

CREATE TABLE CHUDE
(
	MACD CHAR(5),
	TENCD NCHAR (100)

	CONSTRAINT PK_CD
	PRIMARY KEY (MACD)
)

CREATE TABLE NGUOITHAN
(
	MAGV CHAR(5),
	TEN NCHAR(40),
	NGSINH DATETIME,
	PHAI NCHAR(3)

	CONSTRAINT PK_NT
	PRIMARY KEY (MAGV, TEN)
)

CREATE TABLE GV_DT
(
	 MAGV CHAR(5),
	 DIENTHOAI CHAR(12)
	PRIMARY KEY (MAGV, DIENTHOAI)
)

ALTER TABLE GIAOVIEN ADD
	CONSTRAINT FK_GV_GV FOREIGN KEY(GVQLCM) REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT FK_GV_BM FOREIGN KEY(MABM) REFERENCES BOMON(MABM)

ALTER TABLE NGUOITHAN ADD
	CONSTRAINT FK_NT_GV FOREIGN KEY(MAGV) REFERENCES GIAOVIEN(MAGV)

ALTER TABLE  GV_DT ADD
	CONSTRAINT FK_GVDT_GV FOREIGN KEY(MAGV) REFERENCES GIAOVIEN(MAGV)

ALTER TABLE THAMGIADT ADD
	CONSTRAINT FK_TG_GV FOREIGN KEY(MAGV) REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT FK_TG_CV FOREIGN KEY(MADT,STT) REFERENCES CONGVIEC(MADT,SOTT) 

ALTER TABLE  CONGVIEC ADD
	CONSTRAINT FK_CV_DT FOREIGN KEY(MADT) REFERENCES  DETAI(MADT)

ALTER TABLE DETAI ADD
	CONSTRAINT FK_DT_CD FOREIGN KEY(MACD) REFERENCES CHUDE(MACD),
	CONSTRAINT FK_DT_GV FOREIGN KEY(GVCNDT) REFERENCES GIAOVIEN(MAGV)

ALTER TABLE  BOMON ADD
	CONSTRAINT FK_BM_K FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA),
	CONSTRAINT FK_BM_GV FOREIGN KEY(TRUONGBM) REFERENCES GIAOVIEN(MAGV)


ALTER TABLE  KHOA ADD
	CONSTRAINT FK_K_GV FOREIGN KEY(TRUONGKHOA) REFERENCES GIAOVIEN(MAGV)



--==================================================================================
SET DATEFORMAT DMY

INSERT INTO KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC) VALUES
('CNTT',N'Công nghệ thông tin',1995,'B11','0838123456',null,'20/02/2005'),
('HH',N'Hóa học',1980,'B41','0838456456',null,'15/10/2001'),
('SH',N'Sinh học',1980,'B31','0838454545',null,'11/10/2000'),
('VL',N'Vật lý',1976,'B21','0838223223',null,'18/09/2003')

--==================================================================================
INSERT INTO BOMON(MABM, TENBM,PHONG, DIENTHOAI, TRUONGBM, MAKHOA,NGAYNHANCHUC) VALUES
(N'CNTT',N'Công nghệ tri thức','B15','0838126126',null, 'CNTT', null),
(N'HHC',N'Hóa hữu cơ','B44','838222222',null, 'HH', null),
(N'HL',N'Hóa lý','B42','0838878787',null, 'HH', null)	,
(N'HPT',N'Hóa phân tích','B43','0838777777',null,'HH','15/10/2007'),
(N'HTTT',N'Hệ thống thông tin','B13','0838125125',null,'CNTT','20/09/2004'),
(N'MMT',N'Mạng máy tính','B16','0838676767 ',null,'CNTT','15/05/2005'),
(N'SH',N'Sinh hóa','B33','0838898989',null, 'SH', null),
(N'VLĐT',N'Vật lý điện tử','B23','0838234234',null, 'VL', null)	,
(N'VLƯD',N'Vật lý ứng dụng','B24','0838454545',null,'VL','18/02/2006'),
(N'VS',N'Vi sinh','B32','0838909090',null,'SH','01/01/2007')

--==================================================================================
INSERT INTO GIAOVIEN(MAGV,HOTEN,LUONG, PHAI,NGSINH,DIACHI,GVQLCM,MABM) VALUES
('001',N'Nguyễn Hoài An',2000,N'Nam','15/02/1973',N'25/3 Lạc Long Quân, Q.10, TP HCM', null, N'MMT'),
('002',N'Trần Trà Hương',2500,N'Nữ','20/06/1960',N'125	Trần Hưng Đạo, Q.1,TP HCM', null, N'HTTT'),
('003',N'Nguyễn Ngọc Ánh',2200,N'Nữ','11/05/1975',N'12/21	Võ Văn Ngân	Thủ Đức, TP HCM', '002',N'HTTT'),
('004',N'Trương Nam Sơn',2300,N'Nam','20/06/1959',N'215	Lý Thường Kiệt,TP Biên Hòa',null, N'VS'),
('005',N'Lý Hoàng Hà',2500,N'Nam','23/10/1954',N'22/5	Nguyễn Xí, Q.Bình Thạnh, TP HCM',null, N'VLĐT'),
('006',N'Trần Bạch Tuyết',1500,N'Nữ','20/05/1980',N'127	Hùng Vương, TP Mỹ Tho','004',N'VS'),
('007',N'Nguyễn An Trung',2100,N'Nam','05/06/1976',N'234 3/2, TP Biên Hòa',null, N'HPT'),
('008',N'Trần Trung Hiếu',1800,N'Nam','06/08/1977',N'22/11 Lý Thường Kiệt, TP Mỹ Tho','007',N'HPT'),
('009',N'Trần Hoàng Nam',2000,N'Nam','22/11/1975',N'234	Trấn Não, An Phú,TP HCM','001',N'MMT'),
('010',N'Phạm Nam Thanh',1500,N'Nam','12/12/1980',N'221	Hùng Vương, Q.5, TP HCM','007',N'HPT')

--==================================================================================
INSERT INTO GV_DT VALUES
('001','0838912112'),
('001','0903123123'),
('002','0913454545'),
('003','0838121212'),
('003','0903656565'),
('003','0937125125'),
('006','0937888888'),
('008','0653717171'),
('008','0913232323')

--==================================================================================
INSERT INTO NGUOITHAN(MAGV,TEN,NGSINH,PHAI) VALUES
('001', N'Hùng', '14/01/1990', N'Nam'),
('001', N'Thủy', '08/12/1994', N'Nữ'),
('003', N'Hà', '3/9/1998', N'Nữ'),
('003', N'Thu', '3/9/1998', N'Nữ'),
('007', N'Mai', '26/3/2003', N'Nữ'),
('007', N'Vy', '14/02/2000', N'Nữ'),
('008', N'Nam', '06/05/1991', N'Nam'),
('009', N'An', '19/8/1996', N'Nam'),
('010', N'Nguyệt', '14/1/2006', N'Nữ')
--==================================================================================
INSERT INTO CHUDE(MACD,TENCD) VALUES
(N'NCPT',N'Nghiên cứu phát triển'),
(N'QLGD',N'Quản lý giáo dục'),
(N'ƯDCN',N'Ứng dụng công nghệ')

INSERT INTO DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT) VALUES
('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20,'20/10/2007','20/10/2008',N'QLGD','002'),
('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường',20,'12/10/2000','12/10/2001',N'QLGD','002'),
('003',N'Nghiên cứu chế tạo sợi Nanô Platin',N'ĐHQG',300,'15/5/2008','15/05/2010',N'NCPT','005'),
('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100,'01/01/2007','31/12/2009',N'NCPT','004'),
('005',N'Ứng dụng hóa học xanh',N'Trường',200,'10/10/2003','10/12/2004',N'ƯDCN','007'),
('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000,'20/10/2006','20/10/2009',N'NCPT','004'),
('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường',20,'10/5/2009','10/5/2010',N'QLGD','001')

INSERT INTO CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT) VALUES
('001',1,N'Khởi tạo và Lập kế hoạch','20/10/2007','20/12/2008'),
('001',2,N'Xác định yêu cầu','21/12/2008','21/03/2008'),
('001',3,N'Phân tích hệ thống','22/03/2008','22/5/2008'),
('001',4,N'Thiết kế hệ thống','23/05/2008','23/06/2008'),
('001',5,N'Cài đặt thử nghiệm','24/06/2008','20/10/2008'),
('002',1,N'Khởi tạo và Lập kế hoạch','10/05/2009','10/07/2009'),
('002',2,N'Xác định yêu cầu','11/07/2009','11/10/2009'),
('002',3,N'Phân tích hệ thống','12/10/2009','20/12/2009'),
('002',4,N'Thiết kế hệ thống','21/12/2009','22/03/2010'),
('002',5,N'Cài đặt thử nghiệm','23/03/2010','10/05/2010'),
('006',1,N'Lấy mẫu','20/10/2006','20/02/2007'),
('006',2,N'Nuôi cấy','21/02/2007','21/08/2008')

--==================================================================================
INSERT INTO THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA) VALUES
('001','002',1,0, null)	,
('001','002',2,2, null)	,
('002','001',4,2,N'Đạt'),
('003','001',1,1,N'Đạt'),
('003','001',2,0,N'Đạt'),
('003','001',4,1,N'Đạt'),
('003','002',2,0, null)	,
('004','006',1,0,N'Đạt'),
('004','006',2,1,N'Đạt'),
('006','006',2,1.5,N'Đạt'),
('009','002',3,0.5, null),	
('009','002',4,1.5, null)

--==================================================================================

update KHOA set TRUONGKHOA = '002' where MAKHOA='CNTT'
update KHOA set TRUONGKHOA = '005' where MAKHOA='VL'
update KHOA set TRUONGKHOA = '004' where MAKHOA='SH'
update KHOA set TRUONGKHOA = '007' where MAKHOA='HH'
--==================================================================================

update BOMON set TRUONGBM = '002' where MABM=N'HTTT'
update BOMON set TRUONGBM = '001' where MABM=N'MMT'
update BOMON set TRUONGBM = '005' where MABM=N'VLƯD'
update BOMON set TRUONGBM = '004' where MABM=N'VS'
update BOMON set TRUONGBM = '007' where MABM=N'HPT'

SELECT * FROM GIAOVIEN
SELECT * FROM GV_DT
SELECT * FROM BOMON
SELECT * FROM KHOA
SELECT * FROM DETAI
SELECT * FROM CHUDE
SELECT * FROM CONGVIEC
SELECT * FROM THAMGIADT