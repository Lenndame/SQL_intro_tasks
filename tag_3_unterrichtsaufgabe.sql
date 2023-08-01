#--------------------------------------------------------------------------------------------------
# Aufgabe 1
#--------------------------------------------------------------------------------------------------

CREATE DATABASE joy_the_joins;

DROP DATABASE joy_the_joins;

USE joy_the_joins;

#--------------------------------------------------------------------------------------------------
#Aufgabe 2
#--------------------------------------------------------------------------------------------------

CREATE TABLE unternehmen (
    U_id int Primary Key Auto_Increment,
    Unternehmen varchar(64),
    Sitz text(64),
    Vorstand varchar(64),
    Aufsichtsrat varchar(64),
    Land text(4)
);

DESCRIBE unternehmen;

INSERT INTO unternehmen (Unternehmen, Sitz, Vorstand, Aufsichtsrat, Land)
    VALUES  ('BMW', 'München', 'Dr.Meyer', 'Dr.Schmidt', 'DE'),
            ('Deutsche Bank', 'Frankfurt', 'Dr.Specht', 'Dr.Klein', 'DE'),
            ('City Bank', 'London', 'Helmut K.', 'Dr. Collin', 'UK'),
            ('Ping An Insurance', 'Shen Zen', 'Peter S.', 'Herrman R.', 'VR')
;

select * from unternehmen;

#--------------------------------------------------------------------------------------------------
# Aufgabe 3
#--------------------------------------------------------------------------------------------------

create table if not exists unternehmen_copy  like unternehmen;

insert into  unternehmen_copy (Unternehmen, Sitz, Vorstand, Aufsichtsrat, Land)
    select Unternehmen, Sitz, Vorstand, Aufsichtsrat, Land
    from unternehmen
    order by unternehmen.Unternehmen desc;

select * from unternehmen_copy;

#--------------------------------------------------------------------------------------------------
#Aufgabe 4
#--------------------------------------------------------------------------------------------------

create table revenue (
    D_id int Primary Key Auto_Increment,
    `Jahr 2021` VARCHAR(20),
    `Jahr 2022` VARCHAR(20),
    `Jahr 2023` VARCHAR(20)
);

insert into revenue (`Jahr 2021`, `Jahr 2022`, `Jahr 2023`)
    values  ('14,53',    '15,23',    '16,89'),
            ('20,03',    '20,30',    '20,56'),
            ('101,26',   '1,67',     '141,61');

select * from revenue;

#--------------------------------------------------------------------------------------------------
#Aufgabe 5
#--------------------------------------------------------------------------------------------------

create table revenue_dec like revenue;

alter table revenue_dec
    modify `Jahr 2021` dec(10, 2),
    modify `Jahr 2022` dec(10, 2),
    modify `Jahr 2023` dec(10, 2);

#--------------------------------------------------------------------------------------------------
#Aufgabe 6
#--------------------------------------------------------------------------------------------------

CREATE TABLE rev_21 (
    id INT PRIMARY KEY,
    umsatz DECIMAL(10, 2)
    );

INSERT INTO rev_21 (id, umsatz)
    SELECT D_id,
       REPLACE(`Jahr 2021`, ',', '.')
    FROM revenue;

CREATE TABLE rev_22 (
    id INT PRIMARY KEY,
    umsatz DECIMAL(10, 2)
    );

INSERT INTO rev_22 (id, umsatz)
    SELECT D_id,
       REPLACE(`Jahr 2022`, ',', '.')
    FROM revenue;

CREATE TABLE rev_23 (
    id INT PRIMARY KEY,
    umsatz DECIMAL(10, 2)
    );

INSERT INTO rev_23 (id, umsatz)
    SELECT D_id,
       REPLACE(`Jahr 2023`, ',', '.')
    FROM revenue;

#--------------------------------------------------------------------------------------------------
#Aufgabe 7
#--------------------------------------------------------------------------------------------------
/* 
ALS SELF JOIN:

INSERT INTO revenue_dec (`Jahr 2021`, `Jahr 2022`, `Jahr 2023`)
select rev_21.umsatz, rev_22.umsatz, rev_23.umsatz
    From rev_21, rev_22, rev_23
    where rev_21.id = rev_22.id
    and rev_22.id = rev_23.id;
    
UND UNTERHALB FÜR JEDEN EINTRAG EINZELN:
*/

insert into revenue_dec (D_id, `Jahr 2021`, `Jahr 2022`, `Jahr 2023`)
    select 
        D_id,
            (select umsatz from rev_21 where id = D_id),
            (select umsatz from rev_22 where id = D_id),
            (select umsatz from rev_23 where id = D_id)
    From revenue
    where D_id = 1;

insert into revenue_dec (D_id, `Jahr 2021`, `Jahr 2022`, `Jahr 2023`)
    select 
        D_id,
            (select umsatz from rev_21 where id = D_id),
            (select umsatz from rev_22 where id = D_id),
            (select umsatz from rev_23 where id = D_id)
    From revenue
    where D_id = 2;
    
insert into revenue_dec (D_id, `Jahr 2021`, `Jahr 2022`, `Jahr 2023`)
    select 
        D_id,
            (select umsatz from rev_21 where id = D_id),
            (select umsatz from rev_22 where id = D_id),
            (select umsatz from rev_23 where id = D_id)
    From revenue
    where D_id = 3;

#--------------------------------------------------------------------------------------------------
#Aufgabe 8
#--------------------------------------------------------------------------------------------------

create or replace view umsatz as
    select * 
    from revenue_dec;

#--------------------------------------------------------------------------------------------------
#Aufgabe 9
#--------------------------------------------------------------------------------------------------

SELECT 
    MAX(revenue_dec.`Jahr 2021`) AS Maximum,
    MIN(revenue_dec.`Jahr 2021`) AS Minimum,
    AVG(revenue_dec.`Jahr 2021`) AS Durchschnitt,
    SUM(revenue_dec.`Jahr 2021`) AS Summe
FROM revenue_dec;

#--------------------------------------------------------------------------------------------------
#Aufgabe 10
#--------------------------------------------------------------------------------------------------

SELECT unternehmen.Unternehmen, unternehmen.Sitz, unternehmen.Land, revenue_dec.`Jahr 2021`
    FROM unternehmen
    LEFT JOIN revenue_dec
    on  unternehmen.U_id = revenue_dec.D_id;

#--------------------------------------------------------------------------------------------------
#Aufgabe 11
#--------------------------------------------------------------------------------------------------

SELECT unternehmen.Unternehmen, unternehmen.Sitz, unternehmen.Land, revenue_dec.`Jahr 2021`
    FROM unternehmen
    RIGHT JOIN revenue_dec
    on  unternehmen.U_id = revenue_dec.D_id;

#-------------------------------------------------------------------------------------------------- 
#Aufgabe 12
#--------------------------------------------------------------------------------------------------

SELECT unternehmen.Unternehmen, unternehmen.Sitz, unternehmen.Land, revenue_dec.`Jahr 2021`
    FROM unternehmen
    INNER JOIN revenue_dec
    on  unternehmen.U_id = revenue_dec.D_id;

SELECT unternehmen.Unternehmen, unternehmen.Sitz, unternehmen.Land, revenue_dec.`Jahr 2021`
    FROM unternehmen
    CROSS JOIN revenue_dec;
