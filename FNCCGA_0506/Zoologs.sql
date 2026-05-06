CREATE TABLE ZooLogs (
    DATUM DATE DEFAULT SYSDATE,
    EVENT VARCHAR2(100),
    ADAT VARCHAR2(1000)
);

CREATE OR REPLACE TRIGGER TZooInsert
AFTER INSERT ON Zoo
FOR EACH ROW
BEGIN
    INSERT INTO ZooLogs (EVENT, ADAT)
    VALUES ('INSERT', 'ID:' || :NEW.ID || ', Nev:' || :NEW.Nev || ', Fajta:' || :NEW.Fajta || 
                      ', Szul:' || :NEW.Szuletett || ', Suly:' || :NEW.Suly || 
                      ', Ertek:' || :NEW.Ertek || ', Gondozo:' || :NEW.Gondozo);
END;

CREATE OR REPLACE TRIGGER TZooUpdate
AFTER UPDATE ON Zoo
FOR EACH ROW
BEGIN
    INSERT INTO ZooLogs (EVENT, ADAT)
    VALUES ('UPDATE', 'OLD_VALUES -> ID:' || :OLD.ID || ', Nev:' || :OLD.Nev || 
                      ', Fajta:' || :OLD.Fajta || ', Szul:' || :OLD.Szuletett || 
                      ', Suly:' || :OLD.Suly || ', Ertek:' || :OLD.Ertek || 
                      ', Gondozo:' || :OLD.Gondozo);
END;

CREATE OR REPLACE TRIGGER TZooDelete
AFTER DELETE ON Zoo
FOR EACH ROW
BEGIN
    INSERT INTO ZooLogs (EVENT, ADAT)
    VALUES ('DELETE', 'ID:' || :OLD.ID || ', Nev:' || :OLD.Nev || ', Fajta:' || :OLD.Fajta || 
                      ', Szul:' || :OLD.Szuletett || ', Suly:' || :OLD.Suly || 
                      ', Ertek:' || :OLD.Ertek || ', Gondozo:' || :OLD.Gondozo);
END;

CREATE OR REPLACE PROCEDURE DeleteAllTriggers AS
BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER TZooInsert';
    EXECUTE IMMEDIATE 'DROP TRIGGER TZooUpdate';
    EXECUTE IMMEDIATE 'DROP TRIGGER TZooDelete';
END;

-- 1. Teszt beszúrás
INSERT INTO Zoo (ID, Nev, Fajta, Szuletett, Suly, Ertek, Gondozo) 
VALUES (1, 'Bobi', 'Elefánt', TO_DATE('2010-05-10','YYYY-MM-DD'), 3000, 500000, 'Kovács János');

-- 2. Teszt módosítás
UPDATE Zoo SET Suly = 3100 WHERE ID = 1;

-- 3. Teszt törlés
DELETE FROM Zoo WHERE ID = 1;

-- 4. Ellenőrzés
SELECT * FROM ZooLogs;