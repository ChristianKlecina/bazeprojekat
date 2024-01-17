IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'osk')
drop schema osk


if object_id('osk.osiguravajuca_kuca', 'U') is not null
	drop table osk.osiguravajuca_kuca

if object_id('osk.filijala_agencije', 'U') is not null
	drop table osk.filijala_agencije

if object_id('osk.saradjuje_sa', 'U') is not null
	drop table osk.saradjuje_sa

if object_id('osk.racun_agencije', 'U') is not null
	drop table osk.racun_agencije

if object_id('osk.isplacuje_procenat', 'U') is not null
	drop table osk.isplacuje_procenat

if object_id('osk.zaposleni', 'U') is not null
	drop table osk.zaposleni

if object_Id('osk.direktor', 'U')is not null
	drop table osk.direktor

if object_Id('osk.poslovni_partner', 'U')is not null
	drop table osk.poslovni_partner

if object_id('osk.sklapa_ugovor', 'U') is not null
	drop table osk.sklapa_ugovor

if object_id('osk.banka', 'U') is not null
	drop table osk.banka

if object_id('osk.ponuda', 'U') is not null
	drop table osk.ponuda

if object_Id('osk.id_pon_seq', 'SO')is not null
	drop sequence osk.id_pon_seq

if object_Id('osk.id_pp_seq', 'SO')is not null
	drop sequence osk.id_pp_seq

if object_id('osk.banka_tr', 'TR') is not null
	drop trigger osk.banka_tr

if object_id('osk.osiguravajuca_kuca_tr', 'TR') is not null
	drop trigger osk.osiguravajuca_kuca_tr

if object_id('osk.isplacuje_procenat_racun_agencije_datum_tr', 'TR') is not null
	drop trigger osk.isplacuje_procenat_racun_agencije_datum_tr

if object_id('osk.direktor_tr', 'TR') is not null
	drop trigger osk.direktor_tr

if object_id('osk.sklapa_ugovor_tr', 'TR') is not null
	drop trigger osk.sklapa_ugovor_tr

if object_id('osk.funkcija1', 'TF')is not null
	drop function osk.funkcija1

if object_id('osk.funkcija2', 'IF')is not null
	drop function osk.funkcija2

if object_id ('osk.proc1', 'P') is not null
	drop proc osk.proc1

if object_id('osk.proc2', 'P')is not null
	drop proc osk.proc2
