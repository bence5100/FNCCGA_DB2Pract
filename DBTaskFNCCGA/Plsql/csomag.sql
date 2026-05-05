-- CSOMAG FEJLÉC (Specifikáció)
CREATE OR REPLACE PACKAGE autok_pkg AS
    PROCEDURE auto_felvitel(p_rendszam VARCHAR2, p_marka VARCHAR2, p_ev NUMBER);
    PROCEDURE auto_modositas(p_id NUMBER, p_uj_rendszam VARCHAR2);
    PROCEDURE auto_torles(p_id NUMBER);
    FUNCTION get_auto_marka(p_id NUMBER) RETURN VARCHAR2;
    FUNCTION get_osszes_javitas_koltseg RETURN NUMBER;
END autok_pkg;


-- CSOMAG TÖRZS (Implementáció)
CREATE OR REPLACE PACKAGE BODY autok_pkg AS

    -- Kivételkezeléssel ellátott felvitel
    PROCEDURE auto_felvitel(p_rendszam VARCHAR2, p_marka VARCHAR2, p_ev NUMBER) IS
    BEGIN
        INSERT INTO autok (rendszam, marka, gyartasi_ev, regisztracio_datum)
        VALUES (p_rendszam, p_marka, p_ev, SYSDATE);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('KIVÉTEL ELKAPVA: Ez a rendszám (' || p_rendszam || ') már létezik az adatbázisban!');
            ROLLBACK;
    END auto_felvitel;

    -- Módosítás
    PROCEDURE auto_modositas(p_id NUMBER, p_uj_rendszam VARCHAR2) IS
    BEGIN
        UPDATE autok SET rendszam = p_uj_rendszam WHERE auto_id = p_id;
        COMMIT;
    END auto_modositas;

    -- Törlés
    PROCEDURE auto_torles(p_id NUMBER) IS
    BEGIN
        DELETE FROM autok WHERE auto_id = p_id;
        COMMIT;
    END auto_torles;

    -- Függvény: Egy rekord lekérdezése (Implicit kurzor)
    FUNCTION get_auto_marka(p_id NUMBER) RETURN VARCHAR2 IS
        v_marka autok.marka%TYPE;
    BEGIN
        SELECT marka INTO v_marka FROM autok WHERE auto_id = p_id;
        RETURN v_marka;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Nincs adat';
    END get_auto_marka;

    -- Függvény: Aggregált érték lekérdezése (Explicit kurzorral)
    FUNCTION get_osszes_javitas_koltseg RETURN NUMBER IS
        v_osszesen NUMBER := 0;
        v_aktualis NUMBER;
        CURSOR c_koltsegek IS SELECT koltseg FROM javitasok;
    BEGIN
        OPEN c_koltsegek;
        LOOP
            FETCH c_koltsegek INTO v_aktualis;
            EXIT WHEN c_koltsegek%NOTFOUND;
            v_osszesen := v_osszesen + NVL(v_aktualis, 0);
        END LOOP;
        CLOSE c_koltsegek;
        RETURN v_osszesen;
    END get_osszes_javitas_koltseg;

END autok_pkg;
