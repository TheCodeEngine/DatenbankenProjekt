-- DB Löschen

DROP SEQUENCE GDB1331.buch_id_s;
DROP TABLE buch;
DROP TABLE person;
DROP TABLE ausleihe;

-- DB erzeugen:

CREATE SEQUENCE buch_id_s START WITH 1 INCREMENT BY 1;
CREATE TABLE buch
(
  buch_id NUMBER(7),
  title VARCHAR(25),
  
  PRIMARY KEY (buch_id)
);

CREATE TABLE person
(
  person_id NUMBER(7),
  vorname VARCHAR(25),
  
  PRIMARY KEY (person_id)
);

CREATE TABLE ausleihe
(
  ausleih_id NUMBER(7),
  person_id NUMBER(7),
  buch_id NUMBER(7),
  
  PRIMARY KEY (ausleih_id)
);

-- DB auffüllen

-- // Buch
-- INSERT INTO buch VALUES ()
