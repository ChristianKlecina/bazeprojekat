create schema osk
go

if object_id('osk.osiguravajuca_kuca', 'U') is not null
	drop table osk.osiguravajuca_kuca

create table osk.osiguravajuca_kuca(
	id_ok int not null,
	naz_ok nvarchar(30) not null, 
	mesto_ok nvarchar(30) not null,
	ulica_ok nvarchar(30),
	broj_ok integer,
	id_pp int not null
	constraint PK_osiguravajuca_kuca_id_ok primary key (id_ok),
	constraint UQ_osiguravajuca_kuca_id_pp unique (id_pp),
	constraint CHK_osiguravajuca_kuca_id_ok check (id_ok > 0),
	constraint CHK_osiguravajuca_kuca_broj_ok check (broj_ok > 0),
	constraint CHK_osiguravajuca_kuca_id_pp check (id_pp > 0)
)


create sequence osk.id_ok_seq
start with 1
minvalue 1
increment by 1
cycle

if object_id('osk.filijala_agencije', 'U') is not null
	drop table osk.filijala_agencije

create table osk.filijala_agencije(
	id_ag int not null,
	naz_ag nvarchar(30) not null,
	mesto_ag nvarchar(30),
	ulica_ag nvarchar(20),
	broj_ag int,
	email_ag nvarchar(30),
	tel_ag nvarchar(15)

	constraint PK_filijala_agencije_id_ag primary key (id_ag),
	constraint CHK_filijala_agencije_id_ag check (id_ag > 0),
	constraint CHK_filijala_agencije_broj_ag check (broj_ag > 0),
	constraint CHK_filijala_agencije_tel_ag check (len(convert(int, tel_ag)) >= 6)
)


create sequence osk.id_ag_seq
start with 1
minvalue 1
increment by 1
cycle


if object_id('osk.saradjuje_sa', 'U') is not null
	drop table osk.saradjuje_sa

create table osk.saradjuje_sa(
	datum_s date not null default getdate(),
	id_ag int not null,
	id_ok int not null
	constraint PK_saradjuje_sa primary key(id_ag, id_ok),
	constraint CHK_saradjuje_sa_datum_s check (datum_s <= getdate()),
	constraint CHK_saradjuje_sa_id_ag check (id_ag > 0),
	constraint CHK_saradjuje_sa_id_ok check (id_ok > 0)
)

if object_id('osk.racun_agencije', 'U') is not null
	drop table osk.racun_agencije

create table osk.racun_agencije(
	vrsta_rac nvarchar(30) not null,
	br_rac nvarchar(18) not null,
	stanje_rac money not null,
	dat_rac date not null default getdate(),
	id_ag int not null,-- unique,
	id_b int not null,
	constraint PK_racun_agencije primary key (id_ag, br_rac),
	constraint CHK_racun_agencije_id_ag check (id_ag > 0),
	constraint CHK_racun_agencije_id_b check (id_b > 0),
	constraint CHK_racun_agencije_stanje_rac check (stanje_rac > 0),
	constraint CHK_racun_agencije_br_rac_length check (len(br_rac) = 18),
	constraint CHK_racun_agencije_dat_rac check (dat_rac <= getdate())
)



if object_id('osk.isplacuje_procenat', 'U') is not null
	drop table osk.isplacuje_procenat

create table osk.isplacuje_procenat(
	iznos_procenta int not null, 
	dat_isplate date not null default getdate(),
	id_ok int not null,
	id_ag int not null,
	br_rac nvarchar(18) not null
	constraint PK_isplacuje_procenat primary key (id_ok, id_ag, br_rac),
	constraint CHK_isplacuje_procenat_dat_isplate check (dat_isplate <= getdate()),
	constraint CHK_isplacuje_procenat_id_ag check (id_ag > 0),
	constraint CHK_isplacuje_procenat_id_ok check (id_ok > 0),
	constraint CHK_isplacuje_procenat_br_rac_length check (len(br_rac) = 18)
)


if object_id('osk.zaposleni', 'U') is not null
	drop table osk.zaposleni

create table osk.zaposleni(
	ime_zap nvarchar(25) not null,
	prz_zap nvarchar(30) not null,
	jmbg_zap numeric(13) not null,
	dat_rodj_zap date,
	mesto_zap nvarchar(30),
	ulica_zap nvarchar(30),
	broj_zap integer,
	nivo_kvalifikacije integer,
	dat_zaposlenja date,
	vrsta_radnog_odnosa nvarchar(11) not null,
	id_ag int not null
	constraint PK_zaposleni primary key (jmbg_zap),
	constraint CHK_zaposleni_jmbg_zap_length check (len(jmbg_zap) = 13),
	constraint CHK_zaposleni_nivo_kvalifikacije check (nivo_kvalifikacije between 1 and 8),
	constraint CHK_zaposleni_dat_zaposlenja check (dat_zaposlenja <= getdate()),
	constraint CHK_zaposleni_vrsta_radnog_odnosa check (vrsta_radnog_odnosa = 'odredjeno' or vrsta_radnog_odnosa = 'neodredjeno'),
	constraint UQ_zaposleni_jmbg_zap unique (jmbg_zap),
	constraint CHK_zaposleni_id_ag check (id_ag > 0)
)


if object_Id('osk.direktor', 'U')is not null
	drop table osk.direktor

create table osk.direktor(
	jmbg_zap numeric(13) not null
	constraint PK_direktor primary key (jmbg_zap)
	constraint CHK_direktor_jmbg_zap check (len(jmbg_zap) = 13),
	constraint UQ_direktor_jmbg_zap unique (jmbg_zap)
)


if object_Id('osk.poslovni_partner', 'U')is not null
	drop table osk.poslovni_partner

create table osk.poslovni_partner(
	id_pp int not null default (next value for osk.id_pp_seq),
	naziv_pp nvarchar(30) not null,
	tel_pp nvarchar(15) not null,
	mail_pp nvarchar(30) not null
	constraint PK_poslovni_partner primary key (id_pp),
	constraint CHK_poslovni_partner_id_pp check (id_pp > 0),
	constraint CHK_poslovni_partner_tel_pp check (len(convert(int, tel_pp)) >= 6)
)

create sequence osk.id_pp_seq
start with 1
minvalue 1
increment by 1
cycle

alter sequence osk.id_pp_seq
	restart with 1

if object_id('osk.sklapa_ugovor', 'U') is not null
	drop table osk.sklapa_ugovor

create table osk.sklapa_ugovor(
	datum_ug date not null,
	datum_prestanka_vaz date not null,
	vrsta_ug nvarchar(30) not null,
	jmbg_zap numeric(13) not null,
	id_pp int not null
	constraint PK_sklapa_ugovor primary key (jmbg_zap, id_pp),
	constraint CHK_sklapa_ugovor_jmbg_zap check (len(jmbg_zap) = 13),
	constraint CHK_sklapa_ugovor_datum_ug check (datum_ug <= getdate()),
	constraint CHK_sklapa_ugovor_datum_prestanka_vaz check (datum_prestanka_vaz > getdate())
)

if object_id('osk.banka', 'U') is not null
	drop table osk.banka

create table osk.banka(
	id_b int not null,
	ime_b nvarchar(20) not null,
	ulica_b nvarchar(30) not null,
	mesto_b nvarchar(30) not null,
	broj_b int not null,
	id_pp int not null 
	constraint PK_banka primary key (id_b),
	constraint UQ_banka_id_pp unique (id_pp),
	constraint CHK_banka_id_b check (id_b > 0),
	constraint CHK_banka_id_pp check (id_pp > 0)
)


create sequence osk.id_b_seq
start with 1
minvalue 1
increment by 1
cycle



--alter table racun agencije podskup od banke tu si stao


if object_id('osk.ponuda', 'U') is not null
	drop table osk.ponuda

create table osk.ponuda(
	
	id_pon int not null,
	iznos_pon money,
	suma_pon money,
	datum_pon date not null,
	id_ok int not null
	constraint PK_ponuda primary key (id_pon),
	constraint CHK_ponuda_id_pon check (id_pon > 0),
	constraint CHK_ponuda_id_ok check (id_ok > 0),
	constraint CHK_datum_pon check (datum_pon <= getdate())
)


alter table osk.ponuda
	add constraint DFT_ponuda_id_pon default next value for osk.id_pon_seq for id_pon

create sequence osk.id_pon_seq
start with 1
minvalue 1
increment by 1
cycle

drop sequence osk.id_pon_seq

if object_id('osk.id_pon_seq', 'SO')is not null
	print 'DA'

select * from sys.sequences




alter table osk.saradjuje_sa
	add constraint FK_saradjuje_sa_filijala_agencije foreign key (id_ag) references osk.filijala_agencije (id_ag)

alter table osk.saradjuje_sa
	add constraint FK_saradjuje_sa_osiguravajuca_kuca foreign key (id_ok) references osk.osiguravajuca_kuca (id_ok) 

/*
--NE RADI OVAJ CONSTRAINT
alter table osk.filijala_agencije
	add constraint FK_filijala_agencije_saradjuje_sa foreign key (id_ag) references osk.saradjuje_sa (id_ag) 
--MOŽDA MORAŠ BRISATI
alter table osk.filijala_agencije
	drop constraint FK_filijala_agencije_saradjuje_sa
--MORA UNIQUE DA BI MOGAO DA SE STAVI INVERZNI REF
alter table osk.saradjuje_sa
	add constraint UQ_saradjuje_sa_id_ag unique(id_ag)
*/


alter table osk.racun_agencije
	add constraint FK_racun_agencije_filijala_agencije foreign key (id_ag) references osk.filijala_agencije (id_ag)

/*
--NE RADI NI OVAJ
alter table osk.filijala_agencije
	add constraint FK_filijala_agencije_racun_agencije foreign key (id_ag) references osk.racun_agencije (id_ag)
--MOŽDA MORAŠ BRISATI
alter table osk.filijala_agencije
	drop constraint FK_filijala_agencije_racun_agencije
*/

alter table osk.isplacuje_procenat
	add constraint FK_isplacuje_procenat_racun_agencije foreign key (id_ag, br_rac) references osk.racun_agencije (id_ag, br_rac)

alter table osk.isplacuje_procenat
	add constraint FK_isplacuje_procenat_saradjuje_sa foreign key (id_ag, id_ok) references osk.saradjuje_sa (id_ag, id_ok)



alter table osk.zaposleni
	add constraint FK_zaposleni_filijala_agencije foreign key (id_ag) references osk.filijala_agencije (id_ag)

alter table osk.direktor
	add constraint FK_direktor_zaposleni foreign key (jmbg_zap) references osk.zaposleni (jmbg_zap)

/*
--nece raditi
alter table osk.zaposleni
	add constraint FK_zaposleni_direktor foreign key (jmbg_zap) references osk.direktor (jmbg_zap)

alter table osk.zaposleni
	drop constraint FK_zaposleni_direktor
*/

alter table osk.sklapa_ugovor
	add constraint FK_sklapa_ugovor_direktor foreign key (jmbg_zap) references osk.direktor (jmbg_zap)

alter table osk.sklapa_ugovor 
	add constraint FK_sklapa_ugovor_poslovni_partner foreign key (id_pp) references osk.poslovni_partner (id_pp)



alter table osk.banka
	add constraint FK_banka_poslovni_partner foreign key (id_pp) references osk.poslovni_partner (id_pp)




alter table osk.racun_agencije
	add constraint FK_racun_agencije_banka foreign key (id_b) references osk.banka (id_b)

alter table osk.osiguravajuca_kuca
	add constraint FK_osiguravajuca_kuca_poslovni_partner foreign key (id_pp) references osk.poslovni_partner (id_pp)




alter table osk.ponuda
	add constraint FK_ponuda_osiguravajuca_kuca foreign key (id_ok) references osk.osiguravajuca_kuca(id_ok)



select * from sys.tables


select * from sys.sequences



if object_id('osk.banka_tr', 'TR') is not null
	drop trigger osk.banka_tr

go
create trigger osk.banka_tr
	on osk.banka
	for insert,update
	as
	begin
		declare @pp as int = (select id_pp from inserted)
		declare @naziv as nvarchar(30) = (select naziv_pp from osk.poslovni_partner where id_pp = @pp)

		if(@naziv != 'Banka')
		begin
			RAISERROR('Poslovni partner nije odgovarajuæi.', 16,1)
			delete from osk.banka where id_pp = @pp
		end
	end
go

if object_id('osk.osiguravajuca_kuca_tr', 'TR') is not null
	drop trigger osk.osiguravajuca_kuca_tr

go
create trigger osk.osiguravajuca_kuca_tr
	on osk.osiguravajuca_kuca
	for insert,update
	as
	begin
		declare @pp as int = (select id_pp from inserted)
		declare @naziv as nvarchar(30) = (select naziv_pp from osk.poslovni_partner where id_pp = @pp)

		if(@naziv != 'Osiguravajuæa kuæa')
		begin
			RAISERROR('Poslovni partner nije odgovarajuæi.', 16,1)
			delete from osk.osiguravajuca_kuca where id_pp = @pp
		end
	end	
go


--PRVI TRIGER ispravi još u sluèaju da ne postoje id_ag i id_ok u saradjuje_sa
if object_id('osk.isplacuje_procenat_racun_agencije_datum_tr', 'TR') is not null
	drop trigger osk.isplacuje_procenat_racun_agencije_datum_tr

create trigger osk.isplacuje_procenat_racun_agencije_datum_tr
	on osk.isplacuje_procenat
	instead of insert,update
	as
	begin
		if update (dat_isplate)
		begin
			declare @datumD as date =(select dat_isplate from deleted)
			declare @datumI as date = (select dat_isplate from inserted)
			declare @ag as int = (select id_ag from inserted)
			declare @ok as int = (select id_ok from inserted)
			

			declare @procenat as int = (select iznos_procenta from inserted)
			declare @rac as nvarchar(18) = (select br_rac from inserted)

		

				if(@datumD is not null)
				begin
					if (@datumI > (select datum_s from osk.saradjuje_sa where id_ag = @ag and id_ok = @ok))
					begin
						update osk.isplacuje_procenat set dat_isplate = @datumI where id_ag = @ag and id_ok = @ok
					end
					else
						RAISERROR ('GREŠKA!Proverite datum i proverite da li agencija i osiguravajuæa kuæa saraðuju',16,1)
				end
				else
				begin
					if (@datumI > (select datum_s from osk.saradjuje_sa where id_ag = @ag and id_ok = @ok))
					begin
						insert osk.isplacuje_procenat values (@procenat, @datumI, @ok,@ag, @rac)
					end
					else
						RAISERROR ('GREŠKA!Proverite datum i proverite da li agencija i osiguravajuæa kuæa saraðuju',16,1)
				end
		end
	end

--TRIGER ZA DIREKTORA 
if object_id('osk.direktor_tr', 'TR') is not null
	drop trigger osk.direktor_tr

create trigger osk.direktor_tr
	on osk.direktor
	instead of update, insert
	as
	begin
		declare @jmbgD as nvarchar(13) = (select jmbg_zap from deleted)
		declare @jmbgI as nvarchar(13) = (select jmbg_zap from inserted)
		declare @vrsta as nvarchar(30) = (select vrsta_radnog_odnosa from osk.zaposleni where jmbg_zap = @jmbgI)
		declare @ag as int = (select id_ag from osk.zaposleni where jmbg_zap = @jmbgI)
		declare @nivo as int = (select nivo_kvalifikacije from osk.zaposleni where jmbg_zap = @jmbgI)

		declare @agD as int = (select id_ag from osk.zaposleni where jmbg_zap = @jmbgD)

		if update(jmbg_zap)
		begin
			if (@jmbgD is not null)
			begin
			print 'UPDATE'
				if(@ag not in (select id_ag from osk.direktor d inner join osk.zaposleni z on d.jmbg_zap=z.jmbg_zap))
				begin
					if(@jmbgI in (select jmbg_zap from osk.zaposleni) and @vrsta = 'neodredjeno' and @nivo = 8)
					begin
						update osk.direktor set jmbg_zap = @jmbgI where jmbg_zap = @jmbgD
					end
					else
					begin
						RAISERROR('Zaposleni ne zadovoljava uslove.',16,1)
					end
				end
				else
				begin
					RAISERROR('Direktor veæ postoji.', 16,1)
				end
			end
			else
			begin
				print 'INSERT'
				if(@ag not in (select id_ag from osk.direktor d inner join osk.zaposleni z on d.jmbg_zap=z.jmbg_zap))
				begin
					if(@jmbgI in (select jmbg_zap from osk.zaposleni) and @vrsta = 'neodredjeno' and @nivo = 8)
					begin
						insert osk.direktor values (@jmbgI)
					end
					else
					begin
						RAISERROR('Zaposleni ne zadovoljava uslove.',16,1)
					end
				end
				else
				begin
					RAISERROR('Direktor veæ postoji.', 16,1)
				end
			end
		end
	end

select * from osk.zaposleni where jmbg_zap in (select Jmbg_zap from osk.direktor) and id_ag = 7
select jmbg_zap from osk.direktor where jmbg_zap in (select jmbg_zap from osk.zaposleni where id_ag = 7 and jmbg_zap != '4885485420552')
select jmbg_zap from osk.direktor where jmbg_zap in (select jmbg_zap from osk.zaposleni where id_ag = 7)
select nivo_kvalifikacije from osk.zaposleni where jmbg_zap = '1478954698532'



--triger sklapa ugovor
if object_id('osk.sklapa_ugovor_tr', 'TR') is not null
	drop trigger osk.sklapa_ugovor_tr

create trigger osk.sklapa_ugovor_tr
	on osk.sklapa_ugovor
	instead of insert,update
	as
	begin
		declare @jmbg as nvarchar(13)= (select jmbg_zap from inserted)
		declare @date as date = (select dat_zaposlenja from osk.zaposleni where jmbg_zap = @jmbg)
		declare @datumugovora as date = (select datum_ug from inserted)
		declare @pp as int = (select id_pp from inserted)
		declare @ag as int = (select id_ag from osk.zaposleni where jmbg_zap = @jmbg)
		declare @datum_saradjuje as date = (select datum_s from osk.saradjuje_sa s inner join osk.osiguravajuca_kuca ok on s.id_ok = ok.id_ok inner join osk.poslovni_partner p on p.id_pp=ok.id_pp where p.id_pp = @pp and id_ag = @ag)
		declare @datpvaz as date = (select datum_prestanka_vaz from inserted)
		declare @vrug as nvarchar(30) = (select vrsta_ug from inserted)

		--check datum isplate procenta mora biti kasniji od datuma sklapanja ugovora
		if @pp in (select id_pp from osk.banka)
		begin
			insert into osk.sklapa_ugovor values (@datumugovora, @datpvaz, @vrug, @jmbg,@pp) 
		end
		else
		begin
			if (update(datum_ug) and ((select count(*) from deleted) > 0))
			begin
				RAISERROR ('SAMO IZ SARADJUJE_SA',16,1)
			end
			else 
			begin
				if(@date < @datumugovora)
				begin
					if (@datum_saradjuje = @datumugovora and @pp in (select id_pp from osk.poslovni_partner where naziv_pp = 'Osiguravajuæa kuæa'))
						insert into osk.sklapa_ugovor values (@datumugovora, @datpvaz, @vrug, @jmbg,@pp) 
					else
					begin
						RAISERROR('Saradnja nije poèela tog datuma',16,1)
					end
				end
				else
				begin
					RAISERROR('Ne može se postaviti datum ugovora ako direktor tada nije radio',16,1)
				end
			end
		end
	end

select id_pp from osk.poslovni_partner where naziv_pp = 'Osiguravajuæa kuæa'

select * from osk.sklapa_ugovor

--provera update
update osk.sklapa_ugovor set datum_ug = '01-01-2021' where jmbg_zap = '1478541111235' and id_pp = 7

--provera inserta
select * from osk.saradjuje_sa --id_ag = 3 id_ok = 2 2017-03-02
select * from osk.osiguravajuca_kuca where id_ok = 2 --id_pp = 7
select * from osk.zaposleni where id_ag = 3 --uzimamo direktorov jmbg 4882145420552
select * from osk.sklapa_ugovor
insert into osk.sklapa_ugovor values ('01-01-1999', '01-01-2022', 'Ugovor OSK', '4882145420552', 7)
--saradnja se ne gaða
insert into osk.sklapa_ugovor values ('01-01-2006', '01-01-2022', 'Ugovor OSK', '4882145420552', 7)
--prolazi
insert into osk.sklapa_ugovor values ('2017-03-02', '01-01-2022', 'Ugovor OSK', '4882145420552', 7)
--banka
select * from osk.banka
insert into osk.sklapa_ugovor values ('2017-03-02', '01-01-2022', 'Ugovor OSK', '4882145420552', 1)




select datum_s,p.id_pp,id_ag from osk.saradjuje_sa s inner join osk.osiguravajuca_kuca ok on s.id_ok = ok.id_ok inner join osk.poslovni_partner p on p.id_pp=ok.id_pp where p.id_pp = 6 and id_ag = 2

--UNOS VREDNOSTI

--banke
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 225883, 'banka1@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 363288, 'banka2@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 255323, 'banka3@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 552832, 'banka4@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 111789, 'banka5@gmail.com')
--uneti posle za proveru ogr sa osiguravajucom kucom
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 111784, 'banka6@gmail.com')

select * from osk.poslovni_partner

alter sequence osk.id_pp_seq
	restart with 1

delete from osk.poslovni_partner



--osiguravajuæe kuæe
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 556596, 'OSK1@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 456781, 'OSK2@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 555111, 'OSK3@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 898653, 'OSK4@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 124876, 'OSK5@gmail.com')

--uneti posle za proveru ogranicenja sa bankom
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 224876, 'OSK6@gmail.com')

select * from osk.poslovni_partner

delete from osk.poslovni_partner


--banka
insert osk.banka values (1, 'Intesa','Gogoljeva', 'Novi Sad', 12, 1)
insert osk.banka values (2, 'Raiffeisen','Zmaj Jovina', 'Novi Sad', 2, 2)
insert osk.banka values (3, 'Narodna Štedionica','Miše Dimitrijeviæa', 'Novi Sad', 25, 3)
insert osk.banka values (4, 'Telenor Banka', 'Futoška', 'Novi Sad', 4,4)
insert osk.banka values (5, 'Narodna Banka Srbije', 'Knez Mihailova', 'Beograd', 20,5)

--PROVERA OGRANICENJA
insert osk.banka values (7, 'Poštanska Štedionica', 'Vojvodjanska', 'Inðija', 24, 12)
insert osk.banka values (6, 'Poštanska Štedionica', 'Vojvodjanska', 'Inðija', 24, 11)

delete from osk.banka


select * from osk.banka

--osiguravajuæa kuæa
insert osk.osiguravajuca_kuca values (1, 'Delta Generali', 'Inðija', 'Novosadska' ,110,6)
insert osk.osiguravajuca_kuca values (2, 'Dunav', 'Beograd', 'Ustanièka' ,52,7)
insert osk.osiguravajuca_kuca values (3, 'Grawe', 'Novi Sad', 'Bulevar Osloboðenja', 60,8)
insert osk.osiguravajuca_kuca values (4, 'Merkur', 'Novi Sad', 'Bulevar Osloboðenja', 30,9)
insert osk.osiguravajuca_kuca values (5, 'OTP', 'Beograd', 'Ruzveltova', 32,10)

--provera ogranicenja sa poslovnim partnerom gde je banka poslovni partner
insert osk.osiguravajuca_kuca values (6, 'DDOR', 'Novi Sad', 'Bulevar Mihaila Pupina', 8,12)

select * from osk.osiguravajuca_kuca

--filijala agencije

insert osk.filijala_agencije values (1,'Perspektiva','Indjija','Jug Bogdana',25,'perspektiva@gmail.com',552702)
insert osk.filijala_agencije values (2,'Domestica','Kragujevac','Sindjeliceva',50,'domestica@gmail.com',365235)
insert osk.filijala_agencije values (3,'Fobia','Kruševac','Šumadinska',48,'fobia@gmail.com',233223)
insert osk.filijala_agencije values (4,'Declare','Indjija','Vojvodjanska',25,'declare@gmail.com',555999)
insert osk.filijala_agencije values (5,'Darija','Novi Sad','Dimitrija Avramovica',55,'darija@gmail.com',484715)
insert osk.filijala_agencije values (6,'Dekom','Novi Sad','Lole Ribara',2,'dekom@gmail.com',445696)
insert osk.filijala_agencije values (7,'HealthIN','Novi Sad','Gospiæka',70,'healthin@gmail.com',444759)
insert osk.filijala_agencije values (8,'Pobeda','Novi Sad','Valentina Vodnika',67,'pobeda@gmail.com',442569)
insert osk.filijala_agencije values (9,'Ekspres','Novi Sad','Jug Bogdana',14,'ekspres@gmail.com',478523)
insert osk.filijala_agencije values (10,'Lifeline','Trstenik','Svetog Save',11,'lifeline@gmail.com',148632)

select * from osk.filijala_agencije
select * from osk.osiguravajuca_kuca


--saradjuje sa inserti
insert osk.saradjuje_sa values ('12-12-2020',1,1)
insert osk.saradjuje_sa values ('06-06-2020',2,2)
insert osk.saradjuje_sa values ('05-07-2017',2,1)
insert osk.saradjuje_sa values ('01-02-2016',1,5)
insert osk.saradjuje_sa values ('03-07-2018',3,3)
insert osk.saradjuje_sa values ('12-23-2019',5,5)
insert osk.saradjuje_sa values ('12-12-2013',4,3)
insert osk.saradjuje_sa values ('11-23-2014',4,1)
insert osk.saradjuje_sa values ('03-02-2017',3,2)
insert osk.saradjuje_sa values ('05-05-2021',5,2)
insert osk.saradjuje_sa values ('05-21-2020',6,6)

--provere ogranicenja



insert osk.saradjuje_sa values ('',4,4)
insert osk.saradjuje_sa values ('',3,1)


--racun agencije
insert osk.racun_agencije values ('Žiro', '123456789123456789', '10', '12-12-2020', 1,1)
insert osk.racun_agencije values ('Žiro', '123456789123456780', '10', '12-12-2020', 2,2)
insert osk.racun_agencije values ('Žiro', '547895684128210586', '1253', '02-01-2021', 3,3)
insert osk.racun_agencije values ('Žiro', '218131841842642864', '50000', '01-06-2017', 1,3)
insert osk.racun_agencije values ('Žiro', '258465186424846824', '25368', '07-02-2017', 4,3)

insert osk.racun_agencije values ('Žiro', '184864224862482486', '1235', '07-02-2017', 5,2)
insert osk.racun_agencije values ('Žiro', '147412682860826222', '30002', '11-25-2017', 6,3)
insert osk.racun_agencije values ('Žiro', '339285464140486168', '25368', '12-06-2016', 7,5)
insert osk.racun_agencije values ('Žiro', '017814698582608206', '82406', '08-17-2020', 8,4)
insert osk.racun_agencije values ('Žiro', '078462388925608618', '1758', '01-08-2019', 9,2)

insert osk.racun_agencije values ('Žiro', '841864242864682428', '2000', '11-08-2020', 10,1)

select * from osk.racun_agencije

--isplaæuje procenat unosi

insert osk.isplacuje_procenat values (5, '12-20-2020', 1,1, '123456789123456789')
insert osk.isplacuje_procenat values (10, '11-12-2017', 5,1, '123456789123456789')
insert osk.isplacuje_procenat values (11, '12-23-2020', 1,1, '218131841842642864')
insert osk.isplacuje_procenat values (3, '12-25-2020', 5,1, '218131841842642864')
insert osk.isplacuje_procenat values (7, '04-05-2021',1,2, '123456789123456780')
insert osk.isplacuje_procenat values (3, '2021-05-06',2,5, '184864224862482486')
insert osk.isplacuje_procenat values (25, '2021-05-20', 2,6, '147412682860826222')
insert osk.isplacuje_procenat values (17, '2015-11-23', 1,4, '258465186424846824')
insert osk.isplacuje_procenat values (23, '2018-11-23', 3,4, '258465186424846824')
insert osk.isplacuje_procenat values (4, '2020-07-17', 5,5, '184864224862482486')



--provera
--proalzi
select * from osk.isplacuje_procenat where br_rac = '184864224862482486'
update osk.isplacuje_procenat set dat_isplate = '05-19-2021' where br_rac = '184864224862482486' and id_ok = 2 and id_ag = 5
--datum alter koji ne sme da proðe
select * from osk.saradjuje_sa --datum je 05 05 2021
update osk.isplacuje_procenat set dat_isplate = '05-19-2020' where br_rac = '184864224862482486' and id_ok = 2 and id_ag = 5
--update gde ne postoje id_ok i id_ag
update osk.isplacuje_procenat set dat_isplate = '05-19-2020' where br_rac = '184864224862482486' and id_ok = 4 and id_ag = 4

--insert gde je datum ne važeæi, ne sme proæi
insert osk.saradjuje_sa values ('04-04-2014',4,4)
insert osk.isplacuje_procenat values (30, '2012-11-17', 4,4, '258465186424846824')


select * from osk.saradjuje_sa --ne prolazi zato što id_ok i id_ag nisu u saraðuje sa
insert osk.isplacuje_procenat values (1, '2020-11-17', 6,6, '147412682860826222')
insert osk.isplacuje_procenat values (30, '2020-11-17', 3,5, '184864224862482486')


select * from osk.isplacuje_procenat

select * from osk.racun_agencije ra inner join osk.saradjuje_sa ss on ra.id_ag = ss.id_ag

select * from osk.saradjuje_sa


--unos ZAPOSLENI

insert osk.zaposleni values ('Zoran', 'Milosavljeviæ', '1234567891234', '12-12-1978', 'Novi Sad', 'Miše Dimitrijeviæa',22 , 3, '07-06-1999','odredjeno', 1)
insert osk.zaposleni values ('Milan', 'Petrovic', '1547896542385', '01-25-1971', 'Novi Sad', 'Gogoljeva',30 , 6, '01-06-2001','odredjeno', 2)
insert osk.zaposleni values ('Petar', 'Sabov', '1478954698532', '08-12-81', 'Beograd', 'Sedmog Jula',25 , 3, '07-01-2005','neodredjeno', 3)
insert osk.zaposleni values ('Dragan', 'Stevanoviæ', '9525801020262', '04-04-1985', 'Novi Sad', 'Trstenèka',64 , 1, '11-11-2010','odredjeno', 4)
insert osk.zaposleni values ('Vojislav', 'Kušiæ', '3525234020262', '04-25-1970', 'Novi Sad', 'Trebinjska',34 , 7, '03-15-1990','odredjeno', 5)
insert osk.zaposleni values ('Vladan', 'Vladisavljeviæ', '2777511657144', '02-03-1990', 'Novi Sad', 'Beogradska',23 , 8, '03-06-2015','neodredjeno', 6)
insert osk.zaposleni values ('Slobodan', 'Vasiæ', '9041978275100', '08-09-1975', 'Novi Sad', 'Dolinska',87 , 4, '07-26-1997','odredjeno', 7)
insert osk.zaposleni values ('Luka', 'Milosavljeviæ', '7411624687339', '10-10-1980', 'Novi Sad', 'Prištinska',52 , 6, '02-11-2003','odredjeno', 8)
insert osk.zaposleni values ('Zoran', 'Ležajiæ', '9069445101944', '1977-02-14', 'Novi Sad', 'Prizrenska',97 , 2, '05-06-1999','odredjeno', 9)
insert osk.zaposleni values ('Mirko', 'Budimir', '3883203843618', '1987-02-12', 'Novi Sad', 'Ratarska',2 , 3, '11-06-2007','odredjeno', 10)
insert osk.zaposleni values ('Trajko', 'Bogdanoviæ', '5860248726732', '1988-03-30', 'Novi Sad', 'Ritska',43 , 2, '03-14-2013','odredjeno', 4)
insert osk.zaposleni values ('Dragomir', 'Ackoviæ', '1764674734242', '1972-04-15', 'Novi Sad', 'Sokolska',85 , 7, '12-06-1990','odredjeno', 5)
insert osk.zaposleni values ('Nikola', 'Tuniæ', '4885875420552', '1978-10-26', 'Novi Sad', 'Solunska',11 , 8, '07-30-1994','neodredjeno', 7)
insert osk.zaposleni values ('Ilija', 'Stankoviæ', '4682567434187', '07-22-1973', 'Novi Sad', 'Miše Dimitrijeviæa',85 , 8, '01-31-1995','odredjeno', 2)
insert osk.zaposleni values ('Ivan', 'Petkoviæ', '4885485420552', '1971-11-17', 'Novi Sad', 'Dunavska',26 , 8, '03-29-1992','neodredjeno', 7)
insert osk.zaposleni values ('Dražen', 'Petroviæ', '4882145420552', '1980-10-22', 'Inðija', 'Novosadska',57 , 8, '06-01-2003','neodredjeno', 3)

--direktori nakdnadno
insert osk.zaposleni values ('Petar', 'Cvetkoviæ', '1478541201235', '12-25-1969', 'Inðija', 'Karaðorðeva',60 , 8, '07-06-1999','neodredjeno', 1)
insert osk.zaposleni values ('Goran', 'Stevanoviæ', '1478541111235', '03-08-1965', 'Inðija', 'Dunvaska',02 , 8, '01-02-2000','neodredjeno', 2)
insert osk.zaposleni values ('Milun', 'Aresnoviæ', '5855548726732', '08-09-1974', 'Inðija', 'Njegoševa',100 , 8, '10-02-2010','neodredjeno', 4)
insert osk.zaposleni values ('Milivoje', 'Draganoviæ', '5855548726658', '10-10-1970', 'Inðija', 'Zmaj Jovina',55 , 8, '02-02-2008','neodredjeno', 5)
insert osk.zaposleni values ('Dragutin', 'Pašaliæ', '5855501526658', '01-02-1975', 'Inðija', 'Miletiæeva',25 , 8, '02-02-2000','neodredjeno', 6)
insert osk.zaposleni values ('Miladin', 'Saviæ', '5855511526658', '09-02-1971', 'Inðija', 'Vojvoðanska',38 , 8, '10-02-2006','neodredjeno', 8)
insert osk.zaposleni values ('Živadin', 'Petriæ', '5855561526658', '01-05-1975', 'Inðija', 'Omladinska',05 , 8, '02-25-1999','neodredjeno', 9)
insert osk.zaposleni values ('Dragoljub', 'Ðurièiæ', '5855561529058', '11-05-1969', 'Inðija', 'Vladimira Roloviæa',50 , 8, '02-25-1990','neodredjeno', 10)


select * from osk.zaposleni
order by id_ag

select * from osk.direktor d inner join osk.zaposleni z on d.jmbg_zap = z.jmbg_zap
order by id_ag


--insert direktor PROMENI IME OBELEZJA direktora u jmbg_dir


insert osk.direktor values ('2777511657144')


--direktori naknadno
insert osk.direktor values ('1478541201235')
insert osk.direktor values ('1478541111235')
insert osk.direktor values ('4882145420552')
insert osk.direktor values ('5855548726732')
insert osk.direktor values ('5855548726658')
insert osk.direktor values ('5855501526658')
insert osk.direktor values ('5855511526658')
insert osk.direktor values ('5855561526658')
insert osk.direktor values ('5855561529058')
insert osk.direktor values ('4885875420552') --Nikola Tuniæ

--provera da li upada u klasu, prvo proveriti ovo zato što ako direktor postoji ne može se update raditi zato što mesto mora 
--biti upraznjeno
insert osk.direktor values ('1764674734242')

--provera inserta isto id_ag = 7
insert osk.direktor values ('4885485420552') --Ivan Petkoviæ


delete from osk.direktor

--provera
update osk.direktor set jmbg_zap = '4885485420552' where jmbg_zap = '4885875420552'




--insert sklapa ugovor

insert osk.sklapa_ugovor values ('12-12-2020', '12-12-2024', 'Ugovor_banka', '4885875420552', 1)
insert osk.sklapa_ugovor values ('2017-05-07', '03-06-2026', 'Ugovor_osk', '1478541111235', 6)
insert osk.sklapa_ugovor values ('2020-06-06', '01-01-2022', 'Ugovor_osk', '1478541111235', 7)
insert osk.sklapa_ugovor values ('2016-01-02', '01-07-2025', 'Ugovor_osk', '1478541201235', 7)
insert osk.sklapa_ugovor values ('2020-06-06', '01-01-2024', 'ugovor_banka', '4882145420552', 2)
insert osk.sklapa_ugovor values ('2018-03-07', '03-07-2022', 'ugovor_osk', '4882145420552', 8)
insert osk.sklapa_ugovor values ('2014-03-02', '03-07-2032', 'ugovor_banka', '5855548726732', 3)
insert osk.sklapa_ugovor values ('2010-11-02', '09-02-2025', 'ugovor_banka', '5855548726658', 4)


--za proveru procedure
insert osk.sklapa_ugovor values ('2014-04-04', '09-02-2025', 'ugovor_banka', '5855548726732', 9)


--provera datum sklapanja mora biti kasniji od datuma ugovora insert
insert osk.sklapa_ugovor values ('01-01-1955', '01-01-2022', 'ugovor3', '5855548726732', 1)
--provera update-a
update osk.sklapa_ugovor set datum_ug = '01-01-2000' where id_pp = 6 and jmbg_zap = '1478541111235'

select * from osk.sklapa_ugovor 

delete from osk.sklapa_ugovor

select * from osk.zaposleni where jmbg_zap= '2777511657144'


select * from osk.saradjuje_sa s inner join osk.filijala_agencije fa on s.id_ag=fa.id_ag inner join osk.osiguravajuca_kuca ok on s.id_ok=ok.id_ok
where s.id_ag = 3


select * from osk.zaposleni
where jmbg_zap in (select jmbg_zap from osk.direktor)
order by id_ag

--unos ponuda

insert osk.ponuda values ((next value for osk.id_pon_seq), 12500, 50000, '12-12-2020', 1)
insert osk.ponuda values ((next value for osk.id_pon_seq), 5000, 10000, '05-12-2017', 2)
insert osk.ponuda values ((next value for osk.id_pon_seq), 50000, 10000000, '11-02-2015', 3)
insert osk.ponuda values ((next value for osk.id_pon_seq), 23500, 200000000, '11-11-2016', 3)
insert osk.ponuda values ((next value for osk.id_pon_seq), 1000, 45000, '11-11-2010', 4)
insert osk.ponuda values ((next value for osk.id_pon_seq), 1500, 80000, '12-01-2010', 2)
insert osk.ponuda values ((next value for osk.id_pon_seq), 6700, 100000, '12-07-2015', 5)
insert osk.ponuda values ((next value for osk.id_pon_seq), 4500, 55800, '12-12-2015', 1)
insert osk.ponuda values ((next value for osk.id_pon_seq), 500, 15000, '01-05-2009', 4)
insert osk.ponuda values ((next value for osk.id_pon_seq), 10000, 200000, '12-12-2018', 2)
insert osk.ponuda values ((next value for osk.id_pon_seq), 12500, 356800, '12-12-2017', 2)



select * from osk.ponuda



--FUNKCIJE

--Funkcija 1 Napisati za taèan jmbg zaposlenog koliko dugo godina meseci i dana radi.

if object_id('osk.funkcija1', 'TF')is not null
	drop function osk.funkcija1

CREATE FUNCTION osk.funkcija1
(
    @jmbg as nvarchar(13)
)
RETURNS @returntable TABLE 
(
	godine int,
	meseci int,
	dani int
)
AS
BEGIN
    INSERT @returntable
    select year(getdate())-year(dat_zaposlenja), iif(month(getdate())-month(dat_zaposlenja)< 0, -(month(getdate())-month(dat_zaposlenja)), month(getdate())-month(dat_zaposlenja) ), day(getdate())-day(dat_zaposlenja) 
	from osk.zaposleni where jmbg_zap = @jmbg
    RETURN 
END

--provera
select * from osk.funkcija1('1234567891234')


--Funkcija 2 Napisati funkciju koja æe vratiti najstarijeg direktora koji je sklopio ugovor sa odreðenom osiguravajuæom kuæom

if object_id('osk.funkcija2', 'IF')is not null
	drop function osk.funkcija2


CREATE FUNCTION osk.funkcija2
(
    @ok as int
)
RETURNS TABLE AS RETURN
(
    select  top 1 ime_zap, prz_zap,  dat_rodj_zap 
	from osk.zaposleni z inner join osk.direktor d on z.jmbg_zap = d.jmbg_zap inner join osk.sklapa_ugovor su on d.jmbg_zap = su.jmbg_zap 
	inner join osk.osiguravajuca_kuca ok on su.id_pp = ok.id_pp where id_ok = @ok 
	order by dat_rodj_zap asc
)

select * from osk.funkcija2(3)

--Procedure

--procedura 1 Za brisanje iz saradjuje sa, briše se i iz tabele sklapa ugovor po datumu i iz tabele isplacuje procenat. 
--Briše se cela jedna saradnja
if object_id ('osk.proc1', 'P') is not null
	drop proc osk.proc1

create proc osk.proc1
@id_ag as int,
@id_ok as int
as
begin
	declare @pp as int
	declare @datum as date

	set @pp = (select ok.id_pp from osk.osiguravajuca_kuca ok inner join osk.poslovni_partner pp on ok.id_pp = pp.id_pp
	where id_ok = @id_ok)

	set @datum=
	(select datum_s from osk.saradjuje_sa sa inner join osk.sklapa_ugovor su on sa.datum_s = su.datum_ug
	where id_ag= @id_ag and id_pp = @pp)

	delete from isplacuje_procenat where id_ag = @id_ag and id_ok = @id_ok
	delete from osk.saradjuje_sa where id_ag = @id_ag and id_ok = @id_ok
	delete from sklapa_ugovor where id_pp = @pp and datum_ug = @datum
	
end

exec osk.proc1 4,4



--procedura 2
--ispisati sve zaposlene iz jedne agencije, ko je direktor i sve ugovore te agencije
if object_id('osk.proc2', 'P')is not null
	drop proc osk.proc2

create proc osk.proc2
	@ag as int 
	as
	begin
		declare @naziv as nvarchar(30) = (select naz_ag from osk.filijala_agencije where id_ag = @ag)
		print 'U agenciji ' + @naziv +' su zaposleni:' 
		declare @ime_zap as nvarchar(30)
		declare @prz_zap as nvarchar(30)
		declare crsr cursor for
		select ime_zap, prz_zap from osk.zaposleni where id_ag = @ag
		open crsr
			fetch next from crsr into @ime_zap, @prz_zap
			while @@fetch_status = 0
			begin
				print @ime_zap + ' ' + @prz_zap
				fetch next from crsr into @ime_zap, @prz_zap
			end
		close crsr
		deallocate crsr
		declare @imeprz as nvarchar(100) = (select ime_zap + ' ' +prz_zap 
											from osk.zaposleni z inner join osk.direktor d on z.jmbg_zap=d.jmbg_zap
											where id_ag = @ag)
		declare @jmbgdir as nvarchar(13) = (select d.jmbg_zap 
											from osk.zaposleni z inner join osk.direktor d on z.jmbg_zap=d.jmbg_zap
											where id_ag = @ag)
		print 'Direktor agejcije ' + @naziv + ' je ' + @imeprz
		print 'Agencija ' +@naziv + ' ima sklopljene ugovore sa osiguravajuæim kuæama: '
		declare @ok as nvarchar(30)
		declare crsr2 cursor for
		select naz_ok 
		from osk.osiguravajuca_kuca ok inner join osk.sklapa_ugovor su on ok.id_pp = su.id_pp
		where jmbg_zap = @jmbgdir
		open crsr2
			fetch next from crsr2 into @ok
			while @@fetch_status = 0
			begin
				print @ok
				fetch next from crsr2 into @ok
			end
		close crsr2
		deallocate crsr2
	end

exec osk.proc2 1


--upiti
--1
--izlistati sve zaposlene koji su rodjeni u novom sadu i koji su rodjeni posle 01/01/1980 i koji rade i agenciji koja nije u NS
select ime_zap,prz_zap,mesto_zap,z.id_ag,mesto_ag from osk.zaposleni z inner join osk.filijala_agencije fa on z.id_ag = fa.id_ag
where dat_rodj_zap > '1980-01-01' and mesto_zap = 'Novi Sad'
group by mesto_zap, z.id_ag,mesto_ag,ime_zap,prz_zap
having mesto_ag != 'Novi Sad'

--2
--izlistati sve osiguravajuce kuce sa kojima je odreðena filijala sklopila ugovor zajedno sa njihovim mestima, ulicama i brojevima
select naz_ok,mesto_ok, ulica_ok, broj_ok from osk.osiguravajuca_kuca ok inner join osk.saradjuje_sa sa on ok.id_ok = sa.id_ok
where sa.id_ag in (select z.id_ag from osk.zaposleni z inner join osk.filijala_agencije fa on z.id_ag = fa.id_ag where naz_ag = 'Darija')



--3
--za svaku osk izlistati najmanji procenat koji plaæa kojoj agenciji 
select ip.id_ok, fa.id_ag, naz_ag,iznos_procenta from osk.isplacuje_procenat ip inner join osk.filijala_agencije fa on ip.id_ag = fa.id_ag
inner join (select min(iznos_procenta) iznos,id_ok from osk.isplacuje_procenat group by id_ok) as ag 
on ag.id_ok = ip.id_ok
where ip.iznos_procenta = ag.iznos

--4 izlistati sve zaposlene iz agencija koje saradjuju sa grawe osiguranjem

select ime_zap, prz_zap,naz_ag 
from osk.zaposleni z left join osk.filijala_agencije fa on z.id_ag = fa.id_ag
inner join (select ok.naz_ok ok,id_ag from osk.osiguravajuca_kuca ok inner join osk.saradjuje_sa sa on ok.id_ok = sa.id_ok) osk
on osk.id_ag = z.id_ag
where osk.ok = 'Grawe'
order by ime_zap asc



--5 
--izlistati sve agencije koje saradjuju sa osiguravajuæom kuæom èija je najmanja suma osiguranja veæa od 20000
select  fa.id_ag,naz_ag 
from osk.filijala_agencije fa inner join osk.saradjuje_sa ss on fa.id_ag = ss.id_ag
inner join (select min(suma_pon) suma,id_ok from osk.ponuda group by id_ok) najmanji
on najmanji.id_ok = ss.id_ok
where najmanji.suma > 20000


select * from osk.poslovni_partner

select * from osk.zaposleni

select * from osk.banka

select * from osk.filijala_agencije

select * from osk.saradjuje_sa

select * from osk.osiguravajuca_kuca

select * from osk.sklapa_ugovor

select * from osk.ponuda

select * from osk.isplacuje_procenat

select * from osk.racun_agencije

select * from osk.direktor

