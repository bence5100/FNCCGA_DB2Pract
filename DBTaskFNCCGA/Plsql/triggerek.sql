-- 1. Trigger: Kulcs érték automatikus megadása beszúráskor
CREATE OR REPLACE TRIGGER auto_pk_trg
BEFORE INSERT ON autok
FOR EACH ROW
BEGIN
  IF :NEW.auto_id IS NULL THEN
    :NEW.auto_id := auto_seq.NEXTVAL;
  END IF;
END;


-- 2. Trigger: Módosítások kontrollálása (Költség nem lehet negatív)
CREATE OR REPLACE TRIGGER javitas_ctrl_trg
BEFORE INSERT OR UPDATE ON javitasok
FOR EACH ROW
BEGIN
    IF :NEW.koltseg < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Hiba: A javítás költsége nem lehet negatív!');
    END IF;
END;


-- 3. Trigger: Események naplózása (Beszúrás, Módosítás, Törlés)
CREATE OR REPLACE TRIGGER javitas_naplo_trg
AFTER INSERT OR UPDATE OR DELETE ON javitasok
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO szerviz_naplo (naplo_id, muvelet, datum, felhasznalo) 
        VALUES (naplo_seq.NEXTVAL, 'ÚJ JAVÍTÁS', SYSDATE, USER);
    ELSIF UPDATING THEN
        INSERT INTO szerviz_naplo (naplo_id, muvelet, datum, felhasznalo) 
        VALUES (naplo_seq.NEXTVAL, 'JAVÍTÁS MÓDOSÍTVA', SYSDATE, USER);
    ELSIF DELETING THEN
        INSERT INTO szerviz_naplo (naplo_id, muvelet, datum, felhasznalo) 
        VALUES (naplo_seq.NEXTVAL, 'JAVÍTÁS TÖRÖLVE', SYSDATE, USER);
    END IF;
END;
