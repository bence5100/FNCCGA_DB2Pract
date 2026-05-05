

BEGIN
    -- Autók feltöltése
    INSERT INTO autok (rendszam, marka, gyartasi_ev, regisztracio_datum) 
    VALUES ('ABC-123', 'Toyota Corolla', 2018, TO_DATE('2026-01-10', 'YYYY-MM-DD'));

    INSERT INTO autok (rendszam, marka, gyartasi_ev, regisztracio_datum) 
    VALUES ('XYZ-987', 'Ford Focus', 2020, TO_DATE('2026-02-15', 'YYYY-MM-DD'));

    INSERT INTO autok (rendszam, marka, gyartasi_ev, regisztracio_datum) 
    VALUES ('QWE-456', 'Suzuki Swift', 2015, TO_DATE('2026-03-20', 'YYYY-MM-DD'));
    
    -- Javítások feltöltése (az 1-es és 2-es ID-jű autókhoz)
    INSERT INTO javitasok (javitas_id, auto_id, leiras, koltseg, javitas_datum) 
    VALUES (1, 1, 'Olajcsere és szűrők cseréje', 45000, SYSDATE);

    INSERT INTO javitasok (javitas_id, auto_id, leiras, koltseg, javitas_datum) 
    VALUES (2, 2, 'Fékbetét csere', 85000, SYSDATE);

    INSERT INTO javitasok (javitas_id, auto_id, leiras, koltseg, javitas_datum) 
    VALUES (3, 1, 'Klíma töltés', 25000, SYSDATE);
    
    -- Ha minden sikeres volt, véglegesítjük az adatokat
    DBMS_OUTPUT.PUT_LINE('Adatok sikeresen feltöltve az adatbázisba!');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        -- Ha bármilyen hiba történik, visszavonjuk a tranzakciót
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Hiba történt a feltöltés során: ' || SQLERRM);
END;

