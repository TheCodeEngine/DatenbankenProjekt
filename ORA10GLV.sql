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
DROP TABLE format;
DROP TABLE formatart;
DROP TABLE verlegt;
DROP TABLE autorenschaft;
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
  title VARCHAR2(25) NOT NULL,
  erstveroeffentlichung DATE NOT NULL,
  herausgeber VARCHAR2(25) NOT NULL,
  aufnahmedatum DATE NOT NULL,
  isbn VARCHAR2(20),
  excerpt VARCHAR2(255),
  tags VARCHAR2(100),
  category VARCHAR2(100) NOT NULL,
  PRIMARY KEY (buch_id)
);

CREATE SEQUENCE seq_leser_id START WITH 1 INCREMENT BY 1;
CREATE TABLE leser
(
  leser_id NUMBER(6),
  nachname VARCHAR2(25) NOT NULL,
  vorname VARCHAR2(25) NOT NULL,
  geburtsdatum DATE NOT NULL,
  titel VARCHAR2(25),
  adresse VARCHAR2(25) NOT NULL,
  anmeldedatum TIMESTAMP NOT NULL,
  konto_aktiv NUMBER(1) NOT NULL,
  PRIMARY KEY (leser_id)
);

CREATE TABLE ausleihe
(
  leser_id NUMBER(6) REFERENCES leser(leser_id),
  buch_id NUMBER(6) REFERENCES buch(buch_id),
  ausleihdatum TIMESTAMP NOT NULL,
  PRIMARY KEY (buch_id,ausleihdatum)
);

CREATE TABLE rueckgabe
(
  leser_id NUMBER(6) REFERENCES leser(leser_id),
  buch_id NUMBER(6),
  ausleihdatum TIMESTAMP,
  rueckgabedatum TIMESTAMP NOT NULL,
  FOREIGN KEY (buch_id,ausleihdatum) REFERENCES ausleihe(buch_id,ausleihdatum),
  PRIMARY KEY (buch_id,ausleihdatum)
);

CREATE TABLE verlaengerung
(
  leser_id NUMBER(6) REFERENCES leser(leser_id),
  buch_id NUMBER(6),
  ausleihdatum TIMESTAMP,
  verlaengerung NUMBER(1),
  FOREIGN KEY (buch_id,ausleihdatum) REFERENCES ausleihe(buch_id,ausleihdatum),
  PRIMARY KEY (buch_id,ausleihdatum)
);

CREATE TABLE vorbestellung
(
  leser_id NUMBER(6) REFERENCES leser(leser_id),
  buch_id NUMBER(6),
  vorbestelldatum TIMESTAMP,
  PRIMARY KEY (buch_id,vorbestelldatum)
);

CREATE TABLE mahnungen
(
  mahnung_id NUMBER(6),
  leser_id NUMBER(6) REFERENCES leser(leser_id),
  mahnungsadtum TIMESTAMP NOT NULL,
  grund NUMBER(4) NOT NULL,
  beschreibung VARCHAR2(255),
  buch_id NUMBER(6) REFERENCES buch(buch_id),
  ausleihdatum TIMESTAMP NOT NULL,
  FOREIGN KEY (buch_id, ausleihdatum) REFERENCES ausleihe(buch_id, ausleihdatum),
  PRIMARY KEY (leser_id,mahnungsadtum)
);

CREATE SEQUENCE seq_verlag_id START WITH 1 INCREMENT BY 10;
CREATE TABLE verlag
(
  verlag_id NUMBER(6),
  name_verlag VARCHAR2(25) NOT NULL,
  ort VARCHAR2(25) NOT NULL,
  PRIMARY KEY (verlag_id)
);

CREATE TABLE verlegt
(
  verlag_id NUMBER(6) REFERENCES verlag(verlag_id),
  buch_id NUMBER(6) REFERENCES buch(buch_id),
  PRIMARY KEY (verlag_id,buch_id)
);

CREATE SEQUENCE seq_autor_id START WITH 1 INCREMENT BY 1;
CREATE TABLE autor
(
  autor_id NUMBER(6),
  vorname VARCHAR2(25) NOT NULL,
  nachname VARCHAR2(25) NOT NULL,
  titel VARCHAR2(25),
  kuenstlername VARCHAR2(25),
  PRIMARY KEY (autor_id)
);

CREATE TABLE autorenschaft
(
  autor_id NUMBER(6) REFERENCES autor(autor_id),
  buch_id NUMBER(6) REFERENCES buch(buch_id),
  PRIMARY KEY (autor_id,buch_id)
);

CREATE TABLE formatart
(
  format_id NUMBER(6),
  PRIMARY KEY (format_id)
);

CREATE TABLE format
(
  buch_id NUMBER(6) REFERENCES buch(buch_id),
  format_id NUMBER(6) REFERENCES formatart(format_id),
  PRIMARY KEY (buch_id,format_id)
);

