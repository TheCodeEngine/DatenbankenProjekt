------------------------------------------------------------------------------------------------------------------------
--
-- Datenbank Projekt: TestDaten
--
------------------------------------------------------------------------------------------------------------------------

--
-- Format
--
INSERT INTO format (format_id, art) VALUES (seq_format_id.nextval, 'E-Book');
INSERT INTO format (format_id, art) VALUES (seq_format_id.nextval, 'Buch');
INSERT INTO format (format_id, art) VALUES (seq_format_id.nextval, 'Zeitschrift');
INSERT INTO format (format_id, art) VALUES (seq_format_id.nextval, 'Zeitung');
INSERT INTO format (format_id, art) VALUES (seq_format_id.nextval, 'Hoerbuch');

--
-- Buecher
--

INSERT INTO buch (BUCH_ID, TITLE, erstveroeffentlichung, herausgeber, aufnahmedatum, isbn, excerpt, tags, CATEGORY, format_id) VALUES ( 
  seq_buch_id.nextval, 
  'Title 1', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  'Pearson', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  '912-144-3444', 
  'Dies ist das Excerpt', 
  'Tag1',
  'category1',
  1
);

INSERT INTO buch (BUCH_ID, TITLE, erstveroeffentlichung, herausgeber, aufnahmedatum, isbn, excerpt, tags, CATEGORY, format_id) VALUES ( 
  seq_buch_id.nextval, 
  'Title 2', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  'Pearson', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  '912-144-3444', 
  'Dies ist das Excerpt', 
  'Tag1',
  'category2',
  2
);

--

--
-- Verlag
--

INSERT INTO verlag (verlag_id, name_verlag, ort) VALUES (
  seq_verlag_id.nextval,
  'Springer',
  'Hamburg'
);

--
-- verlegt
--

--INSERT INTO verlegt (verlag_id, buch_id) VALUES (1, 2);

--
-- autor
--
INSERT INTO autor (AUTOR_ID, VORNAME, NACHNAME) VALUES (
  seq_autor_id.nextval,
  'Alfred',
  'Ibach'
);

--
-- Leser
--
INSERT INTO leser (LESER_ID, NACHNAME, VORNAME, GEBURTSDATUM, TITEL, ADRESSE, ANMELDEDATUM, KONTO_AKTIV) VALUES (
  seq_leser_id.nextval,
  'Max',
  'Mustermann',
  to_date('1990/01/01', 'yyyy/mm/dd'), 
  'Dr.',
  'Stra�e am Platz 17, Leipzig',
  to_date('2014/01/01', 'yyyy/mm/dd'),
  1
);

INSERT INTO leser (LESER_ID, NACHNAME, VORNAME, GEBURTSDATUM, ADRESSE, ANMELDEDATUM, KONTO_AKTIV) VALUES (
  seq_leser_id.nextval,
  'John',
  'Doe',
  to_date('1987/01/01', 'yyyy/mm/dd'), 
  'Stra�e am Platz 17, Berlin',
  to_date('2014/01/01', 'yyyy/mm/dd'),
  1
);

--
-- ausleihe
--
INSERT INTO AUSLEIHE (LESER_ID, BUCH_ID, AUSLEIHDATUM) VALUES (
  5,
  1,
  to_date('2014/01/01 09:34:00', 'yyyy/mm/dd hh24:mi:ss')
);

--
-- rueckgabe
--
INSERT INTO RUECKGABE (LESER_ID, BUCH_ID, AUSLEIHDATUM, RUECKGABEDATUM) VALUES (
  1,
  5,
  to_date('2014/01/01 09:34:00', 'yyyy/mm/dd hh24:mi:ss'),
  to_date('2014/01/22 18:08:00', 'yyyy/mm/dd hh24:mi:ss')
);


------------------------------------------------------------------------------------------------------------------------
--
-- Datenbank Projekt: Statistische Auswertung
--
------------------------------------------------------------------------------------------------------------------------

--
-- Statistische Auswertung Categorys
--
SELECT b.category, COUNT(*) AS numInstances FROM buch b GROUP BY b.category;

--
-- Ausleih Historie Report
SELECT ausleihe.AUSLEIHDATUM, leser.vorname, buch.title FROM ausleihe JOIN leser ON ausleihe.LESER_ID = leser.LESER_ID JOIN buch on ausleihe.BUCH_ID=buch.BUCH_ID;

--
-- Noch nicht zur�ckgegebene B�cher Report
SELECT leser.vorname, leser.nachname, buch.title, ausleihe.AUSLEIHDATUM FROM ausleihe JOIN leser ON ausleihe.LESER_ID = leser.LESER_ID JOIN buch on ausleihe.BUCH_ID=buch.BUCH_ID
MINUS
SELECT leser.vorname, leser.nachname, buch.title, RUECKGABE.AUSLEIHDATUM FROM RUECKGABE JOIN leser ON RUECKGABE.LESER_ID = leser.LESER_ID JOIN buch on RUECKGABE.BUCH_ID=buch.BUCH_ID


--
-- Welche Buecher wurden am meisten ausgeliehen
--
SELECT buch.title, q.TotalAusleihe
FROM buch JOIN
(SELECT buch_id, COUNT(buch_id) as TotalAusleihe FROM ausleihe GROUP BY buch_id) q
ON buch.BUCH_ID=q.buch_id
ORDER BY q.TotalAusleihe DESC
