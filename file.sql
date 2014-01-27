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

INSERT INTO buch (BUCH_ID, TITLE, erstveroeffentlichung, herausgeber, aufnahmedatum, isbn, excerpt, tags, CATEGORY) VALUES ( 
  seq_buch_id.nextval, 
  'Title 1', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  'Pearson', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  '912-144-3444', 
  'Dies ist das Excerpt', 
  'Tag1',
  'category1'
);

INSERT INTO buch (BUCH_ID, TITLE, erstveroeffentlichung, herausgeber, aufnahmedatum, isbn, excerpt, tags, CATEGORY) VALUES ( 
  seq_buch_id.nextval, 
  'Title 2', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  'Pearson', 
  to_date('2011/04/22 08:30:00', 'yyyy/mm/dd hh24:mi:ss'), 
  '912-144-3444', 
  'Dies ist das Excerpt', 
  'Tag1',
  'category2'
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
-- Count Categorys 