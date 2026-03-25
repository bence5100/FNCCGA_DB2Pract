DECLARE
    r NUMBER := 12;
    pi CONSTANT NUMBER := 3.14159265;
    terulet NUMBER;
BEGIN
    terulet := (r ** 2) * pi;
    DBMS_OUTPUT.PUT_LINE('A kör területe (r=12 esetén): ' || ROUND(terulet, 2));
END;