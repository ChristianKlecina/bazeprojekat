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