
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

create table osk.saradjuje_sa(
	datum_s date not null default getdate(),
	id_ag int not null,
	id_ok int not null
	constraint PK_saradjuje_sa primary key(id_ag, id_ok),
	constraint CHK_saradjuje_sa_datum_s check (datum_s <= getdate()),
	constraint CHK_saradjuje_sa_id_ag check (id_ag > 0),
	constraint CHK_saradjuje_sa_id_ok check (id_ok > 0)
)

create table osk.racun_agencije(
	vrsta_rac nvarchar(30) not null,
	br_rac nvarchar(18) not null,
	stanje_rac money not null,
	dat_rac date not null default getdate(),
	id_ag int not null,
	id_b int not null,
	constraint PK_racun_agencije primary key (id_ag, br_rac),
	constraint CHK_racun_agencije_id_ag check (id_ag > 0),
	constraint CHK_racun_agencije_id_b check (id_b > 0),
	constraint CHK_racun_agencije_stanje_rac check (stanje_rac > 0),
	constraint CHK_racun_agencije_br_rac_length check (len(br_rac) = 18),
	constraint CHK_racun_agencije_dat_rac check (dat_rac <= getdate())
)

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

create table osk.direktor(
	jmbg_zap numeric(13) not null
	constraint PK_direktor primary key (jmbg_zap)
	constraint CHK_direktor_jmbg_zap check (len(jmbg_zap) = 13),
	constraint UQ_direktor_jmbg_zap unique (jmbg_zap)
)

create table osk.poslovni_partner(
	id_pp int not null default (next value for osk.id_pp_seq),
	naziv_pp nvarchar(30) not null,
	tel_pp nvarchar(15) not null,
	mail_pp nvarchar(30) not null
	constraint PK_poslovni_partner primary key (id_pp),
	constraint CHK_poslovni_partner_id_pp check (id_pp > 0),
	constraint CHK_poslovni_partner_tel_pp check (len(convert(int, tel_pp)) >= 6)
)


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


create table osk.ponuda(
	
	id_pon int not null,
	iznos_pon money not null,
	suma_pon money not null,
	datum_pon date not null,
	id_ok int not null
	constraint PK_ponuda primary key (id_pon),
	constraint CHK_ponuda_id_pon check (id_pon > 0),
	constraint CHK_ponuda_id_ok check (id_ok > 0),
	constraint CHK_datum_pon check (datum_pon <= getdate())
)



alter table osk.ponuda
	add constraint DFT_ponuda_id_pon default next value for osk.id_pon_seq for id_pon


alter table osk.saradjuje_sa
	add constraint FK_saradjuje_sa_filijala_agencije foreign key (id_ag) references osk.filijala_agencije (id_ag)

alter table osk.saradjuje_sa
	add constraint FK_saradjuje_sa_osiguravajuca_kuca foreign key (id_ok) references osk.osiguravajuca_kuca (id_ok) 


alter table osk.racun_agencije
	add constraint FK_racun_agencije_filijala_agencije foreign key (id_ag) references osk.filijala_agencije (id_ag)


alter table osk.isplacuje_procenat
	add constraint FK_isplacuje_procenat_racun_agencije foreign key (id_ag, br_rac) references osk.racun_agencije (id_ag, br_rac)

alter table osk.isplacuje_procenat
	add constraint FK_isplacuje_procenat_saradjuje_sa foreign key (id_ag, id_ok) references osk.saradjuje_sa (id_ag, id_ok)


alter table osk.zaposleni
	add constraint FK_zaposleni_filijala_agencije foreign key (id_ag) references osk.filijala_agencije (id_ag)

alter table osk.direktor
	add constraint FK_direktor_zaposleni foreign key (jmbg_zap) references osk.zaposleni (jmbg_zap)


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
