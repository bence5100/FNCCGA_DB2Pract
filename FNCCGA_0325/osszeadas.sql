DECLARE
    szam1 NUMBER := 10;
    szam2 NUMBER := 25;
    osszeg NUMBER;
BEGIN
    osszeg := szam1 + szam2;
    DBMS_OUTPUT.PUT_LINE('Az összeg: ' || osszeg);
END;