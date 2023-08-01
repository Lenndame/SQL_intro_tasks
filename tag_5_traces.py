"""
MYSQL anbindung an Python
"""

import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345",
    database="gene_ana",
)

mycursor = mydb.cursor()

# ------------------------------------------------------------------
# Ausführen des Befehls
mycursor.execute("SHOW TABLES")

# zum Anzeigen
for x in mycursor:
    print(x)
# ------------------------------------------------------------------
# Ausführen des Befehls
mycursor.execute("SELECT * FROM auswertung_1")

# zum Anzeigen
for x in mycursor:
    print(x)
print("auswertung_1")

print("*" * 50)

# ------------------------------------------------------------------
# Befehl definieren
sql_1 = "SELECT * FROM auswertung_1"
# Ausführen des Befehls
mycursor.execute(sql_1)

# zum Anzeigen
for x in mycursor:
    print(x)
print("sql_1")

print("*" * 50)

# ------------------------------------------------------------------
# Befehl definieren
sql_copy = "CREATE TABLE IF NOT EXISTS auswertung_copy LIKE auswertung_1"
# Ausführen des Befehls
mycursor.execute(sql_copy)

# Befehl definieren
sql_truncate_table = "TRUNCATE TABLE auswertung_copy"
# Ausführen des Befehls
mycursor.execute(sql_truncate_table)

# Befehl definieren
sql_insert = "INSERT INTO auswertung_copy SELECT * From auswertung_1"
# Ausführen des Befehls
mycursor.execute(sql_insert)

# Änderungen (schreiben) in die Datenbank übertragen
mydb.commit()

# Befehl definieren
sql_2 = "SELECT * FROM auswertung_copy"
# Ausführen des Befehls
mycursor.execute(sql_2)

# Ergebnissobjekt erstellen
my_result = mycursor.fetchall()

# zum Anzeigen
print(my_result)

print("my_result")
print("*" * 50)

# ------------------------------------------------------------------
# Befehl definieren
sql_insert_u = "INSERT INTO auswertung_copy (Id, trace_184, trace_185) VALUES (%s, %s, %s)"
val = ("U", "1500", "1600")

# Ausführen des Befehls
mycursor.execute(sql_insert_u, val)

# Änderungen (schreiben) in die Datenbank übertragen
mydb.commit()

# zum Anzeigen
mycursor.execute(sql_2)
for x in mycursor:
    print(x)

print("sql_insert_u")
print("*" * 50)

# alternative zum Anzeigen(print) und weiterarbeiten(my_result_alt) wie oben
mycursor.execute(sql_2)

my_result_alt = mycursor.fetchall()

print(my_result_alt)

print("my_result_alt")
print("*" * 50)

# ------------------------------------------------------------------
# Input für Befehl Erfassen
nu = input("Welcher nukleotid: ")
tr184 = input("Häufigkeit in trace_184: ")
tr185 = input("Häufigkeit in trace_185: ")

print(nu, tr184, tr185)  # Kontrolle der Eingaben

# Befehl definieren
sql_insert_nu = "INSERT INTO auswertung_copy (Id, trace_184, trace_185) VALUES (%s, %s, %s)"

# Ausführen des Befehls
mycursor.execute(sql_insert_nu, (nu, tr184, tr185))

# zum Anzeigen
mycursor.execute(sql_2)
for x in mycursor:
    print(x)

print("sql_insert_nu")
print("*" * 50)
# ------------------------------------------------------------------
mydb.commit()

mydb.close()
