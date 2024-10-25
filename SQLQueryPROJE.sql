create database SporSalonu
USE SporSalonu

create table UYELER (
uye_id int primary key identity(1,1),
uye_adi nvarchar(50),
uye_soyadi nvarchar (50),
uyelik_baslangic date,)
ALTER table UYELER 
ADD uye_email nvarchar (100) 

create table SPORLAR (
spor_id int primary key identity (1,1),
spor_adi nvarchar (70),
spor_zorluk nvarchar (20))
create table spor_katilim (
katilim_id int primary key identity(1,1),
uye_id int foreign key (uye_id) references UYELER (uye_id),
spor_id int foreign key (spor_id) references SPORLAR (spor_id),
katilim_tarihi date)

declare @i INT=1;
declare @Ad nvarchar(50);
declare @Soyad NVARCHAR(50);
declare @Tarih DATE;
declare @Email Nvarchar(100);

declare @Isimler table (Ad nvarchar (50));
insert into @Isimler values 
('Ahmet'),('Ali'),('Damla'),('Meltem'),('Faruk'),('Fulya'),('Cengiz'),('Hasan'),('Hazal'),('Aysu'),
('Cansel'),('Hande'),('Mert'),('Mehmet'),('Pelin'),('Ata'),('Elif'),('Zeynep')

declare @Soyadlar table (Soyad nvarchar(50));
insert into @Soyadlar values
('ÞEN'),('DEMÝR'),('ASLAN'),('AKTAÞ'),('ERDEM'),('GÜNEÞ'),('YILMAZ'),('KAYA'),('TUNÇ'),('ÖZER'),
('YAVUZ'),('SEZER'),('TEKÝN'),('AYHAN'),('ÖNER'),('AYTAÇ'),('ATAY'),('YILDIZ')

declare @StartDate DATE = '2020-01-01';
declare @EndDate DATE ='2024-01-01';
declare @TotalDays int = DATEDIFF( DAY, @StartDate, @EndDate)

while @i<= 100000
begin 
select TOP 1 @Ad= Ad from @Isimler order by NEWID();
Select TOP 1 @Soyad= Soyad from @Soyadlar order by NEWID();

set @Email= LOWER(@Ad)+'.'+ LOWER(@Soyad) + cast(@i as nvarchar(10))+'@example.com';
set @Tarih = DATEADD (DAY,FLOOR(RAND()* @TotalDays), @StartDate);

INSERT INTO UYELER (uye_adi, uye_soyadi, uyelik_baslangic, uye_email)
values (@Ad,@Soyad,@Tarih,@Email)
set @i=@i+1;
end

INSERT INTO SPORLAR(spor_adi,spor_zorluk)
VALUES ('DAYANIKLILIK ANTREMANLARI','ÝLERÝ SEVÝYE')
ALTER TABLE spor_katilim
ADD haftalik_katilim int;
declare @i int =1;
declare @Uyeid int;
declare @Sporid int;
declare @katilim int;
while @i <= 100000
begin
set @Uyeid = FLOOR (RAND()*100000)+1;
set @Sporid= FLOOR (RAND()*24)+1;
set @katilim=FLOOR (RAND()*7)+1
insert into spor_katilim (uye_id,spor_id,haftalik_katilim)
values (@Uyeid,@Sporid,@katilim)
set 
@i=@i+1;
end
select count(*) from UYELER

CREATE procedure dbo.sp_EnCokTercihEdilen
as
begin
SELECT top 5
s.spor_adi,
COUNT (sk.katilim_id) Toplam_Katýlýmcýlar
From spor_katilim sk
join 
SPORLAR s on sk.spor_id=s.spor_id
group by
s.spor_adi
order by 
Toplam_Katýlýmcýlar desc;
end
 EXEC dbo.sp_EnCokTercihEdilen
 
 create nonclustered index IX_SPOR 
 on SPORLAR (spor_adi)
 set statistics IO ON
 select * from SPORLAR WHERE spor_adi='YÜZME'
 CREATE NONCLUSTERED INDEX IX_ADSOYAD ON UYELER(uye_adi,uye_soyadi);

 CREATE VIEW vw_uyebilgi2
 as
 SELECT TOP 20
 u.uye_id,u.uye_adi,u.uye_soyadi,s.spor_adi
 from
 UYELER u 
 join 
 spor_katilim sk on u.uye_id=sk.uye_id
 join
 SPORLAR s on sk.spor_id =s.spor_id
 SELECT * FROM vw_uyebilgi2

 