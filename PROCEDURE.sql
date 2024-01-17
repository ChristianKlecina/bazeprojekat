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

--za proveru procedure
insert osk.sklapa_ugovor values ('2014-04-04', '09-02-2025', 'ugovor_banka', '5855548726732', 9)


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
