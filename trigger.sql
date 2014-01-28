-- Trigger

CREATE OR REPLACE TRIGGER ausleihe_check_vorbestellung
  BEFORE INSERT ON ausleihe
  FOR EACH ROW
DECLARE
  rowcnt number;
BEGIN
  SELECT COUNT(*) INTO rowcnt FROM vorbestellung WHERE buch_id=:NEW.buch_id;
  IF rowcnt = 0 THEN
    DBMS_OUTPUT.PUT_LINE('ausleihe_check_vorbestellung: Buch ist nicht Vorbestellt');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ausleihe_check_vorbestellung: Buch ist vorbestellt');
    RAISE_APPLICATION_ERROR( -20001, 'Buch ist vorbestellt');
  END IF;
END ausleihe_check_vorbestellung;

-- statements for test Trigger

INSERT INTO AUSLEIHE (LESER_ID, BUCH_ID, AUSLEIHDATUM) VALUES (
  1,
  1,
  to_date('2014/01/01 09:34:00', 'yyyy/mm/dd hh24:mi:ss')
);

