/*
Sie arbeiten in einem biologischen Labor, dass die DNA von Tieren untersucht. Um Ihre
Analysemethodik zu testen wünscht ihre Leitung eine Testdatenbank. Diese soll 10.000 AminosäureSequencen enthalten zu 5 unterschiedlichen Tierproben enthalten. Sie haben aus 5 Versuchsreihen
Basisdaten, die in einer csv – Datei abgespeichert sind. Sie sollen hieraus eine Datenbank gene_ana
erstellen und eine entsprechende Tabelle „traces“ anlagen. Eine Kopie dieser Tabelle wird für
Analyse-Zwecke manipuliert und fehlende Positionen eingebaut. Die in der Datenbanktabelle
vorhanden erfassten Aminosäuren sollen auch auf Ihre Häufigkeit untersucht werden.
*/

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 1. Erzeugen Sie die Datenbank gene_ana
#-----------------------------------------------------------------------------------------------------------------------

CREATE DATABASE gene_ana;

USE gene_ana; 

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 2. Importieren Sie die Daten der Übungsdatei „traces.csv“
#-----------------------------------------------------------------------------------------------------------------------

# Über Bedienfeld links, in entsprechender Datenbank Tables auswählen dann Table Data import wizard
# geht aber auch über SQL-Befehle

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 3. Legen Sie die Tabelle Traces an.
#-----------------------------------------------------------------------------------------------------------------------

# wurde in Aufageb 2 beim Import mit erledigt!
SELECT * 
    FROM traces;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 4. Legen Sie zur Sicherheit eine Kopie traces_copy in der Datenbank ab
#-----------------------------------------------------------------------------------------------------------------------

CREATE TABLE traces_copy 
    like traces;
    
INSERT INTO traces_copy 
    SELECT * 
    FROM traces;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 5. Erzeugen Sie einen View über alle erzeugten Daten der Tabelle Traces.
#-----------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW Traves_V AS
    SELECT * 
    FROM traces;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 6. Zählen Sie die Spalten Einträge der Traces 184 bis 188 aus.
#-----------------------------------------------------------------------------------------------------------------------

SELECT 
    COUNT(trace_184) AS Anzahl_Einträge_trace_184,
    COUNT(trace_185) AS Anzahl_Einträge_trace_185,
    COUNT(trace_186) AS Anzahl_Einträge_trace_186,
    COUNT(trace_187) AS Anzahl_Einträge_trace_187,
    COUNT(trace_188) AS Anzahl_Einträge_trace_188
FROM traces;  

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 7. Wie viele unterschiedliche unique Einträge in den Spalten werden abgebildet?
#-----------------------------------------------------------------------------------------------------------------------

SELECT 
    COUNT(DISTINCT trace_184) AS Anzahl_Einträge_trace_184,
    COUNT(DISTINCT trace_185) AS Anzahl_Einträge_trace_185,
    COUNT(DISTINCT trace_186) AS Anzahl_Einträge_trace_186,
    COUNT(DISTINCT trace_187) AS Anzahl_Einträge_trace_187,
    COUNT(DISTINCT trace_188) AS Anzahl_Einträge_trace_188
FROM traces; 

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 8. Analysieren Sie die Tabellen-Struktur (DESCRIBE)
#-----------------------------------------------------------------------------------------------------------------------

DESCRIBE Traces;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 9. Verwenden Sie die erste Spalte der Tabelle für den Primärschlüssel und ändern Sie die
#           Spaltenbezeichnung auf „id“ ab.
#-----------------------------------------------------------------------------------------------------------------------

ALTER TABLE traces 
    CHANGE COLUMN MyunknownColumn id INT PRIMARY KEY;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 10. Ändern Sie die Formate der Spalten trace_XX auf CHAR(1) ab.
#-----------------------------------------------------------------------------------------------------------------------

ALTER TABLE traces
    MODIFY COLUMN trace_184 CHAR(1),
    MODIFY COLUMN trace_185 CHAR(1),
    MODIFY COLUMN trace_186 CHAR(1),
    MODIFY COLUMN trace_187 CHAR(1),
    MODIFY COLUMN trace_188 CHAR(1);

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 11. Überprüfen Sie erneut, ob die vorgenommen Veränderungen durchgeführt wurden.
#-----------------------------------------------------------------------------------------------------------------------

DESCRIBE traces;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 12. Veränderungen in der Spalte trace_184 vornehmen: Hier soll die 2. Position (Zeile) in der
#            Spalte auf auf „NULL“ gesetzt werden
#-----------------------------------------------------------------------------------------------------------------------

UPDATE Traces 
    SET trace_184 = NULL 
    WHERE id = 2;  

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 13. Veränderungen in der Spalte trace_186 vornehmen: Hier soll die 5. 7. Und 8. Position (Zeile)
#            in der Spalte auf „NULL“ gesetzt werden.
#-----------------------------------------------------------------------------------------------------------------------

UPDATE traces
    SET trace_186 = NULL
    WHERE id 
        IN (5, 7, 8);

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 14. Veränderungen in der Spalte trace_185 vornehmen: Hier sollen die Positionen 500 bis 550
#            auf „NULL“ gesetzt werden
#-----------------------------------------------------------------------------------------------------------------------

UPDATE traces
    SET trace_185 = NULL
    WHERE id 
        BETWEEN 500 AND 550;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 15. Zähle Sie erneut die Einträge in den Spalten aus
#-----------------------------------------------------------------------------------------------------------------------

SELECT 
    COUNT(trace_184) AS Anzahl_Einträge_trace_184,
    COUNT(trace_185) AS Anzahl_Einträge_trace_185,
    COUNT(trace_186) AS Anzahl_Einträge_trace_186,
    COUNT(trace_187) AS Anzahl_Einträge_trace_187,
    COUNT(trace_188) AS Anzahl_Einträge_trace_188
FROM traces;

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 16. Zählen Sie erneut aus, wieviel unterschiedliche Einträge vorhanden sind.
#-----------------------------------------------------------------------------------------------------------------------

SELECT 
    COUNT(DISTINCT trace_184) AS Anzahl_Einträge_trace_184,
    COUNT(DISTINCT trace_185) AS Anzahl_Einträge_trace_185,
    COUNT(DISTINCT trace_186) AS Anzahl_Einträge_trace_186,
    COUNT(DISTINCT trace_187) AS Anzahl_Einträge_trace_187,
    COUNT(DISTINCT trace_188) AS Anzahl_Einträge_trace_188
FROM traces; 

#-----------------------------------------------------------------------------------------------------------------------
# Aufgabe 17. Fertigen Sie eine Tabelle auswertung an, die absolute Häufigkeit der je Spur auftretenden Nukleotide 
#            (einzelne Einträge) anzeigt. Die Tabelle soll in der ersten Spalte letztlich als Id Folgende Werte
#            enthalten A,C,T,G. Gefolgt von den Spalten Traces_XX in denen die Häufigkeiten angezeigt werden.
#-----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Auswertung_1 (
  Id char(1) Primary Key,
  trace_184 INT,
  trace_185 INT,
  trace_186 INT,
  trace_187 INT,
  trace_188 INT
);
    
INSERT INTO Auswertung_1 (id, trace_184, trace_185, trace_186, trace_187, trace_188)
    VALUES 
    ('A', (SELECT COUNT(trace_184) FROM traces WHERE trace_184 = 'A'), 
          (SELECT COUNT(trace_185) FROM traces WHERE trace_185 = 'A'), 
          (SELECT COUNT(trace_186) FROM traces WHERE trace_186 = 'A'), 
          (SELECT COUNT(trace_187) FROM traces WHERE trace_187 = 'A'), 
          (SELECT COUNT(trace_188) FROM traces WHERE trace_188 = 'A')),

    ('T', (SELECT COUNT(trace_184) FROM traces WHERE trace_184 = 'T'), 
          (SELECT COUNT(trace_185) FROM traces WHERE trace_185 = 'T'), 
          (SELECT COUNT(trace_186) FROM traces WHERE trace_186 = 'T'), 
          (SELECT COUNT(trace_187) FROM traces WHERE trace_187 = 'T'), 
          (SELECT COUNT(trace_188) FROM traces WHERE trace_188 = 'T')),

    ('G', (SELECT COUNT(trace_184) FROM traces WHERE trace_184 = 'G'), 
          (SELECT COUNT(trace_185) FROM traces WHERE trace_185 = 'G'), 
          (SELECT COUNT(trace_186) FROM traces WHERE trace_186 = 'G'), 
          (SELECT COUNT(trace_187) FROM traces WHERE trace_187 = 'G'), 
          (SELECT COUNT(trace_188) FROM traces WHERE trace_188 = 'G')),

    ('C', (SELECT COUNT(trace_184) FROM traces WHERE trace_184 = 'C'), 
          (SELECT COUNT(trace_185) FROM traces WHERE trace_185 = 'C'), 
          (SELECT COUNT(trace_186) FROM traces WHERE trace_186 = 'C'), 
          (SELECT COUNT(trace_187) FROM traces WHERE trace_187 = 'C'), 
          (SELECT COUNT(trace_188) FROM traces WHERE trace_188 = 'C'));

SELECT * FROM Auswertung_1;

#-----------------------------------------------------------------------------------------------------------------------
# CHAT GPT hat den code verkürzt zu: 
#-----------------------------------------------------------------------------------------------------------------------

CREATE TABLE Auswertung_chat_gpt (
  Id char(1) Primary Key,
  trace_184 INT,
  trace_185 INT,
  trace_186 INT,
  trace_187 INT,
  trace_188 INT
);

INSERT INTO Auswertung_chat_gpt (id, trace_184, trace_185, trace_186, trace_187, trace_188)
SELECT
    nukleotid AS id,
    COUNT(CASE WHEN trace_184 = nukleotid THEN 1 END) AS trace_184,
    COUNT(CASE WHEN trace_185 = nukleotid THEN 1 END) AS trace_185,
    COUNT(CASE WHEN trace_186 = nukleotid THEN 1 END) AS trace_186,
    COUNT(CASE WHEN trace_187 = nukleotid THEN 1 END) AS trace_187,
    COUNT(CASE WHEN trace_188 = nukleotid THEN 1 END) AS trace_188
FROM (
    SELECT 'A' AS nukleotid UNION ALL
    SELECT 'T' AS nukleotid UNION ALL
    SELECT 'G' AS nukleotid UNION ALL
    SELECT 'C' AS nukleotid
) AS nukleotide
CROSS JOIN traces
GROUP BY nukleotid;

SELECT * FROM Auswertung_chat_gpt;
