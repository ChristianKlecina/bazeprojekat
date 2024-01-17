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

--uneti posle za proveru ogr sa osiguravajucom kucom
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 111784, 'banka6@gmail.com')
--uneti posle za proveru ogranicenja sa bankom
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 224876, 'OSK6@gmail.com')

--PROVERA OGRANICENJA
insert osk.banka values (7, 'Poštanska Štedionica', 'Vojvodjanska', 'Inðija', 24, 12)
insert osk.banka values (6, 'Poštanska Štedionica', 'Vojvodjanska', 'Inðija', 24, 11)

--provera ogranicenja sa poslovnim partnerom gde je banka poslovni partner
insert osk.osiguravajuca_kuca values (6, 'DDOR', 'Novi Sad', 'Bulevar Mihaila Pupina', 8,12)


--PRVI TRIGER 
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

--provera da li upada u klasu, prvo proveriti ovo zato što ako direktor postoji ne može se update raditi zato što mesto mora 
--biti upraznjeno
insert osk.direktor values ('1764674734242')

--provera inserta isto id_ag = 7
insert osk.direktor values ('4885485420552') --Ivan Petkoviæ


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

--provera datum sklapanja mora biti kasniji od datuma ugovora insert
insert osk.sklapa_ugovor values ('01-01-1955', '01-01-2022', 'ugovor3', '5855548726732', 1)
--provera update-a
update osk.sklapa_ugovor set datum_ug = '01-01-2000' where id_pp = 6 and jmbg_zap = '1478541111235'
