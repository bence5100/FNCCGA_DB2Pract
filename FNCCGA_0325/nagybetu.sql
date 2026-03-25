DECLARE
    nev VARCHAR2(50) := 'Vágási Bence';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nagybetűs: ' || UPPER(nev));
    DBMS_OUTPUT.PUT_LINE('Kisbetűs: ' || LOWER(nev));
END;