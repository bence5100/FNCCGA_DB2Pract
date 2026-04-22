CREATE OR REPLACE PROCEDURE TorolRendszám(p_rsz IN Auto.rsz%TYPE) AS
BEGIN
    DELETE FROM Auto WHERE rsz = p_rsz; 
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE TipushozRendszám(p_tipus IN Auto.tipus%TYPE) AS
    v_rsz Auto.rsz%TYPE;
BEGIN
    SELECT rsz INTO v_rsz FROM Auto WHERE tipus = p_tipus; 
    DBMS_OUTPUT.PUT_LINE('Rendszám: ' || v_rsz);
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Nincs ilyen típusú autó!');
    WHEN TOO_MANY_ROWS THEN 
        DBMS_OUTPUT.PUT_LINE('Több ilyen típusú autó is létezik!'); 
END;

CREATE OR REPLACE PROCEDURE Szamol(a IN INT, b IN INT, muv IN VARCHAR2) AS
    ert FLOAT; 
    hibas_muvelet EXCEPTION; 
BEGIN
    CASE muv 
        WHEN 'meg' THEN ert := a + b; 
        WHEN 'bol' THEN ert := a - b;
        WHEN 'szer' THEN ert := a * b;
        WHEN 'oszt' THEN 
            IF b = 0 THEN RAISE ZERO_DIVIDE; END IF;
            ert := a / b;
        ELSE RAISE hibas_muvelet;
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Eredmény: ' || ert); 
EXCEPTION
    WHEN hibas_muvelet THEN 
        DBMS_OUTPUT.PUT_LINE('Hibás művelet!');
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Nullával való osztás!');
END;


