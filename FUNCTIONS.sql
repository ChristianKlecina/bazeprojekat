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