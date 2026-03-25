DECLARE
    a NUMBER := 3;
    b NUMBER := 4;
    c NUMBER := 5;
BEGIN
    IF (a + b > c) AND (a + c > b) AND (b + c > a) THEN
        DBMS_OUTPUT.PUT_LINE('A(z) ' || a || ', ' || b || ', ' || c || ' oldalakkal alkotható háromszög.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ezekből az oldalakból NEM alkotható háromszög.');
    END IF;
END;