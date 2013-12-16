------------------------------------------------------------------------------------------------------------------------
--
-- BIBLIOTHEK-DATENBANK
--
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
--
-- DB zuruecksetzen
--
------------------------------------------------------------------------------------------------------------------------
DROP TABLE ausleihe;
DROP SEQUENCE GDB1331.seq_buch_id;
DROP TABLE buch;
DROP SEQUENCE GDB1331.seq_leser_id;
DROP TABLE leser;

------------------------------------------------------------------------------------------------------------------------
--
-- DB erzeugen:
--
------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE seq_buch_id START WITH 1 INCREMENT BY 1;
CREATE TABLE buch
(
  buch_id NUMBER(6),
  title VARCHAR(25) NOT NULL,
  PRIMARY KEY (buch_id)
);

CREATE SEQUENCE seq_leser_id START WITH 1 INCREMENT BY 1;
CREATE TABLE leser
(
  leser_id NUMBER(6),
  nachname VARCHAR(25) NOT NULL,
  vorname VARCHAR(25) NOT NULL,
  geburtsdatum DATE NOT NULL,
  titel VARCHAR(25),
  adresse VARCHAR(25) NOT NULL,
  anmeldedatum TIMESTAMP NOT NULL,
  PRIMARY KEY (leser_id)
);

CREATE TABLE ausleihe
(
  leser_id NUMBER(6),
  buch_id NUMBER(6),
  ausleihdatum TIMESTAMP NOT NULL,
  FOREIGN KEY (leser_id) REFERENCES leser(leser_id),
  FOREIGN KEy (buch_id) REFERENCES buch(buch_id),
  PRIMARY KEY (buch_id,ausleihdatum)
);

------------------------------------------------------------------------------------------------------------------------
--
-- DB füllen
--
------------------------------------------------------------------------------------------------------------------------

-- // Buch
INSERT INTO buch VALUES (seq_buch_id.NEXTVAL, 'Buch');
-- // Leser
INSERT INTO leser (leser_id, nachname, vorname, geburtsdatum, adresse, anmeldedatum) VALUES
(seq_leser_id.NEXTVAL, 'Doe', 'John', to_date('01.01.1990', 'dd.mm.yyyy'), 'STRASSE NUMMER, ORT', to_timestamp('2013-01-01 15:00', 'YYYY-MM-DD HH24:MI:SS'));
-- // Ausleihe
INSERT INTO ausleihe VALUES (1, 1, to_timestamp('2013-12-01 12:00', 'YYYY-MM-DD HH24:MI:SS'));

