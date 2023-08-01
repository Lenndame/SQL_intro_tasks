create database kursverwaltung;
use kursverwaltung;
create table student(
    MatNr varchar(8) Primary Key,
    Vorname varchar(64),
    Nachname varchar(64),
    Geburtsdatum Date,
    PLZ varchar(5),
    Ort varchar(64),
    Strasse varchar(64),
    Hausnummer varchar(64),
    Telefonnummer varchar(64),
    Email varchar (64)
);

select * from Student;

insert into student(MatNr, Vorname, Nachname, Geburtsdatum, PLZ, Ort, Strasse, Hausnummer, Telefonnummer, Email)
    value( 'a1305729', 'Herrman', 'Meyer', STR_TO_DATE('10.10.1970', '%d.%m.%Y'), '66111', 'Saarbrücken', 'Metzerstraße', '53', '0681 999 12345', 'test@test.de');

insert into student(MatNr, Vorname, Nachname, Geburtsdatum, PLZ, Ort, Strasse, Hausnummer,Telefonnummer, Email)
    value( 'a1305730', 'Petra', 'Keller', STR_TO_DATE('09.06.1990', '%d.%m.%Y'), '81925', 'München', 'Südallee', '25', '0159 9956461', 'petra@pertra.com');

insert into student(MatNr, Vorname, Nachname, Geburtsdatum, PLZ, Ort, Strasse, Hausnummer)
    value( 'a1305731', 'Peter', 'Keller', STR_TO_DATE('03.01.2001', '%d.%m.%Y'), '81925', 'München', 'Abacostraße', '26');
    
select * 
    from student 
    where Nachname = 'Keller';
    
select * 
    from student 
    where Geburtsdatum > STR_TO_DATE('01.01.1980', '%d.%m.%Y');
    
select * 
    from student 
    where Geburtsdatum < STR_TO_DATE('01.01.1980', '%d.%m.%Y');
    
select * 
    from student
    where Geburtsdatum between STR_TO_DATE('01.01.1970', '%d.%m.%Y') And STR_TO_DATE('31.12.1970', '%d.%m.%Y');

create table copy_student like student;
insert into copy_student select * from student where MatNr = 'a1305729';

select Vorname, Nachname, Telefonnummer, Email
    from student
    where Vorname like 'P%';

create or replace view studenten_liste as
    select * 
    from student; 

alter table student 
    add column Geschlecht char(1);
    
select * 
    from student;

update student
    set Geschlecht = 'M'
    where MatNr = 'a1305729';
