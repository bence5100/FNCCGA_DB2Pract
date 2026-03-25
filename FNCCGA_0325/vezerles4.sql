DECLARE
    v_beosztas_kod VARCHAR2(20) := 'root';
    v_teljes_nev VARCHAR2(50);
BEGIN
    v_teljes_nev := CASE v_beosztas_kod
        WHEN 'root' THEN 'Rendszergazda (UNIX/LINUX)'
        WHEN 'admin' THEN 'Adminisztrátor'
        WHEN 'user'  THEN 'Felhasználó'
        ELSE 'Ismeretlen beosztás'
    END;
    
    DBMS_OUTPUT.PUT_LINE('Beosztás: ' || v_teljes_nev);
END;