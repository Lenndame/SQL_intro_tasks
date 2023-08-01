-- zeige die Datenbank an 
show databases; 

# erzeuge die Datenbank Fahrzeuge 
create database if not exists fahrzeuge;

/* 
Wir nutzen die Datenbank Blockkommentar
*/
use fahrzeuge;
create table pkw(
	pkw_id int primary key auto_increment,
    modell varchar (100),
    bezeichnung varchar(100),
    baujahr int(4),
    FIN varchar(17),
    hersteller varchar(100)
);

show tables;
describe pkw;
insert into pkw (modell, bezeichnung, baujahr, FIN, hersteller)
	value('Golf', 'Golf GTI', '1999', 'asdfghjkle', 'VW');

SELECT * FROM pkw;

DELETE FROM fahrzeuge.pkw where pkw_id = '2';

create table pkw_copy like pkw;
insert into pkw_copy select * from pkw;

select * from pkw_copy;

# drop table pkw_copy -- löscht Tabelle
