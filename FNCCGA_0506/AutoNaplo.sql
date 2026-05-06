CREATE TABLE AutoNaplo (
    DATUM TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    ESEMENY VARCHAR2(30),
    ADAT VARCHAR2(150)
);
-- 1. Csomag specifikáció
CREATE OR REPLACE PACKAGE AutoCsomag AS
    -- b.) Beszúr 2 rekordot
    PROCEDURE TriggerAutoInsert;
    
    -- c.) Szín módosítása ID alapján
    PROCEDURE UpdateSzin(p_id IN NUMBER, p_uj_szin IN VARCHAR2);
    
    -- d.) Törlés ID alapján
    PROCEDURE DeleteAuto(p_id IN NUMBER);
END AutoCsomag;


-- 2. Csomag törzse (Package Body)
CREATE OR REPLACE PACKAGE BODY AutoCsomag AS

    PROCEDURE TriggerAutoInsert AS
    BEGIN
        INSERT INTO AutoNaplo (ESEMENY, ADAT) VALUES ('INSERT_TESZT', 'Első teszt rekord');
        INSERT INTO AutoNaplo (ESEMENY, ADAT) VALUES ('INSERT_TESZT', 'Második teszt rekord');
        COMMIT;
    END TriggerAutoInsert;

    PROCEDURE UpdateSzin(p_id IN NUMBER, p_uj_szin IN VARCHAR2) AS
    BEGIN
        -- Itt az ID-t idézőjel nélkül írjuk, ahogy az Oracle szereti alapból
        UPDATE Auto SET Szin = p_uj_szin WHERE ID = p_id;
        
        INSERT INTO AutoNaplo (ESEMENY, ADAT) 
        VALUES ('UPDATE', 'ID: ' || p_id || ' új színe: ' || p_uj_szin);
        COMMIT;
    END UpdateSzin;

    PROCEDURE DeleteAuto(p_id IN NUMBER) AS
    BEGIN
        DELETE FROM Auto WHERE ID = p_id;
        
        INSERT INTO AutoNaplo (ESEMENY, ADAT) 
        VALUES ('DELETE', 'Törölt autó ID: ' || p_id);
        COMMIT;
    END DeleteAuto;

END AutoCsomag;

EXEC AutoCsomag.TriggerAutoInsert;

-- Az 5-ös ID-jú autó színének átírása 'Piros'-ra
EXEC AutoCsomag.UpdateSzin(5, 'Piros');

-- A 10-es ID-jú autó törlése
EXEC AutoCsomag.DeleteAuto(10);

-- Ellenőrzés
SELECT * FROM AutoNaplo;

desc Auto;
ALTER TABLE Auto ADD (ID NUMBER);