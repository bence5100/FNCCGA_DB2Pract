DECLARE
    v_min NUMBER := 10;
    v_max NUMBER := 100;
    v_ertek NUMBER := 78;
BEGIN
    IF v_ertek >= v_min AND v_ertek <= v_max THEN
        DBMS_OUTPUT.PUT_LINE('A(z) ' || v_ertek || ' beleesik a [' || v_min || ', ' || v_max || '] intervallumba.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('A szám kívül esik az intervallumon.');
    END IF;
END;