CREATE TABLE termek (
    TKOd CHAR(3),
    NEV VARCHAR2(30),
    AR NUMBER(38,0),
    Leiras VARCHAR2(20),
    Kategoria CHAR(3)
);
DESCRIBE termek;

BEGIN
    INSERT INTO termek VALUES ('T01', 'Sör', 200, 'világos', 'K02');
    INSERT INTO termek VALUES ('T02', 'bor', 200, 'Vörös', 'K02');
    INSERT INTO termek VALUES ('T03', 'Szilva', 200, 'lila', 'K01');
    INSERT INTO termek VALUES ('T04', 'Kenyér', 300, 'fehér', 'K02');
    INSERT INTO termek VALUES ('T05', 'Zsemle', 50, 'fehér', 'K02');
    INSERT INTO termek VALUES ('T06', 'Sajt', 400, 'sárga', 'K03');
    INSERT INTO termek VALUES ('T07', 'Tej', 250, 'fehér', 'K03');
    INSERT INTO termek VALUES ('T08', 'csipsz', 350, 'sajtos', 'K04');
    INSERT INTO termek VALUES ('T09', 'csipsz', 500, 'tejfölös', 'K04');
    INSERT INTO termek VALUES ('T10', 'Víz', 80, 'átlátszó', 'K05');
    INSERT INTO termek VALUES ('T11', 'Kávé', 600, 'fekete', 'K05');
    INSERT INTO termek VALUES ('T12', 'Tea', 300, 'barna', 'K05');
    INSERT INTO termek VALUES ('T13', 'Cukor', 120, 'fehér', 'K06');
    INSERT INTO termek VALUES ('T14', 'Só', 90, 'fehér', 'K06');
    INSERT INTO termek VALUES ('T15', 'Bors', 110, 'fekete', 'K06');
END;

CREATE OR REPLACE PROCEDURE ModT (
    p_tkod IN termek.tkod%TYPE,
    p_uj_ar IN termek.ar%TYPE
) AS
BEGIN
    UPDATE termek
    SET ar = p_uj_ar
    WHERE tkod = p_tkod;
    
    COMMIT;
END;

CREATE OR REPLACE TRIGGER TArFigy
BEFORE UPDATE OF ar ON termek
FOR EACH ROW
DECLARE
    v_elteres NUMBER;
BEGIN
    -- Kiszámoljuk az eltérést százalékban (az abszolútérték segít mindkét irányban)
    -- Ha az eredeti ár nem 0
    IF :OLD.ar > 0 THEN
        v_elteres := ABS(:NEW.ar - :OLD.ar) / :OLD.ar;
        
        IF v_elteres > 0.2 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nem megengedett mértékű a módosítás (több mint 20%)!');
        END IF;
    END IF;
END;

BEGIN
    ModT('t05', 130);
END;

BEGIN
    ModT('t05', 80);
END;

BEGIN
    ModT('t05', 70);
END;