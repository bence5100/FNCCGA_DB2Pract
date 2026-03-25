DECLARE
    szam1 NUMBER := 5;
    szam2 NUMBER := 4;
    eredmeny NUMBER;
BEGIN
    eredmeny := szam1 * szam2;
    DBMS_OUTPUT.PUT_LINE('A szorzat: ' || eredmeny);
END;