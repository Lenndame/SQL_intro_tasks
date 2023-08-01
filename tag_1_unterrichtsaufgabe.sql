CREATE DATABASE zoologie;
USE zoologie;

-- To create a table:
CREATE TABLE habitat (
id INT,
name VARCHAR(64)
);

DESCRIBE habitat;
DROP TABLE habitat;

-- Use AUTO_INCREMENT to increment the ID automatically witheach new record. An AUTO_INCREMENT column must be definedas a primary or unique key:
CREATE TABLE habitat (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(64)
);

DESCRIBE habitat;

-- To create a table with a foreign key:
CREATE TABLE animal (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(64),
species VARCHAR(64),
age INT,
habitat_id INT,
FOREIGN KEY (habitat_id) REFERENCES habitat(id)
);

/***************   MODIFYING TABLES  ***************/
-- Use the ALTER TABLE statement to modify the table structure.
-- To change a table name:
ALTER TABLE animal RENAME pet;

ALTER TABLE pet RENAME animal;

-- To add a column to the table:
ALTER TABLE animal ADD COLUMN gattung VARCHAR(64);

-- To change a column name:   
/*********funktioniert nicht 
ALTER TABLE animal RENAME COLUMN species TO identifier; **/ 

-- To change a column data type:
ALTER TABLE animal MODIFY COLUMN name VARCHAR(128);

-- To delete a column:
ALTER TABLE animal DROP COLUMN name;

-- Kopieren einer Tabelle (Struktur ohne Inhalt)
CREATE TABLE tier LIKE animal;

-- To delete a table:
DROP TABLE tier;

DROP TABLE animal; -- lösche die Tabelle animal

-- erzeuge eine neue Tabelle animal, die später mit Daten gefüllt wird
CREATE TABLE animal (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(64),
species VARCHAR(64),
age INT,
habitat_id INT,
FOREIGN KEY (habitat_id) REFERENCES habitat(id)
);

/************INSERTING DATA ****************/
-- To insert data into a table, use the INSERT command:
INSERT INTO habitat VALUES
(1, 'River'),
(2, 'Forest');

-- Abfragen der Daten aus der Tabelle
SELECT * FROM zoologie.habitat;


-- You may specify the columns in which the data is added. 
-- There maining columns are filled with default values or NULLs.
INSERT INTO habitat (name) VALUES('Savanna');


INSERT INTO animal VALUES
(1, 'Hund', 'Säuger', 12, 2),
(2, 'Katze', 'Säuger', 7, 1),
(3, 'Eidechse', 'Reptil', 3,2),
(4, 'Katze', 'Säuger', 4, 1);

-- Abfragen der Daten aus der Tabelle
SELECT * FROM zoologie.animal;

-- UPDATING DATA
-- To update the data in a table, use the UPDATE command:

DESCRIBE animal;

UPDATE animal SET species = 'Duck',
name = 'Quack'
WHERE id = 2;

USE zoologie;
-- Kopieren einer Tabelle (Struktur ohne Inhalt)
CREATE TABLE zoologie.tier LIKE animal;
-- Zeige die Daten der Tabelle Tier an
SELECT * FROM zoologie.tier;

-- einfügen der Daten
SELECT * FROM zoologie.tier;
INSERT INTO tier SELECT * FROM animal;

-- Abfragen der Daten aus der Tabelle
SELECT * FROM zoologie.tier;

-- DELETING DATA
-- To delete data from a table, use the DELETE command:

DELETE FROM tier
WHERE id = 1;

SELECT * FROM zoologie.tier;
-- This deletes all rows satisfying the WHERE condition.
-- To delete all data from a table, use the TRUNCATE TABLEstatement:

TRUNCATE TABLE tier;

SELECT * FROM zoologie.tier;

/*** Quering DATA *****/

-- To select data from a table, use the SELECT command.
-- An example of a single-table query:
SELECT species, AVG(age) AS average_age FROM animal
	WHERE id != 3
    GROUP BY species
    HAVING AVG(age) > 3
    ORDER BY
    AVG(age)DESC;
    
    
    -- An example of a multiple-table query:
SELECT animal.name, animal.species, animal.age, habitat.name FROM animal 
RIGHT JOIN habitat
ON animal.habitat_id =  habitat.id; 

-- To get the number of seconds in a week:
SELECT 60 * 60 * 24 * 7; -- result: 604800

SELECT 100 * 3 * 3/6 + 1; -- result 151

SELECT ((3+6) * 4) / 6; -- result 6

/*** AGGREGATION AND GROUPING ******/

-- AVG(expr) - average value of expr for the group.
-- COUNT(expr) - count of expr values within the group.
-- MAX(expr) - maximum value of expr values within thegroup.
-- MIN(expr) - minimum value of expr values within thegroup.
-- SUM(expr) - sum of expr values within the group.

-- To count the rows in the table:
SELECT COUNT(*) FROM animal;

-- To count the non-NULL values in a column:
SELECT COUNT(name) FROM animal;

-- To count unique values in a column:
SELECT COUNT(DISTINCT name) FROM animal;

select * from animal;
INSERT INTO `zoologie`.`animal` (`name`, `species`, `age`, `habitat_id`) VALUES ('Wurm', 'Würmer', '2', '1');
INSERT INTO zoologie.animal (`name`, `species`, `age`, `habitat_id`) VALUES ('Habicht', 'Vögel', '4', '1');