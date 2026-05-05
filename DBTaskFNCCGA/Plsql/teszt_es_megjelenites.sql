

BEGIN
    -- 1. ÚJ REKORD FELVITELE ÉS KULCS TRIGGER TESZT (auto_pk_trg)
    DBMS_OUTPUT.PUT_LINE('--- 1. ÚJ AUTÓ FELVITELE (Csomag eljárás) ---');
    autok_pkg.auto_felvitel('TESZT-01', 'Skoda Octavia', 2021);
    DBMS_OUTPUT.PUT_LINE('Sikeresen felvéve: TESZT-01 Skoda Octavia.');
    DBMS_OUTPUT.PUT_LINE(' ');
END;   
BEGIN
    -- 2. KIVÉTELKEZELÉS TESZT (Duplikált rendszám)
    DBMS_OUTPUT.PUT_LINE('--- 2. KIVÉTELKEZELÉS (Dupla rendszám felvitele) ---');
    autok_pkg.auto_felvitel('TESZT-01', 'Skoda Superb', 2022); -- A csomag elkapja a DUP_VAL_ON_INDEX hibát!
    DBMS_OUTPUT.PUT_LINE(' ');
END;
BEGIN 
    -- 3. ADATOK MÓDOSÍTÁSA
    DBMS_OUTPUT.PUT_LINE('--- 3. ADATOK MÓDOSÍTÁSA (Csomag eljárás) ---');
    -- A TESZT-01 rendszámú autó a 4-es ID-t kapta (ha a 4. fájlt már lefuttattad)
    autok_pkg.auto_modositas(4, 'MOD-001');
    DBMS_OUTPUT.PUT_LINE('A 4-es azonosítójú autó rendszáma módosítva: MOD-001');
    DBMS_OUTPUT.PUT_LINE(' ');
End;
BEGIN
    -- 4. ADATOK TÖRLÉSE (Előbb felveszünk egyet, hogy legyen mit törölni)
    DBMS_OUTPUT.PUT_LINE('--- 4. ADATOK TÖRLÉSE (Csomag eljárás) ---');
    autok_pkg.auto_felvitel('DEL-999', 'Lada Niva', 1990);
    autok_pkg.auto_torles(5); -- Feltételezve, hogy a DEL-999 az 5-ös ID-t kapta
    DBMS_OUTPUT.PUT_LINE('Az 5-ös ID-jű Lada Niva sikeresen törölve.');
    DBMS_OUTPUT.PUT_LINE(' ');
END;
BEGIN    
    -- 5. FÜGGVÉNY (Egy rekord mezőinek lekérdezése / Implicit kurzor)
    DBMS_OUTPUT.PUT_LINE('--- 5. EGY REKORD LEKÉRDEZÉSE (Függvény) ---');
    DBMS_OUTPUT.PUT_LINE('Az 1-es azonosítójú autó márkája: ' || autok_pkg.get_auto_marka(1));
    DBMS_OUTPUT.PUT_LINE(' ');
END;
BEGIN

    -- 6. KONTROLL TRIGGER TESZT (Negatív költség meggátolása)
    DBMS_OUTPUT.PUT_LINE('--- 6. KONTROLL TRIGGER (Módosítás kontrollálása) ---');
    BEGIN
        INSERT INTO javitasok (javitas_id, auto_id, leiras, koltseg, javitas_datum) 
        VALUES (999, 1, 'Hibás adatokkal javítás', -5000, SYSDATE);
    EXCEPTION
        WHEN OTHERS THEN
            -- Itt a trigger által dobott egyedi hibát kapjuk el és írjuk ki!
            DBMS_OUTPUT.PUT_LINE('A trigger blokkolta a műveletet: ' || SQLERRM);
    END;
    DBMS_OUTPUT.PUT_LINE(' ');
END;
BEGIN

    -- 7. NAPLÓZÓ TRIGGER TESZT (Többféle esemény)
    DBMS_OUTPUT.PUT_LINE('--- 7. NAPLÓZÓ TRIGGER TESZT (INSERT, UPDATE, DELETE) ---');
    INSERT INTO javitasok (javitas_id, auto_id, leiras, koltseg, javitas_datum) 
    VALUES (888, 1, 'Teszt javítás', 10000, SYSDATE);
    DBMS_OUTPUT.PUT_LINE('- Új javítás beszúrva (INSERT).');
END;
BEGIN
    
    UPDATE javitasok SET koltseg = 20000 WHERE javitas_id = 888;
    DBMS_OUTPUT.PUT_LINE('- Javítás költsége módosítva (UPDATE).');
END;
BEGIN
    DELETE FROM javitasok WHERE javitas_id = 888;
    DBMS_OUTPUT.PUT_LINE('- Javítás törölve (DELETE).');
    DBMS_OUTPUT.PUT_LINE(' ');
END;
BEGIN

    -- 8. AGGREGÁLT FÜGGVÉNY (Explicit kurzor)
    DBMS_OUTPUT.PUT_LINE('--- 8. AGGREGÁLT ÉRTÉK (Explicit kurzor) ---');
    DBMS_OUTPUT.PUT_LINE('A szerviz eddigi összes javítási bevétele (HUF): ' || autok_pkg.get_osszes_javitas_koltseg());
END;
COMMIT;



-- Ellenőrző lekérdezések (Ezeket külön fotózd ki a jegyzőkönyvbe!)
SELECT * FROM szerviz_naplo;
SELECT * FROM autok;
