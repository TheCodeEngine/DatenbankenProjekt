-- DB Löschen

DROP SEQUENCE GDB1331.seq_buch_id;
DROP TABLE buch;
DROP SEQUENCE GDB1331.seq_person_id;
DROP TABLE person;
DROP TABLE ausleihe;

-- DB erzeugen:

CREATE SEQUENCE seq_buch_id START WITH 1 INCREMENT BY 1;
CREATE TABLE buch
(
  buch_id NUMBER(6),
  title VARCHAR(25) NOT NULL,
  PRIMARY KEY (buch_id)
);

CREATE SEQUENCE seq_person_id START WITH 1 INCREMENT BY 1;
CREATE TABLE person
(
  person_id NUMBER(6),
  vorname VARCHAR(25),
  PRIMARY KEY (person_id)
);

CREATE TABLE ausleihe
(
  ausleihdatum TIMESTAMP,
  person_id NUMBER(6),
  buch_id NUMBER(6),
  PRIMARY KEY (ausleihdatum,buch_id)
);

-- DB auffüllen

-- // Buch
INSERT INTO buch VALUES (seq_buch_id.NEXTVAL, 'Buch');

-- // Person
INSERT INTO person VALUES (seq_person_id.NEXTVAL, 'John');

-- // Ausleihe
INSERT INTO ausleihe (ausleihdatum, buch_id, person_id) VALUES (to_timestamp('2009-09-21 14:45', 'YYYY-MM-DD HH24:MI:SS'), 1, 1);

SELECT * FROM ausleihe;