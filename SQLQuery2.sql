use master
go
--tạo cơ sở dữ liệu 
CREATE DATABASE Lab31_TranHuyTung
GO
--sử dụng cơ sở dữ liệu 
use Lab31_TranHuyTung
go
--tạo cấu trúc bảng Vattu(MaVTu,TenVTu,DvTinh,PhanTram)
Create table VATTU
(
MaVTu char(4) not null Constraint PK_VATTU primary key,
TenVTu nvarchar(100) not null Constraint UQ_VATTU_TenVTu Unique,
DvTinh nvarchar(10) Constraint DF_VATTU_DvTinh default'',
PhanTram real constraint CK_VATTU_PhanTram Check(PhanTram>=0 and PhanTram<=100)
)
go
--tạo bảng NHACC(MaNhaCc,TenNhaCc,DiaChia,DienThoai)
Create table NHACC
(
MaNhaCc char(3) not null Primary key,
TenNhaCc nvarchar(100) not null,
DiaChi nvarchar(200) not null,
DienThoai varchar(20) null default N'chưa có'
)
go
--tạo bảng DONDH(SoDh,NgayDh,MaNhaCC)
create table DONDH
(
SoDH char(4) NOT NULL PRIMARY KEY,
NgayDH datetime DEFAULT GETDATE(),
MaNhaCC CHAR(3) REFERENCES NHACC(MaNhaCC)
)
GO
--TẠO BẢNG CTDONDH(SoDH,MaVTu,SLDat)
CREATE TABLE CTDONDH
(
SoDH CHAR(4) NOT NULL references DONDH ,
MaVTu CHAR(4) NOT NULL references VATTU(MaVTu),
SLDat INT NOT NULL CHECK (SLDaT>0),
PRIMARY KEY(SoDH,MaVTu)
)
GO
--tạo bảng PNHAP (SoPN,NgayNhap,SoDh)
create table PNHAP
(
SoPn CHAR(4) PRIMARY KEY,
NgayNhap datetime ,
SoDh char(4) not null references DONDH(SoDH)
)
GO
--tạo bảng CTPNHAP
create table CTPNHAP
(
SoPn char(4)REFERENCES PNHAP(SoPn),
MaVTu char(4) not null references VATTU(MaVTu),
SlNhap int not null check(SlNhap>0),
DgNhap money not null check(DgNhap>0),
primary key(SoPn,MaVtu)
)
go
-- tạo bang pxuat
create table PXUAT
(SoPX char(4) not null primary key ,
NgayXuat datetime ,
TenKh varchar(100) not null ,
)
go 
--tạo bang CTPXUAT
create table CTPXUAT
(SoPx CHAR (4) NOT NULL REFERENCES PXUAT ,
MaVTu CHAR(4) NOT NULL REFERENCES VATTU(MaVTu),
SlXuat INT NOT NULL CHECK (SlXuat >0),
DgXuat MONEY NOT NULL CHECK (DgXuat>0)
PRIMARY KEY (SoPx,MaVTu)
)
GO 
-- TẠO BẢNG TONKHO 
CREATE TABLE TONKHO 
(
NamThang CHAR(6) NOT NULL ,
MaVTu CHAR(4) NOT NULL REFERENCES VATTU(MaVTu),
SlDau INT NOT NULL CHECK (SlDau >0),
TongSLN INT NOT NULL CHECK (TongSLN>0),
TongSLX int not null check (TongSLX>0),
 SLCuoi  AS SLDau + TongSLN - TongSLX ,
 PRIMARY KEY (NamThang, MaVTu)
)
go