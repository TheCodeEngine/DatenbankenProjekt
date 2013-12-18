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
DROP SEQUENCE GDB1331.seq_autor_id;
DROP TABLE autor;
DROP SEQUENCE GDB1331.seq_verlag_id;
DROP TABLE verlag;
DROP TABLE mahnungen;
DROP TABLE vorbestellung;
DROP TABLE verlaengerung;
DROP TABLE rueckgabe;
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
  erstveroeffentlichung DATE NOT NULL,
  herausgeber VARCHAR(25) NOT NULL,
  isbn NUMBER(13),
  art NUMBER(2),
  excerpt VARCHAR(255),
  tags VARCHAR(100),
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

CREATE TABLE rueckgabe
(
  leser_id NUMBER(6),
  buch_id NUMBER(6),
  ausleihdatum TIMESTAMP,
  rueckgabedatum TIMESTAMP NOT NULL,
  FOREIGN KEY (leser_id) REFERENCES leser(leser_id),
  FOREIGN KEy (buch_id,ausleihdatum) REFERENCES ausleihe(buch_id,ausleihdatum),
  PRIMARY KEY (buch_id,ausleihdatum)
);

CREATE TABLE verlaengerung
(
  leser_id NUMBER(6),
  buch_id NUMBER(6),
  ausleihdatum TIMESTAMP,
  verlaengerung NUMBER(1),
  FOREIGN KEY (leser_id) REFERENCES leser(leser_id),
  FOREIGN KEY (buch_id,ausleihdatum) REFERENCES ausleihe(buch_id,ausleihdatum),
  PRIMARY KEY (buch_id,ausleihdatum)
);

CREATE TABLE vorbestellung
(
  leser_id NUMBER(6),
  buch_id NUMBER(6),
  vorbestelldatum TIMESTAMP,
  FOREIGN KEY (leser_id) REFERENCES leser(leser_id),
  PRIMARY KEY (buch_id,vorbestelldatum)
);

CREATE TABLE mahnungen
(
  mahnung_id NUMBER(6),
  leser_id NUMBER(6),
  mahnungsadtum TIMESTAMP,
  FOREIGN KEY (leser_id) REFERENCES leser(leser_id),
  PRIMARY KEY (leser_id,mahnungsadtum)
);

CREATE SEQUENCE seq_verlag_id START WITH 1 INCREMENT BY 10;
CREATE TABLE verlag
(
  verlag_id NUMBER(6),
  name VARCHAR(25) NOT NULL,
  ort VARCHAR(25) NOT NULL,
  PRIMARY KEY (verlag_id)
);

CREATE SEQUENCE seq_autor_id START WITH 1 INCREMENT BY 1;
CREATE TABLE autor
(
  autor_id NUMBER(6),
  vorname VARCHAR(25) NOT NULL,
  nachname VARCHAR(25) NOT NULL,
  titel VARCHAR(25)
  PRIMARY KEY (autor_id)
);

------------------------------------------------------------------------------------------------------------------------
--
-- DB füllen
--
------------------------------------------------------------------------------------------------------------------------
