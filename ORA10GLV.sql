DROP Table buch;

-- DB erzeugen:

CREATE TABLE buch
(
  buch_id NUMBER(7),
  title VARCHAR(25),
  PRIMARY KEY (buch_id)
)

CREATE TABLE person
(
  person_id NUMBER(7),
  vorname VARCHAR(25),
  PRIMARY KEY (person_id)
)