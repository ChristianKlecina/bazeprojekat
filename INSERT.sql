--UNOS VREDNOSTI

--banke
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 225883, 'banka1@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 363288, 'banka2@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 255323, 'banka3@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 552832, 'banka4@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 111789, 'banka5@gmail.com')
--uneti posle za proveru ogr sa osiguravajucom kucom
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Banka', 111784, 'banka6@gmail.com')

--osiguravajuæe kuæe
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 556596, 'OSK1@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 456781, 'OSK2@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 555111, 'OSK3@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 898653, 'OSK4@gmail.com')
insert osk.poslovni_partner values ((next value for osk.id_pp_seq), 'Osiguravajuæa kuæa', 124876, 'OSK5@gmail.com')

--banka
insert osk.banka values (1, 'Intesa','Gogoljeva', 'Novi Sad', 12, 1)
insert osk.banka values (2, 'Raiffeisen','Zmaj Jovina', 'Novi Sad', 2, 2)
insert osk.banka values (3, 'Narodna Štedionica','Miše Dimitrijeviæa', 'Novi Sad', 25, 3)
insert osk.banka values (4, 'Telenor Banka', 'Futoška', 'Novi Sad', 4,4)
insert osk.banka values (5, 'Narodna Banka Srbije', 'Knez Mihailova', 'Beograd', 20,5)


--osiguravajuæa kuæa
insert osk.osiguravajuca_kuca values (1, 'Delta Generali', 'Inðija', 'Novosadska' ,110,6)
insert osk.osiguravajuca_kuca values (2, 'Dunav', 'Beograd', 'Ustanièka' ,52,7)
insert osk.osiguravajuca_kuca values (3, 'Grawe', 'Novi Sad', 'Bulevar Osloboðenja', 60,8)
insert osk.osiguravajuca_kuca values (4, 'Merkur', 'Novi Sad', 'Bulevar Osloboðenja', 30,9)
insert osk.osiguravajuca_kuca values (5, 'OTP', 'Beograd', 'Ruzveltova', 32,10)

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

--direktori 
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


--insert sklapa ugovor
insert osk.sklapa_ugovor values ('12-12-2020', '12-12-2024', 'Ugovor_banka', '4885875420552', 1)
insert osk.sklapa_ugovor values ('2017-05-07', '03-06-2026', 'Ugovor_osk', '1478541111235', 6)
insert osk.sklapa_ugovor values ('2020-06-06', '01-01-2022', 'Ugovor_osk', '1478541111235', 7)
insert osk.sklapa_ugovor values ('2016-01-02', '01-07-2025', 'Ugovor_osk', '1478541201235', 7)
insert osk.sklapa_ugovor values ('2020-06-06', '01-01-2024', 'ugovor_banka', '4882145420552', 2)
insert osk.sklapa_ugovor values ('2018-03-07', '03-07-2022', 'ugovor_osk', '4882145420552', 8)
insert osk.sklapa_ugovor values ('2014-03-02', '03-07-2032', 'ugovor_banka', '5855548726732', 3)
insert osk.sklapa_ugovor values ('2010-11-02', '09-02-2025', 'ugovor_banka', '5855548726658', 4)


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
